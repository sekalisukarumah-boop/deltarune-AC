local WinterEncounter, super = Class(Encounter)

function WinterEncounter:init()
    super.init(self)

    self.text = "* It's wintertime!"

    self.music = "battle"
    self.background = true

    self:addEnemy("encounter_example_dummy")

    Game:setBorder("christmas")


    self.snow_layer = Sprite("battle/christmas/snow_bg", -184, 600)
    self.snow_layer:setScale(2, 2)
    self.snow_layer.alpha = 0
    self.snow_layer:fadeTo(1, 3)

    self.snow_layer.debug_select = true
    self.snow_layer:setLayer(BATTLE_LAYERS["below_ui"] + 4)

    Game.battle:addChild(self.snow_layer)
    Game.battle.timer:tween(2, self.snow_layer, { y = 285 }, "in-quad")
end

function WinterEncounter:createBackground()
    if self.background then
        return Game.battle:addChild(NewWinterBattleBack())
    end
end

function WinterEncounter:beforeStateChange(old, new)
    if new == "VICTORY" then
        self.snow_layer:fadeTo(0, 0.2)
    end
end

return WinterEncounter
