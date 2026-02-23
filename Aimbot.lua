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
})
AimbotSettingSection:Toggle({
    Title = "Enable Toggle"
})
AimbotSettingSection:Toggle({
    Title = "Enable Through Wall"
})
-- Set Keybind for user mobile on/off Aimbot Settings (Crosshair, Toggle, Through Wall)
AimbotSettingSection:Keybind({
    Title = "Set Keybind"
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
