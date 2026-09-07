local crossrain, super = Class(Wave)

function crossrain:onStart()
   self.time = 8
   self:arenaWah()
end 

function crossrain:arenaWah()
    self.timer:tween(0.2, Game.battle.arena, {height = 142/4, width = 142+40})
    self.timer:after(0.2, function() self:startRain() end)
end 

function crossrain:afterimage(bullet)
    self.timer:every(0.05, function()
        local afterimage = AfterImage(bullet, 1.4, 0.2)
        Game.battle:addChild(afterimage)
        afterimage.physics.speed_y = MathUtils.random(-2, 2)
        afterimage.alpha = 0.6
        afterimage.physics.friction = 0.2
    end)
end

function crossrain:startRain()
    self.timer:everyInstant(0.2, function()
        local rx = love.math.random(Game.battle.arena:getLeft(), Game.battle.arena:getRight())
        local cross = self:spawnBullet("bullets/cross", rx, 0)
        self:afterimage(cross)
        cross.physics.speed_y = 7 
        cross.physics.gravity = 0.3 
        cross.graphics.spin = 0.2
    end)
end 


return crossrain