return function(cutscene)

    Game.world.fader.alpha = 1
    cutscene:wait(0.5)
    Assets.playSound("noise")
    local logo = Game.stage:addChild(Sprite("logo", 113, 130))
    logo:setScale(2)
    logo:setLayer(9999)
    cutscene:wait(1.5)

    local after = Game.stage:addChild(Sprite("after", 188 + 22, 215)) 
    after:shake(2)
    after:setLayer(9999)
    after:setScale(2)
    cutscene:wait(cutscene:playSound("screenshake")) 

    -- hex code: #A8EBFF
    local chill = Game.stage:addChild(Sprite("chill", 360, 215)) 
    chill:shake(2)
    chill:setLayer(9999)
    chill:setScale(2)
    cutscene:wait(cutscene:playSound("screenshake"))

    local function iceshock(kx, ky)
    Assets.playSound("icespell")
    local function createParticle(x, y)
        local sprite = Sprite("effects/icespell/snowflake", x, y)
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(1.5)
        sprite.layer = 99999
        Game.stage:addChild(sprite)
        return sprite
    end

    local particles = {}
    particles[1] = createParticle(kx-25, ky-20)
    cutscene:wait(3/30)
    particles[2] = createParticle(kx+25, ky-20)
    cutscene:wait(3/30)
    particles[3] = createParticle(kx, ky+20)
    cutscene:wait(3/30)

    local burst = IceSpellBurst(kx, ky)
    Game.stage:addChild(burst)

    for _, particle in ipairs(particles) do
        particle:remove()
    end

    for _, particle in ipairs(particles) do
        for i = 0, 5 do
            local effect = IceSpellEffect(particle.x, particle.y)
            effect:setScale(0.75)
            effect.physics.direction = math.rad(60 * i)
            effect.physics.speed = 8
            effect.physics.friction = 0.2
            effect.layer = 99999
            Game.stage:addChild(effect)
        end
        end
    end 

    iceshock(chill:getRelativePos(chill.width/2, chill.height/2, Game.stage))

    cutscene:wait(0.5)
    local duration = Assets.playSound("petrify"):getDuration()
    local elapsed = 0

    Game.world.timer:during(duration, function()
    elapsed = elapsed + DT
    local progress = (math.min(elapsed / duration, 1.0) ^ 2) * 1.3
    local mixed = ColorUtils.mergeColor(COLORS.white, ColorUtils.hexToRGB("A8EBFF"), progress)
    chill:setColor(mixed)
    end) 
    cutscene:wait(duration)

    local snow = Sprite("effects/icespell/snowfall")
    snow:setWrap(true)
    snow:setScale(2)
    snow.alpha = 0
    snow.layer = 9998
    snow.physics = {
        speed = 16,
        direction = math.rad(30)
    }
    Game.stage:addChild(snow)

    Game.world.music:play("start", 0)
    Game.world.music:fade(0.5, 1)
    Game.world.timer:tween(0.5, snow, { alpha = 0.2 })
    cutscene:wait(5)
    logo:fadeOutAndRemove(0.5)
    after:fadeOutAndRemove(0.5)
    chill:fadeOutAndRemove(0.5)
    snow:fadeOutAndRemove(0.5)
    Game.world.music:fade(0, 0.5)
    cutscene:wait(0.5)
    cutscene:gotoCutscene("start.piano")
end
