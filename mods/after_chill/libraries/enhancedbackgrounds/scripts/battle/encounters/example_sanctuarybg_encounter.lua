local SancSecondEncounter, super = Class(Encounter)

function SancSecondEncounter:init()
    super.init(self)

    Game:setBorder("darksanctuary")

    self.text = "* Holy lights dim the field."
    self.music = "ch4_battle"
    self.background = true

    self:addEnemy("encounter_example_dummy")

  local blue_palette = {
    { 0x0E / 255, 0x2B / 255, 0xAD / 255 }, -- #0E2BAD 
    { 0x1A / 255, 0x3C / 255, 0xC3 / 255 }, -- #1A3CC3 
    { 0x18 / 255, 0x40 / 255, 0xC2 / 255 }, -- #1840C2 
    { 0x2D / 255, 0x5C / 255, 0xD8 / 255 }, -- #2D5CD8 
    { 0xA4 / 255, 0xDE / 255, 0xFC / 255 }, -- #A4DEFC 
}
    Game.battle.timer:every(3, function()
        local x = math.random(40, 600)
        local y = math.random(40, 280)

        local life = math.random(50, 110)
        local radmax = math.random(90, 150)
        local thickness = math.random(15, 30)




        local rip2 = Game.battle:addChild(
            RippleEffect(x, y, life, radmax, thickness, TableUtils.pick(blue_palette))
        )

        rip2:setLayer(BATTLE_LAYERS["background"]  + 2)
    end)



    self.candle_holder = Game.battle:addChild(CandleSpireHandler(168, 88))
    self.candle_holder:setLayer(BATTLE_LAYERS["background"] + 8)

     self.candle_holder2 = Game.battle:addChild(CandleSpireHandler(408, 245))
    self.candle_holder2:setLayer(BATTLE_LAYERS["background"] + 8)

    self.church_fog = Game.battle:addChild(ChurchFogBattle(0, 0))
    self.church_fog:setLayer(BATTLE_LAYERS["background"] + 6)
    self.burtress1 = Sprite("battle/spire_a_bg", -63, 234)
    self.burtress1:setScale(1, 1)
    self.burtress1:setOrigin(0.5, 0.5)
    self.burtress1.alpha = 0
    self.burtress1.rotation = math.rad(25)
    self.burtress1:fadeTo(1, 2)
    self.burtress1:setLayer(BATTLE_LAYERS["background"] + 4)

    Game.battle:addChild(self.burtress1)


    self.burtress2 = Sprite("battle/spire_a_bg", 535, -161)
    self.burtress2:setScale(1, 1)
    self.burtress2:setOrigin(0.5, 0.5)
    self.burtress2.alpha = 0
    self.burtress2:fadeTo(1, 2)
    self.burtress2.rotation = math.rad(225)
    self.burtress2:setLayer(BATTLE_LAYERS["background"] + 4)
    Game.battle:addChild(self.burtress2)

    
    self.burtress3 = Sprite("battle/spire_a_bg", 771, 353)
    self.burtress3:setScale(1, 1)
    self.burtress3:setOrigin(0.5, 0.5)
    self.burtress3.alpha = 0
    self.burtress3:fadeTo(1, 2)
    self.burtress3.rotation = math.rad(-40)
    self.burtress3:setLayer(BATTLE_LAYERS["background"] + 4)
    Game.battle:addChild(self.burtress3)


end

return SancSecondEncounter
