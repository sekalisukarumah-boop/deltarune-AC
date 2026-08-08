local Candle, super = Class(Object)

function Candle:animateLight(circ, mult)
	local rad = circ.width
	local alpha = circ.alpha
	local wait = 1.5
	local mult = mult or .90



	Game.battle.timer:tween(wait, circ, { width = rad * mult, height = rad * mult, alpha = alpha * .75 }, 'in-sine',
		function()
			Game.battle.timer:tween(wait, circ, { width = rad, height = rad, alpha = alpha }, 'out-sine', function()
				self:animateLight(circ, mult)
			end)
		end)
end

function Candle:init(x, y)
	super.init(self, x, y, 40, 60)
	self:setOrigin(-0.5, 0.5)

	self.sprite = Sprite("battle/effects/spr_dw_church_torch", -18 ,-60)
	self.sprite.layer = 999
	self.sprite:setScale(2, 2)
	self.sprite.alpha = 1
	--self.sprite:setOrigin(0.5, 0.5)

	self:addChild(self.sprite)
	local circ1 = Ellipse(-2, 50, 25, 25)
	circ1:setColor(70/ 255, 121/ 255, 211/ 255)
	circ1.alpha = 0.85

	local circ2 = Ellipse(-2, 50, 35, 35)
	circ2:setColor(34 / 255, 62 / 255, 140 / 255)
	circ2.alpha = 0.65

	local circ3 = Ellipse(-2, 50, 45, 45)
	circ3:setColor(25 / 255, 49 / 255, 99 / 255)
	circ3.alpha = 0.55



	local t = Timer()

	self:addChild(t)
	self:addChild(circ3)
	self:addChild(circ1)
	self:addChild(circ2)


	self:animateLight(circ1, 0.76)
	self:animateLight(circ2, 0.8)
	self:animateLight(circ3)
end

return Candle
