return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Visual...")
    local State = _G.SharedState
    --=====================================================
    -- UI SETUP (Sesuai dengan UI kamu)
    --=====================================================
    local VisualTab = Window:Tab({ Title = "Visual", Icon = "lucide:eye" })

    local ScreenDisplaySection = VisualTab:Section ({ Title = "Screen Display", Opened = true })
    
    -- Fullbright Logic (Placeholder)
    ScreenDisplaySection:Slider({
        Title = "Full Bright",
        Value = { Min = 0, Max = 100, Default = 5 },
        Callback = function(v) State.FullBright = v end
    })

    local ESPSection = VisualTab:Section ({ Title = "Seven Eye", Opened = true })

    ESPSection:Dropdown({
        Title = "Selected Entities",
        Multi = true,
        Values = {"Killer", "Survivor", "Generators", "Gates", "Pallets", "Windows", "Hooks"},
        Callback = function(v) State.ESP.Selected = v end
    })
    
    ESPSection:Toggle({
        Title = "Enable ESP",
        Value = State.ESP.Enabled or false,
        Callback = function(v) 
            State.ESP.Enabled = v 
        end
    })

    ESPSection:Toggle({ Title = "Show Names", Value = false, Callback = function(v) State.ESP.Names = v end })
    ESPSection:Toggle({ Title = "Show Distance", Value = false, Callback = function(v) State.ESP.Studs = v end })

end
