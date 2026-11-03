local actor, super = Class("noelle", true)

function actor:init()
    super.init(self)
    self.portrait_offset = {-20, -10}
    -- Table of sprite animations
    self.reflection_offsets = { 
        ["battle_alt/float"] = {12, -10}, 
        ["battle/spell"]       = {9, 4}, 
        ["battle/spell_9"]       = {9, 4}, 
    }

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

function actor:onSetAnimation(sprite, anim, keep_anim)
    -- if anim[1] == "battle_alt/pray" then
    --     local background = SnowglobeEffect(0, 0, false)
    --     local foreground = SnowglobeEffect(0, 0, true)
    --     sprite.parent:addChild(background)
    --     sprite.parent:addChild(foreground)
    --     background.layer = sprite.layer - 1
    --     foreground.layer = sprite.layer + 1
    --     background:setScale(0.5)
    --     foreground:setScale(0.5)
    -- end
end

return actor                    
