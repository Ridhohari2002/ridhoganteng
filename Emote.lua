return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Survivor...")

    local State = _G.SharedState
    
local EmoteTab = Window:Tab({ Title = "Emotes", Icon = "lucide:music" })
local EmoteSection = EmoteTab:Section({ Title = "Emote Selection", Opened = true })

local emoteList = {}
for name, _ in pairs(EmoteData) do table.insert(emoteList, name) end
table.sort(emoteList)

EmoteSection:Dropdown({
    Title = "Select Emote",
    Values = emoteList,
    Callback = function(v)
        State.SelectedEmote = v
    end
})

EmoteSection:Paragraph({
    Title = "Instructions",
    Content = "1. Pilih emote di dropdown\n2. Tekan tombol 'V' untuk Play/Stop\n3. Goyang terus bro!"
})
end
