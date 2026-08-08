local SancEncounter, super = Class(Encounter)

function SancEncounter:init()
    super.init(self)

    Game:setBorder("secondsanctuary")

    self.text = "* The lighting of the mind has altered."
    self.music = "ch4_battle"
    self.background = true

    self:addEnemy("encounter_example_dummy")
    local purple_palette = {
        { 99 / 255, 9 / 255,  156 / 255 }, -- #63099c
        { 84 / 255, 9 / 255,  145 / 255 }, -- #540991
        { 74 / 255, 10 / 255, 138 / 255 }, -- #4a0a8a
        { 56 / 255, 9 / 255,  122 / 255 }, -- #38097a
        { 35 / 255, 11 / 255, 102 / 255 }, -- #230b66
    }

    Game.battle.timer:every(3, function()
        local x = math.random(40, 600)
        local y = math.random(40, 280)

        local life = math.random(50, 110)
        local radmax = math.random(90, 150)
        local thickness = math.random(15, 30)




        local rip2 = Game.battle:addChild(
            RippleEffect(x, y, life, radmax, thickness, TableUtils.pick(purple_palette))
        )

        rip2:setLayer(BATTLE_LAYERS["below_battlers"] + 6)
    end)



    self.burtress1 = Sprite("battle/sprire_bg_visible", 76, 389)
    self.burtress1:setScale(1, 1)
    self.burtress1:setOrigin(0.5, 0.5)
    self.burtress1.alpha = 0
    self.burtress1:fadeTo(1, 2)
    self.burtress1:setLayer(BATTLE_LAYERS["below_battlers"] + 4)

    Game.battle:addChild(self.burtress1)


    self.burtress2 = Sprite("battle/sprire_bg_visible", 552, -121)
    self.burtress2:setScale(1, 1)
    self.burtress2:setOrigin(0.5, 0.5)
    self.burtress2.alpha = 0
    self.burtress2:fadeTo(1, 2)
    self.burtress2.rotation = math.rad(180)
    self.burtress2:setLayer(BATTLE_LAYERS["below_battlers"] + 4)

    Game.battle:addChild(self.burtress2)


    self.gonerBg = Sprite("battle/IMAGE_DEPTH_EXTEND_SEAMLESS", 0, 0)
    self.gonerBg:setScale(2, 2)
    self.gonerBg.physics.speed_x = -1.5
    self.gonerBg.physics.speed_y = 2
    self.gonerBg.alpha = 0.35
    self.gonerBg.wrap_texture_x = true
    self.gonerBg.wrap_texture_y = true
    self.gonerBg:setLayer(BATTLE_LAYERS["below_battlers"] + 5)
    self.gonerBg:setColor({ 1, 0, 0 })
    Game.battle:addChild(self.gonerBg)
end

return SancEncounter
