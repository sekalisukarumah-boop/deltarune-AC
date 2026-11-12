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
