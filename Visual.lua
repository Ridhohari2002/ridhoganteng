return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Aimbot...")
    local State = _G.SharedState
--=====================================================
-- VISUAL
--=====================================================
local VisualTab = Window:Tab({ 
    Title = "Visual", 
    Icon = "lucide:eye"
})

local ScreenDisplaySection = VisualTab:Section ({
    Title = "Screen Display",
    Opened = true
})
ScreenDisplaySection:Slider({
    Title = "Full Bright",
    Value = {
        Min = 0,
        Max = 100,
        Default = 10,
    },
    Callback = function(v)
        State.FullBright = v
        UpdateLighting()
    end
})
ScreenDisplaySection:Button({
    Title = "No Fog",
    Callback = function()
        DisableFog()
        print("Fog Removed!")
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local highlights = {}
local billhead = {} -- Untuk Nama & Distance (Atas Kepala)
local billside = {} -- Untuk Killer Type / Weapon (Samping Badan)

local function getCamera()
    return workspace.CurrentCamera
end

-- Fungsi hapus ESP
local function clearESP(plr)
    if highlights[plr] then highlights[plr]:Destroy(); highlights[plr] = nil end
    if billhead[plr] then billhead[plr]:Destroy(); billhead[plr] = nil end
    if billside[plr] then billside[plr]:Destroy(); billside[plr] = nil end
end

-- UI SETUP
local ESPSection = VisualTab:Section ({ Title = "Seven Eye", Opened = true })

ESPSection:Dropdown({
    Title = "Selected Entities",
    Multi = true,
    Values = {"Killer", "Survivor", "Generators", "Gates", "Pallets", "Windows", "Hooks"},
    Callback = function(v) State.ESP.Selected = v end
})

ESPSection:Toggle({
        Title = "Enable ESP",
        Value = State.ESP.Enabled or false,
        Callback = function(v) 
            State.ESP.Enabled = v 
            if not v then
                -- Bersihkan semua ESP saat toggle dimatikan
                for _, plr in ipairs(Players:GetPlayers()) do
                    clearESP(plr)
                end
            end
        end
    })

ESPSection:Toggle({ Title = "Show Names", Value = false, Callback = function(v) State.ESP.Names = v end })
ESPSection:Toggle({ Title = "Show Distance", Value = false, Callback = function(v) State.ESP.Studs = v end })
ESPSection:Toggle({ Title = "Show Health", Value = false, Callback = function(v) State.ESP.Health = v end })

local function updatePlayer(plr, camera, State)
    local char = plr.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local head = char and char:FindFirstChild("Head")

    -- Jika ESP Mati atau Player tidak valid, bersihkan
    if not State.ESP.Enabled or not char or not root or not head then
        if highlights[plr] then highlights[plr].Enabled = false end
        if billhead[plr] then billhead[plr].Enabled = false end
        if billside[plr] then billside[plr].Enabled = false end
        return
    end

    local team = plr.Team
    local isKiller = (team and team.Name == "Killer")
    local isSurvivor = (team and team.Name == "Survivors")

    -----------------------------------------------------------
    -- WARNA TAJAM (NEON)
    -----------------------------------------------------------
    local mainColor = Color3.fromRGB(255, 255, 255)
    if isKiller then
        mainColor = Color3.fromRGB(255, 0, 0) -- MERAH TERANG (PURE RED)
    elseif isSurvivor then
        local knocked = char:GetAttribute("Knocked")
        local hooked = char:GetAttribute("IsHooked")
        
        if hooked then
            mainColor = Color3.fromRGB(255, 0, 255) -- MAGENTA TERANG
        elseif knocked then
            mainColor = Color3.fromRGB(255, 150, 0) -- ORANYE TAJAM
        else
            mainColor = Color3.fromRGB(0, 255, 0) -- HIJAU TERANG (PURE LIME)
        end
    end

    -----------------------------------------------------------
    -- HIGHLIGHT (BODY GLOW)
    -----------------------------------------------------------
    if not highlights[plr] then
        local hl = Instance.new("Highlight")
        hl.Name = "ESP_Highlight"
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.FillTransparency = 0.4
        hl.OutlineTransparency = 0 -- Outline Tebal
        hl.OutlineColor = Color3.new(1, 1, 1)
        hl.Parent = camera
        highlights[plr] = hl
    end
    highlights[plr].Enabled = true
    highlights[plr].Adornee = char
    highlights[plr].FillColor = mainColor

    -----------------------------------------------------------
    -- BILLBOARD ATAS KEPALA (Nama & Distance)
    -----------------------------------------------------------
    if not billhead[plr] then
        local b = Instance.new("BillboardGui")
        b.Size = UDim2.new(0, 150, 0, 50)
        b.StudsOffset = Vector3.new(0, 1.5, 0) -- Jarak Dekat di Atas Kepala
        b.AlwaysOnTop = true
        b.Parent = camera
        
        local t = Instance.new("TextLabel", b)
        t.Size = UDim2.new(1, 0, 1, 0)
        t.BackgroundTransparency = 1
        t.Font = Enum.Font.RobotoMono -- Font lebih tegas
        t.TextSize = 11 -- Text diperkecil sesuai request
        t.TextStrokeTransparency = 0
        t.TextStrokeColor3 = Color3.new(0, 0, 0)
        billhead[plr] = b
    end
    
    local nameLabel = billhead[plr].TextLabel
    billhead[plr].Enabled = true
    billhead[plr].Adornee = head
    
    local distText = ""
    if State.ESP.Studs then
        local lpChar = Players.LocalPlayer.Character
        local lpRoot = lpChar and lpChar:FindFirstChild("HumanoidRootPart")
        if lpRoot then
            local d = math.floor((root.Position - lpRoot.Position).Magnitude)
            distText = " [" .. d .. "m]"
        end
    end
    nameLabel.Text = (State.ESP.Names and plr.Name or "") .. distText
    nameLabel.TextColor3 = mainColor

    -----------------------------------------------------------
    -- BILLBOARD SAMPING (Killer Type / Weapon)
    -----------------------------------------------------------
    if not billside[plr] then
        local b = Instance.new("BillboardGui")
        b.Size = UDim2.new(0, 150, 0, 50)
        b.StudsOffset = Vector3.new(2.5, 0, 0) -- Ditaruh di Samping Badan
        b.AlwaysOnTop = true
        b.Parent = camera
        
        local t = Instance.new("TextLabel", b)
        t.Size = UDim2.new(1, 0, 1, 0)
        t.BackgroundTransparency = 1
        t.Font = Enum.Font.SourceSansBold
        t.TextSize = 12
        t.TextStrokeTransparency = 0
        t.TextXAlignment = Enum.TextXAlignment.Left
        billside[plr] = b
    end

    local sideLabel = billside[plr].TextLabel
    billside[plr].Enabled = true
    billside[plr].Adornee = root
    
    local infoText = ""
    if isKiller then
        local kType = plr:GetAttribute("SelectedKiller") or "Killer"
        infoText = "TYPE: " .. kType
    elseif isSurvivor then
        local weapon = plr:GetAttribute("EquippedItem") or "None"
        if weapon ~= "None" and weapon ~= "" then
            infoText = "WEAPON: " .. weapon
        end
    end
    sideLabel.Text = infoText
    sideLabel.TextColor3 = Color3.new(1, 1, 1) -- Info samping warna putih agar jelas
end

----------------------------------------------------------------
-- RUN LOOP
----------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    local cam = getCamera()
    if not cam then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            updatePlayer(plr, cam, _G.SharedState)
        end
    end
end)

-- Cleanup
Players.PlayerRemoving:Connect(clearESP)

