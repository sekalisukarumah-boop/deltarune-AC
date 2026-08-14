function Mod:init()
    Game:registerEvent("squeak", function(data)
        return Squeak(data.x, data.y, {data.width, data.height, data.polygon})
    end)
    print("Loaded " .. self.info.name .. "!")
end

function Mod:postInit(bool)
    if bool then 
        Game.world:startCutscene("noelle.fall")
    end 
end 

function Mod:onFootstep(chara, num)
    if Game:getFlag("footstep") then 
        Assets.playSound("step"..num, 0.8)
    end 
end 

