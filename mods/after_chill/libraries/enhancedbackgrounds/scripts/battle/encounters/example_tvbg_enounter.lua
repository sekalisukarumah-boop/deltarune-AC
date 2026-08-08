local TvEncounter, super = Class(DojoEncounter, "example_tvbg_enounter")

function TvEncounter:init()
    super.init(self)

    self.text = "* It's an all out battle scene!"

    self.music = "tv_world"
    self.background = true

    self:addEnemy("encounter_example_dummy").spotlight = true

    Game:setBorder("tvworld")


    self.pa_speaker = Game.battle:addChild(PASpeaker(
        "ATTENTION EVERYONE!! ATTENTION EVERYONE!!      It's an all out brawl!"))

    self.tv_crowd = Game.battle:addChild(TeevieCheerCrowd(0, 500, 1000, 90))
    Game.battle.timer:tween(2, self.tv_crowd, { y = 50 }, "in-quad")


    self.logo_sprite = Sprite("battle/effects/tv_time_logo", 575, 279)
    self.logo_sprite:setScale(0.5, 0.5)
    self.logo_sprite:setOrigin(0.5, 0.5)
    self.logo_sprite.alpha = 0
    self.logo_sprite:fadeTo(1, 3)
    self.logo_sprite:setLayer(BATTLE_LAYERS["below_ui"] + 15)

    
    self.rot_siner = 0

    self._pa_strings = {
        "GET THOSE LIGHTNERS, OR ELSE IT'S PAYCUTS FOR ALL OF YOU!",
        "MIKE, MY SHOCK THERAPY! NOW!!!!",
        "KRIS, SUSIE!! GET BACK IN THE CAPSULES!",
        "RAMB, WHY AREN'T YOU ON THE LOOKOUT FOR THEM!"
    }

    Game.battle:addChild(self.logo_sprite)
    self.stop_spawning = false

    Game.battle.timer:every(15, function()
        if not self.stop_spawning then
            self.pa_speaker = Game.battle:addChild(PASpeaker(TableUtils.pick(self._pa_strings)))
        end
    end)
end

function TvEncounter:update()
    super.update(self)
    self.rot_siner = self.rot_siner + (1 * DTMULT)

    self.logo_sprite.rotation = math.sin(self.rot_siner * 0.1) * 0.3
end

function TvEncounter:beforeStateChange(old, new)
    if new == "VICTORY" then
        self.logo_sprite:fadeTo(0, 0.2)
        Game.battle.timer:tween(0.5, self.tv_crowd, { y = 300 }, "out-quad")
        if self.pa_speaker then
            Game.battle.timer:tween(0.5, self.pa_speaker, { y = -200 }, "out-quad")
        end
        self.stop_spawning = true
    end
end

return TvEncounter
