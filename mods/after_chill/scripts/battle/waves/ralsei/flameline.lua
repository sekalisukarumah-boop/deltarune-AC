local FlameLine, super = Class(Wave)

function FlameLine:init()
    super.init(self)
    self.time = 10
end

function FlameLine:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:everyInstant(1.5, function()
        Assets.stopAndPlaySound("flower", 2, 1)
        local x = Utils.pick({arena.left - 60, arena.right + 60})
        local y = Utils.pick({arena.bottom,arena.top,arena.bottom-arena.top/2})
        local angle = MathUtils.angle(x, y, soul.x, soul.y)
        self:spawnBullet("ralsei/firebullet", x, y, angle, 8)
    end)
end

return FlameLine