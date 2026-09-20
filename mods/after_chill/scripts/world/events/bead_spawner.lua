---@class bead_spawner : Event
local bead_spawner, super = Class(Event)

function bead_spawner:init(x, y, w, h, data)
    data = data or {}
    super.init(self, x, y, w, h)

    self.properties = data.properties or {}
    self.spawn_y = self.properties["bead_y"] or 380 
    self.amount = self.properties["beads"] or 5 
    self.spawn_rate = self.properties["rate"] or 1
    self.loop_timer = nil
end

function bead_spawner:spawnWave()
    local colors = {"blue", "orange", "green"}
    local step = self.amount > 1 and (self.width / (self.amount - 1)) or 0
    
    for i = 1, self.amount do 
        local color_index = ((i - 1) % #colors) + 1
        local bullet_color = colors[color_index]
        local spawn_x = self.x + ((i - 1) * step)
        
        Game.world:spawnBullet("bead", spawn_x, self.spawn_y, bullet_color)
    end 
end

function bead_spawner:onEnter(player)
    super.onEnter(self, player)
    self:spawnWave()
    if self.loop_timer then
        Game.stage.timer:cancel(self.loop_timer)
    end
    self.loop_timer = Game.stage.timer:every(self.spawn_rate, function()
        self:spawnWave()
    end)
end 

function bead_spawner:onExit(player)
    super.onExit(self, player)
    if self.loop_timer then
        Game.stage.timer:cancel(self.loop_timer)
        self.loop_timer = nil
    end
end

return bead_spawner
