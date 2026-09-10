local Map, super = HookSystem.hookScript(Map)

function Map:load()
    super.load(self)
    if StringUtils.contains(Game.world.map.id, "recep") or (self.data and self.data.properties["rain"]) then 
    Game.world:addChild(RainTint()):setLayer(WORLD_LAYERS["below_textbox"])
    end 
end 

return Map
