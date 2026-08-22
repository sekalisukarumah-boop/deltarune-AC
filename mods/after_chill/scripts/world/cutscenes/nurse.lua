return {
    ---@param cutscene WorldCutscene
  sell = function(cutscene, event)
    Kristal.Console:warn(event.interact_count)
    local function checkMoney()
        if Game.money >= 140 then
            Game.money = Game.money - 140
            return true
        end
        return false
    end

    local hasRalsei = Game:hasPartyMember("ralsei")
    if hasRalsei then 
      cutscene:getCharacter("ralsei"):setFacing("up")
    end 
    local count = event.interact_count
    local state = "kris"
    if hasRalsei and count == 1 then
        state = "ralsei_first"
    elseif hasRalsei and count >= 2 then
        state = "ralsei_repeat"
    end
    local dialogue = {
        ralsei_first = {
            greeting = function()
                cutscene:text("* Hey,[wait:2] kids!")
                cutscene:text("* I don't know where I am,[wait:2]\nbut you want some candy?")
                cutscene:text("* Oh,[wait:3] sure!", "blush_pleased", "ralsei")
            end,
            buy_intro = function() cutscene:text("* Take a look at my wares.") cutscene:wait(0.2) end,
            buy_success = function() 
                cutscene:text("* Thank you,[wait:5] miss!", "blush", "ralsei")
                cutscene:text("* You're always welcome,[wait:2] sweet.")
            end,
            buy_fail = function()
                cutscene:text("* Looks like you don't have enough money.")
                cutscene:text("* Remember,[wait:5] it costs [color:yellow]$140[color:reset].")
            end,
            cancel_buy = function()
                cutscene:text("* Oh,[wait:2] you don't want candy?")
                cutscene:text("* Smart choice!")
            end,
            sell = "* Sorry,[wait:2] sweet,[wait:2] but I don't need anything!",
            talk_path = "nurse.rtalk",
            leave = function() cutscene:text("* Take care, both of ya.") end
        },
        ralsei_repeat = {
            greeting = function()
                cutscene:text("* Here again,[wait:3] huh?")
                cutscene:text("* Knock yourself out!")
            end,
            buy_intro = function() end,
            buy_success = function() cutscene:text("* Have a good one.") end,
            buy_fail = function()
                cutscene:text("* Looks like you don't have enough money.")
                cutscene:text("* Remember,[wait:5] it costs [color:yellow]$140[color:reset].")
                cutscene:wait(0.25)
                cutscene:text("* I don't make exceptions for any of my customers,[wait:5] even if they're recurring!")
            end,
            cancel_buy = function() cutscene:text("* Oh,[wait:2] changed your mind?") end,
            sell = "* Sorry,[wait:2] sweet,[wait:2] but I don't need anything!",
            talk_path = "nurse.rtalk",
            leave = function()
                cutscene:text("* Come here to buy nothing,[wait:2] huh?")
                cutscene:text("* We were just.[wait:2].[wait:2].[wait:2]", "blush_shy", "ralsei")
            end
        },
        kris = {
            greeting = function()
                cutscene:text("* Hey there!")
                cutscene:text("* Would you like to look at my wares?")
            end,
            buy_intro = function() cutscene:text("* Glad you decided to take a look at my wares!") cutscene:wait(0.2) end,
            buy_success = function() cutscene:text("* You're always welcome,[wait:2] sweet.") end,
            buy_fail = function()
                cutscene:text("* Sweet,[wait:5] you don't have enough money.")
                cutscene:text("* Remember,[wait:5] it costs [color:yellow]$140[color:reset].")
                cutscene:wait(0.5)
                cutscene:text("* I don't make exceptions for any of my customers,[wait:5] sorry!")
            end,
            cancel_buy = function()
                cutscene:text("* Oh,[wait:2] you don't want candy?")
                cutscene:text("* Smart choice!")
            end,
            sell = "* Sorry,[wait:2] sweet,[wait:2] but I don't need anything from ya!",
            talk_path = "nurse.ktalk",
            leave = function() cutscene:text("* Take care!") end
        }
    }
    local ctx = dialogue[state]
    ctx.greeting()
    
    local choice = cutscene:choicer({"Buy", "Sell", "Talk", "Go Back"})
    if choice == 1 then
        ctx.buy_intro()
        local sec = cutscene:textChoicer("* [color:yellow]HoneyDrop[color:reset] costs [color:yellow]$140[color:reset].", {"Buy", "Go Back"})
        
        if sec == 1 then
            if checkMoney() then
                Assets.playSound("item")
                local success, text = Game.inventory:tryGiveItem("honey_drop")
                cutscene:text(text)
                if success then ctx.buy_success() end
            else
                ctx.buy_fail()
            end
        else
            ctx.cancel_buy()
        end
    elseif choice == 2 then
        cutscene:text(ctx.sell)
    elseif choice == 3 then
        cutscene:gotoCutscene(ctx.talk_path, count)
    elseif choice == 4 then
        ctx.leave()
    end
end,
   
    bring = function(cutscene)
        local function checkMoney()
            if Game.money >= 140 then 
                Game.money = Game.money - 140
                return true 
            else 
                return false 
            end 
        end 
       local kris = cutscene:getCharacter("kris")
       cutscene:text("* Hey,[wait:2] over here,[wait:2] blue haired guy!")
       cutscene:wait(cutscene:walkTo(kris, 1330, kris.y, 0.7, "up"))
       cutscene:text("* You look really tired...")
       cutscene:text("* Want a candy to cheer you up?")
       kris:walkTo(kris.x, 776, 0.5)
       cutscene:wait(0.5)
       local choice = cutscene:choicer({"Buy", "Sell", "Talk", "Go Back"})
            if choice == 1 then 
                local sec = cutscene:textChoicer("* [color:yellow]HoneyDrop[color:reset] costs [color:yellow]$140[color:reset].", {"Buy", "Go Back"})
                if sec == 1 then 
                    if checkMoney() then 
                        Assets.playSound("item")
                        local success, text = Game.inventory:tryGiveItem("honey_drop")
                        cutscene:text(text)
                        if success then
                            cutscene:text("* You're always welcome,[wait:2] sweet.")
                        end
                    else 
                        cutscene:text("* Sweet,[wait:5] you don't have enough money.")
                        cutscene:text("* Remember,[wait:5] it costs [color:yellow]$140[color:reset].")
                        cutscene:wait(0.5)
                        cutscene:text("* I don't make exceptions for any of my customers,[wait:5] sorry!")
                    end 
                else 
                    cutscene:text("* Oh,[wait:2] you don't want candy?")
                    cutscene:text("* Smart choice!")
                end 
            elseif choice == 2 then 
                cutscene:text("* Sorry,[wait:2] sweet,[wait:2] but I don't need anything from ya!")
            elseif choice == 3 then 
                -- idk, thisis intentional btw.
                cutscene:gotoCutscene("ktalk", 1)
            elseif choice == 4 then
                cutscene:text("* Take care!")
            end 
        end, 

    rtalk = function(cutscene, count)
    local choice = cutscene:choicer({"Who are\nyou?", "Noelle?", "Why is there a forest?", "What do you sell?"})
     -- PERFECT, I CAN GET THE COUNT! wow im insane lowkey
    if choice == 1 then 
        -- picking who are you?
        if count == 1 then 
        cutscene:text("* I work at the hospital.")
        cutscene:text("* Also,[wait:2] nice to meet you,[wait:2] uh,[wait:2] goat?")
        cutscene:text("* My name is Ralsei!", "blush_smile", "ralsei")
        cutscene:text("* What a peculiar name,[wait:2] Ralsei![wait:5]\n* Who are you?")
        cutscene:text("* I'm...[wait:2] Kris's friend,[wait:2] we're exploring this area.", "blush_shy", "ralsei")
        cutscene:text("* Kris is the blue person,[wait:2] I assume?")
        cutscene:text("* Yeah.", "blush_smile", "ralsei")
        cutscene:text("* Well,[wait:2] see you two around!")
        else 
        cutscene:text("* I'm still the receptionist at the hospital,[wait:5] I'm not retiring anytime soon.")
        end 
    elseif choice == 2 then 
        if count == 1 then 
        cutscene:text("* Oh,[wait:2] her.")
        cutscene:text("* That poor girl,[wait:3] she's been going through so much.")
        cutscene:text("* Her father is in really bad condition.[wait:10]\n* She  doesn't look much better.")
        cutscene:text("* (Oh,[wait:2] that might be why she attacked me...)", nil, "ralsei")
        cutscene:text("* (What was that ring...?)", nil, "ralsei")
        cutscene:text("* What was that?")
        cutscene:text("* O-oh,[wait:3] nothing!", "pleased", "ralsei")
        else 
        cutscene:text("* Pray for her,[wait:5] really.")
        end 
    elseif choice == 3 then 
        cutscene:text("* A forest?")
        cutscene:text("* I have no idea,[wait:5] I didn't know there was one.")
    elseif choice == 4 then 
        cutscene:text("* Just some candy,[wait:5] specifically [color:yellow]HoneyDrop[color:reset].")
        cutscene:text("* Let me know if any of you two want one!")
    end 
    end,
    
    ktalk = function(cutscene, count)

    Kristal.Console:warn(count) 
    local choice = cutscene:choicer({"Who are\nyou?", "What is\nthis place?", "Where's Ralsei?", "Candy?"})
     -- PERFECT, I CAN GET THE COUNT! wow im insane lowkey
    if choice == 1 then 
        -- picking who are you?
        if count == 1 then 
        cutscene:text("* I'm the receptionist at the hospital.")
        cutscene:text("* It's quite boring,[wait:5] but every now and then we get some interesting cases.")
        cutscene:text("* Like that poor girl,[wait:5] Noelle.")
        cutscene:text("* Her father is in really bad shape...")
        cutscene:text("* She visits him regularly,[wait:3] and his condition is only getting worse...")
        cutscene:wait(0.5)
        cutscene:text("* Oh well,[wait:5] pray for her.")
        cutscene:text("* She's been going through so much lately.")
        cutscene:text("* Bye now.")
        else 
        cutscene:text("* I'm still the receptionist at the hospital,[wait:5] I'm not retiring anytime soon.")
        end 
    elseif choice == 2 then 
        if count == 1 then 
        cutscene:text("* I'm not sure,[wait:2] me and you both.")
        cutscene:text("* Although I do really like the peace here.")
        else 
        cutscene:text("* It's quite peaceful,[wait:3] ain't it?")
        end 
    elseif choice == 3 then 
        cutscene:text("* Who's Ralsei?")
        cutscene:text("* The only person I've seen running around was this girl,[wait:5] with a white dress.")
        cutscene:text("* Kind of looked like Noelle,[wait:5] but I hardly believe she'd be here.")
    elseif choice == 4 then 
        if count == 1 then 
        cutscene:text("* Hah,[wait:2] yes,[wait:2] I sell candy!")
        cutscene:text("* It's actually medicine,[wait:4] but it's still good.")
        cutscene:text("* If you want a [color:yellow]HoneyDrop[color:reset],[wait:2] let me know!")
        else 
        cutscene:text("* It's still some sort of candy!")
        end 
    end
end,
}
