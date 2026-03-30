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

local FlashlightSection = AimTab:Section({
          Title = "Flashlight 🔦",
          Opened = true
})

FlashlightSection:Toggle({
    Title = "🔦 Flashlight Aimbot",
    Value = State.FlashlightAimbot or false, 
    Callback = function(Value)
        State.FlashlightAimbot = Value
        print("🔦 Flashlight Aimbot: ", Value)
    end
})
    

local TOFSection = AimTab:Section({
          Title = "🔫 Twist of Fate",
          Opened = true
})

TOFSection:Toggle({
    Title = " Twist of Fate ",
    Value = State.TwistOfFateAimbot or false,
    Callback = function(Value)
        local State = _G.SharedState or getgenv().State
        State.TwistOfFateAimbot = Value
    end
})

TOFSection:Toggle({
    Title = "👻 Enable Silent Aim (Magic Bullet)",
    Desc = "Peluru otomatis belok ke target tanpa harus nge-lock kamera",
    Value = State.ToFSilentAim or false,
    Callback = function(Value)
        local State = _G.SharedState or getgenv().State
        State.ToFSilentAim = Value
    end
})

TOFSection:Toggle({
    Title = "⭕ Show Silent Aim FOV",
    Value = State.ShowFOV or true,
    Callback = function(Value)
        local State = _G.SharedState or getgenv().State
        State.ShowFOV = Value
    end
})

TOFSection:Dropdown({
    Title = " Select Target",
    Desc = "Choose who you want to shoot",
    Values = { "Killer", "Survivor"},
    Value = "Killer", 
    Callback = function(option)
        local State = _G.SharedState or getgenv().State
        State.TargetTeam = option
    end
})
TOFSection:Slider({
    Title = "📏 Silent Aim FOV Radius",
    Value = { Min = 50, Max = 800, Default = 150 },
    Desc = "Jangkauan maksimal kursor mendeteksi musuh",
    Callback = function(v)
        local State = _G.SharedState or getgenv().State
        State.SilentAimFOV = v
    end
})

TOFSection:Slider({
    Title = "Bullet Speed Prediction",
    Value = { Min = 50, Max = 500, Default = 150 },
    Desc = "The smaller the number, the further the aimbot shoots ahead of the enemy",
    Callback = function(v)
        local State = _G.SharedState or getgenv().State
        State.BulletSpeed = v
        print("🚀 Prediksi Kecepatan Peluru diset ke:", v)
    end
})

end
