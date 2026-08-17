---@class tired_angel : Bullet
local tired_angel, super = Class(Bullet)

function tired_angel:init(x, y, is_left_side)
    super.init(self, x, y, "bullets/ralsei/bullet")
    self.sprite:play(0.05, true)
    self.is_left_side = is_left_side
    if is_left_side then self.scale_x = -2 end 
end

function tired_angel:burstProjectiles()
    if not Game.battle.soul then return end 
    Assets.playSound("sparkle_glock")
    local bx, by = self:getRelativePos(self.width/2, self.height/2)
    local side_multiplier = self:isLeft() and 1 or -1
    local target_x = Game.battle.soul.x
    local target_y = Game.battle.soul.y

    for i = 1, 3 do
        local offset_x = bx + (i * 12 * side_multiplier)
        local offset_y = by + (i * 12)     
        local b = self.wave:spawnBullet("tired_z_bullet", offset_x, offset_y)
        local base_angle = MathUtils.angle(b.x, b.y, Game.battle.soul.x, Game.battle.soul.y)
        local spread_offset = (i - (3 + 1) / 2) * 0.7
        b.physics.direction = base_angle + spread_offset
        b.physics.speed = 4
        b.physics.gravity = 0.3
        b.physics.gravity_direction = b.physics.direction
    end 
    
    self.wave.timer:after(0.3, function()
        self.physics.speed_y = -4
        self:fadeOutSpeedAndRemove(0.5)
    end)
end

function tired_angel:isLeft()
    return self.is_left_side 
end 

return tired_angel
