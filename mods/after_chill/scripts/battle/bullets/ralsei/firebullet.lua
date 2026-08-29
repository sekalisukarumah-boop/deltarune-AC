---@class SmallBullet : Bullet
local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/fireglow")
    self.remove_offscreen = false
    self.speedvar = speed
    self.dirvar = dir
    self:setScale(0,0)
    self.destroy_on_hit = false
    
    self.timer = -1
    self.my_trail = {}
    self.has_stopped = false
end

function SmallBullet:update()
    super.update(self)
    if not self.has_stopped then
        if self.timer >= 0 then
            self.timer = self.timer - 1
        elseif self.timer < 0 then
            self.timer = 8
            local b = self.wave:spawnBullet("ralsei/smallflame", self.x, self.y, 0, 0)
            table.insert(self.my_trail, b)
            Assets.stopAndPlaySound("noise")
        end
    end
    if self.physics and self.scale_x >= 1 and self.scale_y >= 1 then
        self.physics.direction = self.dirvar
        self.physics.speed = self.speedvar
        self:setScale(1)
        local distance = MathUtils.dist(self.init_x, self.init_y, self.x, self.y)
        
        if distance >= 250 and not self.has_stopped then
            self.has_stopped = true
            self.physics.speed = 0
            if self.wave.active_trail then
                for _, flame in ipairs(self.wave.active_trail) do
                    if flame and flame.stage then
                        flame:fadeOutAndRemove(0.2)
                    end
                end
            end
            self.wave.active_trail = self.my_trail
            self:fadeOutAndRemove(0.2)
        end
    else
        self.scale_x = self.scale_x + 0.1
        self.scale_y = self.scale_y + 0.1
    end
end

return SmallBullet
