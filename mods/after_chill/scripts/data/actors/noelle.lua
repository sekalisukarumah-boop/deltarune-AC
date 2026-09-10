local actor, super = Class("noelle", true)

function actor:init()
    super.init(self)
    self.portrait_offset = {-20, -10}
    -- Table of sprite animations
    TableUtils.merge(self.animations, {
        ["fall"]         = {"dark", 1/6, true},
        ["float"]        = {"battle_alt/float", 1/8, true},
        ["pray"]         = {"battle_alt/pray", 1/6, true},
        ["sweep"]        = {"battle/sweep", 1/4, true}, 
        ["up_spell"]     = {"up/spell_up", 1/12, false},
      --  ["float"]        = {"float", 1/8, true},
        ["spell"]        = {"battle/spell", 1/15, false},
        -- You can hook here, ["battle/idle"] = {"my/different/id", speed, loop} bc it will override 
    }, false) 

    TableUtils.merge(self.offsets, {
        ["collapsed_opp"] = {-14, 22},
        ["collapsed"] = {-14, 22},
    }, false) 
end

return actor                    
