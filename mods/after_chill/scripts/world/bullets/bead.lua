local bead, super = Class(WorldBullet)

function bead:init(x, y, color)
    super.init(self, x, y) 
    self.sprite = Sprite("bullets/bead_" .. (color or "blue"))
    self.sprite:setOrigin(0.5, 0.5)
    self:addChild(self.sprite)
    self.damage = 32
    self.sprite:setRotationOrigin(0.5, 0.5)
    self.sprite.graphics.spin = 0.2
    self.physics.speed_y = 4
    self.afterimage_timer = 0
    local size = 16
    local offset = -(size / 2)
    self:setHitbox(offset, offset, size, size)
    self.sprite.alpha = 0
    self.sprite:setScale(0.6) 
    Game.stage.timer:tween(0.25, self.sprite, {alpha = 1, scale_x = 1.8, scale_y = 1.8}, "out-cubic", function()
            if self.sprite then
                self.sprite:fadeOutAndRemove(1, function() self:remove() end)
            end
        end)
end 

function bead:update()
    super.update(self)
    
    -- Only drop afterimages while the bullet is visible and alive
    if self.sprite and self.sprite.alpha > 0.1 then
        self.afterimage_timer = self.afterimage_timer + DT
        if self.afterimage_timer >= 0.04 then -- Slightly faster timer for a denser, cooler trail
            self.afterimage_timer = 0
            if self.parent then
                local afterimage = AfterImage(self, 1.4, 0.2)
                afterimage:setLayer(self.layer - 0.1)
                self.parent:addChild(afterimage)
            end
        end
    end
end

function bead:getDrawColor()
    return self.color
end

return bead
