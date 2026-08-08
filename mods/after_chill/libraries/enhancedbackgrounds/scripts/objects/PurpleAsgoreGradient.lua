local PurpleGradient, super = Class(Object)

local gradient_colors = {
    { 0xFF / 255, 0x4F / 255, 0x7A / 255 },     -- #FF4F7A
    { 0xFF / 255, 0x4F / 255, 0x7A / 255 },     -- #FF4F7A

    { 0xF2 / 255, 0x4B / 255, 0x93 / 255 },     -- #F24B93
    { 0xF2 / 255, 0x4B / 255, 0x93 / 255 },     -- #F24B93

    { 0xCE / 255, 0x46 / 255, 0xB3 / 255 },     -- #CE46B3
    { 0xCE / 255, 0x46 / 255, 0xB3 / 255 },     -- #CE46B3

    { 0x99 / 255, 0x45 / 255, 0xCD / 255 },     -- #9945CD
}


local function gradientAt(i)
    local index = math.floor((i / 10) * #gradient_colors) + 1
    index = math.max(1, math.min(#gradient_colors, index))
    return gradient_colors[index]
end


function PurpleGradient:init(x, y)
    super.init(self, x or 0, y or 0)

    self.siner = 0
    self.amt = 1
    self.fade = 0
end

local function fillRect(x1, y1, x2, y2)
    local x = math.min(x1, x2)
    local y = math.min(y1, y2)
    local w = math.abs(x2 - x1)
    local h = math.abs(y2 - y1)
    love.graphics.rectangle("fill", x, y, w, h)
end

function PurpleGradient:draw()
    local ac = 1.5 + math.sin(self.siner / 20)
    self.siner = self.siner + 1

    Draw.setColor(1, 1, 1, 1)

    for i = 0, 9 do
        local t = i / 9
        local color = gradientAt(i)

        Draw.setColor(color[1], color[2], color[3], (0.8 - (i / 16)) * self.amt)

        fillRect(
            -10, SCREEN_HEIGHT - (i * i * ac),
            SCREEN_WIDTH + 10, SCREEN_HEIGHT - ((i + 1) * (i + 1) * ac)
        )
    end

    Draw.setColor(1, 1, 1, 1)

    if self.fade == 1 then
        self.amt = self.amt - 0.03
        if self.amt < 0.05 then
            self:remove()
        end
    end

    super.draw(self)
end

return PurpleGradient
