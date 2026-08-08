local SancThirdEncounter, super = Class(Encounter)

function SancThirdEncounter:init()
    super.init(self)

    Game:setBorder("thirdsanctuary")

    self.text = "* From now on."
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
    Game.battle.timer:every(2.5, function()
        local x = math.random(40, 600)
        local y = math.random(40, 280)

        local life = math.random(50, 110)
        local radmax = math.random(90, 150)
        local thickness = math.random(15, 30)




        local rip2 = Game.battle:addChild(
            RippleEffect(x, y, life, radmax, thickness, TableUtils.pick(blue_palette))
        )

        rip2:setLayer(BATTLE_LAYERS["background"] + 2)
    end)

    self.overlay = Rectangle(-20, -20, SCREEN_WIDTH + 40, SCREEN_HEIGHT + 40)
    self.overlay:setLayer(BATTLE_LAYERS["background"] + 1)
    self.overlay:setParallax(0, 0)
    self.overlay:setColor(COLORS.black)
    self.overlay.alpha = 0.7
    self.overlay.debug_select = false
    Game.battle:addChild(self.overlay)



    self.giga_prophecy = Game.battle:addChild(GigaProphecyBattle())
    self.giga_prophecy:setLayer(BATTLE_LAYERS["background"] + 8)
    self.giga_prophecy.debug_select = false
end

function SancThirdEncounter:beforeStateChange(old, new)
    if new == "VICTORY" then
       -- self.logo_sprite:fadeTo(0, 0.2)
        if self.giga_prophecy then
            self.giga_prophecy.vic_lock = true
        end
       -- self.stop_spawning = true
    end
end

return SancThirdEncounter
