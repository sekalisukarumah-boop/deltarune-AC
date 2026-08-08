---@class ChurchFogBattle : Object
local ChurchFogBattle, super = Class(Object, "ChurchFogBattle")

function ChurchFogBattle:init(x, y)
    super.init(self, x, y)

    self.ss = 0.5
    self.ssy = 0.1
    self.auto = 0
    self.autoy = 0
    self.shadoweffect = 0
    self.siner = 0
    self.accounty = 0

    self.xoff = ((0 + self.auto) * self.ss) + self.x
    self.yoff = ((0 + self.autoy) * self.ssy) + self.y

    self.mysprite = Assets.getTexture("battle/churchfog")
    self.sprwidth = self.mysprite:getWidth() * 2
    self.sprheight = self.mysprite:getHeight() * 2

    -- Fullscreen background effect, don't let the camera cull it
    self.parallax_x = 0
    self.parallax_y = 0
end

local function draw_sprite_tiled_ext(tex, _, x, y, sx, sy, rotation, color, alpha)
    local r, g, b, a = love.graphics.getColor()
    if color then
        Draw.setColor(color, alpha)
    end
    Draw.drawWrapped(tex, true, true, x, y, rotation, sx, sy)
    love.graphics.setColor(r, g, b, a)
end

function ChurchFogBattle:update(dt)
    self.auto = self.auto + (2 * DTMULT)
    self.autoy = self.autoy + (2 * DTMULT)
    super.update(self, dt)
end

function ChurchFogBattle:draw()
    local cx, cy = love.graphics.transformPoint(0, 0)
    love.graphics.origin()

    self.ss = 0.5
    self.ssy = 0.5
    self.xoff = ((cx + self.auto) * self.ss) + self.x
    self.yoff = ((cy + self.autoy) * self.ssy) + self.y
    self.mytransparency = 0.4

    local finalxoff = self.xoff % self.sprwidth
    local finalyoff = self.yoff % self.sprheight

    local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.clear(0, 0, 0, 1)
    draw_sprite_tiled_ext(self.mysprite, 0, cx - finalxoff, cy - finalyoff, 2.5, 2.5, 0,     COLORS.blue, self.mytransparency)
    Draw.popCanvas()

    love.graphics.setBlendMode("add", "premultiplied")
    Draw.draw(canvas)
    love.graphics.setBlendMode("alpha", "alphamultiply")

    super.draw(self)
end

return ChurchFogBattle