local Savepoint, super = HookSystem.hookScript(Savepoint)

function Savepoint:inForest()
  local f = false 
  if StringUtils.contains(Game.world.map.id, "forest") then 
    f = true 
  end
  return f 
end 

function Savepoint:init(...)
    super.init(self, ...)
    if self:inForest() then
    local b = self:addChild(HazyGlow())
    b.layer = self.layer - 0.5
    end 
end

return Savepoint