local actor, super = Class(Actor, "snake")

function actor:init()
    super.init(self)

    self.name = "Snake"
    self.width = 0
    self.height = 16
 --   self.hitbox = {0, 0,45, 34}
    self.color = { 1, 0, 0 }
    self.flip = nil
    self.path = "enemies/bead_snake"
    self.default = "idle"
    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil
    self.can_blush = false
    self.talk_sprites = {}

    self.animations = {
        ["idle"] = { "idle", 0.25, true },
    --    ["spared"] = {"spared", 0.25, true}, 
     --   ["hurt"]= {"hurt", 0.25, true}
    }

    self.offsets = {
        ["idle"] = { 0, 0 },
    }
end

function actor:onSpriteUpdate(sprite) 
   -- Logging.info(""..sprite.frame.."")
    if Game.battle == nil then
    if sprite.frame == 5 or sprite.frame == 4 then
        self.height = 16
    elseif sprite.frame == 6 or sprite.frame == 7 then 
        self.height = 19
    elseif sprite.frame == 8 then 
        self.height = 25
    elseif sprite.frame == 1 then 
        self.height = 33
    elseif sprite.frame == 2 then 
        self.height = 26
    elseif sprite.frame == 3 then 
        self.height = 19
    end 
end 
end

return actor
