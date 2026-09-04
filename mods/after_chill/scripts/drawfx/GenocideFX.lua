---@class GenocideFX: ShaderFX
---@field shader love.Shader
local GenocideFX, super = Class(ShaderFX)

function GenocideFX:init(priority)
    super.init(self, "hsv_transform", {}, nil, priority)

    self.hue_start = 0
    self.sat_start = 0.5  
    self.val_start = 1     
    
    self.hue_target = 0
    self.sat_target = 0.05    
    self.val_target = 0.85
    
    self.progress = 0
    self.wave_time = 4    
    self.heartbeat_mode = false
    self.activation_time = 0 
end

function GenocideFX:update()
    super.update(self)
    
    local current_hue, current_sat, current_val

    if self.progress >= 1 and not self.heartbeat_mode then
        self.heartbeat_mode = true
        self.activation_time = Kristal.getTime()
    end

    if not self.heartbeat_mode then
        current_hue = Utils.lerp(self.hue_start, self.hue_target, self.progress)
        current_sat = Utils.lerp(self.sat_start, self.sat_target, self.progress)
        current_val = Utils.lerp(self.val_start, self.val_target, self.progress)
    else
        local elapsed = Kristal.getTime() - self.activation_time
        current_hue = Mod.scr_wave_relative(self.hue_target, self.hue_target, self.wave_time, elapsed)
        current_sat = Mod.scr_wave_relative(self.sat_target, self.sat_target + 0.05, self.wave_time, elapsed)
        current_val = Mod.scr_wave_relative(self.val_target, self.val_target - 0.10, self.wave_time, elapsed)
    end
    
    self.shader:send("_hsv", {current_hue, current_sat, current_val})
end

return GenocideFX
