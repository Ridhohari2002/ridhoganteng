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

        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj.Name:lower():find("generator") then
                table.insert(gens, obj)
            end
        end

        return gens
    end

    -------------------------------------------------------
    -- AUTO UPDATE GENERATOR STATUS
    -------------------------------------------------------

    local function UpdateGeneratorStatus()

        local generators = GetGenerators()

        if #generators == 0 then
            GenStatusLabel:SetTitle("No Generators Found")
            GenStatusLabel:SetContent("Map belum load atau nama berbeda.")
        return
        end

        local content = ""

        for i, gen in ipairs(generators) do
            content ..= "Generator "..i.." : FOUND\n"
        end

       GenStatusLabel:SetTitle("Total Generators: " .. #generators)
        GenStatusLabel:SetContent(content)

    end

    -- Update tiap 3 detik biar ringan
    task.spawn(function()
        while true do
            task.wait(3)
            UpdateGeneratorStatus()
        end
    end)

SurvivorSection:Button({
    Title = "Find Nearest Generator",
    Callback = function()
        local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                return
            end

            local hrp = character.HumanoidRootPart
            local generators = GetGenerators()

            local nearest = nil
            local shortestDistance = math.huge

            for _, gen in ipairs(generators) do
                if gen.PrimaryPart then
                    local dist = (gen.PrimaryPart.Position - hrp.Position).Magnitude

                    if dist < shortestDistance then
                        shortestDistance = dist
                        nearest = gen
                    end
                end
            end

            if nearest and nearest.PrimaryPart then
                print("Nearest Generator:", nearest.Name)
                print("Distance:", shortestDistance)

                -- Highlight effect
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(0,255,0)
                highlight.OutlineColor = Color3.fromRGB(255,255,255)
                highlight.Parent = nearest

                task.delay(5, function()
                    highlight:Destroy()
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
    Title= "Auto Skill Check (Gen & Heal)",
    Value = false,
    Callback = function(v)
        State.AutoSkillCheck = v 
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
