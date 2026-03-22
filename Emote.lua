return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Emote...")

    local State = _G.SharedState

    local EmoteTab = Window:Tab({ Title = "Emotes", Icon = "lucide:music" })
    local EmoteSection = EmoteTab:Section({ Title = "Emote Selection", Opened = true })

    EmoteSection:Dropdown({
        Title = "Select Emote",
        Values = emoteList,
        Callback = function(v)
            _G.SelectedEmoteName = v
        end
    })

    EmoteSection:Button({
        Title = "Play Emote",
        Callback = function()
            if _G.playCustomEmote and _G.SelectedEmoteName then
                _G.playCustomEmote(_G.SelectedEmoteName)
            else
                print("Fungsi play belum siap atau emote belum dipilih")
            end
        end
    })

    EmoteSection:Button({
        Title = "Stop Emote",
        Callback = function()
            if _G.stopEmote then _G.stopEmote() end
        end
    })
    
    EmoteSection:Toggle({
        Title = "Use Key (V) to Play",
        Value = State.EmoteKeybind or false,
        Callback = function(v)
            State.EmoteKeybind = v
        end
    })

    EmoteSection:Toggle({
        Title = "Rainbow Trail (Neon)",
        Value = State.RainbowTrail or false,
        Callback = function(v)
            State.RainbowTrail = v
            if v then
                -- Pastikan WindUI terdefinisi atau gunakan pcall
                local success, err = pcall(function()
                    _G.WindUI:Notify({ -- Menggunakan _G jika WindUI dishare secara global
                        Title = "Visual System",
                        Content = "Rainbow Trail Enabled!",
                        Duration = 2
                    })
                end)
            end
        end
    })
end
