-- ==========================================
-- 🌟 HEADLESS AUTO SKILL CHECK (HEALING ONLY - FIX) 🌟
-- ==========================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local HealSkillEvent = remotes:WaitForChild("Healing"):WaitForChild("SkillCheckEvent")
local HealResultEvent = remotes:WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")
local healRemote = remotes:WaitForChild("Healing"):WaitForChild("HealEvent")

local currentHealCharacter = nil

-- Aktif otomatis saat dieksekusi
_G.HeadlessHealOnly = true
print("🟢 Headless Auto Skillcheck HEALING AKTIF!")

-- ==========================================
-- AUTO SUCCESS HEALING (ECHO TARGET)
-- ==========================================
HealSkillEvent.OnClientEvent:Connect(function(target)
    if not _G.HeadlessHealOnly then
        return
    end

    if typeof(target) ~= "Instance" then
        return
    end

    -- Simpan Character untuk fitur Anti-Nyangkut
    currentHealCharacter = target

    -- Delay natural agar tidak instan
    task.wait(math.random(25, 45) / 100)

    pcall(function()
        HealResultEvent:FireServer(
            "neutral",
            0,
            target
        )
        print("✅ [DEBUG] Heal Success ditembak ke:", target)
    end)
end)

-- ==========================================
-- ANTI-NYANGKUT (CANCEL SAAT GERAK WASD)
-- ==========================================
RunService.Heartbeat:Connect(function()
    if not _G.HeadlessHealOnly then return end
    
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    -- Jika player bergerak
    if hum and hum.MoveDirection.Magnitude > 0 then
        if currentHealCharacter then
            pcall(function()
                healRemote:FireServer(currentHealCharacter, false)
                print("🛑 [DEBUG] Heal Dibatalkan karena gerak WASD")
            end)
            currentHealCharacter = nil
        end
    end
end)
