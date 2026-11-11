local honey_tree, super = Class(Event)

function honey_tree:init(data)
    super.init(self, data.x, data.y, data.width, data.height)
    local properties = data.properties or {}
    local name = properties["name"] or "norm"
    self:setSprite("tilesets/trees/"..name.."_tree_sap")
    self:setOrigin(0.5, 1)
    if name == "norm" then 
    self:setScale(0.75)
    elseif name == "rose" then  
    self:setScale(1)
    elseif name == "moon" then 
    self:setScale(0.75)
    end 
end 

return honey_tree