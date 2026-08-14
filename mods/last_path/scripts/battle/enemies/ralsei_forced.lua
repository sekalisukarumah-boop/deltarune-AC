local ralsei_forced, super = Class(EnemyBattler)

function ralsei_forced:init()
    super.init(self)

    -- Enemy name
    self.name = "Ralsei"
    self:setActor("enemy_ralsei")

    -- Enemy health
    self.max_health = 100
    self.health = 1000
    -- Enemy attack (determines bullet damage)
    self.attack = 15
    self.ui_modified = false
    -- Enemy defense (usually 0)
    self.defense = 200
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "hidden"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue_offset = {-60, 5}

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT "..self.attack.." DF "..self.defense.."\n* Standing in your way. \n* FIGHT him to his demise."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The tension is so thick it can be cut with a knife.",
        "* Snowflakes fall.",
        "* Smells like ice.",
    }
end

function ralsei_forced:onHurt(damage, battler)
    for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child.x = child.x - 22
            child.y = child.y + 20 
        end 
    end
    Game.battle.timer:after(0.5, function()
    if Game.battle.turn_count ~= 3 then 
    self:resetSprite()
    end
    if Game.battle.turn_count == 3 then 
        for _, child in ipairs(Game.battle.children) do 
        if child:includes(DamageNumber) then 
            child:remove()
        end 
        end
        self.hit_count = 0
        self:statusMessage("msg", "frozen")
        self:startSequence()
    end
    end)   
end 

