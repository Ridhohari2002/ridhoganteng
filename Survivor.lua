return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Survivor...")

    local LocalPlayer = Players.LocalPlayer
--=====================================================
-- SURVIVOR
--=====================================================
local SurvivorTab = Window:Tab({ 
    Title = "Survivor", 
    Icon = "lucide:heart" 
})

local SurvivorSection = SurvivorTab:Section({
    Title = "Generator Status",
    Opened = true
})
--- Scanning generators yang nantinya auto update dan menampilkan (generator 1, generator 2, generator 3 sampai generator 7)
local GenStatusLabel = SurvivorSection:Paragraph({
    Title = "Generator Progress..,",
    Content = "Initializing scanner..."
})
-------------------------------------------------------
-- FUNCTION: GET ALL GENERATORS
-------------------------------------------------------
local function GetGenerators()
    local gens = {}
    local genFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Generator")
    
    if genFolder then
        -- Loop pertama: Masuk ke folder mesin (contoh: [436])
        for _, mesin in ipairs(genFolder:GetChildren()) do
            -- Loop kedua: Cari GeneratorPoint1-4 di dalam mesin tersebut
            for _, point in ipairs(mesin:GetChildren()) do
                if point.Name:find("GeneratorPoint") then
                    table.insert(gens, point)
                end
            end
        end
    end
    return gens
end

local function UpdateGeneratorStatus()
    local generators = GetGenerators()

    if #generators == 0 then
        GenStatusLabel:SetTitle("No Generators Found")
        GenStatusLabel:SetContent("Map belum load atau nama berbeda.") -- FIXED
        return
    end

    local content = ""
    for i, gen in ipairs(generators) do
        -- Kita tampilkan nama aslinya (GeneratorPoint1, dll) agar jelas mana yang ketemu
        content ..= "📍 " .. gen.Name .. " : FOUND\n"
    end

    GenStatusLabel:SetTitle("Total Generators: " .. #generators)
    GenStatusLabel:SetContent(content) -- FIXED
end

SurvivorSection:Button({
    Title = "Find Nearest Generator",
    Callback = function()
        local character = LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local generators = GetGenerators()
        local nearest = nil
        local shortestDistance = math.huge

        for _, point in ipairs(generators) do
            if point:IsA("BasePart") then
                local dist = (point.Position - hrp.Position).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    nearest = point
                end
            end
        end

        if nearest then
            -- Highlight effect agar tembus tembok
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- FIXED
            highlight.Parent = nearest

            task.delay(5, function()
                if highlight then highlight:Destroy() end
            end)
        else
            print("Tidak ditemukan generator valid.")
        end
    end
})
-----------------------------------------------
--Feature Skill Check
------------------------------------------------
local FeatureSkillCheckSection = SurvivorTab:Section({
    Title = "Skill Check Helper",
    Opened = true
})
FeatureSkillCheckSection:Toggle({
    Title= "Auto Skill Check (Generator & Heal)",
    Value = false,
    Callback = function(v)
            State.AutoSkillCheck = v
            if v then
                print("Auto Skill Check Enabled")
            else
                print("Auto Skill Check Disabled")
            end
        end
    })
    -- Auto Skill Check Connection
    local skillCheckConnection
    
    local function setupSkillCheck()
        -- Disconnect existing connection if any
        if skillCheckConnection then
            skillCheckConnection:Disconnect()
            skillCheckConnection = nil
        end
        
        -- Create new connection if enabled
        if State.AutoSkillCheck then
            skillCheckConnection = RunService.Heartbeat:Connect(function()
                if not State.AutoSkillCheck then return end
                
                -- Auto complete skill checks for generators and healing
                -- This listens for skill check events and automatically succeeds them
                local success, errorMsg = pcall(function()
                    -- Find skill check UI elements
                    local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
                    if not playerGui then return end
                    
                    -- Look for skill check popup
                    local skillCheckPopup = playerGui:FindFirstChild("SkillCheck") or 
                                           playerGui:FindFirstChild("GeneratorSkillCheck") or
                                           playerGui:FindFirstChild("HealSkillCheck")
                    
                    if skillCheckPopup and skillCheckPopup.Enabled then
                        -- Find the skill check button/frame and simulate perfect hit
                        local skillCheckButton = skillCheckPopup:FindFirstChild("Button") or 
                                                skillCheckPopup:FindFirstChild("SkillCheckButton")
                        
                        if skillCheckButton and skillCheckButton.Visible then
                            -- Fire the skill check success event
                            local args = {
                                "success",
                                100, -- Perfect hit
                                workspace:WaitForChild("Map"):WaitForChild("Gens"):FindFirstChild("Generator"),
                                workspace:WaitForChild("Map"):WaitForChild("Gens"):FindFirstChild("Generator"):FindFirstChild("GeneratorPoint")
                            }
                            
                            local skillCheckEvent = ReplicatedStorage:FindFirstChild("Remotes") and
                                                   ReplicatedStorage.Remotes:FindFirstChild("Generator") and
                                                   ReplicatedStorage.Remotes.Generator:FindFirstChild("SkillCheckResultEvent")
                            
                            if skillCheckEvent then
                                skillCheckEvent:FireServer(unpack(args))
                            end
                        end
                    end
                end)
                
                if not success then
                    warn("Error in Auto Skill Check: " .. tostring(errorMsg))
                end
            end)
        end
    end
    
    -- Monitor state changes
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if State.AutoSkillCheck and input.UserInputType == Enum.UserInputType.Keyboard then
            -- Optional: Add keybind to toggle or trigger manual override
        end
    end)
    
    -- Initial setup
    setupSkillCheck()
    
    -- Reconnect when state changes
    local oldAutoSkillCheck = State.AutoSkillCheck
    game:GetService("RunService").Stepped:Connect(function()
        if oldAutoSkillCheck ~= State.AutoSkillCheck then
            oldAutoSkillCheck = State.AutoSkillCheck
            setupSkillCheck()
        end
    end)
    
    -- Cleanup when UI closes
    SurvivorTab:OnDestroy(function()
        if skillCheckConnection then
            skillCheckConnection:Disconnect()
            skillCheckConnection = nil
        end
    end)
