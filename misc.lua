return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Misc...")
    local State = _G.SharedState

    -- SAFETY GUARD: Pastikan sub-tabel Misc tersedia
    if not State.Misc then State.Misc = {} end
    if State.Misc.AntiAFK == nil then State.Misc.AntiAFK = false end
    if State.Misc.AntiFling == nil then State.Misc.AntiFling = false end
    if State.Misc.TouchFling == nil then State.Misc.TouchFling = false end
    if State.Misc.AntiAdmin == nil then State.Misc.AntiAdmin = false end
    if State.Misc.AOEFling == nil then State.Misc.AOEFling = false end
    if State.Misc.FlingRadius == nil then State.Misc.FlingRadius = 15 end
    if State.Misc.InvisFling == nil then State.Misc.InvisFling = false end
    
    -- Memaksa variabel Dash terisi kalau belum ada
    if State.Misc.EnableDash == nil then State.Misc.EnableDash = false end
    if State.Misc.DashKey == nil then State.Misc.DashKey = Enum.KeyCode.Q end
    if State.Misc.DashSpeed == nil then State.Misc.DashSpeed = 80 end

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
        local char = game.Players.LocalPlayer.Character
        if char then
            -- Bikin badan transparan/muncul lagi
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = v and 1 or 0
                    if part.Name == "HumanoidRootPart" then part.Transparency = 1 end
                end
            end
        end
        
        if v then
            WindUI:Notify({Title = "Shield", Content = "You are now Ghost! Touch players to fling.", Duration = 3})
        end
    end
})

MiscTabSection:Toggle({
    Title = "AOE Fling",
    Value = false,
    Callback = function(v)
        State.Misc.AOEFling = v
    end
})

MiscTabSection:Slider({
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

local DashSection = MiscTab:Section({
    Title = "Custom Dash",
    Opened = true
})

DashSection:Toggle({
    Title = "Enable Custom Dash",
    Desc = "Dash dengan animasi visual ke player lain",
    Value = State.Misc.EnableDash,
    Callback = function(v)
        State.Misc.EnableDash = v
    end
})

DashSection:Keybind({
    Title = "Set Dash Key",
    Default = Enum.KeyCode.Q,
    Callback = function(key)
        -- WindUI Keybind mengembalikan string nama key (e.g. "Q", "F")
        -- Kita harus konversi ke Enum.KeyCode agar bisa dicocokkan dgn input.KeyCode
        if type(key) == "string" then
            local success, enumKey = pcall(function()
                return Enum.KeyCode[key]
            end)
            State.Misc.DashKey = (success and enumKey) or Enum.KeyCode.Q
        else
            State.Misc.DashKey = key
        end
        print("[Dash] DashKey diset ke:", tostring(State.Misc.DashKey))
    end
})

DashSection:Slider({
    Title = "Dash Speed (Power)",
    Value = {Min = 30, Max = 150, Default = State.Misc.DashSpeed},
    Callback = function(v)
        State.Misc.DashSpeed = v
    end
})
end
