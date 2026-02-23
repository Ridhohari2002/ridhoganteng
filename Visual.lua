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

local ESPSection = VisualTab:Section ({
    Title = "Seven Eye",
    Opened = true
})


ESPSection:Dropdown({
    Title = "Selected",
    Values = {
        {
            Title = "Killer"
        },
        {
            Title = "Survivor"
        },
        {
            Title = "Generators"
        },
        {
            Title = "Gates"
        },
        {
            Title = "Pallets"
        },
        {
            Title = "Windows"
        },
        {
            Title = "Hooks"
        },
    }
})
ESPSection:Toggle({
    Title = "Enable",
})
ESPSection:Toggle({
    Title = "Enable Names",
})
ESPSection:Toggle({
    Title = "Enable Studs",
})
ESPSection:Toggle({
    Title = "Enable Health",
})
