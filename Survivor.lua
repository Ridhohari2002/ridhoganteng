return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Survivor...")

    local LocalPlayer = Players.LocalPlayer
    local State = _G.SharedState
--=====================================================
-- SURVIVOR
--=====================================================
local SurvivorTab = Window:Tab({ 
    Title = "Survivor", 
    Icon = "lucide:heart" 
})

local SurvivorSection = SurvivorTab:Section({
    Title = "Generator Status",
    Opened = true
})
--- Scanning generators yang nantinya auto update dan menampilkan (generator 1, generator 2, generator 3 sampai generator 7)
local GenStatusLabel = SurvivorSection:Paragraph({
    Title = "Generator Progress..,",
    Content = "Initializing scanner..."
})
-------------------------------------------------------
-- FUNCTION: GET ALL GENERATORS
-------------------------------------------------------
local function GetGenerators()
    local gens = {}
    local genFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Generator")
    
    if genFolder then
        -- Loop pertama: Masuk ke folder mesin (contoh: [436])
        for _, mesin in ipairs(genFolder:GetChildren()) do
            -- Loop kedua: Cari GeneratorPoint1-4 di dalam mesin tersebut
            for _, point in ipairs(mesin:GetChildren()) do
                if point.Name:find("GeneratorPoint") then
                    table.insert(gens, point)
                end
            end
        end
    end
    return gens
end

