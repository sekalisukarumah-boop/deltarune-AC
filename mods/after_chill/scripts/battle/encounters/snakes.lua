local snakes, super = Class(Encounter)

function snakes:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* A bundle of snakes block your path...!"

    self.music = "silly"
    -- Enables the purple grid battle background
    self.background = false
    self:addEnemy("snake", 460, 110)
    self:addEnemy("snake", 430, 200)
    self:addEnemy("snake", 460, 290)
end

return snakes
