local BattleSnowflake, super = Class(Object)


function BattleSnowflake:init(x, y)
    super.init(self, x, y)

    self.sprite = Assets.getTexture('battle/christmas/snowflake')
    self:setSize(self.sprite:getDimensions())
    self:setOrigin(0.5)

    self.siner = 0
    self.physics.speed_y = 1
    self.graphics.spin = math.rad(MathUtils.random(0.5, 2)) * TableUtils.pick({ -1, 1 })
    self.base_alpha = MathUtils.random(0.25, 1)
    self.max_scale = MathUtils.random(1, 4)
    self:setScale(self.max_scale)

    self.wobble_siner = Utils.random(5, 10)
    self.physics.speed = Utils.random(0.1, 0.8) * TableUtils.pick({ -1, 1 })
end

function BattleSnowflake:update()
    super.update(self)

    self.siner = self.siner + math.rad(self.wobble_siner) * DTMULT
    self.scale_x = math.sin(self.siner) * self.max_scale

    if self.y > SCREEN_HEIGHT then
        self:remove()
    end
    if Game.battle.background.alpha then
        self.alpha = self.base_alpha * Game.battle.background.alpha
    end
end

function BattleSnowflake:draw()
    super.draw(self)

    love.graphics.draw(self.sprite)
end

return BattleSnowflake
