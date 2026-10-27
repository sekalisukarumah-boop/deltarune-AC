return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    fall = function(cutscene, event)
        --setup stuff.
        if not Game:hasPartyMember("ralsei") then  
            cutscene:gotoCutscene("forest.genofall")
            return 
        end 
        cutscene:wait(cutscene:mapTransition("receplast"))
        Game.world.music:play("wind", 0.2)
        local kris = cutscene:getCharacter("kris")
        local ralsei = cutscene:getCharacter("ralsei")
        cutscene:detachFollowers()
        kris = cutscene:getCharacter("kris")
        ralsei = cutscene:getCharacter("ralsei")

        local starbg = Game.world.map:getTileLayer("stars") 
        local cloudbg = Game.world.map:getTileLayer("Cloud")
        local slopeCloud = Game.world.map:getTileLayer("Slope clouds")
        local slopestar = Game.world.map:getTileLayer("Slope stars")
        local slopestarshine = Game.world.map:getTileLayer("Slope shine")
        
        local snd = Assets.playSound("waterfall", 1.5)
        snd:setLooping(true)
        
        slopeCloud.visible = false
        cloudbg.visible = false
        kris:addFX(ColorMaskFX({0,0,0},0.5))
        ralsei:addFX(ColorMaskFX({0,0,0},0.5)) 
        kris:moveTo(68,-40, 0.1)
        ralsei:moveTo(68,-80, 0.1)
        cutscene:shakeCharacter("kris", 0.5, 0, 0, 0.08)
        cutscene:shakeCharacter("ralsei", -0.5, 0, 0, 0.1)
        cutscene:wait(1)
        cutscene:fadeIn(0.25)
       
        --Grabs and sets up characters
        
        kris:setAnimation("slide")
        ralsei:setAnimation("slide")
        cutscene:wait(1)
        cutscene:slideTo("kris", 90, 310, 4, "out-back")
        cutscene:slideTo("ralsei", 85, 206, 4, "out-back")
        
        kris:addFX(ColorMaskFX({0,0,0.1},0.35))
        ralsei:addFX(ColorMaskFX({0,0,0.1},0.35))

        cutscene:wait(4)
        cutscene:text("* Wow,[wait:2] Kris,[wait:3] this is\nquite a long slide,[wait:3]\nhuh?", "pleased", "ralsei")

        cutscene:wait(0.3)

        cutscene:text("[noskip]* Placeholder text... sorry.")
        cutscene:text("[noskip]* :) consider this a special message from the developer lol")
        cutscene:text("[noskip]* i hope you enjoyed afterchill so far...[wait:5] we've been working hard on it.")
        cutscene:text("[noskip]* and now you go! bye!")

        cutscene:wait(0.3)

        cutscene:slideTo("kris", 104, 455, 1)
        cutscene:slideTo("ralsei", 93, 374, 1)

        cutscene:wait(0.5)
        snd:stop()

        cutscene:fadeOut(0.5)
        Game.world.music:fade(0, 0.5)

        cutscene:wait(1)

        cutscene:wait(cutscene:loadMap("forest1"))
        cutscene:attachCamera()
        kris = cutscene:getCharacter("kris")
        ralsei = cutscene:getCharacter("ralsei")
        cutscene:detachFollowers()
        kris:setSprite("landed")
        ralsei:setSprite("landed")
        kris:setPosition(254, 403)
        ralsei:setPosition(166, 402)
        cutscene:wait(cutscene:playSound("impact"))
        cutscene:wait(0.5)
        cutscene:fadeIn(0.25)
        cutscene:wait(0.5)
        cutscene:text("* That was quite a fall...", "pensive", "ralsei")

        Assets.playSound("wing")

        ralsei:shake(2)
        ralsei:setAnimation({"landed", 1/6, false}, function() ralsei:resetSprite(); cutscene:wait(0.2); ralsei:setFacing("right") end)
        cutscene:wait(0.5)
        cutscene:text("* Kris!", "shock", "ralsei")
        ralsei:walkTo(205, ralsei.y, 0.4)
        cutscene:wait(0.4)
        cutscene:wait(cutscene:setAnimation(ralsei, "hug"))
        Assets.playSound("spell_cure_slight_smaller")
        kris:flash()
        Game.world.timer:every(1 / 30, function()
            for i = 1, 2 do
                local x = kris.x + ((love.math.random() * kris.width) - (kris.width / 2)) * 2
                local y = kris.y - (love.math.random() * kris.height) * 2
                local sparkle = HealSparkle(x, y)
                if r and g and b then
                    sparkle:setColor(r, g, b)
                end
                kris.parent:addChild(sparkle)
                sparkle.layer = 9999 
            end
        end, 4)

        cutscene:wait(4/30)
        cutscene:wait(cutscene:setAnimation(ralsei, "hug_stop"))
        ralsei:resetSprite()
        ralsei:setFacing("right")

        Assets.playSound("wing")
        kris:shake(2)

        kris:setAnimation({"landed", 1/6, false})
        kris:resetSprite()
        kris:setFacing("down")
        cutscene:interpolateFollowers()
        cutscene:attachFollowers()

        cutscene:wait(0.5)
        
        cutscene:text("* Glad you're okay,[wait:2] let's go now,[wait:2] Kris!", "wink", "ralsei")
        
    end,

    genofall = function(cutscene)
        cutscene:wait(cutscene:mapTransition("receplast"))
        Game.world.music:play("wind", 0.2)
        local kris = cutscene:getCharacter("kris")

        Game.world.map:getTileLayer("Cloud").visible = true 
        Game.world.map:getTileLayer("Slope clouds").visible = true 

        local snd = Assets.playSound("waterfall", 1.5)
        snd:setLooping(true)

        kris:addFX(ColorMaskFX({0,0,0},0.5))
        kris:moveTo(68,-40, 0.1)
        cutscene:shakeCharacter("kris", 0.5, 0, 0, 0.08)
        cutscene:wait(1)
        cutscene:fadeIn(0.25)
       
        --Grabs and sets up characters
        
        kris:setAnimation("slide")
        cutscene:wait(1)
        cutscene:slideTo("kris", 90, 310, 4, "out-back")
        
        kris:addFX(ColorMaskFX({0,0,0.1},0.35))

        cutscene:wait(6)

        cutscene:text("* (The faint sound of water rushing is all you can hear.)")

        cutscene:wait(1)
        cutscene:text("* (The cliff's base is slowly approaching.)")

        cutscene:wait(0.5)
        cutscene:text("* (A small light flickers beneath you.)")

        cutscene:wait(0.5)
        cutscene:text("* (A bed of snow awaits to cushion your fall.)")

        cutscene:slideTo("kris", 104, 400, 0.6)

        cutscene:wait(0.25)
        snd:stop()

        cutscene:fadeOut(0.5)
        Game.world.music:fade(0, 0.5)

        cutscene:wait(1)

        cutscene:wait(cutscene:loadMap("forest1"))
        cutscene:attachCamera()
        kris = cutscene:getCharacter("kris")

        kris:setSprite("landed")
        kris:setPosition(254, 403)
        cutscene:wait(cutscene:playSound("impact"))
        cutscene:wait(0.5)
        cutscene:fadeIn(0.25)
        cutscene:wait(0.5)

        Assets.playSound("wing")
        kris:shake(2)

        cutscene:wait(cutscene:setAnimation(kris, {"landed", 1/6, false})) 
        kris:resetSprite()
        kris:setFacing("up")
    end,

    bouquet = function(cutscene)
        if not Game:hasPartyMember("ralsei") then 
            cutscene:text("* (...[wait:5] You can hear glass breaking.)")
            cutscene:text("* (Seems more enemies wait up\nfor you ahead.)")
            if Game:getPartyMember("kris"):hasRupture() then 
                cutscene:text("* (Use [color:red]RUPTURE[color:reset] to finish them off!)")
            end 
            return
        else
            local ral = cutscene:getCharacter("ralsei")
            Assets.playSound("stardrop", 0.5)
            cutscene:wait(0.5)
            cutscene:text("* Did you hear that,[wait:5] Kris?", "small_smile_side_b", ral)
            cutscene:wait()
            cutscene:text("* It sounded like...", "pensive", ral)
            cutscene:text("* Sparkling?", "surprise_smile", ral)
            Game.world.camera.keep_in_bounds = false
            cutscene:panTo(Game.world.camera.x, Game.world.camera.y - 260, 2.5)
            cutscene:wait(3)
            local siner = 0
            local hover = true
            local bouquet = Game.world:addChild(Bouquet(Game.world.camera.x + 100, Game.world.camera.y - 230))
            bouquet.layer = WORLD_LAYERS["below_textbox"]
            local cm = bouquet:addFX(ColorMaskFX({1,1,1}, 1))
            Game.world.timer:tween(4, cm, {amount = 0})
            local c_y = bouquet.c_sprite.y
            local i =  bouquet.y + 400
            bouquet:slideTo(bouquet.x, i, 4)
            cutscene:during(function()
                if not hover then bouquet.y = i return false end
                siner = siner + DT
                bouquet.y = Utils.wave(siner * 1.5, -25, 25)
            end)
            cutscene:wait(8)
            hover = false
            for i = 1, 5 do
                Assets.playSound("bump")
                bouquet:shake(4)
                cutscene:wait(1 - i*0.15)
            end
            cutscene:wait(1)
            bouquet:doBreak(-60, -23, "break_1")
            cutscene:wait(2)
            cutscene:text("* Ah,[wait:5] shit.[wait:15] It's go time.", "surprise_confused", ral, {top = false})
            cutscene:wait(1)
            bouquet:doBreak(-115, -76, "break_2")
            cutscene:wait(2)
            bouquet:doFinal()
            cutscene:wait(3)
            cutscene:text("* Holy hell Kris did you see that?", "shock_smile", ral, {top = false})
            cutscene:wait(1)
            cutscene:attachCamera(0.75)
            cutscene:wait(1)
            Game.world.camera.keep_in_bounds = true
        end 
    end, 
}
