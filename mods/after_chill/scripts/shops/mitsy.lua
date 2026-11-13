local Mitsy, super = Class(Shop,  "mitsy")

function Mitsy:init()
    super.init(self)

    self.shop_music = "wip_misty_theme"

    self.encounter_text = "* Well well...[wait:2]\n* Nice to meet you all again."
    self.shop_text = "* Take your time...[wait:2]\nAin't like it's better spent."
    self.leaving_text = "* See you later...[wait:5]\n* Or not.[wait:5]\n* Ha ha ha ha..."
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "What do\nyou like\nto buy?"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "Buy it for\n%s ?"
    -- Voice to use 
    self.voice = "mitsy"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "What,\nnot good\nenough?"
    -- Shown when you buy something
    self.buy_text = "Thanks for that."
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "Thanks for that."
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "I don't\nhave enough\nmoney for\nthis."
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "I'm\ncarrying\ntoo much."
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "Why would\nI sell\nthis?"
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "Guess I\ncan get\nrid of\nstuff."
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "Nothing\nto give."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "Sell it for\n%s ?"
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "I'd\nrather\nhold on\nto this."
    -- Shown when you sell something
    self.sell_text = "There\nwe go."
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "Nothing\nin there."
    -- Shown when you enter the talk menu.
    self.talk_text = "Guess I\nshould\nthink."

    self.sell_options_text["items"]   = "What\nshould\nI sell?"
    self.sell_options_text["weapons"] = "What\nshould\nI sell?"
    self.sell_options_text["armors"]  = "What\nshould\nI sell?"
    self.sell_options_text["storage"] = "What\nshould\nI sell?"

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