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

    local highlights = {}
    local labels = {}
    local camera = workspace.CurrentCamera

    -- Fungsi untuk membersihkan ESP per player
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

    local function updatePlayer(plr)
        -- Jika ESP dimatikan secara global di UI, bersihkan dan stop
        if not State.ESP.Enabled then
            clearESP(plr)
            return
        end

        local char = plr.Character
        local head = char and char:FindFirstChild("Head")

        -- Cek apakah karakter ada
        if not char or not head then
            if highlights[plr] then highlights[plr].Enabled = false end
            if labels[plr] then labels[plr].Visible = false end
            return
        end

        -- Cek Filter Tim dari Dropdown UI (State.ESP.Selected)
        local team = plr.Team
        local isKiller = (team and team.Name == "Killer")
        local isSurvivor = (team and team.Name == "Survivors")

        -- Logika Filter: Hanya tampilkan jika timnya dipilih di Dropdown UI
        local isSelected = false
        if isKiller and table.find(State.ESP.Selected, "Killer") then isSelected = true end
        if isSurvivor and table.find(State.ESP.Selected, "Survivor") then isSelected = true end
        
        -- Jika tidak terpilih di UI, sembunyikan
        if not isSelected then
            clearESP(plr)
            return
        end

        -----------------------------------------------------------
        -- WARNA & STATUS (Sinkron dengan kondisi game)
        -----------------------------------------------------------
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

            if item and item ~= "" and item ~= "None" then
                statusText = "[" .. item .. "]"
            end
        end

        -----------------------------------------------------------
        -- RENDER HIGHLIGHT
        -----------------------------------------------------------
        if not highlights[plr] then
            local hl = Instance.new("Highlight")
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = camera
            highlights[plr] = hl
        end
        
        local hl = highlights[plr]
        hl.Adornee = char
        hl.FillColor = color
        hl.FillTransparency = 0.4
        hl.OutlineColor = Color3.new(1, 1, 1)
        hl.Enabled = true

        -----------------------------------------------------------
        -- RENDER TEXT (Name, Dist, Health)
        -----------------------------------------------------------
        if not labels[plr] then
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0, 200, 0, 50)
            bill.StudsOffset = Vector3.new(0, 3, 0)
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
        local dist = ""
        local name = State.ESP.Names and plr.Name or ""
        
        -- Sinkronisasi Jarak (UI Toggle: State.ESP.Studs)
        if State.ESP.Studs then
            local myRoot = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local d = math.floor((head.Position - myRoot.Position).Magnitude)
                dist = " [" .. d .. "m]"
            end
        end

        -- Update Text Final
        txt.Visible = true
        txt.TextColor3 = color
        txt.Text = string.format("%s%s\n%s", name, dist, statusText)
    end

    -- Loop Utama
    RunService.RenderStepped:Connect(function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Players.LocalPlayer then
                updatePlayer(plr)
            end
        end
    end)

    -- Cleanup saat player keluar
    Players.PlayerRemoving:Connect(clearESP)
end
