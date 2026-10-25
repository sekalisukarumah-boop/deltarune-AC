---@class Bouquet : Object
local Bouquet, super = Class(Object)

function Bouquet:init(x, y)
    super.init(self, x, y)

    self.spr_amount = 100

    self.top_sprite = Sprite("bouquet/top", 0, 0)
    self.top_sprite.debug_select = false 
    self:addChild(self.top_sprite)
    self.top_sprite:setOrigin(0.5, 0.5)
    self.top_sprite:setScale(4)

    self.width = (self.top_sprite.width) * 4
    self:setOrigin(0.5, 0.5)
    self.height = (self.top_sprite.height) * 4

    self.c_sprite = Sprite("bouquet/container", 0, math.floor(self.top_sprite.y - (-6 * self.top_sprite.scale_x / -2)))
    self.c_sprite.debug_select = false 
    self:addChild(self.c_sprite)
    self.c_sprite:setOrigin(0.5, 0.5)
    self.c_sprite:setScale(4)

    self:fillWithSprites({"enemies/peonie/idle"})
end

function Bouquet:getDebugRectangle()
    return {-self.width/2, -self.height/2, self.width, self.height}
end

function Bouquet:fillWithSprites(tbl)
    local visual_rx = (self.top_sprite.width * self.top_sprite.scale_x) / 2
    local visual_ry = (self.top_sprite.height * self.top_sprite.scale_y) / 2
    local pad_x = 40
    local pad_y = 40

    local spacing_x = 22
    local spacing_y = 18

    local min_x = -visual_rx + pad_x
    local max_x =  visual_rx - pad_x
    local min_y = -visual_ry + pad_y
    local max_y =  visual_ry - pad_y

    for grid_y = min_y, max_y, spacing_y do
        for grid_x = min_x, max_x, spacing_x do
            local jitter_x = love.math.random(-4, 4)
            local jitter_y = love.math.random(-4, 4)
            
            local final_x = grid_x + jitter_x
            local final_y = grid_y + jitter_y
            if final_x >= min_x and final_x <= max_x and final_y >= min_y and final_y <= max_y then
                local path = TableUtils.pick(tbl) 
                local spr = Sprite(path, final_x, final_y)
                spr.debug_select = false 
                self:addChild(spr)
                spr:setScale(1)
                spr.rotation = math.rad(love.math.random(-45, 45))
                spr:setOrigin(0.5, 0.5)
                spr:setLayer(self.top_sprite.layer - 1)
            end
        end
    end
end

-- doBreak(-115, -76, "break_2")
-- doBreak(-60, -23, "break_1")

function Bouquet:doBreak(ex, ey, spr)
    Assets.playSound("explosion", 0.7, 1.1)
    self:shake(6)
    Game.stage.timer:after(0.3, function() Assets.stopSound("explosion") end)
    local exp = Sprite("effects/firespell/explosion/spr_omegaflowery_explosion_a", ex, ey)
    self.top_sprite.parent:addChild(exp)
    exp:setScale(0.6)
    exp:play(0.05, false, function() exp:remove() end)
    exp:setLayer(9999)
    spr = spr or "break_1"
    self.top_sprite:setSprite("bouquet/" .. spr) 
end 



return Bouquet
