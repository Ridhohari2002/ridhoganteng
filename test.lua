local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local HealSkillEvent = remotes:WaitForChild("Healing"):WaitForChild("SkillCheckEvent")
local HealResultEvent = remotes:WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")

print("[Boyfinity] Headless Auto Perfect Heal SkillCheck Loaded!")

-- Mendengarkan instruksi Skill Check dari Server
HealSkillEvent.OnClientEvent:Connect(function(targetCharacter)
    -- Delay mikroskopis 0.05 detik biar gerakan bypass lu nggak kedetek Anti-Cheat
    task.wait(0.05)
    
    -- Kita ubah "neutral" hasil sadapan lu jadi "success"
    -- Kita ubah "0" jadi "5" biar lu dapet bonus poin Perfect
    -- Argumen ketiga ngambil langsung dari target yang lu heal (Model Karakter)
    local args = {
        "success",
        5,
        targetCharacter
    }
    
    -- Tembak server!
    pcall(function()
        HealResultEvent:FireServer(unpack(args))
    end)
