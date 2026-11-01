local licksby, super = Class(EnemyBattler)

function licksby:init()
    super.init(self)

    self.name = "Licksby"
    self:setActor("licksby")

    self.max_health = 220
    self.health = 220
    self.tired_percentage = 0.2
    self.attack = 8
    self.defense = 13
    self.money = 54

    self.spare_points = 20

    self.waves = {}

    self.experience = 22

    self.dialogue = {} 
    self.check = {
        "AT 8 DF 13\n* Feline malware,[wait:3] wags its mouse to move your cursor.", 
        "It wants a download of affection,[wait:2] try [color:yellow]PETTING[color:reset] it!"
    }

    self.text = {
        "* Smells like encrypted cookies.",
        "* The power of kaomoji faces\nis in the air.", 
        "* Licksby smiles at you,[wait:3] showing all its teeth.[wait:3]\n* They looks ready to byte.", 
        "* You start to remember your search history.[wait:7]\n* Oh no."
    }

    self:registerAct("Wag")
    self:registerAct("Pet")
    self:registerAct("PetX", "Gain\n100% Mercy", {"ralsei"}, 8)
end

function licksby:onActStart(battler, name)
    if name == "Wag" then 
        battler:setActSprite("party/kris/dark/wag_1", 0, 0)
    end 
    return super.onActStart(self, battler, name)
end 

function licksby:onAct(battler, name)
    if name == "Pet" then
    self:addMercy(50)
    return "* You pet the enemy's head![wait:3]\n* It nuzzles your hand!"
    elseif name == "Wag" then 
        battler:setSprite("wag_1")
        return { 
            "* You wagged your tail\nwith the enemy!", 
            "* They had fun with you!"
        }
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

return licksby
