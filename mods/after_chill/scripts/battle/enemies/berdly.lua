local berdly, super = Class(EnemyBattler)

function berdly:init()
    super.init(self)
    self.name = "Berdly"
    self:setActor("iced_berdly")

    self.max_health = 280
    self.health = 280
    self.attack = 18
    self.defense = 12
    self.money = 40
    self.tired_percentage = 0 
    self.dialogue = ""

    self.spare_points = 0

    self.check = "AT 18 DF 12[wait:5]\n* Not so frozen anymore.[wait:5]\n* Will always protect Noelle."

    self.text = {}
 
    self.waves = {}
    self:registerAct("Glare", "Get\nMercy")
    self:registerAct("ConvinceX", "", {"ralsei"})
end

function berdly:onAct(battler, name)
    if name == "Glare" then 
        self:addMercy(8)
        return "* You psyched out Berdly by taunting Noelle!\n* He got flustered!"
    elseif name == "ConvinceX" then 
        return {
            "* You and Ralsei tried to convince Berdly you mean no harm.", 
            "[wait:10]* Berdly was too ignorant to listen to you!"
        }
    else 
    return super.onAct(self, battler, name)
    end 
end

return berdly
