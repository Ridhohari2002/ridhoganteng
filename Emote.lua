return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Emote...")

    local State = _G.SharedState
    -- Definisikan di sini agar tidak tergantung urutan file lain
    local localEmoteData = {
        ["24 Hour Cinderella"] = {anim = "137195203725366", sound = "121099446613414"},
        ["Applause"]           = {anim = "96328361165090",  sound = "115490787020749"},
        ["Arm Swing"]          = {anim = "80552139463944",  sound = "74216458932348"},
        ["California Girls"]   = {anim = "123552803041504", sound = "87899327891544"},
        ["Ghoul"]              = {anim = "130415594909401", sound = "123004139176580"},
        ["Kyoufuu"]            = {anim = "137322894494527", sound = "129064643026442"},
        ["Mannrobics"]         = {anim = "134677515695156", sound = "109596159930017"},
        ["Quick Combo"]        = {anim = "105592621576604", sound = "88505795419631"},
        ["Schadenfreude"]      = {anim = "138303785534052", sound = "92070710839040"},
        ["Static"]             = {anim = "95096724457263",  sound = "70950516511572"},
        ["Thriller"]           = {anim = "99835792883875",  sound = "139985043810748"},
        ["Tor Monitor Ketua"]  = {anim = "81792358514569",  sound = "72665050838808"},
        ["Wave"]               = {anim = "99670106766588",  sound = nil}
    }

    local emoteList = {}
    for name, _ in pairs(localEmoteData) do
        table.insert(emoteList, name)
    end
    table.sort(emoteList)

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
