local Map, super = HookSystem.hookScript(Map)

function Map:init(world, data) 
    super.init(self, world, data)
    if data then 
    self.w = data.properties and data.properties["weather"] or nil 
    self.persist = (data.properties and data.properties["weather_persist"]) or false 
    else 
    self.w = nil 
    self.persist = false 
    end 
end 

function Map:onEnter()
    super.onEnter(self)
    if self.w then 
    if type(self.w) ~= "string" then return error("Weather set in "..self.id.." is not a string!") end  
    Game.stage:setWeather(self.w, self.persist)
    end 
end 

return Map
