local fiery_aim, super = Class(Wave)

function fiery_aim:init()
    super.init(self)
    self.time = 5.5
    self.active_bullets = {}
end 

function fiery_aim:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end

function fiery_aim:onStart()
    Game.battle.arena:setFire(true, true)
    local x, y = Game.battle.arena:getTopRight()
    local bx, by = Game.battle.arena:getBottomRight()
    local px, py = Game.battle.arena:getBottomLeft()
    local tx, ty = Game.battle.arena:getTopLeft()
    
    self.positions = { 
        [1]  = {x + 40, y},
        [2]  = {x + 40, y + (142 / 3)},
        [3]  = {x + 40, y + (142 / 3) * 2},
        [4]  = {x + 40, y + 142},
        [5]  = {bx, by + 40},
        [6]  = {bx - (142 / 3), by + 40},
        [7]  = {bx - (142 / 3) * 2, by + 40},
        [8]  = {bx - 142, by + 40},
        [9]  = {px - 40, py},
        [10] = {px - 40, py - (142 / 3)},
        [11] = {px - 40, py - (142 / 3) * 2},
        [12] = {px - 40, py - 142},
        [13] = {tx, ty - 40},
        [14] = {tx + (142 / 3), ty - 40},
        [15] = {tx + (142 / 3) * 2, ty - 40},
        [16] = {tx + 142, ty - 40}
    }
    for i = 1, 16 do 
        local ax, ay = self.positions[i][1], self.positions[i][2]
        self:alertPos(ax, ay)
    end
    self.timer:after(0.3, function()
        Assets.playSound("bell")
        for i = 1, 16 do
            local ax, ay = self.positions[i][1], self.positions[i][2]
            local bullet = self:spawnBullet("fire_spin_bullet", ax, ay)
            table.insert(self.active_bullets, bullet)
        end
        for i = 1, 16 do
            self.timer:after((i - 1) * 0.25, function()
                local target_bullet = self.active_bullets[i]
                if target_bullet and target_bullet.stage then
                    Assets.playSound("bigcut")
                    target_bullet:fireAtTarget(Game.battle.soul.x,  Game.battle.soul.y)
                end
            end)
        end
    end)
end 

function fiery_aim:alertPos(px, py)
    local prep = self:spawnBullet("bullets/fire", px, py)
    prep.sprite:play(0.1, true)
    prep.alpha = 0.7 
    prep:addFX(ColorMaskFX(COLORS.red, 0.7))
    local toggle = false
    
    self.timer:every(0.1, function()
        Assets.playSound("noise")
        toggle = not toggle
        if toggle then
            prep.alpha = 0
        else
            prep.alpha = 0.8
        end
    end, 3)
    self.timer:after(0.3, function()
        prep:remove() 
    end) 
end

return fiery_aim
