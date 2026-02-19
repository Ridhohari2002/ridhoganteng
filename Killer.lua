return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Killer...")
--=====================================================
-- ATTACK SECTION [⚔️]
--=====================================================
local KillerTab = Window:Tab({
    Title = "Killer",
    Icon = "lucide:sword"
})
local KillerSection = KillerTab:Section({
    Title ="Attack [⚔️]",
    Opened = true
})
KillerSection:Toggle({
    Title = "Infinite Abillities",
    Value = false,
    Callback = function(v)
        State.InfiniteAbilities = v
    end
})
KillerSection:Toggle({
    Title = "No Cooldown Attack",
    Callback = function (v)
        State.NoCooldown = v 
    end
})
KillerSection:Toggle({
    Title = "Double Swing",
    Callback = function(v) 
        State.DoubleSwing = v 
    end
})

--=====================================================
-- HITBOX SECTION [🎯]
--=====================================================
local HitboxSection = KillerTab:Section({
    Title = "HitBox",
    Opened = true
})
HitboxSection:Slider({
    Title = "Set Transparency",
    Value = { Min = 0, Max = 1, Default = 0.5 },
    Callback = function(v) State.HitboxTransparency = v end
})

HitboxSection:Slider({
    Title = "Size Hitbox",
    Value = { Min = 2, Max = 50, Default = 10 },
    Callback = function(v) State.HitboxSize = v end
})

HitboxSection:Toggle({
    Title = "Enable Hitbox",
    Value = false,
    Callback = function(v) 
        State.HitboxEnabled = v 
        if not v then
            State.ResetHitbox()
        end
    end
})

--=====================================================
-- MISC KILLER SECTION [🛠️]
--=====================================================
local MiscKillerSection = KillerTab:Section({
    Title = "Misc",
    Opened = true
})
MiscKillerSection:Toggle({ 
    Title = "Break Generator", 
    Callback = function(v) 
        State.AutoBreak = v 
    end 
})
MiscKillerSection:Toggle({ 
    Title = "No Pallet Stun", 
    Callback = function(v) 
        State.NoStun = v 
    end 
})
MiscKillerSection:Toggle({ 
    Title = "Anti Flashlight", 
    Callback = function(v) 
        State.AntiBlind = v 
    end 
})
MiscKillerSection:Toggle({ 
    Title = "Anti Slowdown", 
    Callback = function(v) 
        State.NoSlow = v 
    end 
})
end
