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

    self.dialogue_offset = {-2, 10}

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

    self:registerAct("Pet", "Gain\n50% Mercy", {}, 4)
    self:registerAct("Wag", "Gain\n25% Mercy")
    self:registerAct("PetX", "Gain\n100% Mercy", {"ralsei"}, 8)
end

function licksby:onActStart(battler, name)
    if name == "Wag" then
        if battler.chara.id == "kris" then 
        battler:setActSprite("party/kris/dark/wag", -4, 6, 1/8, true)
        end 
    else 
    return super.onActStart(self, battler, name)
    end 
end 

function licksby:getEnemyDialogue()
    if self.mercy >= 50 and not (self.health <= self.max_health/2) then 
        return TableUtils.pick({">w<", "(=^.v.^=)", "*purrs*"})
    elseif self.health <= self.max_health/2 then 
        local random_error = MathUtils.randomInt(356, 404)
        return TableUtils.pick({"(=x_x=)", "Meow-ware is crashing...", "(o-o)", "ERROR "..random_error.."!"}) 
    else 
        return TableUtils.pick({"Uwa~ So cozy!", "Ooo,[wait:5] glowy snow!", '-v-"'})
    end 
end


function licksby:onAct(battler, name)
    if name == "Pet" then
       Game.battle:startActCutscene(function(cutscene)    
         cutscene:text("* You pet the enemy,[wait:2] and scratched it's ears![func:mercy][wait:7]\n* Licksby purred,[wait:2] nuzzling your hand!", {
        functions = {
            mercy = function()
                self:addMercy(50)
            end
        }})
       end)
    elseif name == "Wag" then 
        Game.battle:startActCutscene(function(cutscene)         
        cutscene:text("* You pretend to wag your tail with the enemy!")
        battler:shake(2)
        battler:resetSprite()
        self:addMercy(25)
        cutscene:wait(cutscene:playSound("wing"))
        cutscene:text("* The enemy smiled and wagged\nits tail faster!")
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

return licksby
