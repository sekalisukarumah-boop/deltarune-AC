local actor, super = Class(Actor, "snake")

function actor:init()
    super.init(self)

    self.name = "Snake"
    self.width = 0
    self.height = 22
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

return actor
