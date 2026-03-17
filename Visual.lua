return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Visual...")
    local State = _G.SharedState

    --=====================================================
    -- UI SETUP (Sesuai dengan UI kamu)
    --=====================================================
    local VisualTab = Window:Tab({ Title = "Visual", Icon = "lucide:eye" })

    local ScreenDisplaySection = VisualTab:Section ({ Title = "Screen Display", Opened = true })
    
    -- Fullbright Logic (Placeholder)
    ScreenDisplaySection:Slider({
        Title = "Full Bright",
        Value = { Min = 0, Max = 100, Default = 10 },
        Callback = function(v) State.FullBright = v end
    })

    local ESPSection = VisualTab:Section ({ Title = "Seven Eye", Opened = true })

    ESPSection:Dropdown({
        Title = "Selected Entities",
        Multi = true,
        Values = {"Killer", "Survivor", "Generators", "Gates", "Pallets", "Windows", "Hooks"},
        Callback = function(v) State.ESP.Selected = v end
    })

    -- Variabel penyimpanan internal agar tidak error nil
    local highlights = {}
    local labels = {}

    -- Fungsi Pembersih
    local function clearESP(plr)
        if highlights[plr] then
            highlights[plr]:Destroy()
            highlights[plr] = nil
        end
        if labels[plr] then
            if labels[plr].Parent then labels[plr].Parent:Destroy() end
            labels[plr] = nil
        end
    end

    ESPSection:Toggle({
        Title = "Enable ESP",
        Value = State.ESP.Enabled or false,
        Callback = function(v) 
            State.ESP.Enabled = v 
            if not v then
                for _, plr in ipairs(Players:GetPlayers()) do clearESP(plr) end
            end
        end
    })

    ESPSection:Toggle({ Title = "Show Names", Value = false, Callback = function(v) State.ESP.Names = v end })
    ESPSection:Toggle({ Title = "Show Distance", Value = false, Callback = function(v) State.ESP.Studs = v end })
    ESPSection:Toggle({ Title = "Show Health", Value = false, Callback = function(v) State.ESP.Health = v end })

    --=====================================================
    -- LOGIKA CORE ESP (DIPERBAIKI)
    --=====================================================
    local function updatePlayer(plr, currentCam)
        if not State.ESP.Enabled then
            clearESP(plr)
            return
        end

        local char = plr.Character
        local head = char and char:FindFirstChild("Head")

        if not char or not head then
            if highlights[plr] then highlights[plr].Enabled = false end
            if labels[plr] then labels[plr].Visible = false end
            return
        end

        -- Filter Tim
        local team = plr.Team
        local isKiller = (team and team.Name == "Killer")
        local isSurvivor = (team and team.Name == "Survivors")

        local isSelected = false
        if isKiller and table.find(State.ESP.Selected, "Killer") then isSelected = true end
        if isSurvivor and table.find(State.ESP.Selected, "Survivor") then isSelected = true end
        
        if not isSelected then
            clearESP(plr)
            return
        end

        -- Warna & Status
        local color = Color3.fromRGB(255, 255, 255)
        local statusText = ""

        if isKiller then
            color = Color3.fromRGB(255, 80, 80)
            statusText = "[" .. (plr:GetAttribute("SelectedKiller") or "Killer") .. "]"
        elseif isSurvivor then
            local knocked = char:GetAttribute("Knocked")
            local hooked = char:GetAttribute("IsHooked")
            local item = plr:GetAttribute("EquippedItem")

            if hooked then color = Color3.fromRGB(255, 110, 80) 
            elseif knocked then color = Color3.fromRGB(255, 170, 80)
            else color = Color3.fromRGB(100, 255, 100) end

            if item and item ~= "" and item ~= "None" then statusText = "[" .. item .. "]" end
        end

        -- Render Highlight (Gunakan currentCam yang dioper dari loop)
        if not highlights[plr] then
            local hl = Instance.new("Highlight")
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = currentCam -- INI PERBAIKANNYA
            highlights[plr] = hl
        end
        highlights[plr].Adornee = char
        highlights[plr].FillColor = color
        highlights[plr].Enabled = true

        -- Render Billboard (Text)
        if not labels[plr] then
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0, 200, 0, 50)
            bill.StudsOffset = Vector3.new(0, 3, 0)
            bill.AlwaysOnTop = true
            bill.Parent = currentCam -- INI PERBAIKANNYA
            
            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Font = Enum.Font.SourceSansBold
            txt.TextSize = 14
            txt.TextStrokeTransparency = 0
            txt.Parent = bill
            labels[plr] = txt
        end

        local txt = labels[plr]
        txt.Parent.Adornee = head
        
        local displayText = ""
        if State.ESP.Names then displayText = plr.Name end
        if State.ESP.Studs then
            local myRoot = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local d = math.floor((head.Position - myRoot.Position).Magnitude)
                displayText = (displayText ~= "" and displayText .. " " or "") .. "[" .. d .. "m]"
            end
        end
        if statusText ~= "" then displayText = (displayText ~= "" and displayText .. "\n" or "") .. statusText end

        txt.Text = displayText
        txt.TextColor3 = color
        txt.Visible = (displayText ~= "")
    end

    -- LOOP UTAMA: Mengambil kamera terbaru setiap frame
    RunService.RenderStepped:Connect(function()
        local currentCam = workspace.CurrentCamera
        if not currentCam then return end -- Guard clause jika kamera nil

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Players.LocalPlayer then
                updatePlayer(plr, currentCam)
            end
        end
    end)

    Players.PlayerRemoving:Connect(clearESP)