local function UpdateGeneratorStatus()
    local generators = GetGenerators()

    if #generators == 0 then
        GenStatusLabel:SetTitle("No Generators Found")
        GenStatusLabel:SetContent("Map belum load atau nama berbeda.") -- FIXED
        return
    end

    local content = ""
    for i, gen in ipairs(generators) do
        -- Kita tampilkan nama aslinya (GeneratorPoint1, dll) agar jelas mana yang ketemu
        content ..= "📍 " .. gen.Name .. " : FOUND\n"
    end

    GenStatusLabel:SetTitle("Total Generators: " .. #generators)
    GenStatusLabel:SetContent(content) -- FIXED
end

SurvivorSection:Button({
    Title = "Find Nearest Generator",
    Callback = function()
        local character = LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local generators = GetGenerators()
        local nearest = nil
        local shortestDistance = math.huge

        for _, point in ipairs(generators) do
            if point:IsA("BasePart") then
                local dist = (point.Position - hrp.Position).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    nearest = point
                end
            end
        end

        if nearest then
            -- Highlight effect agar tembus tembok
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- FIXED
            highlight.Parent = nearest

            task.delay(5, function()
                if highlight then highlight:Destroy() end
            end)
        else
            print("Tidak ditemukan generator valid.")
        end
    end
})
--==============================================
-- Feature Skill Check
--==============================================
local FeatureSkillCheckSection = SurvivorTab:Section({
    Title = "Feature SkillCheck",
    Opened = true
})

FeatureSkillCheckSection:Toggle({
    Title= "Generator SkillCheck",
    Value = false,
    Callback = function(v)
        State.GenSkillCheck = v
        if v then
            print("Generator SkillCheck Enabled")
        else
            print("Generator SkillCheck Disabled")
        end
    end
})

FeatureSkillCheckSection:Toggle({
    Title= "Healing SkillCheck",
    Value = false,
    Callback = function(v)
        State.HealSkillCheck = v
        if v then
            print("Healing SkillCheck Enabled")
        else
            print("Healing SkillCheck Disabled")
        end
    end
})

-- Tools
local ToolsSection = SurvivorTab:Section({
    Title = "Tools",
    Opened = true
})
-- Fast Gate Tool = mempercepat proses loading pembukaan gate
ToolsSection:Toggle({
    Title = "Fast Gate Tools",
    Value = false,
    Callback = function (v)
        State.FastGate = v
    end
})

-- Survivor Auto Skill 
local SvvAutoSkillSection = SurvivorTab:Section({
    Title = "Survivor Auto Skill",
    Opened = true
})
SvvAutoSkillSection:Toggle({
    Title ="Auto Crouch", -- game:GetService("ReplicatedStorage").Remotes.Mechanics.Crouch
    Value = false,
    Callback = function(v) State.AutoCrouch = v end
})
--// LOGIC: FAST VAULT - PLAYER OBJECT
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function GetMyPlayerObject()
    -- Langsung cari objek dengan nama persis LocalPlayer
    return workspace:FindFirstChild(LocalPlayer.Name)
end

SvvAutoSkillSection:Toggle({
    Title = "Fast Vault (3x Speed)",
    Value = false,
    Callback = function(v)
        State.FastVault = v
        local myObj = GetMyPlayerObject()
        
        if myObj then
            if v then
                myObj:SetAttribute("vaultspeed", 1.5)
                print("🚀 Vault Speed 3x activated for:", LocalPlayer.Name)
            else
                myObj:SetAttribute("vaultspeed", 1)
                print("🔁 Vault Speed normal for:", LocalPlayer.Name)
            end
        else
            warn("Objek player tidak ditemukan di workspace:", LocalPlayer.Name)
        end
    end
})

-- Loop maintain
RunService.Heartbeat:Connect(function()
    if State.FastVault then
        local myObj = GetMyPlayerObject()
        if myObj and myObj:GetAttribute("vaultspeed") ~= 3 then
            myObj:SetAttribute("vaultspeed", 3)
        end
    end
end)

SvvAutoSkillSection:Toggle({
    Title ="No Slowdown",
    Value = false,
    Callback = function(v) State.NoSlowSurv = v end
})
SvvAutoSkillSection:Toggle({
    Title ="Auto Drop Pallete", --game:GetService("ReplicatedStorage").Remotes.Pallet.PalletDropEvent
    Value = false,
    Callback = function(v) State.AutoPallet = v end
})

-- Dagger 
local DaggerSection = SurvivorTab:Section ({
    Title = "Dagger [🔪]",
    Opened = true
})
DaggerSection:Dropdown({
    Title = "Parry Mode",
    Values = {"Animation", "No Animation"},
    Callback = function(v)
        State.ParryMode = v
    end
})
DaggerSection:Slider({
    Title = "Parry Radius",
    Value = {
        Min = 1,
        Max = 100,
        Default = 10,
    },
    Callback = function(v)
        State.ParryRadius = v
    end
})
DaggerSection:Toggle({
    Title = "Auto Parry", -- untuk menghidupkan atau matikan auto parry
    Value = false,
    Callback = function(v)
        State.AutoParry = v
    end
})

local MiscSurvivorSection = SurvivorTab:Section ({
    Title = "Misc",
    Opened = true
})
MiscSurvivorSection:Button({
    Title = "Instant Escape",
    Callback = function()
        local GateRemote = game:GetService("ReplicatedStorage").Remotes.Exit.gate
        -- Cari objek gerbang di Workspace
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:find("Gate") and obj:IsA("Model") then
                -- Kirim sinyal buka berkali-kali secara instan
                for i = 1, 50 do 
                    GateRemote:FireServer(obj)
                end
            end
        end
        WindUI:Notify({ Title = "Survivor", Content = "Mencoba membuka semua gerbang secara instan!", Duration = 3 })
    end
})
MiscSurvivorSection:Button({
    Title = "Destroy Gates",
    Callback = function()
        -- Fitur ini menghapus objek gerbang secara lokal (Client-Side)
        -- Berguna agar lu bisa lewat meskipun gerbang belum terbuka
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:find("Gate") and (obj:IsA("Model") or obj:IsA("BasePart")) then
                obj:Destroy()
            end
        end
        WindUI:Notify({ Title = "Survivor", Content = "Gerbang dihapus secara lokal! Lu bisa lewat sekarang.", Duration = 3 })
    end
})

--// Masukkan ke dalam tabel State
State.GodMode = false

--// UI Section di WindUI
local GodSection = SurvivorTab:Section({
    Title = "Survival [🛡️]",
    Opened = false
})

GodSection:Toggle({
    Title = "God Mode (Anti-Death)",
    Value = State.GodMode,
    Callback = function(v)
        State.GodMode = v
    end
})

--// LOGIC GOD MODE
RunService.Stepped:Connect(function()
    if not State.GodMode then return end
    
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if hum then
        -- 1. Mencegah kematian standar
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        
        -- 2. Jika Health terlalu rendah, paksa naik sedikit agar tidak pingsan
        -- (Tetap di bawah 100 agar tidak mencolok, tapi cukup untuk pakai dagger)
        if hum.Health <= 1 then
            hum.Health = 5 -- Menjaga tetap hidup di mata server
        end
    end
end)
end
