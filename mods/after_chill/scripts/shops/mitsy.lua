local Mitsy, super = Class(Shop,  "mitsy")

function Mitsy:init()
    super.init(self)

    self.shop_music = "mitsy"
    self.music:setVolume(2)
    -- text :p
    self.encounter_text = "* Oh! Hello there,[wait:2] travellers![wait:5]\n* Welcome,[wait:2] welcome!"
    self.shop_text = "* Take all the time\nyou need.\n* Don't forget you're always welcome here,[wait:5] faha."
    self.leaving_text = "* Safe travels!\n* Come back whenever you're hungry!"

    -- Shown when you're in the BUY menu
    self.buy_menu_text = "What catches\nyour eye\ntoday?"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "Wrap it up\nfor %s ?"
    -- Voice to use 
    self.voice = "mitsy"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "Oh,[wait:2] no worries\nat all!"
    -- Shown when you buy something
    self.buy_text = "Thank you!\nEnjoy the\ngoodness!"
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "Sent straight\nto your\nstorage!"
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "Oh dear...\nYou're a bit\nshort."
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "Looks like\nyour pockets\nare full!"
    -- Shown when you sold everything
    self.sell_everything_text = "Oop,[wait:2] you have\nnothing else."
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "Oh,[wait:2] I couldn't\npossibly\ntake that!"
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "Got something\nto share\nwith me?"
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "There's\nnothing\nthere."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "Trade it\nfor %s ?"
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "Changed your\nmind?"
    -- Shown when you sell something
    self.sell_text = "Ooh,[wait:2] thank\nyou so much!"
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "Sorry,[wait:2] that's\nempty..."
    -- Shown when you enter the talk menu.
    self.talk_text = "Oh![wait:2] What\nshall we\nchat about?"

    self.sell_options_text["items"]   = "Let's see\nhere..."
    self.sell_options_text["weapons"] = "Let's see\nhere..."
    self.sell_options_text["armors"]  = "Let's see\nhere..."
    self.sell_options_text["storage"] = "Let's see\nhere..."


   -- self:registerItem("cd_bagel", {description = "ITEM\nMusic with\neach bite\nheals 80HP"})
    -- self:registerItem("adventure_tea")
    -- self:registerItem("graze_wisp")
    -- self:registerItem("tense_net")
    -- self:registerItem("warrior_nail")
	
    self:registerItem("cell_phone", {stock = 10, color = {1, 0.8, 1, 1}, price = -14, description = "*\n|_\n(O)    Sell phoe\n|#|\n'-'", name="Pone"})
    self:registerItem("tensionbit")
    self:registerItem("manual")
    self:registerItem("amber_card", {bonuses = {defense = math.huge}})

	self.shopkeeper:setActor("mitsy")
    self.shopkeeper.slide = true 
    self:registerTalk("About Yourself")
    self:registerTalk("Your Recipes")
    self:registerTalk("This Forest")
    self:registerTalk("Rudy")


    -- self.background = "ui/shopKeeper/seam"
	-- self.shop_music = "seam_shop"
end

function Mitsy:slideShopkeeper(away)
    if away then
        local target_x = SCREEN_WIDTH / 2 - 115
        if self.shopkeeper.x > target_x + 60 then
            self.shopkeeper.x = MathUtils.approach(self.shopkeeper.x, target_x, 4 * DTMULT)
        end
        if self.shopkeeper.x > target_x + 40 then
            self.shopkeeper.x = MathUtils.approach(self.shopkeeper.x, target_x, 4 * DTMULT)
        end
        if self.shopkeeper.x > target_x then
            self.shopkeeper.x = MathUtils.approach(self.shopkeeper.x, target_x, 4 * DTMULT)
        end
    else
        local target_x = SCREEN_WIDTH / 2
        if self.shopkeeper.x < target_x - 50 then
            self.shopkeeper.x = MathUtils.approach(self.shopkeeper.x, target_x, 4 * DTMULT)
        end
        if self.shopkeeper.x < target_x - 30 then
            self.shopkeeper.x = MathUtils.approach(self.shopkeeper.x, target_x, 4 * DTMULT)
        end
        if self.shopkeeper.x < target_x then
            self.shopkeeper.x = MathUtils.approach(self.shopkeeper.x, target_x, 4 * DTMULT)
        end
    end
end

function Mitsy:startTalk(topic)
    -- add branching options
    -- topic is a string 
    self:startDialogue({"idk", "i genuinely DONT KNOW BRUH"})
end

return Mitsy