function ralsei_forced:startSequence()
    Game.battle:startCutscene(function(cutscene)
        Game.battle.battle_ui:clearEncounterText()
        Game.battle.seen_encounter_text = false
        Game.battle.current_selecting = 0  
        local ralsei = Game.battle:getEnemyBattler("ralsei_forced")
        ralsei.sprite.frozen = true 
        ralsei.sprite.freeze_progress = 0 
        local snd = Assets.playSound("petrify")
        Game.battle.timer:tween(0.75, ralsei.sprite, {freeze_progress = 1})
        Game.battle.music:fade(0, 2)
        cutscene:wait(2)
        local noelle = Game.battle:getPartyBattler("noelle")
        Game.battle.tension_bar:hide()
        noelle:setAnimation("battle/victory")
        cutscene:wait(1)
        Game.fader:fadeOut(nil, {speed = 0.5})
        cutscene:wait(0.5)
        local function gonerTextFade(text)
            Game.stage.timer:tween(1, text, { alpha = 0 }, "linear", function() text:remove() end)
            cutscene:wait(1) 
        end   
        local function rtext(str, x, y)
            local txt = DialogueText("[noskip][voice:ralsei]" ..str, x or 110, y or 345) 
            txt:setParallax(0, 0)
            txt.layer = 9999
            Game.stage:addChild(txt)
            cutscene:wait(function() return not txt:isTyping() end)
            gonerTextFade(txt)
        end 
        rtext("* N-No...", 255)
        rtext("* This is not what\nshould've happened...", 158)
        rtext("* I have to...[wait:10]\nkeep trying!", 213)
        rtext("* I can't let my fate end here!", 80)
        cutscene:wait(cutscene:playSound("boost", 0.7)) 
        Game.fader:fadeIn(nil, {speed = 0.5})
        cutscene:wait(1)
        ralsei:resetSprite()
        Game.battle.timer:tween(0.5, ralsei.sprite, {freeze_progress = 0})
        ralsei.sprite:setAnimation("attack", function() ralsei.sprite:resetSprite() end)
        Assets.playSound("explosion")
        local me_spr = {}
        for i = 1, 4 do
        local sx, sy = ralsei:getRelativePos(ralsei.width/2, ralsei.height/2) 
    local spr = Sprite("effects/iceshard_1", sx - 15, sy)
    spr.alpha = 0.7
    spr:setScale(2.4) 
    spr.x = spr.x + love.math.random(-12, 12) 
    spr.y = spr.y + love.math.random(-12, 12)   
    if i % 2 == 0 then 
        spr.physics.direction = math.rad(love.math.random(210, 260))
    else 
        spr.physics.direction = math.rad(love.math.random(280, 330))
    end  
    spr.physics.speed = love.math.random(4, 6)
    spr.physics.gravity = love.math.random(0.3, 0.6) 
    spr:setLayer(ralsei.layer + 1)
    ralsei.parent:addChild(spr) 
    table.insert(me_spr, spr)
end  
        cutscene:wait(2)
        for _, ib in ipairs(me_spr) do ib:remove() end 
        Assets.playSound("wing")
        noelle:resetSprite()
        cutscene:wait(0.5)
        cutscene:text("* You're...[wait:5] still here?", "upset_down", "noelle")
        cutscene:wait(0.5)
        cutscene:text("* If you refuse to give up,[wait:5] then...", "upset_down_b", "noelle")
        cutscene:wait(cutscene:setAnimation(noelle, "battle/spell"))
        Assets.playSound("ice_impact")
        local shield = Game.battle:addChild(Sprite("effects/shield", noelle.x + 73, noelle.y - 98)) 
        shield:setScale(2)
        shield.scale_x = -2
        shield:play(1/6, false)
        cutscene:wait(0.5)
        noelle:shake()
        Assets.playSound("damage")
        noelle:getActiveSprite():setSprite("kneel_right")
        noelle.y = 296 
        cutscene:wait(1)
        cutscene:text("[shake:1]* I can't... [wait:5]go any further...", nil, "noelle")
        cutscene:text("[shake:1]* It hurts...[wait:5] so much...", nil, "noelle")
        cutscene:wait(0.5)
        cutscene:text("* (Wait,[wait:5] that ring she's wearing...!)", "shock", "ralsei")
        Assets.playSound("laz_c")
        ralsei:setAnimation("attack", function() ralsei:resetSprite() end)
        local spx, spy = shield:getRelativePos(shield.width/2, shield.height/2)
        local atk = Sprite("effects/attack/slap_r", spx, spy) 
        Game.battle:addChild(atk) 
        atk:setScale(2) 
        atk:setOrigin(0.5, 0.5)
        local can_progress = false
        atk:play(1/15, false, function() atk:remove(); Assets.playSound("damage"); can_progress = true; end)
        cutscene:wait(function() return can_progress end)
        shield:setSprite("effects/shield_4")
        cutscene:wait(1/30)
        shield:setSprite("effects/shield_3")
        cutscene:wait(1/30)
        shield:setSprite("effects/shield_2")
        cutscene:wait(1/30)
        shield:setSprite("effects/shield_1")
        shield:remove()
        cutscene:wait(0.5)
        local star = Sprite("effects/criticalswing/sparkle", 119, 275) 
        Assets.playSound("bump")
        star:addFX(ColorMaskFX(COLORS.black)) 
        star:addFX(OutlineFX())
        noelle.parent:addChild(star)
        star:setLayer(9999)
        star:setScale(2)
        star:play(0.1) 
        star:fadeOutAndRemove(0.5)
        cutscene:wait(0.7)
        cutscene:text("* (It looks like some sort of torture device..!?)", "surprise_confused", "ralsei")
        Assets.playSound("wing")
        ralsei:setSprite("walk/right_1")
        ralsei.y = 294 
        ralsei:setSprite("walk/right")
        ralsei.sprite:play(0.1, true)
        ralsei:slideTo(176, 297, 2)
        cutscene:wait(2)
        cutscene:wait(cutscene:setAnimation(ralsei, "hug"))
        Assets.playSound("cure")
        Assets.playSound("power")
        noelle:healEffect()
        cutscene:wait(1)
        Assets.playSound("grab")
        cutscene:wait(cutscene:setAnimation(ralsei, "hug_stop")) 
        ralsei:resetSprite()
        ralsei:setSprite("walk/left_1")
        cutscene:text("* (Ralsei got the [color:yellow]THORNRING[color:reset].)", nil, nil)
        cutscene:text("* (That should help!)", "small_smile_side", "ralsei")
        cutscene:fadeOut(1)
        cutscene:wait(1.5)
        cutscene:after(function() Game.battle:setState("TRANSITIONOUT") end)
    end)
end 
return ralsei_forced