---@class tired_angel : Bullet
local tired_angel, super = Class(Bullet)

function tired_angel:init(x, y, is_left_side)
    super.init(self, x, y, "bullets/ralsei/bullet")
    self.sprite:play(0.05, true)
    self.is_left_side = is_left_side
    if is_left_side then
        self.scale_x = -2
    end
end

function tired_angel:burstProjectiles()
    if not Game.battle.soul then return end
    
    Assets.playSound("sparkle_glock")
    
    local bx, by = self:getRelativePos(self.width/2, self.height/2)
    
    -- SWEET SPOT FIX: Snapshot the target angle right now
    local target_angle = MathUtils.angle(bx, by, Game.battle.soul.x, Game.battle.soul.y)
    
    for i = 1, 3 do
        -- A tighter delay (0.09) makes the wall feel cohesive but distinct
        self.wave.timer:after((i - 1) * 0.09, function()
            if not Game.battle.soul then return end
            
            -- Wider structural vertical layout per bullet
            local offset_x = bx
            local offset_y = by + (i * 12) - 24
            
            local b = self.wave:spawnBullet("tired_z_bullet", offset_x, offset_y)
            b.layer = self.layer - 0.0001
            
            -- SWEET SPOT FIX: Straight paths, but aimed dynamically at your location!
            b.physics.direction = target_angle
            b.physics.speed = 6.5 + (i * 0.5) -- Later bullets fly slightly faster to close escape windows!
            b.physics.gravity = 0 -- No curved drop off, clean lines
        end)
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
