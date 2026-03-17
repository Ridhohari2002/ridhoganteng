return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Visual...")
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
    local trackedGates = {}
    local trackedPallets = {}


    --=====================================================
    -- UI SETUP (Sesuai dengan UI kamu)
    --=====================================================
    local VisualTab = Window:Tab({ Title = "Visual", Icon = "lucide:eye" })

    local ScreenDisplaySection = VisualTab:Section ({ Title = "Screen Display", Opened = true })
    
    -- Fullbright Logic (Placeholder)
    ScreenDisplaySection:Slider({
        Title = "Full Bright",
        Value = { Min = 0, Max = 100, Default = 5 },
        Callback = function(v) State.FullBright = v end
    })

    local ESPSection = VisualTab:Section ({ Title = "Seven Eye", Opened = true })

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

    local function clearAllESP(obj)
        if highlights[obj] then highlights[obj]:Destroy() highlights[obj] = nil end
        if labels[obj] then 
            if labels[obj].Parent then labels[obj].Parent:Destroy() end 
            labels[obj] = nil 
        end
    end

    ESPSection:Toggle({
        Title = "Enable ESP",
        Value = State.ESP.Enabled or false,
        Callback = function(v) 
            State.ESP.Enabled = v 
            if not v then
                for _, plr in ipairs(Players:GetPlayers()) do clearESP(plr) end
                for obj, _ in pairs(trackedGens) do clearGenESP(obj) end
                for obj, _ in pairs(trackedGates) do clearAllESP(obj) end
                for obj, _ in pairs(trackedPallets) do clearAllESP(obj) end
            end
        end
    })

    ESPSection:Toggle({ Title = "Show Names", Value = false, Callback = function(v) State.ESP.Names = v end })
    ESPSection:Toggle({ Title = "Show Distance", Value = false, Callback = function(v) State.ESP.Studs = v end })

    --=====================================================
    -- LOGIKA CORE ESP KILLER DAN SURVIVOR
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
    --=====================================================
    -- LOGIKA CORE ESP GENERATOR
    --=====================================================
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
        local ratio = progress / 100
        genHighlights[obj].FillColor = Color3.fromRGB(
            255 * (1 - ratio),
            255 * ratio,
            50
        )

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
    --=====================================================
    -- LOGIKA CORE ESP GATE 
    --=====================================================

    local function updateGate(obj, currentCam) [cite: 1]
        local isEnabled = State.ESP.Enabled and table.find(State.ESP.Selected, "Gates")
        if not isEnabled then clearAllESP(obj) return end

        local color = Color3.fromRGB(160, 0, 255) -- Purple 

        if not highlights[obj] then
            local hl = Instance.new("Highlight", currentCam) [cite: 1]
            hl.Adornee = obj
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.FillColor = color [cite: 1]
            highlights[obj] = hl
        end
    end
    --=====================================================
    -- 3. LOGIKA UPDATE PALLET
    --=====================================================
    local function updatePallet(obj, currentCam) [cite: 5]
        local isEnabled = State.ESP.Enabled and table.find(State.ESP.Selected, "Pallets")
        if not isEnabled then clearAllESP(obj) return end

        local color = Color3.fromRGB(255, 200, 0) -- Yellow [cite: 5]

        if not highlights[obj] then
            local hl = Instance.new("Highlight", currentCam) [cite: 5]
            hl.Adornee = obj
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.FillColor = color [cite: 5]
            highlights[obj] = hl
        end
    end


    --=====================================================
    -- DETECTION SYSTEM
    --=====================================================
    local function scan(child)
        if child:IsA("Model") then
            if child.Name:lower():find("pallet") then [cite: 5]
                trackedPallets[child] = true
            end
        elseif child:IsA("BasePart") then
            if child.Name == "LeftGate" or child.Name == "RightGate" then
                trackedGates[child] = true
            end
        end
    end

    if map then
        map.DescendantAdded:Connect(scan)
        map.DescendantRemoving:Connect(function(child)
            trackedGates[child] = nil
            trackedPallets[child] = nil
            clearAllESP(child)
        end)
        for _, v in ipairs(map:GetDescendants()) do scan(v) end
    end
    --=====================================================
    -- MAIN LOOP
    --=====================================================
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

            for gate in pairs(trackedGates) do
                if gate.Parent then updateGate(gate, currentCam) else trackedGates[gate] = nil end
            end
            
            for pallet in pairs (trackedPallets) do
                if pallet.Parent then updatePallet(pallet, currentCam) else trackedPallets[pallet] = nil end
            end
        end

    end)

    Players.PlayerRemoving:Connect(clearESP)
    print("Tab Visual Berhasil Dimuat!")
end
