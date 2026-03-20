return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Settings...")
    local State = _G.SharedState

--=====================================================
-- SETTINGS
--=====================================================
local SettingTab = Window:Tab({ 
    Title = "Settings", 
    Icon = "lucide:settings" 
})

local UISection = SettingTab:Section({
    Title = "UI Settings",
    Opened = true
})

-- Keybind untuk buka/tutup menu
UISection:Keybind({
    Title = "Toggle Menu",
    Value = "G",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

-- Dropdown untuk ganti Tema UI secara instan
UISection:Dropdown({
    Title = "Change Theme",
    Multi = false,
    Values = {"Dark", "Light", "Grey", "Aqua", "Rose"},
    Callback = function(v)
        Window:SetTheme(v)
    end
})

-- Toggle Transparansi UI
UISection:Toggle({
    Title = "UI Transparency",
    Value = true,
    Callback = function(v)
        Window:SetTransparent(v)
    end
})

local CreditSection = SettingTab:Section({
    Title = "Credits & Info",
    Opened = true
})

CreditSection:Button({
    Title = "Discord Server",
    Callback = function()
        Window:Dialog({
            Title = "Discord Server",
            Content = "Join our community for more updates and private scripts!",
            Icon = "lucide:message-circle",
            Buttons = {
                { 
                    Title = "Copy Link", 
                    Callback = function() 
                        setclipboard("https://discord.gg/boinihboss") -- Ganti link lu di sini
                        WindUI:Notify({ Title = "Clipboard", Content = "Discord link copied!", Duration = 3 })
                    end 
                },
                { Title = "Close", Callback = function() end }
            }
        }):Show()
    end
})

-- Tombol Unload (Penting buat bersihin script)
CreditSection:Button({
    Title = "Unload Script",
    Callback = function()
        Window:Dialog({
            Title = "Unload",
            Content = "Are you sure you want to unload the script? All features will stop working.",
            Icon = "lucide:log-out",
            Buttons = {
                { 
                    Title = "Yes", 
                    Callback = function() 
                        -- Tambahkan logic pembersihan di sini (hapus ESP, stop loop, dll)
                        _G.SharedState.ESP.Enabled = false
                        _G.SharedState.Movement.NoClip = false
                        task.wait(0.1)
                        Window:Destroy() 
                    end 
                },
                { Title = "Cancel", Callback = function() end }
            }
        }):Show()
    end
})
end
