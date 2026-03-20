return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Movement...")
    local State = _G.SharedState
    --=====================================================
    -- UI SETUP
    --=====================================================

    local MoveTab = Window:Tab({ Title = "Movement", Icon = "lucide:zap" })
    local MoveSection = MoveTab:Section({ Title = "Movement Character", Opened = true })

    MoveSection:Slider({
        Title = "WalkSpeed Boost",
        Value = { Min = 1, Max = 5, Default = 1.03, Decimal = 2 },
        Callback = function(v) State.Movement.SpeedValue = v end
    })

    MoveSection:Toggle({
        Title = "Enable Speed",
        Value = State.Movement.SpeedEnabled,
        Callback = function(v) State.Movement.SpeedEnabled = v end
    })

    MoveSection:Toggle({
        Title = "No Clip",
        Value = State.Movement.NoClip,
        Callback = function(v) State.Movement.NoClip = v end
    })

    local CameraSection = MoveTab:Section({ Title = "Camera Settings", Opened = true })
    CameraSection:Slider({
        Title = "Max Zoom Distance",
        Value = { Min = 12, Max = 1000, Default = 500 },
        Callback = function(v) LocalPlayer.CameraMaxZoomDistance = v 
            LocalPlayer.CameraMinZoomDistance = 12
        end
    })

    CameraSection:Button({
        Title = "Unlock Camera Zoom (F9 Fix)",
        Callback = function()
            LocalPlayer.CameraMaxZoomDistance = 1000
            workspace.CurrentCamera.FieldOfView = 90
            WindUI:Notify({Title = "Camera", Content = "Zoom Unlocked!", Duration = 2})
        end
    })
end
