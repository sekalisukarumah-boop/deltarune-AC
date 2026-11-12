local honey_tree, super = Class(Event)

function honey_tree:init(data)
    super.init(self, data.x, data.y, data.width, data.height)
    self.solid = true
    local properties = data.properties or {}
    self.name = properties["name"] or "norm"

    self.harvested = self:getFlag("harvested", false)

    if self.harvested then
        self:setSprite("tilesets/trees/"..self.name.."_tree")
    else
        self:setSprite("tilesets/trees/"..self.name.."_tree_sap")
    end

    self:setOrigin(0.5, 1)

    if self.name == "rose" then  
        self:setScale(1)
    else 
        self:setScale(0.75)
    end 

    self.particle_timer = 0
end 

function honey_tree:update()
    super.update(self)

    if not self.harvested then
        self.particle_timer = self.particle_timer + DT 
        if self.particle_timer > (1/3) then 
            self.particle_timer = MathUtils.random(-1.5, -0.5)
            local rx, ry = self:getRelativePos(self.width/2, (self.height/2) + 30) 
            local spr = Sprite("effects/spare/star", rx + (love.math.random(-8, 8)), ry) 
            self.parent:addChild(spr) 
            spr:setScale(2) 
            spr:play(0.1, true)  
            spr:setLayer(self.layer + 0.01)
            spr.physics.speed_y = MathUtils.random(0.32, 0.45)
            spr.physics.gravity = MathUtils.random(0.32, 0.45)
            spr:setScale(MathUtils.random(0.6, 1.2))
            spr:fadeOutAndRemove(MathUtils.random(0.5, 0.7))
            spr:setOrigin(0.5, 0.5)
            spr.graphics.spin = MathUtils.random(0.2, 0.6)      

            if love.math.random(1, 2) == 1 then 
                spr:addFX(ColorMaskFX(ColorUtils.hexToRGB("#F58F00")))
            else 
                spr:addFX(ColorMaskFX(ColorUtils.hexToRGB("#D65E2D")))
            end
        end 
    end
end



function honey_tree:onInteract(player, dir)
    if dir ~= "up" then
        return false
    end

    Game.world:startCutscene(function(cutscene)
        if not self.harvested then
            cutscene:text("* There is a thick patch of glowing sap oozing from the bark.")
            local choice = cutscene:textChoicer("* Collect the Glowy Resin?", {"Yes", "No"})

            if choice == 1 then
                local s = Assets.playSound("grab")
                cutscene:wait(s:getDuration())
                local success, text = Game.inventory:tryGiveItem("glowy_resin")

                if success then
                    Assets.playSound("item")
                    self.harvested = true
                    self:setFlag("harvested", true)
                    self:setSprite("tilesets/trees/"..self.name.."_tree")

                    cutscene:text("* You scraped off the sap.[wait:5]\n" .. text)
                else
                    cutscene:text(text)
                end
            else
                cutscene:text("* You decided to leave the tree alone.")
            end
        else
            cutscene:text("* Just an ordinary tree now.[wait:5]\n* The bark feels slightly sticky.")
        end
    end)

    return true 
end 

return honey_tree
