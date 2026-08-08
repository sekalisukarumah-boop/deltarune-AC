local GigaProphecyBattle, super = Class(Object)

function GigaProphecyBattle:init()
	super.init(self)
	self:setPosition(0)
	self:setParallax(0)

	self.blueswirly_tex = Assets.getTexture("battle/IMAGE_DEPTH_EXTEND_MONO_SEAMLESS_BRIGHTER")
	self.blueswirly_blur_tex = Assets.getTexture("battle/IMAGE_DEPTH_EXTEND_SEAMLESS")
	self.perlin_tex = Assets.getTexture("battle/perlin_noise_looping")
	self.fill_tex = Assets.getTexture("bubbles/fill")
	self.prophecies = {}
	self.prophecy_color = ColorUtils.hexToRGB("#42D0FF")
	self.con = 0

	self:generateProphecies()

	self.alpha_controller_layer_a = 0
	self.vic_lock = false
	self.alpha_controller_layer_b = 0
end

local function getProphecyTexture()
	return Assets.getTexture("battle/giga_prophecy_set/set_" .. MathUtils.randomInt(1, 10))
end

function GigaProphecyBattle:generateProphecies()
	local prophspace_width = SCREEN_WIDTH
	local prophspace_height = SCREEN_HEIGHT - 70

	local gap0 = 120
	for j = 0, 1 + math.floor(prophspace_height / gap0) do
		for i = 0 - 50, 1 + math.floor(prophspace_width / gap0) do
			local j_side = (j % 2 == 0)
			local i_side = (i % 2 == 0)
			if (not j_side and i_side) or (j_side and not i_side) then
				table.insert(self.prophecies, {
					texture = getProphecyTexture(),
					x = 50 + (i * gap0) + MathUtils.random(-42, 42),
					y = 50 + (j * gap0) + MathUtils.random(-42, 42),
					scale = 1,
					alpha = 1,
					layer = 0,
					local_offset = MathUtils.random(0, 10),
				})
			end
		end
	end

	local gap1 = 70
	for j = 0, 1 + math.floor(prophspace_height / gap1) do
		for i = 0 - 50, 1 + math.floor(prophspace_width / gap1) do
			table.insert(self.prophecies, {
				texture = getProphecyTexture(),
				x = 50 + (i * gap1) + MathUtils.random(-52, 52),
				y = 50 + (j * gap1) + MathUtils.random(-52, 52),
				scale = 0.5,
				alpha = 0.9,
				layer = 1,
				local_offset = MathUtils.random(0, 10),
			})
		end
	end

	local gap2 = 50
	for j = 0, 1 + math.floor(prophspace_height / gap2) do
		for i = 0 - 50, 1 + math.floor(prophspace_width / gap2) do
			table.insert(self.prophecies, {
				texture = getProphecyTexture(),
				x = 50 + (i * gap2) + MathUtils.random(-42, 42),
				y = 50 + (j * gap2) + MathUtils.random(-42, 42),
				scale = 0.25,
				alpha = 0.85,
				layer = 2,
				local_offset = MathUtils.random(0, 10),
			})
		end
	end
end

local function returnAlphaColor(color, value)
	local color = color
	return {
		color[1],
		color[2],
		color[3],
		color[4] * (value or 1),
	}
end

function GigaProphecyBattle:update()
	super.update(self)
end

local function scr_wave(arg0, arg1, speed_seconds, phase)
	local a4 = (arg1 - arg0) * 0.5;
	return arg0 + a4 + (math.sin((((Kristal.getTime()) + (speed_seconds * phase)) / speed_seconds) * (2 * math.pi)) * a4);
end

function GigaProphecyBattle:draw()
	super.draw(self)

	local t = Kristal.getTime()

	for _, prophecy in ipairs(self.prophecies) do
		local tt = (t * 1.25) + prophecy.local_offset
		prophecy.draw_x = prophecy.x
		prophecy.draw_y = prophecy.y + (math.sin(tt * math.pi) * 5)
	end

	local canvas_prophecy = Draw.pushCanvas(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - 70)
	love.graphics.clear()
	love.graphics.stencil(function()
		local last_shader = love.graphics.getShader()
		local shader = Kristal.Shaders["Mask"]
		love.graphics.setShader(shader)
		for _, prophecy in ipairs(self.prophecies) do
			if prophecy then
				Draw.draw(prophecy.texture, math.floor(prophecy.draw_x), math.floor(prophecy.draw_y), 0, prophecy.scale,
					prophecy.scale)
			end
		end
		love.graphics.setShader(last_shader)
	end, "replace", 1)
	love.graphics.setStencilTest("greater", 0)

	if self.vic_lock then
		self.alpha_controller_layer_a = MathUtils.lerp(self.alpha_controller_layer_a, 0, 0.1 * DTMULT)
		Draw.setColor(returnAlphaColor(self.prophecy_color, self.alpha_controller_layer_a))
	else
		self.alpha_controller_layer_a = MathUtils.lerp(self.alpha_controller_layer_a, 0.65, 0.01 * DTMULT)

		Draw.setColor(returnAlphaColor(self.prophecy_color, self.alpha_controller_layer_a))
	end
	Draw.drawWrapped(self.blueswirly_tex, true, true, (t * 15) * 0.5, (t * 15) * 0.5, 0, 1, 1)
	love.graphics.setBlendMode("add", "alphamultiply")


	if self.vic_lock then
		self.alpha_controller_layer_b = MathUtils.lerp(self.alpha_controller_layer_b, 0, 0.1 * DTMULT)
	else
		self.alpha_controller_layer_b = MathUtils.lerp(self.alpha_controller_layer_b, 1, 0.01 * DTMULT)
	end
	Draw.setColor(returnAlphaColor(self.prophecy_color, self.alpha_controller_layer_b * scr_wave(0, 0.4, 4, 0)))

	Draw.drawWrapped(self.perlin_tex, true, true, (t * 15) * 0.5, (t * 15) * 0.5, 0, 1, 1)
	love.graphics.setBlendMode("alpha", "alphamultiply")
	love.graphics.setStencilTest()
	Draw.popCanvas(true)
	Draw.setColor(self:getDrawColor())
	Draw.drawCanvas(canvas_prophecy, 0, 0, 0, 2, 2)
end

return GigaProphecyBattle
