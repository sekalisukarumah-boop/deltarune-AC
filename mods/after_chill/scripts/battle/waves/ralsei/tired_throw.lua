local tired_throw, super = Class(Wave)

function tired_throw:init()
    super.init(self)
    self.time = 9
end

function tired_throw:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end

function tired_throw:onStart()
    local arena = Game.battle.arena
    arena:setFire(true, true)
    local tx, _ = arena:getTopLeft()
    self.timer:everyInstant(0.65, function()
        Assets.playSound("spell_cure_slight_smaller", 1, 1.2)
        
        local side_picker = TableUtils.pick({1, 2})
        local offset_y_choices = {-24, -12, 0, 12, 24}
        local spawn_y = Game.battle.soul.y + TableUtils.pick(offset_y_choices)
        
        local angel
        if side_picker == 1 then
            local offset_left = tx - love.math.random(10, 25)
            angel = self:spawnBullet("tired_angel", offset_left, spawn_y, true)
        else
            local offset_right = tx + 142 + love.math.random(10, 25)
            angel = self:spawnBullet("tired_angel", offset_right, spawn_y, false)
        end
        
        angel.alpha = 0
        angel:fadeTo(1, 0.20, function()
            angel:burstProjectiles()
        end)
    end)
end

return tired_throw
