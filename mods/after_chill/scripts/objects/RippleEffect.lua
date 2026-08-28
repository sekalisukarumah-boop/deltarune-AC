local RippleEffect, super = Class(Object)

local function computeBezier(curve, iteration)
	local numpoints = math.max(#curve.x, #curve.y)
	if numpoints < 2 then return nil end
	local points = {}
	local iterations = iteration * 2
	local iter = 1 / iterations
	for i = 1, numpoints do
		local p0x = curve.x[i]
		local p0y = curve.y[i]
		local p1x = curve.x[i] + curve.tx1[i]
		local p1y = curve.y[i] + curve.ty1[i]
		local p2x = curve.x[math.min(i + 1, numpoints)] + curve.tx0[math.min(i + 1, numpoints)]
		local p2y = curve.y[math.min(i + 1, numpoints)] + curve.ty0[math.min(i + 1, numpoints)]
		local p3x = curve.x[math.min(i + 1, numpoints)]
		local p3y = curve.y[math.min(i + 1, numpoints)]
		for j = 0, iterations do
			local t = j * iter
			local t2 = t * t
			local t3 = t2 * t
			local mt = 1 - t
			local mt2 = mt * mt
			local mt3 = mt2 * mt
			local vx = (p0x * mt3) + (3 * p1x * mt2 * t) + (3 * p2x * mt * t2) + (p3x * t3)
			local vy = (p0y * mt3) + (3 * p1y * mt2 * t) + (3 * p2y * mt * t2) + (p3y * t3)
			table.insert(points, {x = vx, value = vy})
		end
	end
	return points
end 

local ripple_curve = {
		norm = computeBezier({
			x = {0, 0.051526718, 1},
			y = {0, 0.20855069, 1},
			tx0 = {-0.1, -0.007633588, -0.62404585},
			tx1 = {0, 0.014325198, 0.1},
			ty0 = {0, -0.06856331, -0.0013129711},
			ty1 = {0, 0.12866598, 0},
		}, 16),
		slow = computeBezier({
			x = {0, 0.013358779, 1},
			y = {0, 0.10375321, 1},
			tx0 = {-0.1, -0.010598192, -0.69488364},
			tx1 = {0.0000000002337616, 0.06633949, 0.1},
			ty0 = {0, -0.046568524, -0.37333333},
			ty1 = {0, 0.2914962, 0},
		}, 16),
	}

function RippleEffect:init()
    super.init(self, 0, 0)
    self.shader = Assets.getShader("ripple")
	self.ripples = {}
	self.layer = WORLD_LAYERS["bottom"]
end

function RippleEffect:makeRipple(x, y, life, color, radmax, radstart, thickness, depth, hsp, vsp, fric, curve)
	life = life or 60
    color = color or ColorUtils.hexToRGB("#4A91F6")
	radstart = radstart or 1
	radmax = radmax or 160
	thickness = thickness or 15
	hsp = hsp or 0
	vsp = vsp or 0
	fric = fric or 0.1
	curve = curve or ripple_curve["norm"]
	table.insert(self.ripples, {
		x = x,
		y = y,
		life = life,
		lifemax = life,
		color = color,
		rad = radstart,
		radmax = radmax,
		radstart = radstart,
		thickness = thickness,
		hsp = hsp,
		vsp = vsp,
		fric = fric,
		curve = curve
	})
end

function RippleEffect:evaluate(curve, time)
	if time < 0 then
		time = 0
	end
	if time > 1 then
		time = 1
	end
	local cmax = #curve
	local cstart = 0
	local cend = cmax  - 1
	local cmid = math.floor(cend / 2)
	while (cmid ~= cstart) do
		if curve[math.min(cmid + 1, #curve)].x > time then
			cend = cmid
		else
			cstart = cmid
		end
		cmid = math.floor((cstart + cend) / 2)
	end
	local x1 = curve[math.min(cmid + 1, cmax)].x
	local x2 = curve[math.min(cmid + 2, cmax)].x
	
	if x1 == x2 then
		return curve[math.min(cmid + 1, cmax)].value
	end
	
	local val1 = curve[math.min(cmid + 1, cmax)].value
	local val2 = curve[math.min(cmid + 2, cmax)].value
	
	local ratio = (time - x1) / (x2 - x1)
	local val = ((val2 - val1) * ratio) + val1
	
	return val
end

function RippleEffect:draw()
    super.draw(self)
	local cx, cy = Game.world.camera.x - SCREEN_WIDTH/2, Game.world.camera.y - SCREEN_HEIGHT/2
	local to_remove = {}
	local ripple_canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
	love.graphics.clear()
	love.graphics.setShader(self.shader)
	for _, ripple in ipairs(self.ripples) do
		ripple.life = math.max(0, ripple.life - DTMULT)
		ripple.x = ripple.x + ripple.hsp * DTMULT
		ripple.y = ripple.y + ripple.vsp * DTMULT
		
		if ripple.hsp > 0 then
			ripple.hsp = MathUtils.approach(ripple.hsp, 0, ripple.fric*DTMULT)
		end
		if ripple.vsp > 0 then
			ripple.vsp = MathUtils.approach(ripple.vsp, 0, ripple.fric*DTMULT)
		end
		
		local xx = ripple.x - cx
		local yy = ripple.y - cy
		ripple.rad = MathUtils.lerp(ripple.radstart, ripple.radmax, self:evaluate(ripple.curve, 1 - (ripple.life / ripple.lifemax)))
		if ripple.rad > 0 then
			love.graphics.setShader(self.shader)
			self.shader:send("rippleCenter", {xx, yy})
			self.shader:send("rippleRad", {ripple.rad, ripple.radmax, ripple.thickness})
			Draw.setColor(ripple.color)
			love.graphics.rectangle("fill", xx - ripple.rad, yy - ripple.rad, ripple.rad*2, ripple.rad*2)
			if ripple.life == 0 then
				table.insert(to_remove, ripple)
			end
		end
	end
	for _,ripple in ipairs(to_remove) do
        TableUtils.removeValue(self.ripples, ripple)
	end
	love.graphics.setShader()
	Draw.popCanvas()
	
	Draw.setColor(1,1,1,1)
	Draw.draw(ripple_canvas, cx, cy)
end

return RippleEffect