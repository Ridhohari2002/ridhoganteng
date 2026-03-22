return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Emote...")

    local State = _G.SharedState
    -- Ambil nama emote dari tabel global
    local emoteList = {}
    if _G.EmoteData then
        for name, _ in pairs(_G.EmoteData) do
            table.insert(emoteList, name)
        end
        table.sort(emoteList) -- Biar urut abjad
    else
        warn("EmoteData tidak ditemukan di _G!")
        emoteList = {"Data Missing"}
    end

    local EmoteTab = Window:Tab({ Title = "Emotes", Icon = "lucide:music" })
    local EmoteSection = EmoteTab:Section({ Title = "Emote Selection", Opened = true })

    EmoteSection:Dropdown({
        Title = "Select Emote",
        Multi = false,
        Values = emoteList, -- Menggunakan array string, bukan dictionary data
        Callback = function(v)
            _G.SelectedEmoteName = v -- Simpan ke global agar bisa diakses logic keybind
            print("Selected Emote:", v)
        end
    })

    EmoteSection:Button({
        Title = "Play Emote",
        Callback = function()
            if _G.SelectedEmoteName then
                -- Memanggil fungsi global yang sudah kita buat di versiGemini.lua
                if _G.playCustomEmote then
                    _G.playCustomEmote(_G.SelectedEmoteName)
                else
                    warn("Fungsi playCustomEmote belum dimuat!")
                end
            else
                WindUI:Notify({
                    Title = "Emote System",
                    Content = "Pilih emote dulu dari dropdown!",
                    Duration = 2
                })
            end
        end
    })

    EmoteSection:Button({
        Title = "Stop Emote",
        Callback = function()
            if _G.stopEmote then
                _G.stopEmote()
            end
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
