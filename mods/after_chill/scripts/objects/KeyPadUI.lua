local KeyPadUI, super = Class(Object)

function KeyPadUI:init(processor)
    super.init(self, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
    
    self.processor = processor 
    self.layer = 999995 
    
    self.heart = Assets.getTexture("player/heart_menu")
    self.keypad_alpha = 0
    self.selected_index = 1
    self.window_state = "DEFAULT"

    Game.world.timer:tween(0.25, self, {keypad_alpha = 1})
end

function KeyPadUI:update()
    super.update(self)
    
    if self.window_state ~= "DEFAULT" then return end

    if Input.pressed("cancel") then 
        self:closeUpSequence(false) 
        return
    end 

    if Input.pressed("confirm") then 
        if self.selected_index == 11 then
            self:handleBackspace()
        else
            self:insertNum()
        end
    end 
    
    local prev = self.selected_index
    local next_num = prev
    local moved = false

    if Input.pressed("down") then 
        if prev <= 6 then next_num = prev + 3 moved = true
        elseif prev == 7 or prev == 8 then next_num = 10 moved = true
        elseif prev == 9 then next_num = 11 moved = true
        else Assets.stopAndPlaySound("ui_cant_select") end 
    elseif Input.pressed("up") then
        if prev == 10 then next_num = 8 moved = true
        elseif prev == 11 then next_num = 9 moved = true
        elseif prev >= 4 then next_num = prev - 3 moved = true
        else Assets.stopAndPlaySound("ui_cant_select") end
    elseif Input.pressed("right") then
        if prev == 10 then next_num = 11 moved = true
        elseif prev == 11 then Assets.stopAndPlaySound("ui_cant_select")
        elseif prev % 3 == 0 then next_num = prev - 2 moved = true
        else next_num = prev + 1 moved = true end
    elseif Input.pressed("left") then
        if prev == 10 then Assets.stopAndPlaySound("ui_cant_select")
        elseif prev == 11 then next_num = 10 moved = true
        elseif prev % 3 == 1 then next_num = prev + 2 moved = true
        else next_num = prev - 1 moved = true end
    end

    if moved then
        Assets.playSound("ui_move")
        self.selected_index = next_num
    end
end


function KeyPadUI:handleBackspace()
    if #self.processor.code.answer > 0 then
        Assets.stopAndPlaySound("ui_select")
        table.remove(self.processor.code.answer)
    else
        Assets.stopAndPlaySound("ui_cant_select")
    end
end

function KeyPadUI:insertNum()
    if self.window_state ~= "DEFAULT" then return end

    Assets.stopAndPlaySound("ui_select")
    local digit = self.selected_index
    if digit == 10 then 
        digit = 0 
    end

    self.processor.code:addNumberToAnswer(digit)
    
    if #self.processor.code.answer == 4 then
        if self.processor.code:check() then
            Assets.playSound("won")
            self.window_state = "SUCCESS"
            Game.world.timer:after(1.2, function()
                self:closeUpSequence(true)
            end)
        else
            Assets.playSound("error")
            self.window_state = "FAILURE"
            Game.world.timer:after(0.6, function()
                self.processor.code.answer = {}
                self.window_state = "DEFAULT"
            end)
        end
    end
end 

function KeyPadUI:closeUpSequence(is_success)
    Assets.playSound("ui_cancel")
    
    if not is_success then
        self.processor.code.answer = {}
    end
    
    self.window_state = "DEFAULT"
    
    Game.world.timer:tween(0.25, self, {keypad_alpha = 0}, "linear", function()
        self.processor:onUIClosed() 
        if is_success then
            self.processor:onSuccess()
        end
        self:remove() 
    end)
end

function KeyPadUI:draw()
    super.draw(self)
    
    local box_size = 60
    local spacing = 15
    local grid_w = (3 * box_size) + (2 * spacing)  
    local grid_h = (4 * box_size) + (3 * spacing)  

    local base_x = -(grid_w / 2)
    local base_y = -(grid_h / 2) + 40 

    local win_w = grid_w
    local win_h = 60
    local win_x = base_x
    local win_y = base_y - 85 

    Draw.setColor(0, 0, 0, 0.4 * self.keypad_alpha)
    Draw.rectangle("fill", win_x + 3, win_y + 3, win_w, win_h)

    Draw.setColor(0, 0, 0, 0.6 * self.keypad_alpha)
    Draw.rectangle("fill", win_x, win_y, win_w, win_h)
    
    if self.window_state == "SUCCESS" then
        Draw.setColor(0, 1, 0, 1 * self.keypad_alpha) 
    elseif self.window_state == "FAILURE" then
        Draw.setColor(1, 0, 0, 1 * self.keypad_alpha) 
    else
        Draw.setColor(1, 1, 1, 1 * self.keypad_alpha) 
    end
    
    love.graphics.setLineWidth(2)
    Draw.rectangle("line", win_x, win_y, win_w, win_h)

    love.graphics.setFont(Assets.getFont("main_mono"))
    local start_text_x = win_x + (win_w / 2) - 45 
    
    for slot = 1, 4 do
        local slot_x = start_text_x + ((slot - 1) * 25)
        local slot_y = win_y + 15
        
        if self.processor.code.answer[slot] then
            local text_char = tostring(self.processor.code.answer[slot])
            love.graphics.print(text_char, slot_x + 4, slot_y)
        else
            if self.window_state == "DEFAULT" then
                Draw.setColor(1, 1, 1, 0.25 * self.keypad_alpha)
            end
            love.graphics.print("-", slot_x + 4, slot_y)
        end
    end

    for i = 1, 11 do
        local col, row
        if i == 10 then 
            col = 1 row = 3 
        elseif i == 11 then 
            col = 2 row = 3 
        else 
            col = (i - 1) % 3 row = math.floor((i - 1) / 3) 
        end
        
        local button_x = base_x + (col * (box_size + spacing))
        local button_y = base_y + (row * (box_size + spacing))
        
        Draw.setColor(0, 0, 0, 0.4 * self.keypad_alpha)
        Draw.rectangle("fill", button_x + 3, button_y + 3, box_size, box_size)
        
        if i == self.selected_index then
            Draw.setColor(1, 1, 1, 0.25 * self.keypad_alpha) 
        else
            Draw.setColor(0, 0, 0, 0.6 * self.keypad_alpha) 
        end
        Draw.rectangle("fill", button_x, button_y, box_size, box_size)
        
        Draw.setColor(1, 1, 1, 1 * self.keypad_alpha) 
        love.graphics.setLineWidth(2)
        Draw.rectangle("line", button_x, button_y, box_size, box_size)
        
        if i == self.selected_index then
            Draw.setColor(COLORS.red, COLORS.red, COLORS.red, self.keypad_alpha)
            local heart_x = button_x + 21
            local heart_y = button_y + 22
            Draw.draw(Assets.getTexture("player/heart"), heart_x, heart_y, 0)
        else
            love.graphics.setFont(Assets.getFont("main_mono"))
            local label_text = ""
            local text_offset_x = 24
            
            if i == 10 then
                label_text = "0"
            elseif i == 11 then
                label_text = "<-"
                text_offset_x = 18
            else
                label_text = tostring(i)
            end
            
            love.graphics.print(label_text, button_x + text_offset_x, button_y + 15)
        end
    end 
end

return KeyPadUI
