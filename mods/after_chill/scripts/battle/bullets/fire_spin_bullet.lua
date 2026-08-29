---@class fire_spin_bullet : Bullet
local fire_spin_bullet, super = Class(Bullet)
function fire_spin_bullet:init(x, y)
    super.init(self, x, y, "bullets/fire")
    self.sprite:play(0.1, true)
    self.alpha = 0
    self.is_fired = false
    self:setHitbox(10, 10, 12, 14)
end

function fire_spin_bullet:onWaveSpawn()
    self:fadeTo(1, 0.2)
end

function fire_spin_bullet:fireAtTarget(target_x, target_y)
    self.is_fired = true
    local angle = MathUtils.angle(self.x, self.y, target_x, target_y)
    self.physics.direction = angle
    self.physics.gravity = 0.2
    self.physics.gravity_direction = angle
    self.physics.speed = 9
end

return fire_spin_bullet
