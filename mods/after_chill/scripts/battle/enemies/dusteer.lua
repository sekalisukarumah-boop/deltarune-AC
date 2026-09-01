local dusteer, super = Class(EnemyBattler)

function dusteer:init()
    super.init(self)

    self.name = "Reinfrost"
    self:setActor("dusteer")
    self.max_health = 340
    self.health = 340
    self.attack = 8
    self.defense = 7
    self.money = 100

    self.spare_points = 10
    self.wave_index = 1

    self.waves = { 
        "reinfrost/gallop", 
        "reinfrost/snow_graze"
    }
    self.dialogue = {"*neigh*", "Don't slip on\nthe tracks.", "It's snow problem."} 
    self.check = "AT 8 DF 7\n* A deer that likes the way you smell.\n* Tramples snow, try [color:yellow]sweeping[color:reset] it!"

    self.text = {
        "* A cold breeze runs through.\n* Reinfrost shakes a little.", 
        "* Smells like trampled snow.", 
        "* Reinfrost trots and kicks some\nsnow.", 
    }

    self.experience = 24
    self.low_health_percentage = 0.2
    self.dmg_sprite_offset = {30, 10}
    self.low_health_text = "* Reinfrost's antlers look slightly cracked."
    self:registerAct("Sweep", "Get\nMercy")
    self:registerAct("HeatUp", "Get\n80% Mercy", {"ralsei"}, 8)
    -- Game.battle:registerXAction("N-Sweep", "Get\nMercy")
end

function dusteer:getNextWaves()
    local wave = self.waves[self.wave_index]
    self.wave_index = self.wave_index + 1
    if self.wave_index > #self.waves then
        self.wave_index = 1
    end
    return { wave }
end

function dusteer:onAct(battler, name)
    if name == "Sweep" then    
        Game.battle:startActCutscene(function(cutscene)
            battler:setAnimation("sweep")
            cutscene:text("* You pick up some snowflakes that drifted into the arena.")
            battler:setAnimation("battle/idle")
            cutscene:text("* Reinfrost is embarassed that they left snow tracks![wait:5]\n* They appreciate the gesture!")
            self.dialogue_override = "Thanks for\ntidying up."
            self:addMercy(50)
        end)
    elseif name == "HeatUp" then 
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* You and Ralsei gave warm smiles to the enemy!")
            cutscene:wait(0.2)
    --        cutscene:text("* (Kris,[wait:3] they must be freezing! The poor things!)")
            local ralsei = Game.battle:getPartyBattler("ralsei")
            ralsei:setAnimation("battle/alt_spell")
            cutscene:wait(0.2)
            local spr = Sprite("effects/hazy_glow", 62, 119) 
            spr.alpha = 0 
            spr:setScale(0)
            ralsei.parent:addChild(spr) 
            spr:setLayer(ralsei.layer - 0.01)
            spr:setScaleOrigin(0.5, 0.5)
            spr:setColor(COLORS.orange)
            local snd = Assets.playSound("spell_cure_slight_smaller")
            Game.battle.timer:tween(snd:getDuration(), spr, {alpha = 1, scale_x = 0.5, scale_y = 0.5})
            cutscene:wait(snd:getDuration())
            spr:fadeOutAndRemove(0.4)
            Assets.playSound("explosion")
            spr.graphics.grow = 9
            cutscene:wait(0.5)
            self:addMercy(75)
            cutscene:text("* Ralsei spread heat across the arena![wait:5]\n* The enemy was flattered!")
        end)
    elseif name == "Standard" then 
        if battler.chara.id == "ralsei" then 
            battler:setAnimation("battle/spell")
            Assets.playSound("spellcast")
            for _, enemy in ipairs(Game.battle:getActiveEnemies()) do 
                if enemy.id == "dusteer" then  
                    enemy:addMercy(50)
                else 
                    enemy:addMercy(25)
                end 
            end 
            return "* Ralsei tried to heat up the arena![wait:5]\n* The enemies felt comforted!"
        end 
    end 
    return super.onAct(self, battler, name)
end

return dusteer
