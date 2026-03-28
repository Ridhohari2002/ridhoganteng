return function(Window, State, Players, RunService)
    print("Mencoba memuat Tab Survivor...")

    local State = _G.SharedState
    local LocalPlayer = Players.LocalPlayer
    
--=====================================================
-- SURVIVOR UI: GENERATOR STATUS
--=====================================================
local SurvivorTab = Window:Tab({ Title = "Survivor", Icon = "lucide:heart" })
local SurvivorSection = SurvivorTab:Section({ Title = "Generator Status", Opened = true })

local GenStatusLabel = SurvivorSection:Paragraph({
    Title = "Generator Progress",
    Content = "Scanning..."
})

-- Auto-Update Label UI
task.spawn(function()
    while task.wait(1) do -- Update UI setiap 1 detik agar tidak lag
        local content = ""
        local data = State.GeneratorData or {}

        if #data == 0 then
            GenStatusLabel:SetDesc("Waiting for map to load...")
        else
            for _, info in ipairs(data) do
                content ..= string.format("📍 %s: %d%% [%s]\n", info.Name, info.Progress, info.Status)
            end
            GenStatusLabel:SetTitle("Total Generators: " .. #data)
            GenStatusLabel:SetDesc(content)
        end
    end
end)

SurvivorSection:Button({
    Title = "Teleport Nearest Generator",
    Callback = function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local nearest = nil
        local shortestDistance = math.huge

        for _, info in ipairs(State.GeneratorData) do
            local genPart = info.Instance.PrimaryPart or info.Instance:FindFirstChildWhichIsA("BasePart")
            if genPart then
                local dist = (genPart.Position - hrp.Position).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    nearest = genPart
                end
            end
        end

        if nearest then
            -- Teleport player ke atas generator (ditambah Y: 3 agar tidak nyangkut di dalam mesin)
            hrp.CFrame = nearest.CFrame + Vector3.new(0, 10, 0)
            WindUI:Notify({Title = "Survivor", Content = "Teleported to Nearest Generator!", Duration = 2})
        end
    end
})
--==============================================
-- Feature Skill Check
--==============================================
local FeatureSkillCheckSection = SurvivorTab:Section({
    Title = "Feature SkillCheck",
    Opened = true
})

FeatureSkillCheckSection:Toggle({
    Title= "Generator SkillCheck",
    Value = false,
    Callback = function(v)
        State.GenSkillCheck = v
        if v then
            print("Generator SkillCheck Enabled")
        else
            print("Generator SkillCheck Disabled")
        end
    end
})

FeatureSkillCheckSection:Toggle({
    Title= "Healing SkillCheck",
    Value = false,
    Callback = function(v)
        State.HealSkillCheck = v
        if v then
            print("Healing SkillCheck Enabled")
        else
            print("Healing SkillCheck Disabled")
        end
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
    Title = "Instant Heal (1 click)",
    Value = State.InstantHeal or false,
    Callback = function(v)
        State.InstantHeal = v
        if not v then
            -- Memaksa server mereset status healing agar tidak bug animasi
            pcall(ForceResetHeal)
        end
    end
})
-- Toggle Silent Heal
SvvAutoSkillSection:Toggle({
    Title = "Silent Heal (No Sound)",
    Value = State.SilentHeal or false,
    Callback = function(v)
        State.SilentHeal = v
    end
})

SvvAutoSkillSection:Toggle({
    Title ="Auto Crouch", -- game:GetService("ReplicatedStorage").Remotes.Mechanics.Crouch
    Value = false,
    Callback = function(v) State.AutoCrouch = v end
})

SvvAutoSkillSection:Toggle({
    Title = "Fast Vault",
    Value = State.FastVault or false,
    Callback = function(v)
        State.FastVault = v
        WindUI:Notify({
            Title = "Survivor",
            Content = v and "Fast Vault Enabled!" or "Fast Vault Disabled!",
            Duration = 2
        })
    end
})

SvvAutoSkillSection:Toggle({
    Title ="No Slowdown",
    Value = false,
    Callback = function(v) State.NoSlowSurv = v end
})
SvvAutoSkillSection:Toggle({
    Title = "Auto Pallet (Auto Space)",
    Value = false,
    Callback = function(v)
        State.AutoPallet = v
    end
})

-- Tambahkan di Survivor.lua
SvvAutoSkillSection:Toggle({
    Title = "Auto Dodge Abysswalker",
    Value = State.AutoDodge or false,
    Callback = function(v)
        State.AutoDodge = v
        if v then
            WindUI:Notify({
                Title = "Dodge System",
                Content = "Auto Crouch for Abysswalker Active!",
                Duration = 3
            })
        end
    end
})
-- Dagger Section (Survivor.lua)
local DaggerSection = SurvivorTab:Section ({
    Title = "Dagger (Advanced Parry) [八]",
    Opened = true
})

DaggerSection:Keybind({
    Title = "Auto Parry Toggle Key",
    Description = "Tekan tombol ini untuk On/Off Auto Parry",
    Key = "C", -- Default Key
    Callback = function(key)
        State.AutoParry = not State.AutoParry
        WindUI:Notify({
            Title = "Dagger [八]",
            Content = State.AutoParry and "Auto Parry: ON" or "Auto Parry: OFF",
            Duration = 2
        })
    end
})

DaggerSection:Toggle({
    Title = "Auto Parry",
    Value = State.AutoParry or false,
    Callback = function(v)
        State.AutoParry = v
    end
})

DaggerSection:Toggle({
    Title = "Aim Prediction",
    Description = "Mendeteksi ayunan bahkan saat Killer nge-dash/flick dengan membaca velocity-nya.",
    Value = State.AimPrediction or false,
    Callback = function(v)
        State.AimPrediction = v
    end
})

DaggerSection:Slider({
    Title = "Face Killer Sensitivity",
    Description = "Seberapa lurus Killer harus menghadap ke lu?\n100 = Harus pas depan muka\n0 = Bisa parry serangan dari samping",
    Value = { Min = 0, Max = 100, Default = 70 },
    Callback = function(v)
        State.KillerAimSensitivity = v
    end
})

DaggerSection:Slider({
    Title = "Player Aim Strictness",
    Description = "Seberapa lurus LU harus menghadap ke Killer?\n100 = Lu harus aim ke killer\n0 = Bisa parry walau lu ngebelakangin killer (OP)",
    Value = { Min = 0, Max = 100, Default = 0 },
    Callback = function(v)
        State.PlayerAimStrictness = v
    end
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
    Value = { Min = 1, Max = 50, Default = 15 },
    Callback = function(v)
        State.ParryRadius = v
    end
})

DaggerSection:Toggle({
    Title = "Show Killer Aim (Visualizer)",
    Description = "Menampilkan garis laser merah dari Killer untuk melihat batas jangkauan Sensitivity.",
    Value = State.ShowKillerAim or false,
    Callback = function(v)
        State.ShowKillerAim = v
    end
})

local DashSection = SurvivorTab:Section({
    Title = "Flash Step [⚡]",
    Opened = true
})

DashSection:Toggle({
    Title = "Instant Flash Escape",
    Value = false,
    Callback = function(v)
        State.InstantDash = v
    end
})

DashSection:Slider({
    Title = "Instant Flash Distance",
    Value = { Min = 5, Max = 50, Default = 20 },
    Callback = function(v)
        State.DashDistance = v
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

local GodSection = SurvivorTab:Section({
    Title = "Survival [🛡️]",
    Opened = true
})

GodSection:Toggle({
    Title = "Bypass Anti-Camp (not work)",
    Value = State.BypassAntiCamp or false,
    Callback = function(v)
        State.BypassAntiCamp = v
        if v then
            WindUI:Notify({
                Title = "Bypass Active",
                Content = "Progress will run even if Killer is far!",
                Duration = 3
            })
        end
    end
})
GodSection:Toggle({
    Title = "God Mode (Eksperimental)",
    Value = State.GodMode or false,
    Callback = function(v)
        State.GodMode = v
        if v then
            WindUI:Notify({Title = "Survival", Content = "Be careful of Void.", Duration = 3})
        end
    end
})
end
