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

-- Visual.lua
    -- Inisialisasi State agar tidak error
    State.ESP = State.ESP or {
        Enabled = false,
        Selected = {},
        Names = false,
        Studs = false,
        Health = false
    }

    local cache = {
        Highlights = {},
        Labels = {}
    }

    -- HELPER: Cek Selection
    local function isSelected(name)
        if not State.ESP.Selected then return false end
        for _, v in pairs(State.ESP.Selected) do
            if v == name then return true end
        end
        return false
    end

    -- HELPER: Bersihkan ESP
    local function clearESP(obj)
        if cache.Highlights[obj] then 
            cache.Highlights[obj]:Destroy()
            cache.Highlights[obj] = nil 
        end
        if cache.Labels[obj] then 
            cache.Labels[obj].Parent:Destroy()
            cache.Labels[obj] = nil 
        end
    end

    -- CORE: Apply ESP Logic
    local function applyESP(obj, text, color, isPlayer, hum)
        if not State.ESP.Enabled then 
            clearESP(obj)
            return 
        end

        -- 1. Setup Highlight
        if not cache.Highlights[obj] then
            local hl = Instance.new("Highlight")
            hl.Name = "VD_ESP_HL"
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = camera
            cache.Highlights[obj] = hl
        end
        
        local hl = cache.Highlights[obj]
        hl.Adornee = obj
        hl.FillColor = color
        hl.OutlineColor = Color3.new(1,1,1) -- Outline putih agar tegas
        hl.FillTransparency = 0.5

        -- 2. Setup Billboard (Label)
        if not cache.Labels[obj] then
            local bill = Instance.new("BillboardGui", camera)
            bill.Name = "VD_ESP_LABEL"
            bill.AlwaysOnTop = true
            bill.Size = UDim2.new(0, 160, 0, 50)
            bill.StudsOffset = Vector3.new(0, 3.5, 0)
            
            local lbl = Instance.new("TextLabel", bill)
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.SourceSansBold
            lbl.TextSize = 14
            lbl.TextStrokeTransparency = 0.4
            lbl.RichText = true
            cache.Labels[obj] = lbl
        end

        local lbl = cache.Labels[obj]
        local attach = (obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart"))) or obj
        lbl.Parent.Adornee = attach
        
        -- Logic Content
        local content = ""
        if State.ESP.Names then content = "<b>" .. text .. "</b>" end
        
        if State.ESP.Studs and attach then
            local dist = math.floor((camera.CFrame.Position - attach.Position).Magnitude)
            content = content .. " [" .. dist .. "m]"
        end

        if isPlayer and State.ESP.Health and hum then
            local hpPercent = hum.Health / hum.MaxHealth
            local hpCol = (hpPercent > 0.5) and "#00FF00" or "#FF4444"
            content = content .. "\n<font color='" .. hpCol .. "'>HP: " .. math.floor(hum.Health) .. "</font>"
        end

        lbl.Text = content
        lbl.TextColor3 = color
    end

    -- REFRESH LOOP (Cek Objek Map setiap 2 detik agar tidak LAG)
    task.spawn(function()
        while task.wait(2) do
            if not State.ESP.Enabled then continue end
            
            local map = workspace:FindFirstChild("Map")
            if not map then continue end

            for _, obj in pairs(map:GetDescendants()) do
                -- Gates
                if isSelected("Gates") and (obj.Name == "LeftGate" or obj.Name == "RightGate") then
                    applyESP(obj, "Gate", Color3.fromRGB(200, 200, 220))
                
                -- Generators
                elseif isSelected("Generators") and obj:GetAttribute("RepairProgress") ~= nil then
                    local prog = obj:GetAttribute("RepairProgress")
                    local color = Color3.fromHSV((prog/100) * 0.35, 0.9, 1) -- Merah ke Hijau
                    applyESP(obj, "Generator ("..math.floor(prog).."%)", color)

                -- Pallets
                elseif isSelected("Pallets") and obj.Name:lower():find("pallet") and obj:IsA("Model") then
                    applyESP(obj, "Pallet", Color3.fromRGB(255, 180, 50))

                -- Windows (Fix: Mencari part Bottom di dalam model Window)
                elseif isSelected("Windows") and obj.Name == "Bottom" and obj.Parent.Name:lower():find("window") then
                    applyESP(obj.Parent, "Window", Color3.fromRGB(150, 220, 255))

                -- Hooks
                elseif isSelected("Hooks") and obj.Name:lower() == "hook" and obj:IsA("Model") then
                    applyESP(obj, "Hook", Color3.fromRGB(255, 80, 80))
                end
            end
        end
    end)

    -- FAST LOOP (Untuk Player & Pergerakan)
    RunService.RenderStepped:Connect(function()
        if not State.ESP.Enabled then return end

        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local char = plr.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                local team = plr.Team and plr.Team.Name or ""

                if team == "Killer" and isSelected("Killer") then
                    applyESP(char, plr.Name, Color3.fromRGB(255, 50, 50), true, hum)
                elseif team == "Survivors" and isSelected("Survivor") then
                    applyESP(char, plr.Name, Color3.fromRGB(80, 255, 120), true, hum)
                else
                    clearESP(char)
                end
            end
        end
    end)

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
        Value = false,
        Callback = function(v) 
            State.ESP.Enabled = v 
            if not v then
                -- Hapus semua saat off
                for obj, _ in pairs(cache.Highlights) do clearESP(obj) end
            end
        end
    })

    ESPSection:Toggle({ Title = "Show Names", Value = false, Callback = function(v) State.ESP.Names = v end })
    ESPSection:Toggle({ Title = "Show Distance", Value = false, Callback = function(v) State.ESP.Studs = v end })
    ESPSection:Toggle({ Title = "Show Health", Value = false, Callback = function(v) State.ESP.Health = v end })
end
