return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Misc...")
    local State = _G.SharedState

    -- SAFETY GUARD: Pastikan sub-tabel Misc tersedia
    State.Misc = State.Misc or {
        AntiAFK = false,
        AntiFling = false,
        TouchFling = false,
        AntiAdmin = false
    }

    local LocalPlayer = Players.LocalPlayer

--=====================================================
-- MISCELLANEOUS UI
--=====================================================
local MiscTab = Window:Tab({ 
    Title = "Misc", 
    Icon = "lucide:component" 
})

local MiscTabSection = MiscTab:Section ({
    Title = "Shield System",
    Opened = true
})

MiscTabSection:Toggle({
    Title = "Anti AFK",
    Value = State.Misc.AntiAFK or false,
    Callback = function(v) State.Misc.AntiAFK = v end
})

MiscTabSection:Toggle({
    Title = "Anti Fling",
    Value = State.Misc.AntiFling or false,
    Callback = function(v) State.Misc.AntiFling = v end
})

MiscTabSection:Toggle({
    Title = "Touch Fling (Kill Aura)",
    Value = State.Misc.TouchFling or false,
    Callback = function(v) State.Misc.TouchFling = v end
})

MiscTabSection:Toggle({
    Title = "Invisible Fling",
    Value = State.Misc.InvisFling or false,
    Callback = function(v) 
        State.Misc.InvisFling = v 
        if v then
            WindUI:Notify({Title = "Shield", Content = "Invisible Fling Active! Approach them.", Duration = 3})
        end
    end
})

MiscSection:Toggle({
    Title = "AOE Fling",
    Value = false,
    Callback = function(v)
        State.Misc.AOEFling = v
    end
})

MiscSection:Slider({
    Title = "Fling Radius",
    Value = {Min = 5, Max = 30, Default = 15},
    Callback = function(v)
        State.Misc.FlingRadius = v
    end
})

MiscTabSection:Toggle({
    Title = "Anti Admin (Auto Leave)",
    Value = State.Misc.AntiAdmin or false,
    Callback = function(v) State.Misc.AntiAdmin = v end
})

MiscTabSection:Button({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
})

MiscTabSection:Button({
    Title = "Free Private Server (Hop)",
    Callback = function()
        -- Mencari server dengan jumlah pemain paling sedikit (serasa private)
        WindUI:Notify({Title = "Misc", Content = "Finding small server...", Duration = 3})
        local HttpService = game:GetService("HttpService")
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
        for _, s in pairs(servers) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id)
                break
            end
        end
    end
})
end
