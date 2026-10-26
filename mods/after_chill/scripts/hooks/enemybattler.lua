local EnemyBattler, super = HookSystem.hookScript(EnemyBattler)

function EnemyBattler:getCheckText()
    if Game:getFlag("geno") then 
        return "* " .. string.upper(self.name) .. " - AT ??? DF ???\n* Standing in your way."
    else 
        return super.getCheckText(self)
    end
end

function EnemyBattler:draw()
   super.draw(self)
   if Game.battle.encounter.reflections then 

   local offset_x, offset_y = Game.world:getRelativePos(0, 0, self)
   local scale_x, scale_y = self:getScale()

   local reflection = Game.world.map:getTileLayer("Tile Layer 1")

   love.graphics.stencil(function()
      love.graphics.setShader(Mod.mask_shader)

      love.graphics.scale(1 / scale_x, 1 / scale_y)
      love.graphics.translate(offset_x * scale_x, offset_y * scale_y)

      if reflection then reflection:draw() end

      love.graphics.setShader()
   end, "replace", 1)

   love.graphics.setStencilTest("greater", 0)

   love.graphics.origin()

   love.graphics.translate(self.x - (self.width), self.y + self.height * 2 + (self.actor.ground_height or 0))
   love.graphics.scale(1 * scale_x, -1 * scale_y)

   love.graphics.setShader(Mod.fade_out_shader)
   super.draw(self)
   love.graphics.setShader()

   self.getDrawColor = getDrawColorOld

   love.graphics.setStencilTest()
end 
end

function EnemyBattler:init()
    super.init(self)
    -- make sure to change the value here when the time comes 
    if (Game:getFlag("enemies_killed", 0) >= 10) and Game:getFlag("encounter#ralsei:violenced") then
    local kills = Game:getFlag("enemies_killed", 0)
    local dynamic_tp = 0

    if kills >= 10 then
        local scaling_kills = kills - 5
        dynamic_tp = MathUtils.clamp(MathUtils.roundFromZero((scaling_kills * 1.5)), 10, 50)
    end

    self.rupt = self:registerAct("Rupture", "Bonus DMG\nwhen TIRED", {}, dynamic_tp) 
    TableUtils.removeValue(self.acts, self.rupt)
    end 
end 

function EnemyBattler:onTurnStart(...)
    super.onTurnStart(self, ...)
    if (not self:getAct("Rupture")) and (Game:getFlag("enemies_killed", 0) >= 10) and Game:getFlag("encounter#ralsei:violenced") then 
    table.insert(self.acts, self.rupt)
    end 
end 

function EnemyBattler:onDefeat(...)
    -- so here be like, add it on IF rupture hasn't been unlocked yet, so, if its bigger than  like, the amount needed, then start counting the rupture kills.
    if Game:getFlag("enemies_killed") <= 9 then 
    Game:addFlag("enemies_killed", 1)
    super.onDefeat(self, ...)
    end 
end 

function EnemyBattler:onAct(battler, name)
    if name == "Rupture" then 
        Game.battle:powerAct("rupture", battler, "kris")
    end 
    return super.onAct(self, battler, name)
end 

return EnemyBattler