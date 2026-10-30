local snake, super = Class(EnemyBattler)

function snake:init()
    super.init(self)

    self.name = "Beadie"
    self:setActor("snake")

    self.max_health = 340
    self.health = 340
    self.attack = 12 
    self.defense = 7
    self.money = 54

    self.spare_points = 0

    self.waves = {
    }

    self.experience = 34 

    self.dialogue = {} 
    self.check = {
        "AT 12 DF 7\n* A snake with a beaded body.\n* Hates being \"toyed\" around with.", 
    }

    self.text = {
        "* Faint clattering fills the air occasionally.",
        "* Smells like permanent marker and wood.", 
        "* You remember some childhood memories.", 
        "* Infinite...[wait:4] Infinite beads..."
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
