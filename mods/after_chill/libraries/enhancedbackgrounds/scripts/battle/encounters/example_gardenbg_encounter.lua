local GardenEncounter, super = Class(Encounter)

function GardenEncounter:init()
    super.init(self)

    self.text = "* The party blooms into battle!"

    self.music = "rakuichi_battle"
    self.background = true
    self:addEnemy("encounter_example_dummy")
    Game:setBorder("flowercastle")

    self.petal_rain = Game.battle:addChild(PetalRain(0, 0))
    self.petal_rain.petal_rain_layer = BATTLE_LAYERS["below_battlers"] + 4


    self.bg_gradient = Game.battle:addChild(PurpleAsgoreGradient(0, 600))
    self.bg_gradient:setLayer(BATTLE_LAYERS["below_battlers"] + 3)
    Game.battle.timer:tween(4, self.bg_gradient, { y = -185 }, "out-quad")



    self.bushes = Sprite("battle/bushes", 318, 295)
    self.bushes:setScale(0.4, 0.4)
    self.bushes:setOrigin(0.5, 0.5)
    self.bushes.alpha = 0
    self.bushes:fadeTo(1, 2)
    self.bushes:setLayer(BATTLE_LAYERS["above_battlers"] + 5)

    Game.battle:addChild(self.bushes)
end

function GardenEncounter:beforeStateChange(old, new)
    if new == "VICTORY" then
        self.bushes:fadeTo(0, 0.2)
        Game.battle.timer:tween(0.5, self.bg_gradient, { y = 600 }, "in-quad")
        self.petal_rain.stop_spawn = true
        for _, petal in ipairs(Game.stage:getObjects(GoldPetal)) do
            petal:fadeTo(0, 0.2)
        end
    end
end

return GardenEncounter
