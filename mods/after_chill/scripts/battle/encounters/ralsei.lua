local ralsei, super = Class(Encounter)

function ralsei:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Ralsei unwillingly blocks your way."

    -- Battle music ("battle" is rude buster)
    self.music = "ralsei"
    -- Enables the purple grid battle background
    self.background = false 
    self.hide_world = false 

    -- Add the dummy enemy to the encounter
    self:addEnemy("ralsei", 533, 271)


    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function ralsei:onStateChange(old, new) 
    if old == "INTRO" and new == "ACTIONSELECT" then
            self:setFlag("ralsei", true)
            Game:saveQuick(141, 435)
            Game.battle.battle_ui:clearEncounterText()
            Game.battle.seen_encounter_text = false
            Game.battle.current_selecting = 0         
            Game.battle:startCutscene(function(cutscene)
            local ralsei = Game.battle:getEnemyBattler("ralsei")
            ralsei:setAnimation("spell", function()
            Game.battle.background = Game.battle:addChild(FireGlow())
            end)
        end)
    end 
end


function ralsei:getPartyPosition(index)
    if index == 1 then 
        return 113, 280
    end 
    return super.getPartyPosition(self, index)
end 

return ralsei
