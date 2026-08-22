local Battle, super = HookSystem.hookScript(Battle)

function Battle:postInit(state, encounter)
    super.postInit(self, state, encounter)
    if not self.encounter.background then if #Game.stage.weather > 0 then
            for i, w in ipairs(Game.stage.weather) do
                w.addto = self
            end
            Game.stage.addto = self
        end 
    end
end 

function Battle:onStateChange(old, new, reason) 
    super.onStateChange(self, old, new, reason) 
    if new == "TRANSITIONOUT" then 
        if not self.encounter.background then 
            if #Game.stage.weather > 0 then 
                for i, w in ipairs(Game.stage.weather) do 
                    w.addto = Game.world 
                end 
            end 
            Game.stage.addto = self 
        end 
    end 
end

return Battle

