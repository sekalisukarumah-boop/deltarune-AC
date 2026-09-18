---@class Bouquet : Object
local Bouquet, super = Class(Object)

function Bouquet:init(x, y)
    super.init(self, x, y)

    self.spr_amount = 100

    self.top_sprite = Sprite("bouquet/top", 0, 0)
    self:addChild(self.top_sprite)
    self.top_sprite:setOrigin(0.5, 0.5)
    self.top_sprite:setScale(4)

    self.c_sprite = Sprite("bouquet/container", 0, math.floor(self.top_sprite.y - (-6 * self.top_sprite.scale_x / -2)))
    self:addChild(self.c_sprite)
    self.c_sprite:setOrigin(0.5, 0.5)
    self.c_sprite:setScale(4)

    self:fillWithSprites({"enemies/peonie/idle"})
end

function Bouquet:fillWithSprites(tbl)
    local rx = (self.top_sprite.width * self.top_sprite.scale_x) / 2
    local ry = ((self.top_sprite.height) * self.top_sprite.scale_y) / 2
    local pad_x = 26
    local pad_y = 14
    rx = rx - pad_x
    ry = ry - pad_y

    local spacing_x = 22
    local spacing_y = 18

    for grid_y = -ry, ry, spacing_y do
        if grid_y > ry * 0.85 then 
            break 
        end

        for grid_x = -rx, rx, spacing_x do
            local jitter_x = love.math.random(-4, 4)
            local jitter_y = love.math.random(-4, 4)
            
            local final_x = grid_x + jitter_x
            local final_y = grid_y + jitter_y

            if ((final_x * final_x) / (rx * rx)) + ((final_y * final_y) / (ry * ry)) <= 1 then
                local path = TableUtils.pick(tbl) 
                
                local spr = Sprite(path, final_x, final_y - 16)
                self:addChild(spr)
                spr:setScale(1)
                spr.rotation = math.rad(love.math.random(-45, 45))
                spr:setOrigin(0.5, 0.5)
                
                spr:setLayer(self.top_sprite.layer - 1)
            end
        end
    end
end

function Bouquet:doBreak(snd, ex, ey)
    if snd then Assets.playSound(snd) end 
    self:shake()
    local exp = Sprite("effects/firespell/explosion/spr_omegaflowery_explosion_a", ex, ey)
    self:addChild(exp)
    exp:setScale(0.2)
    exp:play(0.05, false, function() exp:remove() end)
    exp:setLayer(9999)
 --   self.top_sprite:setSprite("crack_1")
end 



return Bouquet
