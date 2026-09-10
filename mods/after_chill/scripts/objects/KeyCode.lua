local KeyCode, super = Class(Object)

function KeyCode:init(properties)
    super.init(self, 0, 0, 0, 0)
    local to_be_inserted = TiledUtils.parsePropertyList("num", properties)
    self.passcode = {}
    self.answer = {}
    for i = 1, #to_be_inserted do 
    table.insert(self.passcode, tonumber(to_be_inserted[i]))
    end 
end

function KeyCode:addNumberToAnswer(num)
    if #self.answer < 4 then  
        table.insert(self.answer, num)
    end 
end 

function KeyCode:check()
    return Utils.equal(self.answer, self.passcode)
end 



return KeyCode