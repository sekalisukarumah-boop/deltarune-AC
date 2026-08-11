local pacify_wave, super = Class(Wave)

function pacify_wave:init()
    super.init(self)
    self.time = 11.3
    self.pacify = {}
    self.loop_timer = nil 
end

function pacify_wave:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end

function pacify_wave:onStart()
    Game.battle.arena:setFire(true, true)
    local ralsei = self:getAttackers()[1]
    self.loop_timer = self.timer:everyInstant(1.5, function()
        if ralsei then
            ralsei:setAnimation("spell", function()
                Assets.playSound("spell_pacify") 
                local cx, cy = SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2
                cx, cy = ralsei:getRelativePos(ralsei.width / 2 - 20, ralsei.height / 2 - 10)
                self.timer:script(function(wait)
                    for i = 1, love.math.random(3, 5) do
                        local z_bullet = self:spawnBullet("pacify_z_bullet", cx, cy)
                        z_bullet.tiredness = 8 
                        table.insert(self.pacify, z_bullet)
                        wait(0.08) 
                    end
                end)
            end)
        end
    end)
end

function pacify_wave:beforeEnd()
    if self.loop_timer then
        Game.battle.timer:cancel(self.loop_timer)
    end
    Assets.stopSound("spell_pacify")
    super.beforeEnd(self)
end

function pacify_wave:onEnd()
    if self.loop_timer then
        Game.battle.timer:cancel(self.loop_timer)
    end
    Assets.stopSound("spell_pacify")
    super.onEnd(self)
end 

return pacify_wave
