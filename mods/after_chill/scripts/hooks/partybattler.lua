local PartyBattler, super = HookSystem.hookScript(PartyBattler)

function PartyBattler:draw()
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

return PartyBattler