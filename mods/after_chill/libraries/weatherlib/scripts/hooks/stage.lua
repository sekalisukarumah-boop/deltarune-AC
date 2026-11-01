local Stage, super = HookSystem.hookScript(Stage)

function Stage:setWeather(typer, keep, sfx, addto)
    local weather_type = {} 
    local wrongtype = false 
    local istable = false 
    local nuh_uh = false 
    local possible_types_a = { 
        "rain", "thunder", "snow", "wind", 
        --"volcanic", "chilly", "cloudy", "overcast", "dark_overcast", 
        --"hot", "clear", "cd", 
    } 
    local possible_types = possible_types_a 

    if Kristal.getLibConfig("weatherlib", "extraWeathers") then 
        possible_types = TableUtils.merge(possible_types_a, Kristal.getLibConfig("weatherlib", "extraWeathers")) 
    end 

    if type(typer) == "string" then 
        typer = {typer} 
    end 

    if typer and type(typer[2]) ~= "number" then 
        for i, t in ipairs(typer) do 
            if type(t) ~= "table" then 
                t = {t, 1} 
                table.remove(typer, i) 
                table.insert(typer, i, t) 
            else 
                if #t < 2 then 
                    table.insert(t, 2, 1) 
                end 
            end 
        end 
    elseif typer and #typer == 2 and type(typer[2]) == "number" then 
        typer = {typer} 
    end 

    if sfx == nil then 
        sfx = true 
    end 

    if type(typer) == "table" then 
        TableUtils.merge(weather_type, typer) 
    end 

    for i, symb in ipairs(weather_type) do 
        for i, again in ipairs (symb) do 
            if i == 1 then 
                local number = 0 
                for i, symb2 in ipairs(possible_types) do 
                    if again == symb2 then 
                        number = number + 1 
                    end 
                end 
                if number < 1 then 
                    wrongtype = true 
                end 
            end 
        end 
    end 

    local haveoverlay = true 
    if typer then 
        for i, all in ipairs(typer) do 
            if all[1] == "clear" then 
                haveoverlay = false 
            end 
        end 
    end 

    if not typer or typer[1][1] == "none" then 
        self.weather_type = nil 
        self.keep_weather = nil 
        if self.overlay then 
            if self.weather then 
                for i, o in ipairs(self.overlay) do 
                    o[2]:remove() 
                end 
            end 
        end 
        self.overlay = {} 
        if self.weather then 
            for i, weather in ipairs(self.weather) do 
                weather:remove() 
            end 
        end 
        self.weather = {} 
        self.weather_type = typer 
        if #self.weather > 0 then 
            Game:setFlag("weather_save", false) 
        end 
        self.addto = nil 
    elseif wrongtype then 
        local first = typer[1][1] 
        for i, ty in ipairs(typer) do 
            if #typer > 1 and i > 1 then 
                first = first + " + " + ty[1] 
            end 
        end 
        error("Attempt to set nonexistent weather \"" .. first .."\"") 
    else 
        self.weather_type = nil 
        self.keep_weather = nil 
        if self.overlay then 
            if self.weather then 
                for i, o in ipairs(self.overlay) do 
                    o[2]:remove() 
                end 
            end 
        end 
        if self.weather then 
            for i, weather in ipairs(self.weather) do 
                weather:remove() 
            end 
        end 
        self.weather = {} 
        self.overlay = {} 
        if keep then 
            self.keep_weather = true 
        end 
        
        for i, typ in ipairs (typer) do 
            local w 
            local possible_types_again = { 
                "rain", "thunder", "snow", "wind", "volcanic", "chilly", 
                "cloudy", "overcast", "dark_overcast", "hot", "clear", "cd", 
            } 
            if Utils.containsValue(possible_types_again, typ[1]) then 
                w = self:addChild(WeatherHandler(typ[1], sfx, addto, typ[2], haveoverlay)) 
            else 
                local b = WeatherRegistry.createWeatherData(typ[1], sfx, addto, typ[2], haveoverlay) 
                w = self:addChild(b) 
            end 
            table.insert(self.weather, w) 
        end 
        
        local first = typer[1][1] 
        for i, ty in ipairs(typer) do 
            if #typer > 1 then 
                first = first + " + " + ty[1] 
            end 
        end 
        self.weather_type = first 
        self.last_weather = {typer, keep, sfx, addto} 
        Game:setFlag("weather_save", { typer = typer, keep = keep, sfx = sfx}) 
        if Game.world.map.inside or Game.world.map.data.properties["inside"] then 
            self:pauseWeather("inside") 
        end 
        self.addto = addto 
    end 