end

--=====================================================
-- LOGIKA ESP GENERATOR (SINKRON UI)
--=====================================================
local genHighlights = {}
local genLabels = {}
local trackedGens = {}
local map = workspace:WaitForChild("Map")

-- Fungsi Bersih Generator
local function clearGenESP(obj)
    if genHighlights[obj] then genHighlights[obj]:Destroy() genHighlights[obj] = nil end
    if genLabels[obj] then 
        if genLabels[obj].Parent then genLabels[obj].Parent:Destroy() end
        genLabels[obj] = nil 
    end
end

local function updateGen(obj, currentCam)
    -- Cek Toggle Utama & Dropdown UI
    local isEnabled = State.ESP.Enabled and table.find(State.ESP.Selected, "Generators")
    
    if not isEnabled then
        clearGenESP(obj)
        return
    end

    if not obj:IsA("Model") or obj:GetAttribute("RepairProgress") == nil then return end

    local progress  = obj:GetAttribute("RepairProgress") or 0
    local repairing = obj:GetAttribute("PlayersRepairingCount") or 0
    local isFull = progress >= 100

    -- 1. RENDER HIGHLIGHT
    if not genHighlights[obj] then
        local hl = Instance.new("Highlight")
        hl.Adornee = obj
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.FillTransparency = 0.5
        hl.Parent = currentCam
        genHighlights[obj] = hl
    end

    local hl = genHighlights[obj]
    hl.Enabled = true
    hl.FillColor = isFull and Color3.fromRGB(0, 255, 0) or Color3.new(1, 1, 1)
    hl.OutlineColor = hl.FillColor

    -- 2. RENDER TEXT
    local attach = obj:FindFirstChild("defaultMaterial") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
    if not attach then return end

    if not genLabels[obj] then
        local bill = Instance.new("BillboardGui")
        bill.Adornee = attach
        bill.Size = UDim2.new(0, 170, 0, 38)
        bill.StudsOffset = Vector3.new(0, 4, 0)
        bill.AlwaysOnTop = true
        bill.Parent = currentCam

        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.TextSize = 14
        txt.Font = Enum.Font.SourceSansSemibold
        txt.TextStrokeTransparency = 0.4
        txt.Parent = bill
        genLabels[obj] = txt
    end

    local txt = genLabels[obj]
    txt.Visible = true

    if isFull then
        txt.Text = "Generator\n100.0%"
        txt.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        local gradient = math.clamp(progress / 100, 0, 1)
        txt.TextColor3 = Color3.new(1 - gradient * 0.7, 1, 1 - gradient * 0.7)
        txt.Text = repairing > 0 
            and string.format("Generator\n%.1f%% [%d]", progress, repairing)
            or string.format("Generator\n%.1f%%", progress)
    end
end

--=====================================================
-- LOOP & DETEKSI GENERATOR
--=====================================================

-- Deteksi Generator Baru
map.DescendantAdded:Connect(function(child)
    if child:IsA("Model") and child:GetAttribute("RepairProgress") ~= nil then
        trackedGens[child] = true
    end
end)

-- Hapus saat generator hilang dari map
map.DescendantRemoving:Connect(function(child)
    if trackedGens[child] then
        clearGenESP(child)
        trackedGens[child] = nil
    end
end)

-- Scan Awal
for _, obj in ipairs(map:GetDescendants()) do
    if obj:IsA("Model") and obj:GetAttribute("RepairProgress") ~= nil then
        trackedGens[obj] = true
    end
end

-- Masukkan ke dalam Loop RenderStepped yang sudah ada di Visual.lua
RunService.RenderStepped:Connect(function()
    local currentCam = workspace.CurrentCamera
    if not currentCam then return end

    -- Loop Players (Sudah ada di kode sebelumnya)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            updatePlayer(plr, currentCam) -- Fungsi player yang kita buat tadi
        end
    end

    -- Loop Generators (TAMBAHAN BARU)
    for gen in pairs(trackedGens) do
        if gen and gen.Parent then 
            updateGen(gen, currentCam) 
        else
            trackedGens[gen] = nil
        end
    end
end)
