local World, super = HookSystem.hookScript(World) 

function World:setupMap(map, ...) 
    super.setupMap(self, map, ...) 
    local weather = Game.stage.last_weather 
    Game.stage.overlay = {} 
    
    if self.map.inside or self.map.data.properties["inside"] then 
        Game.stage:pauseWeather("inside") 
    elseif Game.stage.pause_reason == "inside" then 
        Game.stage:playWeather() 
        Game.stage.wpaused = false 
        -- print("played") 
    end 
    
    if not Game.stage.keep_weather then 
        Game.stage:resetWeather() 
    end 
end 

return World
