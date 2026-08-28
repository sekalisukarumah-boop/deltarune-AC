local Object, super = HookSystem.hookScript(Object)

local wave_shader = love.graphics.newShader([[
    extern number wave_sine;
    extern number wave_mag;
    extern number wave_height;
    extern vec2 texsize;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
        number i = texture_coords.x * texsize.x;
        vec2 coords = vec2(max(0.0, min(1.0, texture_coords.x + 0.0)), max(0.0, min(1.0, texture_coords.y + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.y)));
        return Texel(texture, coords) * color;
    }
]])

function Object:onAddToStage(stage)
    super.onAddToStage(self, stage)
     if Game.stage then
            local NONONO = {
                LightMenu,
                LightItemMenu,
                LightCellMenu,
                LightStatMenu,
                BattleUI,
                TensionBar,
                Textbox,
                DustPiece
            }

            local number = 0
            for i, cc in ipairs(NONONO) do
                if self:includes(cc) then
                    number = number + 1
                    break
                end
            end

            local yes = true
            if number ~= 0 then yes = false end

            local yes2 = false
            if Game.stage:hasWeather("volcanic") or Game.stage:hasWeather("hot") then yes2 = true end

            local yes3 = false
            if not self:getFX("wave_fx") then yes3 = true end

            if Game.stage and Game.stage.weather and yes and yes2 and yes3 then
                
                local wave_fx = ShaderFX(wave_shader, {
                    ["wave_sine"] = function() return Kristal.getTime() * 50 end,
                    ["wave_mag"] = function () return 0.5 end,
                    ["wave_height"] = function () return 8 end,
                    ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
                }, false, 10)

                self:addFX(wave_fx, "wave_fx")
            end
    end 
end 


return Object

