local snake, super = Class(EnemyBattler)

function snake:init()
    super.init(self)

    self.name = "Beadie"
    self:setActor("snake")

    self.max_health = 340
    self.health = 340
    self.attack = 7  
    self.defense = 7
    self.money = 54

    self.spare_points = 0

    self.waves = {
    }

    self.experience = 34 

    self.dialogue = {} 
    self.check = {
        "AT 9 DF 10\n* Once part of a bouquet.\n* It fell off a flower.", 
        "It has lost the path it was meant\nto follow,[wait:5] and has now found its\nway into the arena."
    }

    self.text = {
        "* The wind sways Peonie around.",
        "* Smells like pollen.", 
        "* A cold draft passess through.", 
    }
    self:registerAct("Bloom", "Get\nMercy")
end
function snake:onAct(battler, name)
    if name == "Bloom" then
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* You tell Peonie that just because\nit left its own flower...")
            cutscene:text("* Doesn't mean it can't bloom into a new, even more wonderful one!")
        end)
    elseif name == "Standard" then 
        if battler.chara.id == "ralsei" then 
            self:addMercy(50)
            return {
            "* Ralsei tried to gently brush dirt off the enemy!", 
            "* The enemy feels cared for\nand happy!", 
            }
        end 
    end 
    return super.onAct(self, battler, name)
end

return snake
