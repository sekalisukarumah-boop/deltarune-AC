local FlameLine, super = Class(Wave)

function FlameLine:init()
    super.init(self)
    self.time = 10
    self.active_trail = nil 
end

function FlameLine:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul

    self.timer:everyInstant(1.5, function()
        Assets.stopAndPlaySound("flower", 2, 1)
        local x = TableUtils.pick({arena.left - 60, arena.right + 60})
        local y = TableUtils.pick({arena.bottom, arena.top, arena.bottom-arena.top/2})
        local angle = MathUtils.angle(x, y, soul.x, soul.y)
        
        self:spawnBullet("ralsei/firebullet", x, y, angle, 8)
    end)
end

return FlameLine
