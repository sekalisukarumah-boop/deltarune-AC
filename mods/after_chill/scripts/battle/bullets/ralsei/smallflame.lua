---@class SmallBullet : Bullet
local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/fireglow")
    self.remove_offscreen = false
    self.speedvar = speed
    self.dirvar = dir
    self:setScale(0,0)
    self.destroy_on_hit = false
    self.timer = 5
end

function SmallBullet:update()
    super.update(self)
    if self.physics and self.scale_x >= 0.3 and self.scale_y >= 0.3 then 
    self.physics.direction = self.dirvar 
    self.physics.speed = self.speedvar
    self:setScale(0.3,0.3)
    else
        self.scale_x = self.scale_x + 0.1
        self.scale_y = self.scale_y + 0.1
    end 
end

return SmallBullet
