local ralsei, super = Class(Encounter)

function ralsei:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Ralsei's [color:yellow]defense[color:reset] is high.[wait:5]\n* Ralsei can heal himself.[wait:5]\n* Ralsei will attempt to induce [color:blue]TIRED[color:reset]."

    -- Battle music ("battle" is rude buster)
    self.music = "ralsei_v"
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
            local battler = Game.battle.party[1]
            local snd = Assets.playSound("boost")
            local fx = ralsei:addFX(ColorMaskFX(COLORS.white, 0))
            Game:getPartyMember("ralsei"):setFlag("serious", true)
            ralsei:setAnimation("attack")
            Game.battle.timer:tween(0.4, fx, {amount = 1})
            cutscene:wait(0.4)
            Game.battle.timer:tween(0.4, fx, {amount = 0})
            cutscene:wait(0.5)
            ralsei:setAnimation("spell")
            Game.stage:addFX(HSVShiftFX(false, 99), "shiftfx")
            Game.world:addChild(ralsei.vig)
            ralsei.vig:fadeTo(0.75, 0.3)
            ralsei.vig:setPosition(322, 165)
            Assets.playSound("spell_cure_slight_smaller")
            ralsei.vig:flash()
            Game.battle.background = Game.battle:addChild(FireGlow())
            Game.battle.battle_ui.action_boxes[1].buttons[4].disabled=true
            cutscene:wait(0.7)
            ralsei:setHardMode()
            cutscene:after(function()
                battler:resetSprite()
                Game.battle:setState("DEFENDINGBEGIN", {"ralsei/fireshock"})
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
