return {
    ---@param cutscene WorldCutscene
    patient0034 = function(cutscene) 
        local y = os.time() - 86400
        local formatted_date = os.date("%m/%d/%Y", y)
        cutscene:text("* [voice:sign]\"Patient 0034 -[wait:2] Entered the hospital at " .. formatted_date .. ".\"")
        cutscene:text("* [voice:sign]\"Condition - Influenza.\"")
        cutscene:text("* [voice:sign]\"Don't give constant care,[wait:2] occasional check ups.\"[wait:3] \n* \"Provide mediocre food.\"")
        end, 
    
    snake_encounter = function(cutscene)  
        local kris = cutscene:getCharacter("kris")
        local ralsei = cutscene:getCharacter("ralsei")
        cutscene:detachFollowers()
        local wx, wy = cutscene:getMarker("walk_here")
        local snake_1 = cutscene:spawnNPC("snake", 3200, 402)
        local snake_2 = cutscene:spawnNPC("snake", 3110, 475)
        local snake_3 = cutscene:spawnNPC("snake", 3200, 552)
        snake_1:setSprite("idle_4")
        snake_2:setSprite("idle_4")
        snake_3:setSprite("idle_4")
        snake_1:setScale(2.8)
        snake_2:setScale(2.8)
        snake_3:setScale(2.8)
        snake_1.reflections = true 
        snake_2.reflections = true 
        snake_3.reflections = true 
        Game.world.timer:tween(2.5, Game.fader, {alpha = 0.5})
        kris:walkTo(wx, wy, 2.5)
        ralsei:walkTo(wx - 50, wy, 2.5)
        cutscene:wait(3)
        local function stext(txt, x, y)
            local txt = DialogueText("[voice:none][wave:1]"..txt.."", x or 240, y or 95)
            Game.stage:addChild(txt)
            cutscene:wait(function() return not txt:isTyping() end)
            txt:fadeOutAndRemove(0.5)
            cutscene:wait(0.5)
        end 
        stext("Hisssssss...")
        stext("Who daresss crossss to here...", 115)
        cutscene:detachCamera()
        kris:walkTo(kris.x + 200, kris.y, 2.5)
        ralsei:walkTo(ralsei.x + 200, ralsei.y, 2.5)
        cutscene:panTo(Game.world.camera.x + 400, Game.world.camera.y, 2.5, "in-quart")
        cutscene:wait(2.5)
    end

}