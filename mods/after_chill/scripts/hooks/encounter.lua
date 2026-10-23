local Encounter, super = HookSystem.hookScript(Encounter)

function Encounter:init(...)
    super.init(self, ...)
    self.snow_background = true 
end 

function Encounter:onStateChange(old, new, reason) 
   if old == "INTRO" and new == "ACTIONSELECT" then
        if Game:getFlag("geno") then 
        local mus = Game.battle.music:tell()
        Game.battle.music:play("snowstorm_g")
        Game.battle.music:seek(mus)
        self.music = "snowstorm_g"
        end 
    end 
    super.onStateChange(self, old, new, reason)
end 

function Encounter:createBackground()
    if self.snow_background then 
    return Game.battle:addChild(SnowflakeBG())
    else
    return super.createBackground(self)
    end 
end 
return Encounter
