local expand, super = Class(Wave) 

function expand:init() 
    super.init(self) 
    self.time = 9 
    self.rects = {}
end 

function expand:onArenaEnter() 
    super.onArenaEnter(self) 
    Game.battle.arena:setFire(true, false) 
end 

function expand:onStart() 
    Game.battle.arena:setFire(true, true) 
    self:drawRect(Game.battle.soul.y) 
end 

function expand:drawRect(y) 
    local rect = Rectangle(Game.battle.arena.x, y, Game.battle.arena.width, 4) 
    rect:setOrigin(0.5, 0.5) 
    rect:setColor(COLORS.red) 
    rect.alpha = 0.7 
    rect.layer = 9999 
    table.insert(self.rects, rect)
    Game.battle:addChild(rect) 
    Assets.playSound("alert") 
    
    self.timer:after(0.2, function() 
        self:expand(rect, y) 
    end) 
end 

function expand:expand(bl, y) 
    bl:setColor({0.4, 0.6, 1.0}) 
    bl.alpha = 0.4 
    bl.layer = 9999 
    Assets.playSound("expand") 
    
    self.timer:tween(0.4, bl, {height = 20}, "in-out-sine", function() 
        bl:fadeOutAndRemove(0.25) 
        self:bulletCall(y) 
    end) 
end 

function expand:bulletCall(spawn_y) 
    local up_bullets = {} 
    local down_bullets = {} 
    for i = 1, 3 do 
        local bullet = self:spawnBullet("effects/spare/z", Game.battle.arena:getLeft() + (i * 142/4), spawn_y) 
        bullet.destroy_on_hit = false  
        bullet:setScale(1) 
        bullet.alpha = 0 
        bullet:fadeTo(1, 0.25) 
        bullet:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4)) 
        bullet.trail_timer = 0 
        
        bullet.update = function(bs) 
            Bullet.update(bs) 
            bs.trail_timer = bs.trail_timer + DT 
            if bs.trail_timer >= 0.033 then 
                local cloud = AfterImage(bs, 0.2) 
                bs.trail_timer = 0.022 
                cloud:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4)) 
                Game.battle:addChild(cloud) 
            end 
        end 
        table.insert(up_bullets, bullet) 
    end 
    for i = 1, 3 do 
        local bullet = self:spawnBullet("effects/spare/z", Game.battle.arena:getLeft() + (i * 142/4), spawn_y) 
        bullet.destroy_on_hit = false 
        bullet:setScale(1) 
        bullet.alpha = 0 
        bullet:fadeTo(1, 0.25) 
        bullet:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4)) 
        bullet.trail_timer = 0 
        
        bullet.update = function(bs) 
            Bullet.update(bs) 
            bs.trail_timer = bs.trail_timer + DT 
            if bs.trail_timer >= 0.033 then 
                local cloud = AfterImage(bs, 0.2) 
                bs.trail_timer = 0.022 
                cloud:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4)) 
                Game.battle:addChild(cloud) 
            end 
        end 
        table.insert(down_bullets, bullet) 
    end 
    
    self:moveBullets(up_bullets, down_bullets, TableUtils.pick({1, 2}) == 2) 
end 

function expand:moveBullets(u_tbl, d_tbl, left) 
    -- Process Upwards Group
    for i, bullet in ipairs(u_tbl) do 
        if left then 
            if i == 1 or i == 3 then 
                bullet.physics.speed_y = -6 
                bullet.physics.gravity = -0.2
            else 
                bullet.physics.speed_y = -4 
                bullet.physics.gravity = -0.2
            end 
        else 
            if i == 2 then 
                bullet.physics.speed_y = -6 
                bullet.physics.gravity = -0.2 
            else 
                bullet.physics.speed_y = -4 
                bullet.physics.gravity = -0.2
            end 
        end 
    end 
    
    -- --- FIXED: No crashes, variables use 'z' correctly, columns stay lined up ---
    for n, z in ipairs(d_tbl) do 
        if left then 
            if n == 2 then 
                z.physics.speed_y = 6 
                z.physics.gravity = 0.2
            else 
                z.physics.speed_y = 4 
                z.physics.gravity = 0.2
            end 
        else 
            if n == 1 or n == 3 then 
                z.physics.speed_y = 6 
                z.physics.gravity = 0.2
            else 
                z.physics.speed_y = 4 
                z.physics.gravity = 0.2
            end 
        end 
    end 
    
    self.timer:after(0.4, function() 
        if Game.battle.soul then 
            self:drawRect(Game.battle.soul.y) 
        end 
    end) 
end 

function expand:onEnd()
    super.onEnd(self)
    for _, re in ipairs(self.rects) do 
        re:remove()
    end 
end 

return expand
