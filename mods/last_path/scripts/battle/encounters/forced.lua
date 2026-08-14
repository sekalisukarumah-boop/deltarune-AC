local forced, super = Class(Encounter)

function forced:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Noelle can't stop attacking.\n* (Tension is high.)"
    self.music = "scary"
    -- Enables the purple grid battle background
    self.background = false 
    self.hide_world = false  
    self.dialogue_lines = {
    [1] = {
        {"Calm down\nplease..!"},
    },
    [2] = {
        {"If you keep attacking me..."},
        {"I might..."}, 
    }
}
    self:addEnemy("ralsei_forced", 558, 281)
end

function forced:getPartyPosition(i)
    if i == 1 then 
        return 125, 293
    else 
        return super.getPartyPosition(self, i)
    end 
end 

function forced:onBattleStart()
    Game:setTension(32)
    Game.battle.music:setVolume(0.8)
    return super.onBattleStart(self)
end

function forced:getDialogueCutscene()
    local turn = Game.battle.turn_count
    local lines = self.dialogue_lines[turn]
    if lines then
        return function(cutscene)
            for _, data in ipairs(lines) do
                local text = data[1]     
                    cutscene:wait(cutscene:battlerText("ralsei_forced", text))
            end
        end 
    end 
end

return forced
