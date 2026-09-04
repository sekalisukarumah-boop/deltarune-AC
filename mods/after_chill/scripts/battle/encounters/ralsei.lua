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
        if self:getFlag("ralsei", false) == false then 
            self:setFlag("ralsei", true)
            Game.battle.music:setVolume(0)
            Game:saveQuick(141, 435)
            Game.battle.battle_ui:clearEncounterText()
            Game.battle.seen_encounter_text = false
            Game.battle.current_selecting = 0         
            Game.battle:startCutscene(function(cutscene)
                local ralsei = Game.battle:getEnemyBattler("ralsei")
                cutscene:wait(0.5)
                cutscene:battlerText("ralsei", "Kris,[wait:3] if you can't hear me...")
                cutscene:battlerText("ralsei", "Then I'll have to...[wait:2]\ntry and save\nyou myself!")
                cutscene:wait(0.3)
                cutscene:wait(cutscene:setAnimation(ralsei, "battle/spell"))
                -- cutscene:wait(0.6)
                -- local snd = Assets.playSound("snd_vsral")
                -- Game.fader:fadeOut(nil, {speed = 1})
                -- cutscene:wait(1)     
                -- local mask = ColorMaskFX({1, 1, 1}, 1)
                -- mask.amount = 0 
                -- local sprite = Sprite("party/kris/dark/sit", 75, 150)
                -- sprite:setScale(2)
                -- sprite:addFX(mask)
                -- Game.stage:addChild(sprite)
                -- sprite.layer = 1000
                -- sprite.alpha = 0 
                
                -- Game.battle.timer:tween(0.5, sprite, {alpha = 1}, "in-out-sine")
                -- Game.battle.timer:tween(0.5, mask, {amount = 1}, "in-out-sine")       
                
                -- local melody_text = DialogueText("[noskip][shake:0.6][speed:0.10][spacing:3][voice:none]A melody you once played.", 160, 240, {
                --     style = "none",
                --     align = "center"
                -- })
                -- melody_text:setOrigin(0.5, 0.5)
                -- melody_text.layer = 1000
                -- melody_text.x  = 346
                -- melody_text.y = 319
                -- Game.stage:addChild(melody_text)
                
                -- cutscene:wait(9.6)
                -- local rectangle = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                -- rectangle.color = COLORS.black 
                -- Game.stage:addChild(rectangle)
                -- rectangle.layer = 9000
                -- rectangle.alpha = 0 
                -- Game.battle.timer:tween(0.5, rectangle, {alpha = 1})
                -- cutscene:wait(0.5)
                
                -- Game.fader.alpha = 0 
                -- sprite:remove()
                -- melody_text:remove()
                -- cutscene:wait(0.1)
                
                -- Game.battle.timer:tween(0.5, rectangle, {alpha = 0}, "in-out-sine", function()
                --     rectangle:remove()
                -- end)
                -- cutscene:wait(1.5)
                
                ralsei:resetSprite()

                Game.battle.music:fade(1, 1)
                Assets.playSound("boost", 0.4, 0.8)
                Game.battle.background = Game.battle:addChild(FireGlow())
                Assets.playSound("weaponpull_fast")  
                cutscene:wait(cutscene:setAnimation(ralsei, "battle/intro"))
                ralsei:resetSprite()
            end)
        else 
            local bg = Game.battle:addChild(FireGlow())
            Game.battle.background = bg  
        end 
    end
end


function ralsei:getPartyPosition(index)
    if index == 1 then 
        return 113, 280
    end 
    return super.getPartyPosition(self, index)
end 

return ralsei
