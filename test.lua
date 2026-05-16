-- ==========================================
-- 🌟 HEADLESS AUTO SKILL CHECK (HEALING ONLY) 🌟
-- ==========================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local HealSkillEvent = remotes:WaitForChild("Healing"):WaitForChild("SkillCheckEvent")
local HealResultEvent = remotes:WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")
local healRemote = remotes:WaitForChild("Healing"):WaitForChild("HealEvent")

local currentHealTargetHRP = nil

-- Aktif otomatis saat dieksekusi
_G.HeadlessHealOnly = true
print("🟢 Headless Auto Skillcheck HEALING AKTIF!")

HealSkillEvent.OnClientEvent:Connect(function(incomingArg) 
    if _G.HeadlessHealOnly then
        local targetChar = nil
        local targetHRP = nil
        
        -- Deteksi otomatis apakah server ngirim Model atau BasePart
        if typeof(incomingArg) == "Instance" then
            if incomingArg:IsA("Model") and incomingArg:FindFirstChild("Humanoid") then
                targetChar = incomingArg
                targetHRP = incomingArg:FindFirstChild("HumanoidRootPart")
            elseif incomingArg:IsA("BasePart") and incomingArg.Parent:FindFirstChild("Humanoid") then
                targetChar = incomingArg.Parent 
                targetHRP = incomingArg
            end
        end
        
        -- Kalau target valid, eksekusi skillcheck
        if targetChar and targetHRP then
            currentHealTargetHRP = targetHRP
            
            -- [PENTING] DELAY DITAMBAH: 0.75 - 1.2 detik.
            -- Biar server mengira jarum skillcheck sudah benar-benar masuk area hijau.
            task.wait(math.random(75, 120) / 100)
            
            -- Kita kembalikan ke "success", 1 karena "neutral", 0 adalah fail/miss
            pcall(function() 
                HealResultEvent:FireServer("success", 1, targetChar) 
                print("✅ [DEBUG] Auto Heal (Success) Ditembak ke: " .. targetChar.Name)
            end)
        else
            warn("❌ [DEBUG] Auto Heal Gagal! Target tidak ditemukan.")
        end
    end
end)

-- ==========================================
-- ANTI-NYANGKUT (CANCEL SAAT GERAK WASD)
-- ==========================================
RunService.Heartbeat:Connect(function()
    if not _G.HeadlessHealOnly then return end
    
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    -- Jika player bergerak (Input dari Joystick HP / WASD)
    if hum and hum.MoveDirection.Magnitude > 0 then
        -- Lepas interaksi Healing
        if currentHealTargetHRP then
            pcall(function() healRemote:FireServer(currentHealTargetHRP, false) end)
            currentHealTargetHRP = nil
        end
    end
end)
