local TitanDarknessController, super = Class(Object)

function TitanDarknessController:init()
    super.init(self)
    self:setPosition(0, 0)
    self.layer = -760
    self.timer = 0
    self.spawn_speed = 15
    self.spawn_timer = self.spawn_speed

    self.alpha_gain = 0

    self.fumes = {}
    self:addFX(ShaderFX('pixelate', {
        size = { SCREEN_WIDTH, SCREEN_HEIGHT },
        factor = 2
    }))
    local center_x, center_y = 320, 200
    local radius_x           = 350
    local radius_y           = 280

    local count              = 160


    for i = 1, SCREEN_WIDTH, 10 do
        local x = i
        local y = 340 + Utils.random(-40, 40)


        table.insert(self.fumes, {
            x,
            y,
            Utils.random(20, 45),
            self.timer + Utils.random(-30, 30),
            false
        })
    end

    self.hand_texture = Assets.getTexture("battle/effects/hands_bobbing_left")
    self.hand_texture_right = Assets.getTexture("battle/effects/hands_bobbing_right")

    self.hands = {}

    table.insert(self.hands, {
        texture = self.hand_texture,
        x = 40,
        base_y = 370 + Utils.random(-10, 10),
        rotation = math.rad(-35),
        offset = Utils.random(0, 200),
        speed = Utils.random(0.6, 1.2),
        rise = Utils.random(25, 45)
    })

    table.insert(self.hands, {
        texture = self.hand_texture_right,
        x = 180,
        base_y = 360 + Utils.random(-10, 10),
        rotation = math.rad(20),

        offset = Utils.random(0, 200),
        speed = Utils.random(0.6, 1.2),
        rise = Utils.random(25, 45)
    })


    table.insert(self.hands, {
        texture = self.hand_texture,
        x = 450,
        base_y = 350 + Utils.random(-10, 10),
        rotation = math.rad(-42),

        offset = Utils.random(0, 200),
        speed = Utils.random(0.6, 1.2),
        rise = Utils.random(25, 45)
    })


    table.insert(self.hands, {
        texture = self.hand_texture_right,
        x = 600,
        base_y = 340 + Utils.random(-10, 10),
        rotation = math.rad(35),

        offset = Utils.random(0, 200),
        speed = Utils.random(0.6, 1.2),
        rise = Utils.random(25, 45)
    })
end

function TitanDarknessController:getHandInfo(hand)
    local time = self.timer + hand.offset 
    local cycle = math.max(0, math.sin(time * 0.05 * hand.speed))
    local x = hand.x + math.sin(time / 4) * 4
    local y = hand.base_y - (cycle * hand.rise)
    return hand.texture, x, y, hand.rotation, cycle
end

function TitanDarknessController:update()
    super.update(self)
    self:setLayer(BATTLE_LAYERS["background"] + 10)
    self.timer = self.timer + DTMULT
    self.spawn_timer = self.spawn_timer - DTMULT

    if self.toggle_lessen then
        self.alpha_gain = Utils.approach(self.alpha_gain, 0, 0.03 * DTMULT)
    else
        if self.alpha_gain >= 1 then
            self.alpha_gain = 1
        else
            self.alpha_gain = self.alpha_gain + (0.03 * DTMULT)
        end
    end

    --[[if self.spawn_timer < 0 then
        self.spawn_timer = self.spawn_timer + self.spawn_speed
        table.insert(self.fumes,
            { Utils.random(0, SCREEN_WIDTH), SCREEN_HEIGHT + 30, Utils.random(10, 40), self.timer, true })
    end]]



    local to_remove = {}
    for index, fume in ipairs(self.fumes) do
        local x, y, radius = self:getFumeInformation(index)
        if y < -(radius + 30) or radius < 0 then table.insert(to_remove, fume) end
    end

    for _, fume in ipairs(to_remove) do
        Utils.removeFromTable(self.fumes, fume)
    end
end

function TitanDarknessController:getFumeInformation(index)
    local x, y, radius, time, shrink_move = Utils.unpack(self.fumes[index])
    if shrink_move then
        time = self.timer - time
        x = x + math.sin(time / 4) * 4
        y = y - time * 1.9
        radius = radius - time * 0.1
    else
        time = self.timer - time
        y = y + math.sin(time / 4) * 4
    end
    return x, y, radius, time
end

function TitanDarknessController:draw()
    super.draw(self)

    Draw.setColor(1, 1, 1, self.alpha_gain)
    for index, _ in ipairs(self.fumes) do
        local x, y, radius = self:getFumeInformation(index)
        love.graphics.setLineWidth(4)
        love.graphics.circle("line", x, y, radius)
    end


    Draw.setColor(1, 1, 1, self.alpha_gain)
    for _, hand in ipairs(self.hands) do
        local texture, x, y, rotation, cycle = self:getHandInfo(hand)
        love.graphics.draw(
            texture, x, y, rotation, 1 / 2, 1 / 2,
            self.hand_texture:getWidth() / 2,
            self.hand_texture:getHeight()
        )
    end



    Draw.setColor(COLORS.black, self.alpha_gain)
    for index, _ in ipairs(self.fumes) do
        local x, y, radius = self:getFumeInformation(index)
        love.graphics.circle("fill", x, y, radius - 2)
    end
    love.graphics.rectangle("fill", 0, 440, SCREEN_WIDTH, 200)
    love.graphics.rectangle("fill", 0, 340, 50, 200)
    love.graphics.rectangle("fill", 560, 340, 80, 200)
end

return TitanDarknessController
