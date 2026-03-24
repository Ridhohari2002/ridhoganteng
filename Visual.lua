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
        Callback = function(v) 
            State.ESP.Selected = v 
        end
    })
    
    ESPSection:Toggle({
        Title = "Enable ESP",
        Value = State.ESP.Enabled or false,
        Callback = function(v) 
            State.ESP.Enabled = v 
            if not v then
                -- Bersihkan semua saat OFF
                for obj, _ in pairs(_G.ESP_Cache.Highlights) do
                    if typeof(obj) == "Instance" or typeof(obj) == "table" then
                        -- Fungsi pembersih global
                        if _G.ESP_Cache.Highlights[obj] then _G.ESP_Cache.Highlights[obj]:Destroy() end
                        if _G.ESP_Cache.Labels[obj] then _G.ESP_Cache.Labels[obj].Parent:Destroy() end
                    end
                end
                table.clear(_G.ESP_Cache.Highlights)
                table.clear(_G.ESP_Cache.Labels)
            end
        end
    })

    ESPSection:Toggle({ Title = "Show Names", Value = State.ESP.Names, Callback = function(v) State.ESP.Names = v end })
    ESPSection:Toggle({ Title = "Show Distance", Value = State.ESP.Studs, Callback = function(v) State.ESP.Studs = v end })
end
