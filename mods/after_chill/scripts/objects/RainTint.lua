---@class RainTint : RainTint
local RainTint, super = Class(Object)

function RainTint:init()
    super.init(self)
    self.layer = WORLD_LAYERS["below_ui"]
end 

function RainTint:draw()
    local dark = 20
    local darker = 70
    Draw.setColor((99 - dark)/255, (126 - dark)/255, (135 - dark)/255, 55/255)
    love.graphics.rectangle("fill", 0, 0, 9999, 9999)
end 

return RainTint
