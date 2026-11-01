local licksby1, super = Class(Encounter)

function licksby1:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Licksby glitched its way into\nthe battlefield!"

    --sd
    self.music = "snowstorm"
    -- Enables the purple grid battle background
    self.background = true
     
    -- adds enemy
    self:addEnemy("licksby", 549, 214)
end


return licksby1
