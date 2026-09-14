local crossrain, super = Class(Wave)

function crossrain:onStart()
   self.time = 8
   self.active_crosses = {} -- Table to hold our live bullets
   
   self:arenaWah()
   self:startAfterimageLoop() -- Call our single central loop
end 

function crossrain:arenaWah()
    self.timer:tween(0.2, Game.battle.arena, {height = 142/4, width = 142+40})
    self.timer:after(0.2, function() self:startRain() end)
end 

function crossrain:startAfterimageLoop()
    -- One single timer loop for the whole wave
    self.timer:every(0.05, function()
        for i = #self.active_crosses, 1, -1 do
            local bullet = self.active_crosses[i]
            
            -- Check if the bullet still exists in the battle world
            if bullet and bullet.stage then
                local afterimage = AfterImage(bullet, 1.4, 0.2)
                Game.battle:addChild(afterimage)
                afterimage.physics.speed_y = MathUtils.random(-2, 2)
                afterimage.alpha = 0.6
                afterimage.physics.friction = 0.2
            else
                -- Bullet was destroyed, safely remove it from our tracking table
                table.remove(self.active_crosses, i)
            end
        end
    end)
end

function crossrain:startRain()
    self.timer:everyInstant(0.2, function()
        local rx = love.math.random(Game.battle.arena:getLeft(), Game.battle.arena:getRight())
        local cross = self:spawnBullet("bullets/cross", rx, 0)
        
        cross.physics.speed_y = 7 
        cross.physics.gravity = 0.3 
        cross.graphics.spin = 0.2
        
        -- Stuff the cross into our tracker
        table.insert(self.active_crosses, cross)
    end)
end 

return crossrain 
