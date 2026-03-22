return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Emote...")

    local State = _G.SharedState
    State.EmoteKeybind = false

    local EmoteTab = Window:Tab({ Title = "Emotes", Icon = "lucide:music" })
    local EmoteSection = EmoteTab:Section({ Title = "Emote Selection", Opened = true })

    local selectedEmote = nil

    local emoteNames = {}
    for name,_ in pairs(EmoteData) do
        table.insert(emoteNames, name)
    end

    EmoteSection:Dropdown({
        Title = "Select Emote",
        Multi = false,
        Values = emoteNames,
        Callback = function(v)
            selectedEmote = v
            print("Selected:", v)
        end
    })

    EmoteSection:Button({
    Title = "Play Emote",
    Callback = function()
        if selectedEmote then
            playCustomEmote(selectedEmote)
        else
            warn("Pilih emote dulu!")
        end
    end
})

EmoteSection:Button({
    Title = "Stop Emote",
    Callback = function()
        if currentTrack then currentTrack:Stop() end
        if currentSound then currentSound:Stop() end
    end
})

EmoteSection:Toggle({
    Title = "Use Key (V)",
    Value = false,
    Callback = function(v)
        State.EmoteKeybind = v
    end
})
    -- Tambahkan di Survivor.lua (Tab Emotes atau Movement)
    EmoteSection:Toggle({
        Title = "Rainbow Trail (Neon)",
        Value = State.RainbowTrail or false,
        Callback = function(v)
            State.RainbowTrail = v
            if v then
                WindUI:Notify({
                    Title = "Visual System",
                    Content = "Rainbow Trail Enabled! Enjoy the glow.",
                    Duration = 2
                })
            end
        end
    })
    end
