return function(Window, State, Players, RunService)
    print("Memuat Module Visual...")
    local State = _G.SharedState
    
    -- Safety check untuk folder Map agar tidak error DescendantAdded
    local map = workspace:FindFirstChild("Map") 
    if not map then
        -- Jika tidak ketemu, coba tunggu sebentar (max 3 detik)
        map = workspace:WaitForChild("Map", 3)
    end

    -- Storage
    local highlights = {}
    local labels = {}
    local genHighlights = {}
    local genLabels = {}
    local trackedGens = {}

    --=====================================================
    -- UI SETUP
    --=====================================================
    local VisualTab = Window:Tab({ Title = "Visual", Icon = "lucide:eye" })
    local ScreenSection = VisualTab:Section({ Title = "Screen Display", Opened = true })
    
    ScreenSection:Slider({
        Title = "Full Bright",
        Value = { Min = 0, Max = 100, Default = 10 },
        Callback = function(v) State.FullBright = v end
    })

    local ESPSection = VisualTab:Section({ Title = "Seven Eye", Opened = true })
    ESPSection:Dropdown({
        Title = "Selected Entities",
        Multi = true,
        Values = {"Killer", "Survivor", "Generators", "Gates", "Pallets", "Windows", "Hooks"},
        Callback = function(v) State.ESP.Selected = v end
    })

    --=====================================================
    -- CLEANUP FUNCTIONS
    --=====================================================
    local function clearESP(plr)
        if highlights[plr] then highlights[plr]:Destroy() highlights[plr] = nil end
        if labels[plr] then if labels[plr].Parent then labels[plr].Parent:Destroy() end labels[plr] = nil end
    end

    local function clearGenESP(obj)
        if genHighlights[obj] then genHighlights[obj]:Destroy() genHighlights[obj] = nil end
        if genLabels[obj] then if genLabels[obj].Parent then genLabels[obj].Parent:Destroy() end genLabels[obj] = nil end
    end

    --=====================================================
    -- TOGGLES
    --=====================================================
    ESPSection:Toggle({
        Title = "Enable ESP",
        Value = State.ESP.Enabled or false,
        Callback = function(v) 
            State.ESP.Enabled = v 
            if not v then
                for _, plr in ipairs(Players:GetPlayers()) do clearESP(plr) end
                for gen in pairs(trackedGens) do clearGenESP(gen) end
            end
        end
    })

    ESPSection:Toggle({ Title = "Show Names", Value = false, Callback = function(v) State.ESP.Names = v end })
    ESPSection:Toggle({ Title = "Show Distance", Value = false, Callback = function(v) State.ESP.Studs = v end })

    --=====================================================
    -- CORE LOGIC FUNCTIONS
    --=====================================================
    local function updatePlayer(plr, currentCam)
        if not State.ESP.Enabled then clearESP(plr) return end
        
        local char = plr.Character
        local head = char and char:FindFirstChild("Head")
        if not char or not head then return end

        local team = plr.Team
        local isKiller = (team and team.Name == "Killer")
        local isSurvivor = (team and team.Name == "Survivors")

        local isSelected = (isKiller and table.find(State.ESP.Selected, "Killer")) or (isSurvivor and table.find(State.ESP.Selected, "Survivor"))
        if not isSelected then clearESP(plr) return end

    -----------------------------------------------------------
    -- LOGIKA WARNA & STATUS (ENHANCED)
    -----------------------------------------------------------
    local color = Color3.fromRGB(255, 255, 255)
    local statusText = ""
    local hum = char:FindFirstChildOfClass("Humanoid")

    if isKiller then
        color = Color3.fromRGB(255, 80, 80)
        local killerName = plr:GetAttribute("SelectedKiller") or "Killer"
        statusText = "[" .. killerName .. "]"
    elseif isSurvivor then
        -- Coba ambil attribute
        local knocked = char:GetAttribute("Knocked") or char:GetAttribute("IsKnocked")
        local hooked = char:GetAttribute("IsHooked") or char:GetAttribute("Hooked")
        local item = plr:GetAttribute("EquippedItem") or plr:GetAttribute("Item")

        -- Logic Prioritas Status
        if hooked == true then 
            color = Color3.fromRGB(255, 110, 80)
            statusText = "[HOOKED]"
        elseif knocked == true then 
            color = Color3.fromRGB(255, 170, 80)
            statusText = "[KNOCKED]"
        elseif hum and hum.Health <= 0 then
            color = Color3.fromRGB(150, 150, 150)
            statusText = "[DEAD]"
        else 
            color = Color3.fromRGB(100, 255, 100)
            -- Kalau sehat, baru tampilin Item (biar gak numpuk pas Hooked)
            if item and item ~= "" and item ~= "None" then 
                statusText = "[" .. tostring(item) .. "]"
            end
        end
    end

    -----------------------------------------------------------
    -- FIX TAMPILAN (Pastikan muncul meski Nama dimatikan)
    -----------------------------------------------------------
    local nameStr = State.ESP.Names and plr.Name or ""
    local distStr = State.ESP.Studs and " ["..math.floor((head.Position - currentCam.CFrame.Position).Magnitude).."m]" or ""
    
    -- Gabungin: Jika nama mati, minimal munculin Jarak + Status
    local line1 = nameStr .. distStr
    local finalDisplayText = ""

    if line1 ~= "" and statusText ~= "" then
        finalDisplayText = line1 .. "\n" .. statusText
    elseif line1 ~= "" then
        finalDisplayText = line1
    else
        finalDisplayText = statusText
    end

    txt.Text = finalDisplayText
    txt.TextColor3 = color
    txt.Visible = (finalDisplayText ~= "")

    -----------------------------------------------------------
    -- RENDER ESP
    -----------------------------------------------------------
    -- Highlight
        if not highlights[plr] then
            local hl = Instance.new("Highlight")
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = currentCam
            highlights[plr] = hl
        end
        highlights[plr].Adornee = char
        highlights[plr].FillColor = isKiller and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(100, 255, 100)

        if not labels[plr] then
            local bill = Instance.new("BillboardGui", currentCam)
            bill.Size = UDim2.new(0, 200, 0, 50)
            bill.AlwaysOnTop = true
            local txt = Instance.new("TextLabel", bill)
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Font = Enum.Font.SourceSansBold
            txt.TextSize = 14
            txt.TextStrokeTransparency = 0
            labels[plr] = txt
        end
        labels[plr].Parent.Adornee = head
        local distStr = State.ESP.Studs and " ["..math.floor((head.Position - currentCam.CFrame.Position).Magnitude).."m]" or ""
        labels[plr].Text = (State.ESP.Names and plr.Name or "")..distStr
        labels[plr].TextColor3 = highlights[plr].FillColor
        labels[plr].Visible = true
    end

    local function updateGen(obj, currentCam)
        local isEnabled = State.ESP.Enabled and table.find(State.ESP.Selected, "Generators")
        if not isEnabled then clearGenESP(obj) return end

        local progress = obj:GetAttribute("RepairProgress") or 0
        
        if not genHighlights[obj] then
            local hl = Instance.new("Highlight", currentCam)
            hl.Adornee = obj
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            genHighlights[obj] = hl
        end
        genHighlights[obj].FillColor = (progress >= 100) and Color3.new(0, 1, 0) or Color3.new(1, 1, 1)

        if not genLabels[obj] then
            local bill = Instance.new("BillboardGui", currentCam)
            bill.Size = UDim2.new(0, 170, 0, 38)
            bill.AlwaysOnTop = true
            local txt = Instance.new("TextLabel", bill)
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.TextSize = 14
            txt.Font = Enum.Font.SourceSansBold
            txt.TextStrokeTransparency = 0.4
            genLabels[obj] = txt
        end
        genLabels[obj].Parent.Adornee = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
        genLabels[obj].Text = string.format("Generator\n%.1f%%", progress)
        genLabels[obj].TextColor3 = genHighlights[obj].FillColor
        genLabels[obj].Visible = true
    end

    --=====================================================
    -- GENERATOR DETECTION & MAIN LOOP
    --=====================================================
    if map then
        map.DescendantAdded:Connect(function(child)
            if child:IsA("Model") and child:GetAttribute("RepairProgress") ~= nil then
                trackedGens[child] = true
            end
        end)

        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("Model") and obj:GetAttribute("RepairProgress") ~= nil then
                trackedGens[obj] = true
            end
        end
    else
        warn("Violence District: Folder 'Map' tidak ditemukan. ESP Generator dinonaktifkan.")
    end

    RunService.RenderStepped:Connect(function()
        local currentCam = workspace.CurrentCamera
        if not currentCam then return end

        -- Players
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Players.LocalPlayer then updatePlayer(plr, currentCam) end
        end

        -- Generators (Hanya jalan jika folder map ada)
        if map then
            for gen in pairs(trackedGens) do
                if gen and gen.Parent then updateGen(gen, currentCam) else trackedGens[gen] = nil end
            end
        end
    end)

    Players.PlayerRemoving:Connect(clearESP)
    print("Tab Visual Berhasil Dimuat!")
end
