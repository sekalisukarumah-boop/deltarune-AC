local HazyGlow, super = Class(Object)

function HazyGlow:init(x, y)
    super.init(self, 0, 0) 
    
    self.texture_omg = Assets.getTexture("effects/hazy_glow")
    
    self.tex_w = self.texture_omg:getWidth()
    self.tex_h = self.texture_omg:getHeight()
    
    self.base_radius = (self.tex_w / 2) * 0.60
    self.radius = self.base_radius
    self.pulse_timer = 0
    self.scale_factor = 1.2 
end

function HazyGlow:update()
    super.update(self)
    
    self.pulse_timer = self.pulse_timer + (DT * 4)
    local pulse_offset = math.sin(self.pulse_timer) * 2
    self.radius = self.base_radius + pulse_offset
    
    self.scale_factor = self.radius / (self.tex_w / 2)
end

function HazyGlow:draw()
    super.draw(self) 
    love.graphics.push()
    love.graphics.translate(18, 15)
    local r, g, b, a = love.graphics.getColor()
    Draw.setColor(r, g, b, 1)
    local blend = love.graphics.getBlendMode()
    love.graphics.setBlendMode("add")
    Draw.draw(self.texture_omg, 0, 0, 0, self.scale_factor, self.scale_factor, self.tex_w / 2, self.tex_h / 2)
    Draw.setColor(r, g, b, a)
    love.graphics.setBlendMode(blend)
    love.graphics.pop() 
end

return HazyGlow
