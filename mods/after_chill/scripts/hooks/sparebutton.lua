local SpareButton, super = HookSystem.hookScript(SpareButton)

function SpareButton:init(battler, x, y)
    super.init(self, battler, x, y)
    if Game:getFlag("geno") then
    self.disabled = true 
    end 
end

return SpareButton
