local PetalGen, super = Class(Object)

function PetalGen:init(x, y)
    super.init(self, x, y)
    self.petal_timer = 0


    self.spread_range = 500
    self._cx, self._cy = 100, -100

    self.petal_rain_layer = 0
    self.stop_spawn = false
end

function PetalGen:dropPetal(x, y, arg2, arg3, arg4, arg5)
    local _scale = 2

    local _petal = GoldPetal("battle/effects/particles/bush_leaf_gold", x, y)
    _petal:play(1 / (30 * (MathUtils.random(0.2) + 0.1)), true)
    _petal:setScale(_scale)
    _petal:setOriginExact(4, 4)
    _petal:setLayer(self.petal_rain_layer)
    _petal.physics.gravity_direction = -math.rad(175 + MathUtils.random(10))
    _petal:setSpeed(-2, 5)
    _petal.physics.gravity = 0.06
    _petal:setColor(ColorUtils.mergeColor(COLORS.white, COLORS.black, MathUtils.random(0.25)))
    Game.battle:addChild(_petal)

    Game.battle.timer:after(120 / 30, function() _petal:remove() end)
end

-- equivalent of `default_particle_data`

function PetalGen:update()
    self.petal_timer = self.petal_timer + DTMULT

    local _random = MathUtils.random(self.spread_range)

    if (self.petal_timer >= 5) then
        if not self.stop_spawn then
            self:dropPetal(((self._cx + 640) - (self.spread_range * 0.65)) + _random,
                (self._cy - (self.spread_range * 0.5)) + _random, true, -12,
                1)
            self.petal_timer = 0
        end
    end

    for _, petal in ipairs(Game.stage:getObjects(GoldPetal)) do
        if not self.stop_spawn then
            if Game.battle.state == "DEFENDING" then
                petal.alpha = MathUtils.lerp(petal.alpha, 0.4, 0.3 * DTMULT)
            else
                petal.alpha = MathUtils.lerp(petal.alpha, 1, 0.3 * DTMULT)
            end
        end
    end
end

return PetalGen
