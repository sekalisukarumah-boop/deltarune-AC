---@class noelle_lw : Actor
local actor, super = Class("noelle_lw", true)

function actor:init()
    super.init(self)

    self.animations = TableUtils.merge(self.animations, {
        ["make_fountain/grab_knife"] = {"make_fountain/grab_knife", 1/3, false},
        ["make_fountain/target"] = {"make_fountain/old_target", 1/15, false},
        ["make_fountain/make"] = {"make_fountain/make", 1/15, false, next="make_fountain/make_loop"},
        ["make_fountain/make_loop"] = {"make_fountain/make_loop", 1/15, true},
        ["make_fountain/stand_up"] = {"make_fountain/stand_up", 1/7.5, false, next="make_fountain/walk_scare/left"},
    })

end
function actor:drawSilhouette()
    love.graphics.setColor(1, 1, 1, 1)
    self.sprite:draw()
end

return actor