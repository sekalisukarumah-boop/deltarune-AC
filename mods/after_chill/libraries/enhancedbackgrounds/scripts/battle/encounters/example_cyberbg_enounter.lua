local CyberEncounter, super = Class(Encounter)

function CyberEncounter:init()
    super.init(self)

    self.text = "* Futuristic hums subsume the battlescape."

    self.music = "battle"
    self.background = true

    self:addEnemy("dummy")
    self:addEnemy("dummy")

    Game:setBorder("cyber")



    self.overlay = Rectangle(-20, -20, SCREEN_WIDTH + 40, SCREEN_HEIGHT + 40)
    self.overlay:setLayer(BATTLE_LAYERS["background"] + 1)
    self.overlay:setParallax(0, 0)
    self.overlay:setColor(COLORS.black)
    self.overlay.alpha = 0.7
    self.overlay.debug_select = false
    Game.battle:addChild(self.overlay)




    self.cyber_bg = Sprite("battle/cyber", 0, 0)
    self.cyber_bg:setScale(0.4, 0.4)
    self.cyber_bg.alpha = 0
    self.cyber_bg:fadeTo(1, 3)
    self.cyber_bg.debug_select = false

    self.cyber_bg:setLayer(BATTLE_LAYERS["background"] + 2)
    Game.battle:addChild(self.cyber_bg)
end

function CyberEncounter:beforeStateChange(old, new)
    if new == "VICTORY" then
        self.cyber_bg:fadeTo(0, 0.5)
    end
end


return CyberEncounter