end


function Stage:hasWeather(weather)
    if self.weather then
        if not weather then
            return (#self.weather > 0)
        else
            for i, w in ipairs(self.weather) do
                if w.type == weather then
                    return true
                end
            end
        end
        return false
    end
end

function Stage:getWeatherParent()
    if Game.battle then
        return Game.battle
    elseif Game.world then
        return Game.world
    elseif self:hasWeather() then 
        return self 
    else 
        return false 
    end  
end 

function Stage:setWeatherParent(parent) 
    if not parent then 
        parent = self:getWeatherParent() 
    end 
    if self.weather and #self.weather > 0 then 
        if parent then 
            for i, w in ipairs(self.weather) do 
                w.addto = parent 
            end 
            self.addto = parent 
        end 
    end 
end

function Stage:setWeatherLayer(l)
    self.weather_layer = l and l + 1 or nil
end 

function Stage:resetWeatherLayer()
    self.weather_layer = nil
end 

function Stage:getWeatherLayer()
    return self.weather_layer 
end 

function Stage:resetWeather()
    self:setWeather()
end 

function Stage:pauseWeather(reason) 
    if not self.wpaused then 
        if self.overlay then 
            if self.weather then 
                for i, o in ipairs(self.overlay) do 
                    o.paused = true 
                end 
            end 
        end 
        if self.weather then 
            for i, weather in ipairs(self.weather) do 
                weather.pause = true 
                if weather.weathersounds then
                    weather.weathersounds.volume = weather.weathersounds.volume / 4 
                    weather.weathersounds.pitch = weather.weathersounds.pitch - 0.09 
                end
            end 
        end 
        self.wpaused = true 
        if reason then 
            self.pause_reason = reason 
        end 
    end 
end

function Stage:playWeather() 
    if not self.wpaused then 
        error("WEATHERLIB: Attempt to play when not paused") 
    else 
        if self.overlay then 
            if self.weather then 
                for i, o in ipairs(self.overlay) do 
                    o.paused = false 
                end 
            end 
        end 
        if self.weather then 
            for i, weather in ipairs(self.weather) do 
                weather.pause = false 
                if weather.weathersounds then
                    weather.weathersounds.volume = weather.weathersounds.volume * 4 
                    weather.weathersounds.pitch = weather.weathersounds.pitch + 0.09 
                end
            end 
        end 
    end 
    self.wpaused = false 
    self.pause_reason = nil 
end

function Stage:keepWeather(keep)
    if keep == nil then keep = true end     
    if keep then self.keep_weather = true else self.keep_weather = false end
end 

function Stage:addWeatherOverlays()
    local possible_overlays = { 
        "chilly", "overcast", "dark_overcast", "hot", "clear", "cd", 
    } 
    local number = 0 
    
    if not self.weather or #self.weather < 1 then 
        return 
    end 
    
    for i, weather in ipairs(self.weather) do 
        if weather.type == "clear" then 
            number = 1 
            return 
        end 
    end 
    
    if number == 0 then 
        for i, weather in ipairs(self.weather) do 
            local overlay = weather:addOverlay() 
            table.insert(self.overlay, overlay) 
        end 
    end 
end

function Stage:getWeathers(item)
    if item == nil then 
        item = "object" 
    end 
    
    local function valid(string) 
        if string ~= "object" and string ~= "type" then 
            return false 
        else 
            return true 
        end 
    end 
    
    if type(item) ~= "string" or not valid(item) then 
        error("WEATHERLIB: argument must be a valid string. arguments include:\n[color:red]\"object\", \"type\"") 
        return 
    end 
    
    local tbl = {} 
    for _, weather in ipairs(self.weather) do 
        if item == "object" then 
            table.insert(tbl, weather) 
        elseif item == "type" then 
            table.insert(tbl, weather.type) 
        end 
    end 
    
    return tbl 
end

return Stage







