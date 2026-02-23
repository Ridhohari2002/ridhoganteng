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
    Title = "Selected Entities",
    MultiSelect = true, -- Pastikan WindUI versimu mendukung ini
    Values = {"Killer", "Survivor", "Generators", "Gates", "Pallets", "Windows", "Hooks"},
    Callback = function(v)
        -- v biasanya berupa table jika MultiSelect aktif
        if type(v) == "table" then
            -- Reset semua dulu
            for k in pairs(State.ESP.Selected) do State.ESP.Selected[k] = false end
            -- Aktifkan yang dipilih
            for _, name in pairs(v) do
                if State.ESP.Selected[name] ~= nil then
                    State.ESP.Selected[name] = true
                end
            end
        else
            -- Jika WindUI tidak support MultiSelect, gunakan logic toggle manual
            State.ESP.Selected[v] = not State.ESP.Selected[v]
        end
    end
})
ESPSection:Toggle({
    Title = "Enable ESP",
    Value = false,
    Callback = function(v) State.ESP.Enabled = v end
})
ESPSection:Toggle({
    Title = "Show Names",
    Value = false,
    Callback = function(v) State.ESP.Names = v end
})
ESPSection:Toggle({
    Title = "Show Distance (Studs)",
    Value = false,
    Callback = function(v) State.ESP.Studs = v end
})
ESPSection:Toggle({
    Title = "Show Health",
    Value = false,
    Callback = function(v) State.ESP.Health = v end
})
end
