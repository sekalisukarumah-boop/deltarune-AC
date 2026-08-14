local character, super = Class(PartyMember, "noelle")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Noelle"

    -- Actor (handles sprites)
    self:setActor("noelle")
    self:setLightActor("noelle_lw")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "Snowcaster\nMight be able to\nuse some cool moves."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "N-Action"

    -- Spells
    self:addSpell("heal_prayer")
    self:addSpell("sleep_mist")
    self:addSpell("ice_shock")

    -- Current health (saved to the save file)
    self.health = 166

    -- Base stats (saved to the save file)
    self.stats = {
        health = 166,
        attack = 3,
        defense = 1,
        magic = 11
    }

    -- Max stats from level-ups
    self.max_stats = {
        health = 999
    }
    
    -- Party members which will also get stronger when this character gets stronger, even if they're not in the party
    self.stronger_absent = {}

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/ring"

    -- Equipment (saved to the save file)
    self:setWeapon("thornring")
    self:setArmor(1, "silver_watch")
    if Game.chapter >= 2 then
        self:setArmor(2, "royalpin")
    end

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 1, 0}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {1, 1, 0.3}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {1, 1, 153/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {1, 1, 0}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1, 1, 0.5}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/noelle/head"
    -- Path to head icons used in battle
    self.head_icons = "party/noelle/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/noelle/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_n"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1.5

    -- Battle position offset (optional)
    self.battle_offset = {0, 0}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil

    -- Character flags (saved to the save file)
    self.flags = {
        ["iceshocks_used"] = 0,
        ["boldness"] = (Game.chapter >= 2 and 100 or -12),
        ["weird"] = true
    }
end

function character:getTitle()
    if self:checkWeapon("thornring") then
        return "LV" .. self:getLevel() .. " Ice Trancer\nReceives pain to\nbecome stronger."
    elseif self:getFlag("iceshocks_used", 0) > 0 then
        return "LV" .. self:getLevel() .. " Frostmancer\nFreezes the enemy."
    else
        return super.getTitle(self)
    end
end

function character:onTurnStart(battler)
    if Game.battle.encounter.id == "forced" then 
        Game.battle.timer:afterCond(function() 
            return Game.battle.state == "ACTIONSELECT" and not Game.battle:hasCutscene()
        end, function() 
            local ralsei = Game.battle:getEnemyBattler("ralsei_forced")
            ralsei:setAnimation("hurt")
            local spell = Registry.createSpell("ice_shock")
            Game.battle:pushForcedAction(battler, "SPELL", Game.battle:getActiveEnemies()[1], nil, {
            name = spell:getName(),
            tp = -8, 
            data = spell
            })
          --  Game.battle:nextParty() 
            -- Game.battle:startCutscene(function(cutscene)
            -- local noelle = Game.battle:getPartyBattler("noelle")
            -- noelle:setAnimation({"battle_alt/defend", 0.1, false})
            -- Assets.playSound("ice_impact")
            -- cutscene:wait(1)
            -- local ralsei = Game.battle:getEnemyBattler("ralsei_forced")
            -- cutscene:battlerText(ralsei, "Why...[wait:5] why did you\ninitiate a battle?") 
            -- ralsei:setAnimation("attack", function() ralsei:resetSprite() end)
            -- cutscene:wait(cutscene:playSound("laz_c"))
            -- noelle:statusMessage("msg", "miss", {0.5, 1, 0.5})
            -- cutscene:wait(1)
            -- cutscene:battlerText("* That shield...")
            -- ralsei:setAnimation("attack", function() ralsei:resetSprite() end)
            -- cutscene:wait(cutscene:playSound("laz_c"))
            -- noelle.hit_count = 0 
            -- noelle:statusMessage("msg", "miss", {0.5, 1, 0.5})
            -- cutscene:wait(0.5)
            -- Game.fader:fadeOut(nil, {speed = 1})
            -- ralsei:setAnimation("attack", function() ralsei:resetSprite() end)
            -- noelle.hit_count = 0 
            -- cutscene:wait(cutscene:playSound("laz_c"))
            -- noelle:statusMessage("msg", "miss", {0.5, 1, 0.5})
            -- cutscene:wait(0.5)   
            -- ralsei:setAnimation("attack", function() ralsei:resetSprite() end)
            -- noelle.hit_count = 0 
            -- cutscene:wait(cutscene:playSound("laz_c"))
            -- noelle:statusMessage("msg", "miss", {0.5, 1, 0.5})
            -- cutscene:wait(1.5)
            -- cutscene:after(function()
            --     Game.battle:setState("TRANSITIONOUT")
            -- end)
        end)
       -- end)
    end
end

return character
