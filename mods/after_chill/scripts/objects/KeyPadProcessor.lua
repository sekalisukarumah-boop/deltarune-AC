local KeyPadProcessor, super = Class(Event)

function KeyPadProcessor:init(data)
    super.init(self, data.x, data.y, data.width, data.height)

    self.data = data
    self.code = self:addChild(KeyCode(data.properties)) 
    
    self.rect = Game.world:addChild(Rectangle(0, 0, 9999, 9999))
    self.rect:setColor(COLORS.black)
    self.rect.alpha = 0
    self.rect:setLayer(WORLD_LAYERS["below_textbox"])
    
    self.heart = Assets.getTexture("player/heart_menu")
    
    self.can_draw_keypad = false
    self.keypad_alpha = 0
    self.selected_index = 1
    self.original_layer = self.layer 
    self.solid = true 

    self.window_state = "DEFAULT" 
end

function KeyPadProcessor:onLoad()
    super.onLoad(self)

    self.target = Game.world:getEvent(self.data.properties["door_target"])
    self.transition = Game.world:getEvent(self.data.properties["transition"])
    self.k = Game.world:getEvent(self.data.properties["keypad"])

    if self:getFlag("completed", false) ~= true then 
        for _, t in ipairs(Game.stage:getObjects(Transition)) do 
        if t == self.transition then  
            t.y = t.y - 1000
        end 
        end 
        
        local group = ColliderGroup(self)
        group:addCollider(Hitbox(self, 0, 0, self.width, self.height))
        
        if self.target then
            local offset_x, offset_y = self.target:getRelativePos(0, 0, self)
            group:addCollider(Hitbox(self, offset_x, offset_y, self.target.width, self.target.height))
        end 
        self.collider = group    
    elseif self:getFlag("completed") then 
        self.solid = false   
        self.k.tile = self.k.tile + 1 
        if self.target then 
            self.target:remove() 
        end
    end
end

function KeyPadProcessor:onInteract(player, dir)
    if self:getFlag("completed", false) ~= true then 
        local s = Assets.playSound("beep_on")
        self:setLayer(99999)
        Game.lock_movement = true 
        
        Game.world.timer:after(0.2, function()
            self.rect:fadeTo(0.3, s:getDuration())
            Game.stage:addChild(KeyPadUI(self))
        end)
        return true 
    end 
end 

function KeyPadProcessor:onSuccess()
    self:setFlag("completed", true)
    self.solid = false

    local target_door = Game.world:getEvent(self.data.properties["door_target"])
    local player = Game.world.player
    Game.lock_movement = true 
    local s 
    self.k.tile = self.k.tile + 1 
    player:walkTo(player.x, player.y + 25, 0.25, "up", true)
    
    Game.world.timer:after(0.75, function()
        if target_door then 
            s = Assets.playSound("fwoosh", 1.7)
            target_door:fadeOutAndRemove(s:getDuration())
            target_door:slideTo(target_door.x + 66, target_door.y, s:getDuration())
        end 
        Game.world.timer:after(s:getDuration(), function()
              for _, t in ipairs(Game.stage:getObjects(Transition)) do 
        if t == self.transition then  
            t.y = t.y + 1000
        end 
        end 
            Game.lock_movement = false
        end)
    end)
end 

function KeyPadProcessor:onUIClosed()
    if self.rect then
        self.rect:fadeTo(0, 0.25)
    end
    self.layer = self.original_layer or 0
    Game.lock_movement = false
end

return KeyPadProcessor
