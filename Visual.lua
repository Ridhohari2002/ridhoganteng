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

--=====================================================
-- LOGIC ESP (PLAYER & KILLER)
--=====================================================
    local function updatePlayer(plr, camera)
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

        -- 1. DETEKSI TIM & ROLE
        local team = plr.Team
        local isKiller = false
        
        -- Cek berdasarkan Nama Tim atau Atribut Game
        if (team and team.Name == "Killer") or plr:GetAttribute("SelectedKiller") then
            isKiller = true
        end

        -- 2. FILTER DROPDOWN UI
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

        -- 3. LOGIKA PEWARNAAN (SURVIVOR = HIJAU, KILLER = MERAH)
        local color = Color3.fromRGB(100, 255, 100) -- Default Hijau (Survivor)

        if isKiller then
            color = Color3.fromRGB(255, 50, 50) -- Merah Terang (Killer)
        else
            -- Warna Khusus Status Survivor
            if char:GetAttribute("IsHooked") then 
                color = Color3.fromRGB(255, 0, 0)   -- Merah Tua (Terpaku/Hooked)
            elseif char:GetAttribute("Knocked") then 
                color = Color3.fromRGB(255, 150, 0) -- Orange (Tergeletak/Knocked)
            elseif hum.Health < 50 then
                color = Color3.fromRGB(255, 255, 0) -- Kuning (Darah Rendah)
            end
        end

        -- 4. UPDATE HIGHLIGHT
        if not highlights[plr] or not highlights[plr].Parent then
            local hl = Instance.new("Highlight")
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.OutlineColor = Color3.new(1, 1, 1)
            hl.Parent = camera
            highlights[plr] = hl
        end
        
        local hl = highlights[plr]
        hl.Adornee = char
        hl.FillColor = color
        hl.FillTransparency = 0.4
        hl.OutlineTransparency = 0

        -- 5. UPDATE BILLBOARD UI (INFO TEXT)
        if not labels[plr] or not labels[plr].Parent then
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0, 200, 0, 50)
            bill.StudsOffset = Vector3.new(0, 4, 0)
            bill.AlwaysOnTop = true
            bill.Parent = camera

            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Font = Enum.Font.SourceSansBold
            txt.TextSize = 14
            txt.TextStrokeTransparency = 0.2
            txt.Parent = bill
            labels[plr] = txt
        end

        local txt = labels[plr]
        txt.Parent.Adornee = head

        -- Bangun teks berdasarkan Toggle UI
        local infoRows = {}
        
        if State.ESP.Names then 
            table.insert(infoRows, plr.Name) 
        end
        
        if isKiller then
            local kName = plr:GetAttribute("SelectedKiller") or "Killer"
            table.insert(infoRows, "[" .. kName .. "]")
        elseif State.ESP.Health then
            table.insert(infoRows, "HP: " .. math.floor(hum.Health) .. "%")
        end

        if State.ESP.Studs then
            local dist = math.floor((head.Position - camera.CFrame.Position).Magnitude)
            table.insert(infoRows, "[" .. dist .. "m]")
        end

        txt.Text = table.concat(infoRows, "\n")
        txt.TextColor3 = color
        txt.Visible = true
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
