---@class tired_z_bullet : Bullet
local tired_z_bullet, super = Class("DarkBullet")

function tired_z_bullet:init(x, y)
    super.init(self, x, y, "effects/spare/z")
    
    self:setScale(1)
    self:setHitbox(4, 4, 12, 12)
    
    self.destroy_on_hit = true
    self.tiredness = 16
    self.trail_timer = 0
    self.frame_count = 0
    self:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
end

function tired_z_bullet:update()
    super.update(self)
    
    self.trail_timer = self.trail_timer + DT
    if self.trail_timer >= 0.033 then
        local cloud = AfterImage(self, 0.2)
        self.trail_timer = 0.022
        cloud:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
        Game.battle:addChild(cloud)
    end
end

return tired_z_bullet
