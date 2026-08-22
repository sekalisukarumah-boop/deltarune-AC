WeatherLib = {}

function WeatherLib:init()
    WeatherRegistry.init()
end

function WeatherLib:postInit() 
    local weather = Game:getFlag("weather_save") 
    if weather then 
        Game.stage:setWeather(
            weather.typer, 
            weather.keep, 
            weather.sfx, 
            Game.stage:getWeatherParent()
        ) 
    end 
end

------------------------------ function copies, added V1.1.0, 

-- REMOVED by fluffyboy. If really needed, uncomment all of these.

-- function WeatherLib:setWeather(...)
--     Game.stage:setWeather(...)
-- end

-- function WeatherLib:resetWeather(...)
--     Game.stage:resetWeather(...)
-- end

-- function WeatherLib:keepWeather(...)
--     Game.stage:keepWeather(...)
-- end

-- function WeatherLib:getWeathers(...)
--     return Game.stage:getWeathers(...)
-- end

-- function WeatherLib:hasWeather(...)
--     return Game.stage:hasWeather(...)
-- end

-- function WeatherLib:getWeatherParent(...)
--     return Game.stage:getWeatherParent(...)
-- end

-- function WeatherLib:setWeatherParent(...)
--     Game.stage:setWeatherParent(...)
-- end

-- function WeatherLib:setWeatherLayer(...)
--     Game.stage:setWeatherLayer(...)
-- end

-- function WeatherLib:resetWeatherLayer(...)
--     Game.stage:resetWeatherLayer(...)
-- end

-- function WeatherLib:getWeatherLayer(...)
--     Game.stage:getWeatherLayer(...)
-- end

return WeatherLib