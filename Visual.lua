return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Aimbot...")
    local State = _G.SharedState
--=====================================================
-- VISUAL
--=====================================================
local VisualTab = Window:Tab({ 
    Title = "Visual", 
    Icon = "lucide:eye"
})

local ScreenDisplaySection = VisualTab:Section ({
    Title = "Screen Display",
    Opened = true
})
ScreenDisplaySection:Slider({
    Title = "Full Bright",
    Value = {
        Min = 0,
        Max = 100,
        Default = 10,
    },
    Callback = function(v)
        State.FullBright = v
        UpdateLighting()
    end
})
ScreenDisplaySection:Button({
    Title = "No Fog",
    Callback = function()
        DisableFog()
        print("Fog Removed!")
    end
})
-- UI SETUP
local ESPSection = VisualTab:Section ({ Title = "Seven Eye", Opened = true })

ESPSection:Dropdown({
    Title = "Selected Entities",
    Multi = true,
    Values = {"Killer", "Survivor", "Generators", "Gates", "Pallets", "Windows", "Hooks"},
    Callback = function(v) State.ESP.Selected = v end
})

ESPSection:Toggle({
    Title = "Enable ESP",
    Value = false,
    Callback = function(v) 
    State.ESP.Enabled = v 
        if not v then
            -- Hapus semua saat off
            for obj, _ in pairs(cache.Highlights) do clearESP(obj) end
        end
    end
})

ESPSection:Toggle({ Title = "Show Names", Value = false, Callback = function(v) State.ESP.Names = v end })
ESPSection:Toggle({ Title = "Show Distance", Value = false, Callback = function(v) State.ESP.Studs = v end })
ESPSection:Toggle({ Title = "Show Health", Value = false, Callback = function(v) State.ESP.Health = v end })
end
