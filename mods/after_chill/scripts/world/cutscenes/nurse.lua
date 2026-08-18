return {
    ---@param cutscene WorldCutscene
    sell = function(cutscene, event)
       -- we got it chat:  
       Kristal.Console:warn(event.interact_count)
        local function checkMoney()
            if Game.money >= 140 then 
                Game.money = Game.money - 140
                return true 
            else 
                return false 
            end 
        end  
        if Game:hasPartyMember("ralsei") and event.interact_count == 1 then 
            cutscene:text("* Hey,[wait:2] kids!")
            cutscene:text("* I don't know where I am,[wait:2]\nbut you want some candy?")
            cutscene:text("* Oh,[wait:3] sure!", "blush_pleased", "ralsei")
            local choice = cutscene:choicer({"Buy", "Sell", "Talk", "Go Back"})
            if choice == 1 then 
                cutscene:text("* Take a look at my wares.")
                cutscene:wait(0.2)
                local sec = cutscene:textChoicer("* [color:yellow]HoneyDrop[color:reset] costs [color:yellow]$140[color:reset].", {"Buy", "Go Back"})
                if sec == 1 then 
                    if checkMoney() then 
                        Assets.playSound("item")
                        local success, text = Game.inventory:tryGiveItem("honey_drop")
                        cutscene:text(text)
                        if success then
                            cutscene:text("* Thank you,[wait:5] miss!", "blush", "ralsei")
                            cutscene:text("* You're always welcome,[wait:2] sweet.")
                        end
                    else 
                        cutscene:text("* Looks like you don't have enough money.")
                        cutscene:text("* Remember,[wait:5] it costs [color:yellow]$140[color:reset].")
                    end
                else 
                    cutscene:text("* Oh,[wait:2] you don't want candy?")
                    cutscene:text("* Smart choice!")
                end 
            elseif choice == 2 then 
                cutscene:text("* Sorry,[wait:2] sweet,[wait:2] but I don't need anything!")
            elseif choice == 3 then 
                -- PLACEHOLDER WIP
                -- ME MAKE SURE TO USE cutscene:gotoCutscene 
                -- stupid hyperboid bro why isnt it cutscene:goToCutscene()
                -- whatever gng
                cutscene:text("* I'm the receptionist at the hospital.")
                cutscene:text("* It's very boring over there,[wait:5] everyone's so rude and needy.")
                cutscene:text("* I don't know this place,[wait:5] but I really love the serenity!")
            elseif choice == 4 then
                cutscene:text("* Take care, both of ya.")
            end
               elseif event.interact_count >= 2 then  
            cutscene:text("* Here again,[wait:3] huh?")
            cutscene:text("* Knock yourself out!")
            local choice = cutscene:choicer({"Buy", "Sell", "Talk", "Go Back"})
            
            if choice == 1 then
                local sec = cutscene:textChoicer("* [color:yellow]HoneyDrop[color:reset] costs [color:yellow]$140[color:reset].", {"Buy", "Go Back"})
                if sec == 1 then 
                    if checkMoney() then 
                        Assets.playSound("item")
                        local success, text = Game.inventory:tryGiveItem("honey_drop")
                        cutscene:text(text)
                        cutscene:text("* Have a good one.")
                    else 
                        cutscene:text("* Looks like you don't have enough money.")
                        cutscene:text("* Remember,[wait:5] it costs [color:yellow]$140[color:reset].")
                        cutscene:wait(0.25)
                        cutscene:text("* I don't make exceptions for any of my customers,[wait:5] even if they're recurring!")
                    end
                else
                    cutscene:text("* Oh,[wait:2] changed your mind?")
                end
                
            elseif choice == 2 then
                cutscene:text("* Sorry,[wait:2] sweet,[wait:2] but I don't need anything!")
                
            elseif choice == 3 then
                cutscene:gotoCutscene("nurse.rtalk", event.interact_count)
                
            elseif choice == 4 then
                cutscene:text("* Come here to buy nothing,[wait:2] huh?")
                cutscene:text("* We were just.[wait:2].[wait:2].[wait:2]", "blush_shy", "ralsei")
                cutscene:wait(0.5)
                cutscene:text("* Um,[wait:2] have a good day!", "blush_smile", "ralsei")
                cutscene:text("* You too.")
            end  

        -- this else block is for kris only, im going to need to branch it inside itself asw 
        else 
            cutscene:text("* Hey there!")
            cutscene:text("* You're the first person I've met.")
            cutscene:text("* Would you like to look at my wares?") 
            local choice = cutscene:choicer({"Buy", "Sell", "Who are you?", "Go Back"})
            if choice == 1 then 
                cutscene:text("* Glad you decided to take a look at my wares!")
                cutscene:wait(0.2)
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
                -- PLACEHOLDER WIPPPPPPPPPPPPPPPPPPP
                --- REPLACE WITH `cutscene:gotoCutscene("nurse.ktalk", event.interact_count)`  !!
                cutscene:text("* I'm the receptionist at the hospital.")
                cutscene:text("* It's very boring over there,[wait:5] everyone's so rude and needy.")
                cutscene:text("* I don't know this place,[wait:5] but I really love the serenity!")
                cutscene:wait(0.5)
                cutscene:text("* Oh,[wait:2] don't worry sweet,[wait:2] you're good with me too.")
            elseif choice == 4 then
                cutscene:text("* Take care!")
            end 
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
       local choice = cutscene:choicer({"Buy", "Sell", "Who are you?", "Go Back"})
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
                cutscene:text("* I'm the receptionist at the hospital.")
                cutscene:text("* It's very boring over there,[wait:5] everyone's so rude and needy.")
                cutscene:text("* I don't know this place,[wait:5] but I really love the serenity!")
                cutscene:wait(0.5)
                cutscene:text("* Oh,[wait:2] don't worry sweet,[wait:2] you're good with me too.")
            elseif choice == 4 then
                cutscene:text("* Take care!")
            end 
        end, 

    rtalk = function(cutscene, count)

    Kristal.Console:warn(count)
     -- PERFECT, I CAN GET THE COUNT!
    end,
    
    ktalk = function(cutscene, count)

    Kristal.Console:warn(count)
     -- PERFECT, I CAN GET THE COUNT! wow im insane lowkey
    end,
}
