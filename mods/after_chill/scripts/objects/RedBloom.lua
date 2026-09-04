local RedBloom, super = Class(Event)

function RedBloom:init(data)
    super.init(self, data.x, data.y, data.width, data.height)
    self:setSprite("effects/hazy_glow")
    self.width = data.width
    self.height = data.height
    self:setColor(COLORS.red)
    self:setScale(0.15)
    self.sprite:setColor(COLORS.red)
    self.sprite.alpha = 0.7
    self.timer = 0
    self.sprite:setOrigin(0.5, 0.5)
end


return RedBloom