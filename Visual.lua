return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Aimbot...")
    local State = _G.SharedState
    State.ESP = State.ESP or {}
    State.ESP.Selected = State.ESP.Selected or {}
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

--=====================================================
-- VARIABLES
--=====================================================
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local CoreGui = game:GetService("CoreGui")

    local highlights = {}
    local labels = {}

    --=====================================================
    -- CLEAN FUNCTION
    --=====================================================
    local function clearESP(plr)
        if highlights[plr] then
            highlights[plr]:Destroy()
            highlights[plr] = nil
        end

        if labels[plr] then
            if labels[plr].Parent then
                labels[plr].Parent:Destroy()
            end
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
    -- CREATE ESP
    --=====================================================
    local function createESP(plr)
        if not highlights[plr] then
            local hl = Instance.new("Highlight")
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.FillTransparency = 0.4
            hl.OutlineColor = Color3.new(1,1,1)
            hl.Parent = CoreGui
            highlights[plr] = hl
        end

        if not labels[plr] then
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0, 200, 0, 50)
            bill.StudsOffset = Vector3.new(0, 4, 0)
            bill.AlwaysOnTop = true
            bill.Parent = CoreGui

            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1,0,1,0)
            txt.BackgroundTransparency = 1
            txt.Font = Enum.Font.SourceSansBold
            txt.TextSize = 14
            txt.TextStrokeTransparency = 0
            txt.Parent = bill

            labels[plr] = txt
        end
    end

    --=====================================================
    -- UPDATE PLAYER
    --=====================================================
    local function updatePlayer(plr)
        if not State.ESP.Enabled then
            clearESP(plr)
            return
        end

        local char = plr.Character
        local head = char and char:FindFirstChild("Head")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if not char or not head or not hum then
            clearESP(plr)
            return
        end

        -- ROLE CHECK
        local killerAttr = plr:GetAttribute("SelectedKiller")
        local isKiller = (killerAttr and killerAttr ~= "" and killerAttr ~= "None")
            or (plr.Team and plr.Team.Name == "Killer")

        local selected = State.ESP.Selected or {}

        local allowed =
            (isKiller and table.find(selected, "Killer")) or
            (not isKiller and table.find(selected, "Survivor"))

        if not allowed then
            clearESP(plr)
            return
        end

        createESP(plr)

        -- COLOR
        local color
        if isKiller then
            color = Color3.fromRGB(255, 50, 50)
        else
            color = Color3.fromRGB(0, 255, 120)

            if char:GetAttribute("IsHooked") then
                color = Color3.fromRGB(255, 0, 0)
            elseif char:GetAttribute("Knocked") then
                color = Color3.fromRGB(255, 150, 0)
            end
        end

        -- APPLY
        local hl = highlights[plr]
        hl.Adornee = char
        hl.FillColor = color

        local txt = labels[plr]
        txt.Parent.Adornee = head

        local info = {}

        if State.ESP.Names then
            table.insert(info, plr.Name)
        end

        if State.ESP.Distance then
            local dist = math.floor((head.Position - Camera.CFrame.Position).Magnitude)
            table.insert(info, dist .. "m")
        end

        txt.Text = table.concat(info, "\n")
        txt.TextColor3 = color
    end

    --=====================================================
    -- LOOP (OPTIMIZED)
    --=====================================================
    local running = true

    task.spawn(function()
        while running do
            task.wait(0.1) -- 🔥 lebih ringan dari Heartbeat

            if not Camera then
                Camera = workspace.CurrentCamera
            end

            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    updatePlayer(plr)
                end
            end
        end
    end)

    --=====================================================
    -- EVENTS
    --=====================================================
    Players.PlayerRemoving:Connect(clearESP)

    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            clearESP(plr)
        end)
    end)

    print("ESP Optimized Loaded ✅")
end
