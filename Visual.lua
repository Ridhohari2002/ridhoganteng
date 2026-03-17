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

-- Local variables untuk mempermudah akses
    local LocalPlayer = Players.LocalPlayer
    local highlights = {}
    local labels = {}

    -- Fungsi untuk membersihkan ESP
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

local function updatePlayer(plr, camera)
    -- 1. VALIDASI AWAL
    if not State.ESP.Enabled then 
        clearESP(plr)
        return 
    end

    local char = plr.Character
    local head = char and char:FindFirstChild("Head")
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if not char or not head or not hum or hum.Health <= 0 then
        if highlights[plr] then highlights[plr].Adornee = nil end
        if labels[plr] then labels[plr].Parent.Adornee = nil end
        return
    end

    -- 2. PENENTUAN ROLE (KILLER VS SURVIVOR)
    local team = plr.Team
    local isKiller = false
    
    if (team and team.Name == "Killer") or plr:GetAttribute("SelectedKiller") then
        isKiller = true
    end

    -- 3. FILTER SELECTION (Dropdown WindUI)
    local isSelected = false
    if isKiller and table.find(State.ESP.Selected, "Killer") then 
        isSelected = true 
    elseif not isKiller and table.find(State.ESP.Selected, "Survivor") then 
        isSelected = true 
    end

    if not isSelected then
        clearESP(plr)
        return
    end

    -- 4. LOGIKA PEWARNAAN & TEXT FORMATTING
    local color = Color3.fromRGB(0, 255, 127) -- Default Hijau (Survivor)
    local infoRows = {}

    if isKiller then
        -----------------------------------------
        -- FORMAT KILLER (MERAH)
        -----------------------------------------
        color = Color3.fromRGB(255, 30, 30) 
        if State.ESP.Names then table.insert(infoRows, plr.Name) end
        
        local kName = plr:GetAttribute("SelectedKiller") or "Killer"
        table.insert(infoRows, "👹 [" .. kName .. "]")
    else
        -----------------------------------------
        -- FORMAT SURVIVOR (HIJAU)
        -----------------------------------------
        local hooked = char:GetAttribute("IsHooked")
        local knocked = char:GetAttribute("Knocked")

        -- Warna Berdasarkan Status
        if hooked then
            color = Color3.fromRGB(255, 0, 0)   -- Merah (Hooked)
        elseif knocked then
            color = Color3.fromRGB(255, 150, 0) -- Orange (Knocked)
        end

        if State.ESP.Names then table.insert(infoRows, plr.Name) end
        
        -- Info Item
        local item = plr:GetAttribute("EquippedItem")
        if item and item ~= "" and item ~= "None" then
            table.insert(infoRows, "📦 [" .. item .. "]")
        end

        -- Info Health (Jika Toggle Aktif)
        if State.ESP.Health then
            table.insert(infoRows, "HP: " .. math.floor(hum.Health) .. "%")
        end
    end

    -- Tambahkan Jarak (Jika Toggle Aktif)
    if State.ESP.Studs then
        local dist = math.floor((head.Position - camera.CFrame.Position).Magnitude)
        table.insert(infoRows, "📏 " .. dist .. "m")
    end

    -----------------------------------------
    -- 5. RENDER VISUAL (HIGHLIGHT & TEXT)
    -----------------------------------------
    
    -- Update Highlight (Body Glow)
    if not highlights[plr] or not highlights[plr].Parent then
        local hl = Instance.new("Highlight")
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.OutlineColor = Color3.new(1, 1, 1)
        hl.Parent = camera
        highlights[plr] = hl
    end
    highlights[plr].Adornee = char
    highlights[plr].FillColor = color
    highlights[plr].FillTransparency = 0.4

    -- Update Billboard (Text Info)
    if not labels[plr] or not labels[plr].Parent then
        local bill = Instance.new("BillboardGui")
        bill.Size = UDim2.new(0, 200, 0, 60)
        bill.StudsOffset = Vector3.new(0, 4.5, 0) -- Di atas kepala
        bill.AlwaysOnTop = true
        bill.Parent = camera

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
    txt.Text = table.concat(infoRows, "\n")
    txt.TextColor3 = color
end
    -- Loop Update
    local espLoop
    espLoop = RunService.Heartbeat:Connect(function()
        local camera = workspace.CurrentCamera
        if not camera then return end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                updatePlayer(plr, camera)
            end
        end
    end)

    -- Cleanup saat script di-unload
    Players.PlayerRemoving:Connect(clearESP)
    
    print("ESP Player berhasil dimuat!")
end