end

--=====================================================
-- REPAIR FEATURE
--=====================================================
local RepairSection = SurvivorTab:Section({
    Title = "Repair Automation [🔧]",
    Opened = true
})

RepairSection:Toggle({
    Title = "Auto Repair", -- Nahan interaksi otomatis pas lu deket Gen
    Value = false,
    Callback = function(v)
        State.AutoRepair = v
    end
})

-- Heal (jika knock atau down maka ini auto heal/recovery sendiri tanpa bantuan team)
local HealSection = SurvivorTab:Section({
    Title = "Heal Feature [💉]",
    Opened = true
}) 
HealSection:Toggle({
    Title = "Instant Self-Revive", -- biasanya jika saya knock pasti ada tulisan recovery kita bisa recovery sendiri tapi tidak bisa sampai selesai, dan harus butuh bantuan teman dulu agar kita gak knock lagi jadinya instant heal ini berfungsi tanpa recovery sendiri dan bantuan teman lagi langsung tidak knock lagi
    Value = false,
    Callback = function (v)
        State.InstantHeal = v
    end
})
HealSection:Toggle({
    Title = "Silent Heal",
    Value = false,
    Callback = function (v)
        State.SilentHeal = v
    end
})

-- Tools
local ToolsSection = SurvivorTab:Section({
    Title = "Tools",
    Opened = true
})
-- Fast Gate Tool = mempercepat proses loading pembukaan gate
ToolsSection:Toggle({
    Title = "Fast Gate Tools",
    Value = false,
    Callback = function (v)
        State.FastGate = v
    end
})

-- Survivor Auto Skill 
local SvvAutoSkillSection = SurvivorTab:Section({
    Title = "Survivor Auto Skill",
    Opened = true
})
SvvAutoSkillSection:Toggle({
    Title ="Auto Crouch", -- game:GetService("ReplicatedStorage").Remotes.Mechanics.Crouch
    Value = false,
    Callback = function(v) State.AutoCrouch = v end
})
SvvAutoSkillSection:Toggle({
    Title ="Fast Animations", --- khusus buat lompat di window ketika kita vault auto fast vault game:GetService("ReplicatedStorage").Remotes.Window.fastvault -- game:GetService("ReplicatedStorage").Remotes.Window.VaultEvent --game:GetService("ReplicatedStorage").Remotes.Window.VaultAnim --game:GetService("ReplicatedStorage").Remotes.Window.VaultCompleteEvent -- game:GetService("ReplicatedStorage").Remotes.Window.VaultCompleteEventpart1
    Value = false,
    Callback = function(v) State.FastVault = v end
})
SvvAutoSkillSection:Toggle({
    Title ="No Slowdown",
    Value = false,
    Callback = function(v) State.NoSlowSurv = v end
})
SvvAutoSkillSection:Toggle({
    Title ="Auto Drop Pallete", --game:GetService("ReplicatedStorage").Remotes.Pallet.PalletDropEvent
    Value = false,
    Callback = function(v) State.AutoPallet = v end
})

-- Dagger 
local DaggerSection = SurvivorTab:Section ({
    Title = "Dagger [🔪]",
    Opened = true
})
DaggerSection:Dropdown({
    Title = "Parry Mode",
    Values = {"Animation", "No Animation"},
    Callback = function(v)
        State.ParryMode = v
    end
})
DaggerSection:Slider({
    Title = "Parry Radius",
    Value = {
        Min = 1,
        Max = 100,
        Default = 10,
    },
    Callback = function(v)
        State.ParryRadius = v
    end
})
DaggerSection:Toggle({
    Title = "Auto Parry",
    Value = false,
    Callback = function(v)
        State.AutoParry = v
    end
})

local MiscSurvivorSection = SurvivorTab:Section ({
    Title = "Misc",
    Opened = true
})
MiscSurvivorSection:Button({
    Title = "Instant Escape",
    Callback = function()
        local GateRemote = game:GetService("ReplicatedStorage").Remotes.Exit.gate
        -- Cari objek gerbang di Workspace
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:find("Gate") and obj:IsA("Model") then
                -- Kirim sinyal buka berkali-kali secara instan
                for i = 1, 50 do 
                    GateRemote:FireServer(obj)
                end
            end
        end
        WindUI:Notify({ Title = "Survivor", Content = "Mencoba membuka semua gerbang secara instan!", Duration = 3 })
    end
})
MiscSurvivorSection:Button({
    Title = "Destroy Gates",
    Callback = function()
        -- Fitur ini menghapus objek gerbang secara lokal (Client-Side)
        -- Berguna agar lu bisa lewat meskipun gerbang belum terbuka
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:find("Gate") and (obj:IsA("Model") or obj:IsA("BasePart")) then
                obj:Destroy()
            end
        end
        WindUI:Notify({ Title = "Survivor", Content = "Gerbang dihapus secara lokal! Lu bisa lewat sekarang.", Duration = 3 })
    end
})
end
