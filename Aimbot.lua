return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Aimbot...")
    local LocalPlayer = Players.LocalPlayer
    local State = _G.SharedState

--=====================================================
-- AIMBOT
--=====================================================
local AimTab = Window:Tab({ 
    Title = "Aimbot", 
    Icon = "lucide:crosshair", 
})

local AimbotSettingSection = AimTab:Section({
    Title = "Aimbot Setting",
    Opened = true
})
AimbotSettingSection:Toggle({
    Title = "Enable Crosshair"
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

--=====================================================
-- INPUT HANDLER FOR AIMBOT
--=====================================================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == State.AimbotKeybind then
        if State.AimbotToggleMode then
            Aiming = not Aiming -- Mode Toggle
        else
            Aiming = true -- Mode Tahan
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == State.AimbotKeybind and not State.AimbotToggleMode then
        Aiming = false
    end
end)

end
