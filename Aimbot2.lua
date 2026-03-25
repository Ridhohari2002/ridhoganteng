return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Aimbot...")
    local State = _G.SharedState

--=====================================================
-- AIMBOT
--=====================================================
local AimTab = Window:Tab({ 
    Title = "Aimbot", 
    Icon = "lucide:crosshair" 
})

local AimbotSettingSection = AimTab:Section({
    Title = "Aimbot Setting",
    Opened = true
})

AimbotSettingSection:Toggle({
    Title = "🔦 Flashlight Aimbot",
    Value = State.FlashlightAimbot or false, 
    Callback = function(Value)
        State.FlashlightAimbot = Value
        print("🔦 Flashlight Aimbot: ", Value)
    end
})

AimbotSettingSection:Toggle({
    Title = "Enable Crosshair",
    Value = false,
    Callback = function(v)
        State.EnableCrosshair = v
    end
})
AimbotSettingSection:Toggle({
    Title = "Enable Toggle",
    Desc = "On = Klik sekali | Off = Tahan tombol",
    Value = false,
    Callback = function(v)
        State.AimbotToggleMode = v
    end
})
AimbotSettingSection:Toggle({
    Title = "Enable Through Wall",
    Value = false,
    Callback = function(v)
        State.AimbotThroughWall = v
    end
})
-- Set Keybind for user mobile on/off Aimbot Settings (Crosshair, Toggle, Through Wall)
AimbotSettingSection:Keybind({
    Title = "Set Keybind",
    Default = Enum.KeyCode.E,
    Callback = function(key)
        State.AimbotKeybind = key
    end
})
end
