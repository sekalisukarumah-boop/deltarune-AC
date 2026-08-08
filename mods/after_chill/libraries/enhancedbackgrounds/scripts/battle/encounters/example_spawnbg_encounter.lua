local SpawnEncounter, super = Class(Encounter)

function SpawnEncounter:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text =
    "* It's darker where nightmares lie!\n* [color:yellow]TP[color:reset] Gain reduced outside of [color:green]COURAGE!"
    self.music = "titan_spawn"
    self.background = true

    Game:setBorder("titan")

    self:addEnemy("encounter_example_dummy")

    self.toggle_smoke = true

    self.darkness_controller = nil
    self.reduced_tension = true
    self.banish_goal = 64


    self.bg_sprite = Sprite("battle/effects/ultrasound-pixelated", 0, -100)
    self.bg_sprite:setScale(0.6, 0.6)
    self.bg_sprite.alpha = 0
    self.bg_sprite:fadeTo(1, 2)
    self.bg_sprite:setLayer(BATTLE_LAYERS["background"] + 5)
    self.bg_sprite:addFX(ShaderFX("water", { time = Kristal.getTime, wooblyfactor = 0.01 }))
    self.bg_sprite.debug_select = false

    Game.battle:addChild(self.bg_sprite)
end

function SpawnEncounter:beforeStateChange(old, new)
    if self.toggle_smoke then
        if old == "INTRO" and not self.darkness_controller then
            Game.battle.timer:after(1, function()
                self.darkness_controller = Game.battle:addChild(TitanDarknessController())
            end)
        end
    end

    if new == "VICTORY" and self.darkness_controller then
        self.darkness_controller.toggle_lessen = true
        self.bg_sprite:fadeTo(0, 1)
    end
end

return SpawnEncounter
