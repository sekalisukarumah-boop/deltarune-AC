---@class SmallBullet : Bullet
local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/fireglow")
    self.remove_offscreen = true
    self.speedvar = speed
    self.dirvar = dir
    self:setScale(0,0)
    self.destroy_on_hit = false
    self.timer = -1
end

function SmallBullet:update()
    super.update(self)
    if self.timer >= 0 then
        self.timer = self.timer - 1
    elseif self.timer < 0 then
        self.timer = 8
        self.wave:spawnBullet("ralsei/smallflame", self.x, self.y, 0, 0)
        Assets.stopAndPlaySound("noise")
    end
    if self.physics and self.scale_x >= 1 and self.scale_y >= 1 then 
    self.physics.direction = self.dirvar 
    self.physics.speed = self.speedvar
    self:setScale(1,1)
    else
        self.scale_x = self.scale_x + 0.1
        self.scale_y = self.scale_y + 0.1
    end 
end

return SmallBullet
