local tired_throw, super = Class(Wave)

function tired_throw:init()
    super.init(self)
    self.time = 14
end 

function tired_throw:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end

function tired_throw:onStart()
    local arena = Game.battle.arena
    arena:setFire(true, true)
    local tx, _ = arena:getTopLeft()
    self.timer:everyInstant(0.8, function()
        Assets.playSound("spell_cure_slight_smaller", 1, 1.2)
            local side_picker = TableUtils.pick({1, 2})
            local spawn_y = love.math.random(45, 95)  
            local angel   
            if side_picker == 1 then 
                local offset_left = tx - love.math.random(20, 60)
                angel = self:spawnBullet("tired_angel", offset_left, spawn_y, true)
            else 
                local offset_right = tx + 142 + love.math.random(20, 60)
                angel = self:spawnBullet("tired_angel", offset_right, spawn_y, false)
            end 
            angel.alpha = 0 
            Assets.playSound("alert")
            local spr = self:spawnSprite("bullets/ralsei/bullet_1", angel.x, angel.y)
            if angel:isLeft() then 
            spr:setScale(-2, 2)
            end 
            spr:setOrigin(0.5, 0.5)
            spr.alpha = 0.6 
            spr:addFX(ColorMaskFX(COLORS.red, 0.6))
            self.timer:after(0.1, function()
            angel:fadeTo(1, 0.1, function()  spr:remove(); angel:burstProjectiles() end)
            end)
        end)
end

return tired_throw
