return function(Window, State, Players, RunService)
    print("Memuat Module Visual All-In-One...")
    local State = _G.SharedState
    local map = workspace:FindFirstChild("Map") or workspace:WaitForChild("Map", 3)

    -- Storage terpisah agar tidak bentrok
    local highlights = {} -- Untuk Player
    local labels = {}     -- Untuk Player
    
    local genHighlights = {}
    local genLabels = {}
    local trackedGens = {}

    local objHighlights = {} -- Khusus untuk Pallet/Gate/Hook/Window
    local objLabels = {}     -- Khusus untuk Pallet/Gate/Hook/Window
    local trackedObjects = {} 

    --=====================================================
    -- UI SETUP
    --=====================================================
    local VisualTab = Window:Tab({ Title = "Visual", Icon = "lucide:eye" })
    local ScreenDisplaySection = VisualTab:Section ({ Title = "Screen Display", Opened = true })
    
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

    local function clearObjESP(obj)
        if objHighlights[obj] then objHighlights[obj]:Destroy() objHighlights[obj] = nil end
        if objLabels[obj] then if objLabels[obj].Parent then objLabels[obj].Parent:Destroy() end objLabels[obj] = nil end
    end
    
    ESPSection:Toggle({
        Title = "Enable ESP",
        Value = State.ESP.Enabled or false,
        Callback = function(v) 
            State.ESP.Enabled = v 
            if not v then
                -- Bersihkan SEMUA saat OFF
                for _, plr in ipairs(Players:GetPlayers()) do clearESP(plr) end
                for gen in pairs(trackedGens) do clearGenESP(gen) end
                for obj in pairs(trackedObjects) do clearObjESP(obj) end
            end
        end
    })

    ESPSection:Toggle({ Title = "Show Names", Value = false, Callback = function(v) State.ESP.Names = v end })
    ESPSection:Toggle({ Title = "Show Distance", Value = false, Callback = function(v) State.ESP.Studs = v end })
    
    --=====================================================
    -- HELPERS & LOGIC
    --=====================================================
    local function getObjectType(obj)
        local name = obj.Name:lower()
        if name:find("hook") then return "Hooks" end
        if name:find("pallet") or obj:FindFirstChild("PrimaryPartPallet") then return "Pallets" end
        if name:find("gate") or obj:FindFirstChild("LeftGate") then return "Gates" end
        if name:find("window") or name:find("vault") or obj:FindFirstChild("Bottom") then return "Windows" end
        return nil
    end

    -- Fungsi update tetap sama seperti punya kamu, tapi ganti variabel table-nya ke objHighlights/objLabels
    local function updateObjectESP(obj, objType, currentCam)
        local isEnabled = State.ESP.Enabled and table.find(State.ESP.Selected, objType)
        if not isEnabled then clearObjESP(obj) return end

        local attach = obj:IsA("BasePart") and obj or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
        if objType == "Pallets" then attach = obj:FindFirstChild("PrimaryPartPallet", true) or attach end
        if objType == "Windows" then attach = obj:FindFirstChild("Bottom", true) or attach end
        if not attach then return end

        local color = Color3.fromRGB(255, 255, 255)
        if objType == "Hooks" then color = Color3.fromRGB(255, 80, 80)
        elseif objType == "Pallets" then color = Color3.fromRGB(255, 200, 50)
        elseif objType == "Gates" then color = Color3.fromRGB(50, 255, 200)
        elseif objType == "Windows" then color = Color3.fromRGB(200, 200, 200) end

        -- Pakai objHighlights
        if not objHighlights[obj] then
            local hl = Instance.new("Highlight", currentCam)
            hl.Adornee = obj
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.FillTransparency = 0.6
            objHighlights[obj] = hl
        end
        objHighlights[obj].FillColor = color
        objHighlights[obj].OutlineColor = color

        -- Pakai objLabels
        if not objLabels[obj] then
            local bill = Instance.new("BillboardGui", currentCam)
            bill.Size = UDim2.new(0, 100, 0, 30)
            bill.AlwaysOnTop = true
            bill.StudsOffset = Vector3.new(0, 3, 0)
            local txt = Instance.new("TextLabel", bill)
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.TextSize = 13
            txt.Font = Enum.Font.SourceSansBold
            txt.TextStrokeTransparency = 0.5
            objLabels[obj] = txt
        end
        
        local txt = objLabels[obj]
        txt.Parent.Adornee = attach
        txt.TextColor3 = color
        local dist = math.floor((attach.Position - currentCam.CFrame.Position).Magnitude)
        txt.Text = objType:sub(1, -2) .. " [" .. dist .. "m]"
    end

    -- [Fungsi updatePlayer dan updateGen tetap sama seperti kode kamu]
    -- ... (Sisipkan kembali fungsi updatePlayer dan updateGen kamu di sini) ...

    --=====================================================
    -- SCANNING & DETECTION
    --=====================================================
    local function trackInstance(inst)
        local t = getObjectType(inst)
        if t then trackedObjects[inst] = t end
    end

    if map then
        for _, o in ipairs(map:GetDescendants()) do trackInstance(o) end
        map.DescendantAdded:Connect(trackInstance)
        map.DescendantRemoving:Connect(function(o) 
            clearObjESP(o) 
            trackedObjects[o] = nil 
        end)

        -- Generator Detection
        map.DescendantAdded:Connect(function(child)
            if child:IsA("Model") and child:GetAttribute("RepairProgress") ~= nil then trackedGens[child] = true end
        end)
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("Model") and obj:GetAttribute("RepairProgress") ~= nil then trackedGens[obj] = true end
        end
    end

    --=====================================================
    -- MAIN LOOP
    --=====================================================
    RunService.RenderStepped:Connect(function()
        local currentCam = workspace.CurrentCamera
        if not currentCam then return end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Players.LocalPlayer then updatePlayer(plr, currentCam) end
        end

        for obj, objType in pairs(trackedObjects) do
            if obj and obj.Parent then updateObjectESP(obj, objType, currentCam) else trackedObjects[obj] = nil end
        end
        
        for gen in pairs(trackedGens) do
            if gen and gen.Parent then updateGen(gen, currentCam) else trackedGens[gen] = nil end
        end
    end)

    Players.PlayerRemoving:Connect(clearESP)
    print("ESP Visual Lengkap Berhasil Dimuat!")
end
