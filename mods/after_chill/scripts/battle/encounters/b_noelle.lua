local b_noelle, super = Class(Encounter)

function b_noelle:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The old study buddies block your way.[wait:5]\n* [color:yellow]TP[color:reset] reduced outside of [color:blue]???[color:reset]"

    self.music = "noelle"
    self.reduced_tension = true 
    -- Enables the purple grid battle background
    self.background = false 
    self.hide_world = false 
    self:addEnemy("berdly", 498, 167)
    self:addEnemy("noelle", 551, 285)
    Game.battle.church = Game.battle:addChild(ChurchFogBattle())
end

function b_noelle:getPartyPosition(i)
    if i == 1 then 
        return 161, 165 
    else 
        return super.getPartyPosition(self, i)
    end 
end  

function b_noelle:onBattleStart()
    Game.fader:fadeOut(function()
        super.onBattleStart(self) 
        Game.fader:fadeIn(nil, {speed = 0.2}) 
    end, {speed = 0.4, color = {204/255, 255/255, 255/255}})
end


return b_noelle
