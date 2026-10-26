local SnowflakeBG, super = Class(BattleBackground)

function SnowflakeBG:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.timer = 0

    self.flakes = {}
    local bottom_vertices = {
        {0,   320, 0, 0,  0.4, 0.7, 0.9, 0.0}, 
        {640, 320, 0, 0,  0.4, 0.7, 0.9, 0.0}, 
        
        {0,   480, 0, 0,  0.4, 0.7, 0.9, 0.5}, 
        {640, 480, 0, 0,  0.4, 0.7, 0.9, 0.5}, 

        {0,   640, 0, 0,  0.4, 0.7, 0.9, 0.5}, 
        {640, 640, 0, 0,  0.4, 0.7, 0.9, 0.5}, 
    }

    self.glow_mesh = love.graphics.newMesh(bottom_vertices, "strip", "static")

    for i = 1, 20 do
        self:spawnFlake(true)
    end
end

function SnowflakeBG:spawnFlake(init)
    local f = Sprite("effects/icespell/snowflake")
    f.debug_select = false 
    f.x = love.math.random(-50, 690)
    f.y = init and love.math.random(-50, 480) or love.math.random(-100, -20)
    local scale = love.math.random(8, 12) / 10
    f:setScale(scale)
    f:setOrigin(0.5, 0.5)
    f:setColor(0.8, 0.95, 1, 0.35) -- Set your baseline alpha directly here
    f.physics.speed_y = love.math.random(8, 12)
    f.physics.gravity = 0.5                      
    f.physics.friction = 0.02                    
    f.graphics.spin = math.abs(love.math.random(-5, 5)) / 30
    f.graphics.grow = -0.00001                  
    f.start_x = love.math.random(0, 100)
    f.sway_speed = love.math.random(1, 3)
    f.sway_width = love.math.random(8, 15)       
    
    -- Custom timer variable so it doesn't spawn an afterimage every single frame
    f.trail_timer = 0
    
    self:addChild(f)
    table.insert(self.flakes, f) 
end

function SnowflakeBG:update()
    super.update(self)
    self.timer = self.timer + DT

    for i = #self.flakes, 1, -1 do
        local f = self.flakes[i]
        if f.stage then
            f.physics.speed_x = math.sin(self.timer * f.sway_width) * MathUtils.random(1, 1.3)
            f.trail_timer = f.trail_timer + DT
            if f.trail_timer >= 0.05 then
                local trail = AfterImage(f, 0.6, 0.1)
                self:addChild(trail)
                trail.debug_select = false
                trail:addFX(ColorMaskFX(COLORS.white, 0.6))   
                f.trail_timer = 0
            end
            
            if f.y > 500 then
                f:remove()
                table.remove(self.flakes, i)
                self:spawnFlake(false)
            end
        else
            table.remove(self.flakes, i)
        end
    end
end

function SnowflakeBG:draw()
    super.draw(self)
    love.graphics.setBlendMode("add", "alphamultiply")
    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.draw(self.glow_mesh, 0, -110)
    love.graphics.setBlendMode("alpha", "alphamultiply")
    love.graphics.setColor(1, 1, 1, 1)
end

return SnowflakeBG
