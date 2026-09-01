local Character, super = HookSystem.hookScript(Character)

function Character:init(...)
   super.init(self, ...)
   self.mask_shader = love.graphics.newShader[[
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
            if (Texel(texture, texture_coords).a == 0.0) {
                discard;
            }
            return vec4(1.0);
        }
    ]]

    self.fade_out_shader = love.graphics.newShader[[
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
            float fade = mix(0.0, 1.0, texture_coords.y);

            return Texel(texture, texture_coords) * color * vec4(1.0, 1.0, 1.0, fade * 0.3);
        }
    ]]
end 

function Character:draw()
   super.draw(self)
   if not self:includes(ChaserEnemy) then

   local offset_x, offset_y = Game.world:getRelativePos(0, 0, self)
   local scale_x, scale_y = self:getScale()
   
   local reflection = Game.world.map:getTileLayer("Tile Layer 1")
   love.graphics.stencil(function()
      love.graphics.setShader(self.mask_shader)
      
      love.graphics.scale(1 / scale_x, 1 / scale_y)
      love.graphics.translate(offset_x * scale_x, (offset_y * scale_y) - 4)

      if reflection then reflection:draw() end

      love.graphics.setShader()
   end, "replace", 1)

   love.graphics.setStencilTest("greater", 0)

   love.graphics.translate(self.x - self.width, self.y + self.height * 2)
   love.graphics.scale(1 * scale_x, -1 * scale_y)

   love.graphics.setShader(self.fade_out_shader)
   super.draw(self)
   love.graphics.setShader()

   self.getDrawColor = getDrawColorOld

   love.graphics.setStencilTest()
end 
end

return Character