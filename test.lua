local function startProfessionalLoader()
    local UserInputService = game:GetService("UserInputService")
    -- Deteksi apakah device memiliki layar sentuh (Mobile)
    local isMobile = UserInputService.TouchEnabled

    local asciiArt = ""
    local barFilled = ""
    local barEmpty = ""

    
    if isMobile then
        -- 🔥 Versi Mobile (Ramping & Aman dari Word Wrap)
        asciiArt = [[
  _                 __ _       _ _         
 | |__   ___  _   _/ _(_)_ __ (_) |_ _   _ 
 | '_ \ / _ \| | | | |_| | '_ \| | __| | | |
 | |_) | (_) | |_| |  _| | | | | | |_| |_| |
 |_.__/ \___/ \__, |_| |_|_| |_|_|\__|\__, |
              |___/                   |___/ 
        ]]
        barFilled = "="
        barEmpty = "-"
    else
        -- 💻 Versi PC (Lebar & Menggunakan Karakter Balok BOYFINITY)
        asciiArt = [[
        
    ██████╗  ██████╗ ██╗   ██╗ ███████╗ ██╗ ███╗   ██╗ ██╗ ████████╗ ██╗   ██╗
    ██╔══██╗██╔═══██╗╚██╗ ██╔╝ ██╔════╝ ██║ ████╗  ██║ ██║ ╚══██╔══╝ ╚██╗ ██╔╝
    ██████╔╝██║   ██║ ╚████╔╝  █████╗   ██║ ██╔██╗ ██║ ██║    ██║     ╚████╔╝ 
    ██╔══██╗██║   ██║  ╚██╔╝   ██╔══╝   ██║ ██║╚██╗██║ ██║    ██║      ╚██╔╝  
    ██████╔╝╚██████╔╝   ██║    ██║      ██║ ██║ ╚████║ ██║    ██║       ██║   
    ╚═════╝  ╚═════╝    ╚═╝    ╚═╝      ╚═╝ ╚═╝  ╚═══╝ ╚═╝    ╚═╝       ╚═╝  
        ]]
        barFilled = "█"
        barEmpty = "░"
    end

    print(asciiArt)
    print("---------------------------------------------------------")
    print("System: Boyfinity v3.0.2B")
    print("User: " .. game.Players.LocalPlayer.Name .. "")
    print("---------------------------------------------------------")

    local stages = {
        {percent = 5, status = "Checking server files"},
        {percent = 10, status = "Loading Core"},
        {percent = 25, status = "Building UI"},
        {percent = 50, status = "Adding features"},
        {percent = 75, status = "Anti Debug"},
        {percent = 85, status = "Randomizing"},
        {percent = 90, status = "Secure Boot"},
        {percent = 95, status = "Checking HWID"},
        {percent = 100, status = "Successfully Loaded!"},
    }

    for _, stage in ipairs(stages) do
        local progress = stage.percent / 5
        -- Menggunakan simbol yang sudah disesuaikan dengan platform
        local bar = string.rep(barFilled, progress) .. string.rep(barEmpty, 20 - progress)
        warn(string.format("[%s] %d%% | %s", bar, stage.percent, stage.status))
        task.wait(0.5) 
    end

    print("---------------------------------------------------------")
    print(" BOYFINITY SUCCESSFULLY LOADED! ENJOY, BRO.")
    print("---------------------------------------------------------")
end

task.spawn(startProfessionalLoader)

--=====================================================
-- SERVICES
--=====================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local map = workspace:WaitForChild("Map")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


repeat wait() until LocalPlayer
--=====================================================
-- GLOBAL STATE
--=====================================================
_G.SharedState = _G.SharedState or {

    IsPremium = true, -- Set to false if you want to test non-premium features (will show notifications for locked features)
    --Killer Features
    InfiniteLunge = false,
    NoCooldown = false,
    DoubleSwing = false,
    HitboxEnabled = false,
    HitboxSize = 10,
    HitboxTransparency = 0.5,
    AutoBreak = false,
    NoStun = false,
    AntiBlind = false,
    NoSlow = false,
    AttackMode = "Legit",
    SpamHitCount = 10,
    KillAura = false,
    SpearSilentAim = false,
    SpearDropComp = false,
    SpearGravity = 100,
    SpearSpeed = 100,
    ThroughTheVeil = false,
    SnapLine = true,
    HookSpam = false,
    HookAmount = 10,
    SilentHook = false,
    ForceKillCarried = false,
    


    --Survivor
    GeneratorData = {},
    PerfectSkillCheck = false,
    NoSkillCheck = false,
    InstantHeal = false,
    SilentHeal = false,
    FastGate = false,
    AntiCampFollow = false,
    FastVault = false,
    NoSlowSurv = false,
    AutoPallet = false,
    -- Survivor (Dagger / Parry Settings)
    AutoParry = false,
    FaceKillerSens = -1.0,
    AimPrediction = true,
    AimStrictness = 2.6,
    FakeParry = false,
    DefensiveReflexDelay = 0,
    ParryMode = "Animation",
    ParryRadius = 15,
    ShowKillerAim = false,
    GodMode = false,
    AutoDodge = false,
    InstantDash = false,
    DashDistance = false,
    AutoRepair = false,
    RepairMethod = "Legit",
    PanicEscape = false,
    KillerDistance = 30,
    InstantSelfHeal = false,
    SelfHealKey = Enum.KeyCode.H,
    BypassLever = false,
    ShowKillerAim = false,
    AutoRun = false,

    SelectedEmote = "Wave",
    EmotePlaying = false,
    RainbowTrail = false,
    EmoteKeybind = false,
    GenTPMode = "Nearest", -- "Nearest" or "SafeSpot"
    EnableGenTP = false,


    --Aimbot
    AimbotEnabled = false,
    AimbotThroughWall = false,
    AimbotToggleMode = false,
    AimbotKeybind = Enum.KeyCode.E,
    EnableCrosshair = true,
    FlashlightAimbot = false,
    InfiniteFlashlight = false,
    TwistOfFateAimbot = false,   -- Twist of Fate homing missile aimbot
    ToFSilentAim = false,
    TargetTeam = "Killer",       -- "Killer" or "Survivor"
    ShowFOV = false,
    AimbotFOV = 150,
    FilledFOV = false,
    IgnoreKnocked = false,        -- Abaikan survivor yang sudah terkena hit (knocked)
    TeamCheck = false,           -- Hanya target musuh (misal: survivor hanya target killer)


    --visual
    FullBright = false,
    NoFog = false,
    CustomTime = false,
    SpectatorList = false,
    ESP = {
        Enabled = false,
        Names = false,
        Selected = {
            ["Killer"] = true, 
            ["Survivor"] = true, 
            ["Generators"] = true, 
            ["Gates"] = true, 
            ["Pallets"] = true, 
            ["Windows"] = true, 
            ["Hooks"] = true
        },
        Studs = false,
        
    },

    --Movement
    Movement = {
        SpeedEnabled = false,
        SpeedValue = 1.03,
        NoClip = false,
        MaxZoomValue = 500,
        FOVValue = 70,
        FlyEnabled = false,
        FlyKey = Enum.KeyCode.O,
        FlySpeed = 50,
    },

    Misc = {
        AntiAFK = true,
        AntiFling = false,
        TouchFling = false,
        AntiAdmin = false,
        InvisFling = false,
        AOEFling = false,
        FlingRadius = 10
    },

    PotatoMode = false,
    EnableDash = false,
    DashKey = Enum.KeyCode.Q,
    DashSpeed = 80




}

--=====================================================
-- PC & MOBILE INPUT BRIDGE FUNCTION
--=====================================================

local State = _G.SharedState

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

-- Fungsi jembatan PC & Mobile
local function TriggerAction(pcKey, mobileButton)
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local isMobile = playerGui and playerGui:FindFirstChild("Survivor-mob")

    if isMobile and mobileButton then
        -- [MODE MOBILE] Simulasikan klik pada tombol layar
        if firesignal then
            pcall(function()
                firesignal(mobileButton.MouseButton1Down)
                firesignal(mobileButton.MouseButton1Click)
                firesignal(mobileButton.MouseButton1Up)
            end)
        end
    else
        -- [MODE PC] Pakai Virtual Input Manager (VIM)
        if pcKey then
            VIM:SendKeyEvent(true, pcKey, false, game)
            task.wait(0.01)
            VIM:SendKeyEvent(false, pcKey, false, game)
        end
    end
end


--=====================================================
-- LOGIC: EMOTE SYSTEM DATA & FUNCTIONS
--=====================================================
_G.EmoteData = {
    ["24 Hour Cinderella"] = {anim = "137195203725366", sound = "121099446613414"},
    ["Applause"]           = {anim = "96328361165090",  sound = "115490787020749"},
    ["Arm Swing"]          = {anim = "80552139463944",  sound = "74216458932348"},
    ["California Girls"]   = {anim = "123552803041504", sound = "87899327891544"},
    ["Ghoul"]              = {anim = "130415594909401", sound = "123004139176580"},
    ["Kyoufuu"]            = {anim = "137322894494527", sound = "129064643026442"},
    ["Mannrobics"]         = {anim = "134677515695156", sound = "109596159930017"},
    ["Quick Combo"]        = {anim = "105592621576604", sound = "88505795419631"},
    ["Schadenfreude"]      = {anim = "138303785534052", sound = "92070710839040"},
    ["Static"]             = {anim = "95096724457263",  sound = "70950516511572"},
    ["Thriller"]           = {anim = "99835792883875",  sound = "139985043810748"},
    ["Tor Monitor Ketua"]  = {anim = "81792358514569",  sound = "72665050838808"},
    ["Wave"]               = {anim = "99670106766588",  sound = nil},
    ["Backflip"]           = {anim = "74705617908505",  sound = nil},
    ["Go0n"]                = {special = "Troll"}
}

local currentTrack = nil
local currentSound = nil
local trollLoop = nil

_G.playCustomEmote = function(name)
    local data = _G.EmoteData[name]
    if not data then return end

    local char = game.Players.LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if humanoid then
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
        if _G.stopEmote then _G.stopEmote() end

        -- Troll Logic
        if data.special == "Troll" then
            local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
            local anim = Instance.new("Animation")
            anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
            currentTrack = animator:LoadAnimation(anim)
            
            trollLoop = task.spawn(function()
                while currentTrack do
                    currentTrack:Play()
                    currentTrack:AdjustSpeed(isR15 and 0.7 or 0.65)
                    currentTrack.TimePosition = 0.6
                    task.wait(0.1)
                    if currentTrack then currentTrack:Stop() end
                    task.wait(0.01)
                end
            end)
            return 
        end

        -- Normal Animation
        local animInstance = Instance.new("Animation")
        animInstance.AnimationId = "rbxassetid://" .. data.anim
        currentTrack = animator:LoadAnimation(animInstance)
        currentTrack.Looped = true
        currentTrack:Play()

        if data.sound and root then
            currentSound = Instance.new("Sound", root)
            currentSound.SoundId = "rbxassetid://" .. data.sound
            currentSound.Volume = 2
            currentSound.Looped = true
            currentSound:Play()
        end
    end
end

_G.stopEmote = function()
    if trollLoop then task.cancel(trollLoop); trollLoop = nil end
    if currentTrack then currentTrack:Stop(); currentTrack:Destroy(); currentTrack = nil end
    if currentSound then currentSound:Stop(); currentSound:Destroy(); currentSound = nil end
end

--=====================================================
-- HELPER: SYNC VISUALS (SINKRONISASI PC & MOBILE)
--=====================================================
local function UpdateMoonwalkUI()
    if not _G.MoonwalkUI then return end
    local Frame = _G.MoonwalkUI:FindFirstChild("Frame", true)
    if not Frame then return end

    local FaceBtn = Frame:FindFirstChild("FaceUserBtn")
    local NormBtn = Frame:FindFirstChild("NormalBtn")

    if FaceBtn and NormBtn then
        if State.MoonwalkActive then
            -- MJ Mode Aktif: Panah Atas Ungu, Bawah Abu
            FaceBtn.ImageColor3 = Color3.fromRGB(188, 0, 255)
            NormBtn.ImageColor3 = Color3.fromRGB(150, 150, 150)
        else
            -- Normal Mode Aktif: Panah Bawah Ungu, Atas Abu
            NormBtn.ImageColor3 = Color3.fromRGB(188, 0, 255)
            FaceBtn.ImageColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
end

--=====================================================
-- OPTIMIZATION: DYNAMIC GLOBAL OBJECT CACHE
--=====================================================
-- 🔥 FIX: Tambahkan Levers = {} di pendaftaran awal
local ObjectCache = { Generators = {}, Gates = {}, Pallets = {}, Hooks = {}, Windows = {}, PalletPoints = {}, Levers = {} }

task.spawn(function()
    while task.wait(2) do
        local currentMap = workspace:FindFirstChild("Map")
        if currentMap then
            -- 🔥 FIX: Tambahkan Levers = {} di refresh cache tiap 2 detik
            local newCache = { Generators = {}, Gates = {}, Pallets = {}, Hooks = {}, Windows = {}, PalletPoints = {}, Levers = {} }
            local descendants = currentMap:GetDescendants()
            
            for i, child in ipairs(descendants) do
                -- 🔥 FIX: Kasih CPU nafas tiap nge-scan 150 objek biar ga patah-patah
                if i % 150 == 0 then RunService.Heartbeat:Wait() end

                local nama = child.Name:lower()
                local fullPath = child:GetFullName()
                
                local isBlacklisted = fullPath:find("Rooftop.Details.Window") or nama:find("entrance") or fullPath:lower():find("entrance")
                
                if child:IsA("Model") or child:IsA("Folder") then
                    if child:IsA("Model") and child:GetAttribute("RepairProgress") ~= nil then 
                        newCache.Generators[child] = true
                    elseif nama:find("pallet") and not nama:find("crate") and not isBlacklisted then 
                        newCache.Pallets[child] = true
                    elseif nama == "hook" then 
                        newCache.Hooks[child] = true
                    elseif nama:find("window") and not isBlacklisted then 
                        newCache.Windows[child] = true
                    elseif nama == "exitlever" then 
                        newCache.Levers[child] = true
                    end
                elseif child:IsA("BasePart") then
                    if child.Name == "LeftGate" or child.Name == "RightGate" then 
                        newCache.Gates[child] = true
                    elseif nama == "bottom" and not isBlacklisted then 
                        newCache.Windows[child] = true
                    elseif nama == "palletpoint" or nama == "palletpointslide" then 
                        newCache.PalletPoints[child] = true 
                    end
                end
            end
            ObjectCache = newCache
        end
    end
end)

--=====================================================
-- OBSIDIAN UI INTEGRATION
--=====================================================
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()


SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings() -- Agar tema tidak tertimpa saat ganti config
SaveManager:SetIgnoreIndexes({ "MenuKeybind" }) -- Abaikan keybind menu agar tidak ter-reset
SaveManager:SetFolder("BoyfinityVD") -- Nama folder di folder workspace kamu

local Window = Library:CreateWindow({
    Title = "boyfinity",
    Icon = 120508213351603,
    Font = Enum.Font.Gotham,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    ToggleKeybind = Enum.KeyCode.G,
    ShowMobileButtons = true,
    MobileButtonsSide = "Left",
    Footer = "v3.0.2B | discord.gg/boyfinity" 

})

local oldNotify = Library.Notify
function Library:Notify(self, data, time)
    if type(data) == "string" then
        oldNotify(self, data, 1)
    elseif type(data) == "table" then
        data.Time = 1
        oldNotify(self, data)
    end
end


--=====================================================
-- 1. KILLER TAB
--=====================================================
local KillerTab = Window:AddTab("Killer", "sword")

local AttackGB = KillerTab:AddLeftGroupbox("Attack","swords")
AttackGB:AddToggle("InfiniteLunge", { 
    Text = "Infinite Lunge", 
    Default = State.InfiniteLunge, 
    Tooltip = "Endless attacks, bypasses animation delay between swings.",
    Callback = function(v) 
        State.InfiniteLunge = v 
        if v then Library:Notify("Infinite Lunge Activated!") end
    end 
})
AttackGB:AddToggle("NoCooldown", { 
    Text = "No Cooldown Attack", 
    Default = State.NoCooldown, 
    Tooltip = "Removes attack cooldown delay (fast swing).",
    Callback = function(v) 
        State.NoCooldown = v 
        if v then Library:Notify("No Cooldown Attack Activated!") end
    end 
})
AttackGB:AddToggle("DoubleSwing", { 
    Text = "Double Swing", 
    Default = State.DoubleSwing, 
    Tooltip = "Deals double damage in a single attack click.",
    Callback = function(v) 
        State.DoubleSwing = v 
        if v then Library:Notify("Double Swing Activated!") end
    end 
})


local HitboxGB = KillerTab:AddLeftGroupbox("Hitbox", "target")
HitboxGB:AddSlider("HitboxTransparency", { 
    Text = "Set Transparency", 
    Default = 0.5, Min = 0, Max = 1, Rounding = 1, 
    Tooltip = "Adjusts the transparency of the enemy hitbox.",
    Callback = function(v) State.HitboxTransparency = v end 
})
HitboxGB:AddSlider("HitboxSize", { 
    Text = "Size Hitbox", 
    Default = 10, Min = 2, Max = 50, Rounding = 0, 
    Tooltip = "Adjusts the size of the enemy hitbox.",
    Callback = function(v) State.HitboxSize = v end 
})
HitboxGB:AddToggle("HitboxEnabled", { 
    Text = "Enable Hitbox", 
    Default = State.HitboxEnabled, 
    Tooltip = "Expands the enemy's body area making them much easier to hit.",
    Callback = function(v) 
        State.HitboxEnabled = v 
        if v then Library:Notify("Hitbox Expander Activated!") end
        if not v and State.ResetHitbox then State.ResetHitbox() end
    end 
})

local MiscKillerGB = KillerTab:AddLeftGroupbox("Misc", "wrench")
MiscKillerGB:AddToggle("AutoBreak", { 
    Text = "Auto Break Generator", 
    Default = State.AutoBreak, 
    Tooltip = "Automatically damages generators near you.",
    Callback = function(v) 
        State.AutoBreak = v 
        if v then Library:Notify("Auto Break Generator Activated!") end
    end 
})
MiscKillerGB:AddToggle("NoStun", { 
    Text = "No Pallet Stun", 
    Default = State.NoStun, 
    Tooltip = "Prevents your character from getting stunned by dropped pallets.",
    Callback = function(v) 
        State.NoStun = v 
        if v then Library:Notify("Anti Pallet Stun Activated!") end
    end 
})
MiscKillerGB:AddToggle("AntiBlind", { 
    Text = "Anti Flashlight", 
    Default = State.AntiBlind, 
    Tooltip = "Removes the white screen (blind) effect from survivor flashlights.",
    Callback = function(v) 
        State.AntiBlind = v 
        if v then Library:Notify("Anti Flashlight Activated!") end
    end 
})
MiscKillerGB:AddToggle("NoSlow", { 
    Text = "Anti Slowdown", 
    Default = State.NoSlow, 
    Tooltip = "Prevents movement speed reduction while attacking or carrying a survivor.",
    Callback = function(v) 
        State.NoSlow = v 
        if v then Library:Notify("Anti Slowdown Activated!") end
    end 
})
MiscKillerGB:AddDivider()
MiscKillerGB:AddButton({ 
    Text = "Destroy All Pallets", 
    Tooltip = "Destroys all pallets on the map locally.",
    Func = function()
        local count = 0
        -- Menghapus pallet dari cache yang sudah kita buat
        for pallet in pairs(ObjectCache.Pallets) do
            if pallet and pallet.Parent then
                pallet:Destroy()
                count = count + 1
            end
        end
        Library:Notify(count .. " The pallets are destroyed locally! Just break through, bro.")
    end 
})
MiscKillerGB:AddDivider()
MiscKillerGB:AddToggle("HookSpam", { 
    Text = "Hook Spam", 
    Default = State.HookSpam, 
    Tooltip = "Repeatedly hooks a survivor extremely fast (remote spam).",
    Callback = function(v) 
        State.HookSpam = v 
        if v then Library:Notify("Hook Spam Activated!") end
    end 
})
MiscKillerGB:AddSlider("HookAmount", { 
    Text = "Hook Amount", 
    Default = 10, Min = 1, Max = 50, Rounding = 0, 
    Tooltip = "Amount of hook events executed per spam.",
    Callback = function(v) State.HookAmount = v end 
})
MiscKillerGB:AddToggle("SilentHook", { 
    Text = "Silent Hook", 
    Default = State.SilentHook, 
    Tooltip = "Forcefully removes the hooking animation for an instant process.",
    Callback = function(v) 
        State.SilentHook = v 
        if v then Library:Notify("Silent Hook Activated!") end
    end 
})
MiscKillerGB:AddToggle("ForceKillCarried", { 
    Text = "Force Kill Carried", 
    Default = State.ForceKillCarried, 
    Tooltip = "Instantly kills the carried survivor by exploiting the hook remote.",
    Callback = function(v) 
        State.ForceKillCarried = v 
        if v then Library:Notify("Force Kill Carried Activated!") end
    end 
})

local KillAuraGB = KillerTab:AddRightGroupbox("Kill Aura", "skull")

KillAuraGB:AddToggle("KillAura", { 
    Text = "Kill Aura", 
    Default = false, 
    Tooltip = "Fully automates detecting, attacking, carrying, and hooking nearby survivors.",
    Callback = function(v) 
        State.KillAura = v 
        if v then Library:Notify("Kill Aura Activated!") end
    end 
}):AddKeyPicker("KillAuraKey", { 
    Default = "...", 
    SyncToggleState = true, 
    Text = "Kill Aura Bind" 
})

KillAuraGB:AddDropdown("AttackMode", { 
    Text = "Attack Mode", 
    Default = "Legit", 
    Values = {"Legit", "Teleport"}, 
    Tooltip = "Kill Aura attack method. Legit = waits for enemy to get close. Teleport = auto teleports to enemy.",
    Callback = function(v) State.AttackMode = v end 
})

KillAuraGB:AddSlider("SpamHitCount", { 
    Text = "Spam Hit Count", 
    Default = 1, 
    Min = 1, 
    Max = 10, 
    Rounding = 0, 
    Tooltip = "Number of hit signals sent to the server per attack.",
    Callback = function(v) State.SpamHitCount = v end 
})

--=====================================================
-- 2. SURVIVOR TAB
--=====================================================
local SurvivorTab = Window:AddTab("Survivor","user")

local GenStatusGB = SurvivorTab:AddLeftGroupbox("Generator Status", "activity")
local GenStatusLabel = GenStatusGB:AddLabel({
    Text = "Scanning for generators...",
    DoesWrap = true,
})

task.spawn(function()
    while task.wait(1) do
        local data = State.GeneratorData or {}
        if #data == 0 then
            GenStatusLabel:SetText("Waiting for map to load...")
        else
            local content = ""
            -- Loop lompat 2 langkah untuk bikin baris berpasangan
            for i = 1, #data, 2 do
                local g1 = data[i]
                local g2 = data[i+1]

                -- Format Gen pertama
                local str1 = string.format("Gen %d: %d%% %s", i, g1.Progress, g1.Progress >= 100 and "✔️" or "🛠️")
                local line = str1

                -- Kalau ada Gen pasangannya, tambahin di sampingnya
                if g2 then
                    local str2 = string.format(" | Gen %d: %d%% %s", i+1, g2.Progress, g2.Progress >= 100 and "✔️" or "🛠️")
                    line = line .. str2
                end
                content = content .. line .. "\n"
            end
            GenStatusLabel:SetText(content)
        end
    end
end)


local SkillCheckGB = SurvivorTab:AddLeftGroupbox("Feature SkillCheck", "vote")

SkillCheckGB:AddToggle("NoSkillCheck", { 
    Text = "No SkillCheck", 
    Default = false, 
    Tooltip = "Automatically succeed all generator and healing skill checks.",
    Callback = function(v) 
        State.NoSkillCheck = v 
        if v then Library:Notify("No SkillCheck Activated!") end
    end 
})


SkillCheckGB:AddToggle("PerfectSkillCheck", { 
    Text = "Auto Perfect SkillCheck", 
    Default = false, 
    Tooltip = "Automatically hits perfect skill checks for both repairing and healing.",
    Callback = function(v) 
        State.PerfectSkillCheck = v 
        if v then Library:Notify("Auto Perfect SkillCheck Activated!") end
    end 
})


local ToolsGB = SurvivorTab:AddLeftGroupbox("Tools", "hammer")
ToolsGB:AddToggle("FastGate", { 
    Text = "Fast Gate Tools", 
    Default = State.FastGate, 
    Tooltip = "Instantly opens escape gates without waiting for the progress bar.",
    Callback = function(v) 
        State.FastGate = v 
        if v then Library:Notify("Fast Gate Tools Activated!") end
    end 
})


local AutoSkillGB = SurvivorTab:AddLeftGroupbox("Survivor Auto Skill", "zap")
AutoSkillGB:AddToggle("InstantHeal", { 
    Text = "Instant Heal", 
    Default = State.InstantHeal, 
    Tooltip = "Instantly fully heals other survivors when you start healing them.",
    Callback = function(v) 
        State.InstantHeal = v 
        if v then Library:Notify("Instant Heal Activated!") end
        if not v and ForceResetHeal then pcall(ForceResetHeal) end
    end 
})
AutoSkillGB:AddToggle("SilentHeal", { 
    Text = "Silent Heal", 
    Default = State.SilentHeal, 
    Tooltip = "Heals nearby survivors automatically without playing animations or interacting.",
    Callback = function(v) 
        State.SilentHeal = v 
        if v then Library:Notify("Silent Heal Activated!") end
    end 
})

AutoSkillGB:AddToggle("InstantSelfHeal", { 
    Text = "Instant Self Heal", 
    Default = State.InstantSelfHeal, 
    Tooltip = "Instantly fully heals yourself upon pressing the keybind.",
    Callback = function(v) 
        State.InstantSelfHeal = v 
        if v then Library:Notify("Instant Self Heal Activated!") end
    end 
}):AddKeyPicker("SelfHealKey", { 
    Default = "H", 
    SyncToggleState = true,
    Text = "Self Heal Bind" 
})

AutoSkillGB:AddToggle("BypassLever", { 
    Text = "Bypass Lever", 
    Default = State.BypassLever, 
    Tooltip = "Bypasses the exit gate lever interaction.",
    Callback = function(v) 
        State.BypassLever = v 
        if v then
            Library:Notify("Bypass Lever Active! Get close to the gate.")
        end
    end 
})

AutoSkillGB:AddToggle("AutoRun", { 
    Text = "Auto Sprint", 
    Default = State.AutoRun, 
    Tooltip = "Automatically holds the sprint key for you.",
    Callback = function(v) 
        State.AutoRun = v 
        if v then Library:Notify("Auto Sprint Activated!") end
    end 
})

AutoSkillGB:AddToggle("FastVault", { 
    Text = "Fast Vault", 
    Default = State.FastVault, 
    Tooltip = "Vaults over windows and pallets significantly faster.",
    Callback = function(v) 
        State.FastVault = v 
        if v then Library:Notify("Fast Vault Activated!") end
    end 
})
AutoSkillGB:AddToggle("NoSlowSurv", { 
    Text = "No Slowdown", 
    Default = State.NoSlowSurv, 
    Tooltip = "Prevents any slowdown effects on your survivor.",
    Callback = function(v) 
        State.NoSlowSurv = v 
        if v then Library:Notify("No Slowdown Activated!") end
    end 
})
AutoSkillGB:AddToggle("AutoPallet", { 
    Text = "Auto Pallet", 
    Default = State.AutoPallet, 
    Tooltip = "Automatically drops pallets when the killer is within range.",
    Callback = function(v) 
        State.AutoPallet = v 
        if v then Library:Notify("Auto Pallet Activated!") end
    end 
})
AutoSkillGB:AddToggle("AutoDodge", { 
    Text = "Auto Dodge Abysswalker", 
    Default = State.AutoDodge, 
    Tooltip = "Automatically ducks or dodges specific killer attacks like Abysswalker.",
    Callback = function(v) 
        State.AutoDodge = v 
        if v then Library:Notify("Auto Dodge Activated!") end
    end 
})

--=====================================================
-- DAGGER (AUTO PARRY) GROUPBOX
--=====================================================
local DaggerGB = SurvivorTab:AddLeftGroupbox("Dagger", "shield-check")

DaggerGB:AddToggle("AutoParry", { 
    Text = "Auto Parry", 
    Default = State.AutoParry, 
    Tooltip = "Automatically parries incoming killer attacks within range.",
    Callback = function(v) 
        State.AutoParry = v 
        if v then Library:Notify("Auto Parry Activated!") end
    end 
}):AddKeyPicker("AutoParryKey", { 
    Default = "C", 
    SyncToggleState = true,
    Text = "Auto Parry Bind" 
})

DaggerGB:AddSlider("FaceKillerSens", { 
    Text = "Face Killer Sensitivity", 
    Default = State.FaceKillerSens, 
    Min = -1.0, Max = 1.0, Rounding = 1, 
    Tooltip = "Higher value = Must look more directly at killer, 0.1 Standard (~85 degrees), -1.0 = 360 degrees (All directions valid) (Only used when Aim Prediction is OFF)",
    Callback = function(v) State.FaceKillerSens = v end 
})

DaggerGB:AddToggle("AimPrediction", { 
    Text = "Aim Prediction", 
    Default = State.AimPrediction, 
    Tooltip = "Predicts if the killer attack will actually hit you before parrying. More accurate than simple angle check. When OFF, falls back to Face Killer Sensitivity.",
    Callback = function(v) 
        State.AimPrediction = v 
        if v then Library:Notify("Aim Prediction Activated!") end
    end 
})

DaggerGB:AddSlider("AimStrictness", { 
    Text = "Aim Strictness", 
    Default = State.AimStrictness, 
    Min = 1.0, Max = 3.0, Rounding = 1, 
    Tooltip = "How accurately the killer must aim at you to trigger parry. Higher = only parry when attack is aimed directly at you. Lower = parry even if slightly off-target.",
    Callback = function(v) State.AimStrictness = v end 
})

DaggerGB:AddToggle("FakeParry", { 
    Text = "Fake Parry", 
    Default = State.FakeParry, 
    Tooltip = "Enable fake parry. Press keybind to trigger fake parry (killer thinks you parried but you didnt).",
    Callback = function(v) 
        State.FakeParry = v 
        if v then Library:Notify("Fake Parry Activated!") end
    end 
}):AddKeyPicker("FakeParryKey", { 
    Default = "X", 
    Text = "Fake Parry Bind" 
})

DaggerGB:AddSlider("DefensiveReflexDelay", { 
    Text = "Parry Delay", 
    Default = State.DefensiveReflexDelay, 
    Min = 0, Max = 0.5, Rounding = 2, 
    Tooltip = "Delay in seconds before executing the parry after detecting an attack.",
    Callback = function(v) State.DefensiveReflexDelay = v end 
})

DaggerGB:AddDropdown("ParryMode", { 
    Text = "Parry Mode", 
    Default = 1, 
    Values = {"Animation", "No Animation"}, 
    Tooltip = "Toggle between standard parry animation or silent/hidden parry.",
    Callback = function(v) State.ParryMode = v end 
})

DaggerGB:AddSlider("ParryRadius", { 
    Text = "Parry Radius", 
    Default = State.ParryRadius, 
    Min = 1, Max = 50, Rounding = 0, 
    Tooltip = "Maximum distance in studs to detect and parry incoming attacks.",
    Callback = function(v) State.ParryRadius = v end 
})


local DashGB = SurvivorTab:AddLeftGroupbox("Flash Step", "zap")
DashGB:AddToggle("InstantDash", { 
    Text = "Instant Flash Escape", 
    Default = State.InstantDash, 
    Tooltip = "Instantly teleports you forward to dodge attacks.",
    Callback = function(v) 
        State.InstantDash = v 
        if v then Library:Notify("Instant Flash Escape Activated!") end
    end 
})
DashGB:AddSlider("DashDistance", { 
    Text = "Instant Flash Distance", 
    Default = 20, Min = 5, Max = 50, Rounding = 0, 
    Tooltip = "Adjusts the teleport distance for the instant flash escape.",
    Callback = function(v) State.DashDistance = v end 
})

local MiscSurvGB = SurvivorTab:AddLeftGroupbox("Misc", "wrench")
MiscSurvGB:AddButton({ Text = "Instant Escape", Func = function()
    local GateRemote = game:GetService("ReplicatedStorage").Remotes.Exit.gate
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:find("Gate") and obj:IsA("Model") then
            for i = 1, 50 do GateRemote:FireServer(obj) end
        end
    end
    Library:Notify("Trying to open all the gates instantly!")
end })
MiscSurvGB:AddButton({ Text = "Destroy Gates", Func = function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:find("Gate") and (obj:IsA("Model") or obj:IsA("BasePart")) then
            obj:Destroy()
        end
    end
    Library:Notify("Gates destroyed locally! You can pass through now.")
end })

local GodGB = SurvivorTab:AddLeftGroupbox("Survival", "heart")

GodGB:AddToggle("FakeKnockdown", { 
    Text = "Fake Knockdown", 
    Default = false, 
    Tooltip = "Simulates the knockdown state without actually being downed, tricking killers into thinking you're vulnerable.",
    Callback = function(v) 
        State.FakeKnockdown = v 
        if v then Library:Notify("Fake Knockdown Activated!") end
    end 
}):AddKeyPicker("FakeKnockKey", { 
    Default = "Z", 
    SyncToggleState = false,
    Text = "Fake Knockdown Bind" 
})

GodGB:AddToggle("AntiCampFollow", { 
    Text = "Force Anti-Camp", 
    Default = false, 
    Tooltip = "Forces an unhook and goes underground to avoid face-camping killers.",
    Callback = function(v) 
        State.AntiCampFollow = v 
        if v then Library:Notify("Anti-Camp Active!") end
    end 
})
GodGB:AddToggle("GodMode", { 
    Text = "God Mode", 
    Default = State.GodMode, 
    Tooltip = "Makes you immortal and instantly breaks free from the killer's carry.",
    Callback = function(v) 
        State.GodMode = v 
        if v then Library:Notify("God Mode Activated!") end
    end 
})
--=====================================================
-- SURVIVOR RIGHT COLUMN: EMOTES
--=====================================================
local EmoteGB = SurvivorTab:AddRightGroupbox("Emotes", "smile")

local emoteList = {}
for name, _ in pairs(_G.EmoteData) do table.insert(emoteList, name) end
table.sort(emoteList)

EmoteGB:AddDropdown("SelectedEmote", {
    Text = "Select Emote",
    Default = "Wave",
    Values = emoteList,
    Tooltip = "Choose an emote animation to play.",
    Callback = function(v)
        State.SelectedEmote = v
    end
})

EmoteGB:AddToggle("EmoteKeybind", {
    Text = "Emote Keybind",
    Default = State.EmoteKeybind,
    Tooltip = "Enables playing the selected emote via keybind.",
    Callback = function(v)
        State.EmoteKeybind = v
        if v then Library:Notify("Emote Keybind Activated!") end
    end
}):AddKeyPicker("CustomEmoteKey", { 
    Default = "V",
    Text = "Emote Bind" 
})

EmoteGB:AddDivider("Generator Teleport")
EmoteGB:AddButton({ 
    Text = "Teleport Nearest Generator",
    Tooltip = "Instantly teleports you to the closest generator on the map.",
    Func = function()
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
            hrp.CFrame = nearest.CFrame + Vector3.new(0, 10, 0)
            Library:Notify("Teleported to Nearest Generator!")
        end
    end })

--=====================================================
-- GENERATOR TELEPORT GROUPBOX (RIGHT)
--=====================================================
local GenTPGB = SurvivorTab:AddRightGroupbox("Generator Teleport", "zap")

GenTPGB:AddDropdown("GenTPMode", {
    Text = "Teleport Mode",
    Default = "Nearest",
    Values = {"Nearest", "Random"},
    Tooltip = "Choose whether to teleport to the nearest or a random generator.",
    Callback = function(Value)
        State.GenTPMode = Value
    end
})

GenTPGB:AddToggle("EnableGenTP", {
    Text = "Teleport Keybind",
    Default = State.EnableGenTP,
    Tooltip = "Enable to trigger teleport using the assigned keybind.",
    Callback = function(Value)
        State.EnableGenTP = Value
        if Value then Library:Notify("Gen Teleport Keybind Activated!") end
    end
}):AddKeyPicker("GenTPKeybind", {
    Default = "T", 
    Text = "TP Keybind"
})

--=====================================================
-- AVATAR CHANGER (OUTFIT COPIER) GROUPBOX
--=====================================================
local AvatarGB = SurvivorTab:AddRightGroupbox("Avatar Changer", "shirt")

local ActiveAvatarName = game.Players.LocalPlayer.Name
-- FUNGSI HELPER: WELD AKSESORIS MANUAL (ANTI-JATUH/ANTI-GAGAL)
local function ForceAttachAccessory(character, accessory)
    local handle = accessory:FindFirstChild("Handle")
    if not handle then return end

    local accAttachment = handle:FindFirstChildOfClass("Attachment")
    if not accAttachment then return end

    -- Cari titik kait (attachment) yang cocok di badan karakter lu (misal: HatAttachment di Head)
    local charAttachment = nil
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            local att = part:FindFirstChild(accAttachment.Name)
            if att and att:IsA("Attachment") then
                charAttachment = att
                break
            end
        end
    end

    -- Jika ketemu titik kaitnya, kita LAS paksa!
    if charAttachment then
        -- Pindahkan aksesoris ke dalam karakter lu
        accessory.Parent = character
        
        -- Sesuaikan posisinya
        handle.CFrame = charAttachment.Parent.CFrame * charAttachment.CFrame * accAttachment.CFrame:Inverse()

        -- Buat sistem las (Weld) buatan sendiri biar nempel permanen
        local weld = Instance.new("Weld")
        weld.Name = "Boyfinity_AccWeld"
        weld.Part0 = charAttachment.Parent
        weld.Part1 = handle
        weld.C0 = charAttachment.CFrame
        weld.C1 = accAttachment.CFrame
        weld.Parent = handle
    end
end

-- 1. FUNGSI INTI GANTI AVATAR
local function ChangeAvatarTo(username)
    task.spawn(function()
        local success, userId = pcall(function()
            return game.Players:GetUserIdFromNameAsync(username)
        end)

        if success and userId then
            local descSuccess, description = pcall(function()
                return game.Players:GetHumanoidDescriptionFromUserId(userId)
            end)

            if descSuccess and description then
                local char = game.Players.LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                
                if char and hum then
                    local rigType = hum.RigType
                    -- Bikin Dummy dari server
                    local dummy = game.Players:CreateHumanoidModelFromDescription(description, rigType)
                    
                    if dummy then
                        -- 🔥 BERSIHKAN AVATAR LAMA TOTAL
                        for _, v in pairs(char:GetChildren()) do
                            if v:IsA("Accessory") or v:IsA("Hat") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") then 
                                v:Destroy() 
                            end
                        end

                        local head = char:FindFirstChild("Head")
                        if head then
                            for _, v in pairs(head:GetChildren()) do
                                if v:IsA("Decal") or v:IsA("SpecialMesh") then v:Destroy() end
                            end
                        end

                        -- 🔥 COPY WARNA KULIT
                        local dummyColors = dummy:FindFirstChildOfClass("BodyColors")
                        local myColors = char:FindFirstChildOfClass("BodyColors")
                        if dummyColors then
                            if myColors then myColors:Destroy() end
                            dummyColors:Clone().Parent = char
                        end

                        -- 🔥 COPY WAJAH & KEPALA
                        local dummyHead = dummy:FindFirstChild("Head")
                        if head and dummyHead then
                            for _, v in pairs(dummyHead:GetChildren()) do
                                if v:IsA("Decal") or v:IsA("SpecialMesh") then
                                    v:Clone().Parent = head
                                end
                            end
                        end

                        -- 🔥 COPY PAKAIAN & BENTUK BADAN
                        for _, v in pairs(dummy:GetChildren()) do
                            if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("CharacterMesh") then
                                v:Clone().Parent = char
                            end
                        end

                        -- 🔥 COPY AKSESORIS DENGAN MANUAL WELDING (FIX!)
                        for _, v in pairs(dummy:GetChildren()) do
                            if v:IsA("Accessory") or v:IsA("Hat") then
                                local accClone = v:Clone()
                                -- Panggil fungsi las buatan kita
                                ForceAttachAccessory(char, accClone)
                            end
                        end

                        dummy:Destroy()
                        Library:Notify("Avatar successfully changed to: " .. username)
                    else
                        Library:Notify("Failed to load asset from the Roblox server.")
                    end
                end
            else
                Library:Notify("Failed to fetch outfit from this user.")
            end
        else
            Library:Notify("Username not found!")
        end
    end)
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(newChar)
    -- Jika ActiveAvatarName bukan nama asli kamu, berarti kamu sedang menggunakan avatar custom
    if ActiveAvatarName and ActiveAvatarName ~= game.Players.LocalPlayer.Name then
        -- Tunggu sampai karakter benar-benar ter-load di dunia
        newChar:WaitForChild("HumanoidRootPart", 5)
        newChar:WaitForChild("Humanoid", 5)
        task.wait(1.5) -- Jeda aman agar tidak bentrok dengan loading game
        
        -- Terapkan ulang avatar secara otomatis tanpa perlu klik apa-apa
        ChangeAvatarTo(ActiveAvatarName)
    end
end)

-- 2. DROPDOWN FAMOUS OUTFITS
local famousAvatars = {
    "Pilih Avatar...",
    "mrflimflam",      
    "KreekCraft",      
    "DenisDaily",      
    "Skeletor",        
    "Linkmon99",        
    "TalonMidnight",    
    "The_Emblaze",      
    "loleris",          
    "Wildes",           
    "Cerealboii",       
    "DevNamedDavid",
    "Horrace_Cat"
}

AvatarGB:AddDropdown("FamousAvatarList", {
    Text = "Famous Outfits",
    Default = "Select Avatar...",
    Values = famousAvatars,
    Tooltip = "Copies the outfit of famous Roblox players.",
    Callback = function(Value)
        if Value ~= "Select Avatar..." then
            Library:Notify("Copying outfit " .. Value .. "...")
            ChangeAvatarTo(Value)
        end
    end
})

-- 3. INPUT MANUAL USERNAME
AvatarGB:AddInput("CustomAvatarInput", {
    Default = "",
    Numeric = false,
    Tooltip = "Type any Roblox username and press Enter to copy their outfit.",
    Finished = true,
    ClearTextOnFocus = true,
    Text = "Copy by Username",
    Placeholder = "Type roblox username...",
    Callback = function(Value)
        if Value and Value ~= "" then
            Library:Notify("Searching username: " .. Value .. "...")
            ChangeAvatarTo(Value)
        end
    end
})

-- 4. RESET AVATAR (KEMBALI KE ASLI)
AvatarGB:AddButton({ 
    Text = "Reset to Original", 
    Func = function()
        Library:Notify("Resetting to original outfit...")
        ChangeAvatarTo(game.Players.LocalPlayer.Name)
    end 
})

--=====================================================
-- CLIENT STATS CHANGER (FUN ONLY)
--=====================================================
local FunStatsGB = SurvivorTab:AddRightGroupbox("Client Stats (Fun Only)", "coins")

FunStatsGB:AddInput("GearsInput", {
    Default = tostring(LocalPlayer:GetAttribute("Gears") or 0),
    Numeric = true, 
    Finished = true, -- Hanya update saat kamu tekan Enter
    ClearTextOnFocus = true,
    Text = "Set Gears Amount",
    Placeholder = "example: 999999",
    Tooltip = "Locally fakes your Gears amount (client-side only).",
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            LocalPlayer:SetAttribute("Gears", num)
            Library:Notify("Gears are changed locally to: " .. Value)
        end
    end,
})

FunStatsGB:AddInput("LevelInput", {
    Default = tostring(LocalPlayer:GetAttribute("Level") or 1),
    Numeric = true,
    Finished = true,
    ClearTextOnFocus = true,
    Text = "Set Level",
    Placeholder = "example: 999999",
    Tooltip = "Locally fakes your Level (client-side only).",
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            LocalPlayer:SetAttribute("Level", num)
            Library:Notify("Level is changed locally to: " .. Value)
        end
    end,
})

FunStatsGB:AddInput("ScrewsInput", {
    Default = tostring(LocalPlayer:GetAttribute("Screws") or 0),
    Numeric = true,
    Finished = true,
    ClearTextOnFocus = true,
    Text = "Set Screws Amount",
    Placeholder = "example: 999999",
    Tooltip = "Locally fakes your Screws amount (client-side only).",
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            LocalPlayer:SetAttribute("Screws", num)
            Library:Notify("Screws are changed locally to: " .. Value)
        end
    end,
})

local AutoGenGB = SurvivorTab:AddRightGroupbox("Auto Generator & Escape","boom-box")

AutoGenGB:AddToggle("AutoRepair", { 
    Text = "Auto Repair", 
    Default = State.AutoRepair, 
    Tooltip = "Automatically repairs generators without any input.",
    Callback = function(v) 
        State.AutoRepair = v 
        
        -- 🔥 LOGIC TAMBAHAN: Jika Auto Repair ON, paksa Perfect SkillCheck ON
        if v then
            State.PerfectSkillCheck = true
            
            -- Update visual di UI biar centangnya muncul (Khusus Obsidian/Linoria Library)
            if Library.Toggles and Library.Toggles.PerfectSkillCheck then
                Library.Toggles.PerfectSkillCheck:SetValue(true)
            end
            
            Library:Notify("Auto Repair ON: Perfect SkillCheck Activated!")
        end
    end
}):AddKeyPicker("AutoRepairKey", { 
    Default = "...", 
    SyncToggleState = true, 
    Text = "Auto Repair Bind" 
})

AutoGenGB:AddDropdown("RepairMethod", { 
    Text = "Repair Method", 
    Default = "Legit", 
    Values = {"Legit", "Silent"},
    Tooltip = "Method used for auto repairing generators. Legit = performs normal repairs with animations. Silent = repairs without animations or interactions (faster but less legit).", 
    Callback = function(v) State.RepairMethod = v end 
})

AutoGenGB:AddToggle("PanicEscape", { 
    Text = "Panic Escape", 
    Default = State.PanicEscape, 
    Tooltip = "Automatically runs away if the killer gets too close while repairing.", 
    Callback = function(v) State.PanicEscape = v end 
})

AutoGenGB:AddSlider("KillerDistance", { 
    Text = "Killer Distance", 
    Default = 30, 
    Min = 10, 
    Max = 500, 
    Rounding = 0, 
    Tooltip = "Distance at which panic escape triggers.", 
    Callback = function(v) State.KillerDistance = v end 
})

--=====================================================
-- 3. AIMBOT TAB
--=====================================================
local AimTab = Window:AddTab("Aimbot","crosshair")
if not State.GlobalAim then State.GlobalAim = {} end

local GlobalAimGB = AimTab:AddLeftGroupbox("Global Aimbot", "crosshair")

GlobalAimGB:AddToggle("Aimlock", { 
    Text = "Aimlock", 
    Default = false, 
    Tooltip = "Locks your camera onto the target while holding the aim key.",
    Callback = function(Value) 
        State.GlobalAim.Aimlock = Value 
        if Value then Library:Notify("Global Aimlock Activated!") end
    end 
})

GlobalAimGB:AddSlider("AimFOV", { 
    Text = "Aim FOV", 
    Default = 150, 
    Min = 10, 
    Max = 500, 
    Rounding = 0, 
    Tooltip = "Adjusts the field of view size for the global aimbot.",
    Callback = function(Value) 
        State.GlobalAim.AimFOV = Value 
    end 
})

GlobalAimGB:AddSlider("AimSmoothing", { 
    Text = "Smoothing", 
    Default = 1, 
    Min = 1, 
    Max = 10, 
    Rounding = 1, 
    Tooltip = "Adjusts how smooth the camera movement is. 1 is instant, higher is smoother.",
    Callback = function(Value) 
        State.GlobalAim.Smoothing = Value 
    end 
})

GlobalAimGB:AddDropdown("AimTargetPart", { 
    Text = "Target Part", 
    Default = "Head", 
    Values = {"Head", "HumanoidRootPart", "UpperTorso"}, 
    Tooltip = "Selects the body part the global aimbot will lock onto.",
    Callback = function(Value) 
        State.GlobalAim.TargetPart = Value 
    end 
})

GlobalAimGB:AddCheckbox("VisibilityCheck", {
    Text = "Visibility Check", 
    Default = false,
    Tooltip = "Only aim at visible targets (will not lock onto players behind walls).",
    Callback = function(Value) 
        State.GlobalAim.VisibilityCheck = Value 
        if Value then Library:Notify("Visibility Check Activated!") end
    end
})

GlobalAimGB:AddCheckbox("ShowAimFOV", {
    Text = "Show FOV", 
    Default = true,
    Tooltip = "Displays the FOV circle for the global aimbot.",
    Callback = function(Value) 
        State.GlobalAim.ShowFOV = Value 
        if Value then Library:Notify("Show Global FOV Activated!") end
    end
})



local AimGB = AimTab:AddLeftGroupbox("Aimbot Setting", "crosshair")
AimGB:AddToggle("EnableCrosshair", { 
    Text = "Crosshair", 
    Default = State.EnableCrosshair, 
    Tooltip = "Displays a custom crosshair in the center of your screen.",
    Callback = function(v) 
        State.EnableCrosshair = v 
        if v then Library:Notify("Custom Crosshair Activated!") end
    end 
})
AimGB:AddToggle("AimbotThroughWall", { 
    Text = "Through Wall", 
    Default = State.AimbotThroughWall, 
    Tooltip = "Allows the aimbot to lock onto targets through walls and obstacles.",
    Callback = function(v) 
        State.AimbotThroughWall = v 
        if v then Library:Notify("Aimbot Through Wall Activated!") end
    end 
})

local FlashGB = AimTab:AddLeftGroupbox("Flashlight", "flashlight")
FlashGB:AddToggle("FlashlightAimbot", { 
    Text = "Flashlight Aimbot", 
    Default = State.FlashlightAimbot, 
    Tooltip = "Automatically locks your camera to blind the killer's face while aiming.",
    Callback = function(v) 
        State.FlashlightAimbot = v 
        if v then Library:Notify("Flashlight Aimbot Activated!") end
    end 
})


local TOFGB = AimTab:AddRightGroupbox("Twist of Fate", "toggle-right")

TOFGB:AddToggle("TwistOfFateAimbot", { 
    Text = "Aimbot ToF", 
    Default = false, 
    Tooltip = "Automatically aims at the killer",
    Callback = function(v) 
        State.TwistOfFateAimbot = v 
        if v then Library:Notify("Twist Of Fate Aimbot Activated!") end
    end 
})

TOFGB:AddDropdown("TargetTeam", { 
    Text = "Select Target", 
    Default = "Killer", 
    Values = {"Killer", "Survivor"}, 
    Tooltip = "Selects which team the Twist of Fate aimbot will target.",
    Callback = function(v) State.TargetTeam = v end 
})
TOFGB:AddDropdown("TargetPart", { 
    Text = "Select Part", 
    Default = "HumanoidRootPart", 
    Values = {"Head", "UpperTorso", "HumanoidRootPart"}, 
    Tooltip = "Selects the body part the Twist of Fate aimbot will hit.",
    Callback = function(v) State.TargetPart = v end 
})

--=====================================================
-- 1. UI: AIMBOT RIGHT COLUMN (FOV & FILTERING)
--=====================================================
local AimRightGB = AimTab:AddRightGroupbox("FOV Setting", "circle")


AimRightGB:AddSlider("FOVRadius", { 
    Text = "FOV Radius", 
    Default = 150, Min = 10, Max = 800, Rounding = 0, 
    Tooltip = "Adjusts the radius of the main aimbot FOV.",
    Callback = function(v) State.AimbotFOV = v end 
})

AimRightGB:AddLabel("FOV Color"):AddColorPicker("FOVColor", {
    Default = Color3.fromRGB(189, 5, 245),
    Callback = function(v) if _G.FOVCircle then _G.FOVCircle.Color = v end end
})

AimRightGB:AddToggle("FilledFOV", { 
    Text = "Filled FOV", 
    Default = false, 
    Tooltip = "Fills the inside of the FOV circle with a translucent color.",
    Callback = function(v) 
        State.FilledFOV = v 
        if v then Library:Notify("Filled FOV Activated!") end
    end 
})

local FilterGB = AimTab:AddRightGroupbox("Target Filtering", "filter")

FilterGB:AddToggle("IgnoreKnocked", { 
    Text = "Ignore Knocked Players", 
    Default = false, 
    Tooltip = "Prevents the aimbot from locking onto downed/knocked players.",
    Callback = function(v) 
        State.IgnoreKnocked = v 
        if v then Library:Notify("Ignore Knocked Players Activated!") end
    end 
})

FilterGB:AddDropdown("TargetPriority", { 
    Text = "Target Priority", 
    Default = "Mouse", 
    Values = {"Mouse", "Distance"}, 
    Tooltip = "Prioritizes targets based on cursor distance (Mouse) or character distance (Distance).",
    Callback = function(v) State.TargetPriority = v end 
})

FilterGB:AddToggle("TeamCheck", { 
    Text = "Team Check", 
    Default = false, 
    Tooltip = "Prevents the aimbot from locking onto your teammates.",
    Callback = function(v) 
        State.TeamCheck = v 
        if v then Library:Notify("Team Check Activated!") end
    end 
})

--=====================================================
-- 4. VISUAL TAB
--=====================================================
local VisualTab = Window:AddTab("Visual","eye")

local ScreenDispGB = VisualTab:AddLeftGroupbox("Screen Display", "monitor")
ScreenDispGB:AddSlider("FullBright", { 
    Text = "Full Bright", 
    Default = 1, Min = 0, Max = 100, Rounding = 0, 
    Tooltip = "Removes all shadows and makes the map fully bright.",
    Callback = function(v) State.FullBright = v end 
})

local EspGB = VisualTab:AddLeftGroupbox("Seven Eye", "view")
EspGB:AddDropdown("SelectedEntities", { 
    Text = "Selected Entities", 
    Default = {"Killer", "Survivor", "Generators", "Gates", "Pallets", "Windows", "Hooks"}, 
    Multi = true, 
    Values = {"Killer", "Survivor", "Generators", "Gates", "Pallets", "Windows", "Hooks"}, 
    Tooltip = "Select which entities you want to see through walls.",
    Callback = function(v) 
        State.ESP.Selected = v 
    end 
})
EspGB:AddToggle("EnableESP", { 
    Text = "Enable ESP", 
    Default = State.ESP.Enabled, 
    Tooltip = "Displays information about players and objects through walls.",
    Callback = function(v) 
        State.ESP.Enabled = v 
        if v then Library:Notify("ESP Activated!") end
    end 
})
EspGB:AddToggle("ShowNames", { 
    Text = "Show Names", 
    Default = State.ESP.Names, 
    Tooltip = "Displays the names of the players on the ESP.",
    Callback = function(v) 
        State.ESP.Names = v 
        if v then Library:Notify("Show ESP Names Activated!") end
    end 
})
EspGB:AddToggle("ShowDistance", { 
    Text = "Show Distance", 
    Default = State.ESP.Studs, 
    Tooltip = "Displays the distance between you and the entities on the ESP.",
    Callback = function(v) 
        State.ESP.Studs = v 
        if v then Library:Notify("Show ESP Distance Activated!") end
    end 
})

-- ==========================================
-- CUSTOM SPECTATOR UI (DI KANAN LAYAR)
-- ==========================================
if _G.SpecGui then _G.SpecGui:Destroy() end

_G.SpecGui = Instance.new("ScreenGui")
_G.SpecGui.Name = "BoyfinitySpectatorUI"
_G.SpecGui.Parent = game:GetService("CoreGui")
_G.SpecGui.Enabled = false 

_G.SpecFrame = Instance.new("Frame")
_G.SpecFrame.Parent = _G.SpecGui
_G.SpecFrame.BackgroundColor3 = Color3.fromRGB(28, 18, 45) 
_G.SpecFrame.BackgroundTransparency = 0.01
_G.SpecFrame.BorderSizePixel = 0
_G.SpecFrame.Position = UDim2.new(1, -160, 0, 50) 
_G.SpecFrame.Size = UDim2.new(0, 150, 0, 45)
_G.SpecFrame.Active = true -- Wajib true biar bisa mendeteksi input mouse/touch
Instance.new("UICorner", _G.SpecFrame).CornerRadius = UDim.new(0, 8)


local SpecStroke = Instance.new("UIStroke")
SpecStroke.Parent = _G.SpecFrame
SpecStroke.Color = Color3.fromRGB(70, 36, 138) -- Warna ungu cerah untuk stroke
SpecStroke.Thickness = 1.5
SpecStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local SpecTitle = Instance.new("TextLabel")
SpecTitle.Parent = _G.SpecFrame
SpecTitle.BackgroundTransparency = 1
SpecTitle.Size = UDim2.new(1, 0, 0, 25)
SpecTitle.Font = Enum.Font.GothamBold
SpecTitle.Text = "Spectators"
SpecTitle.TextColor3 = Color3.fromRGB(188, 0, 255) 
SpecTitle.TextSize = 13

_G.SpecListLabel = Instance.new("TextLabel")
_G.SpecListLabel.Parent = _G.SpecFrame
_G.SpecListLabel.BackgroundTransparency = 1
_G.SpecListLabel.Position = UDim2.new(0, 5, 0, 25)
_G.SpecListLabel.Size = UDim2.new(1, -10, 1, -25)
_G.SpecListLabel.Font = Enum.Font.Gotham
_G.SpecListLabel.Text = "None"
_G.SpecListLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
_G.SpecListLabel.TextSize = 12
_G.SpecListLabel.TextYAlignment = Enum.TextYAlignment.Top

-- LOGIKA DRAGGABLE (Bisa Digeser)
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

_G.SpecFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = _G.SpecFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

_G.SpecFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        _G.SpecFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local SpectatorGB = VisualTab:AddRightGroupbox("Spectator System", "eye")

SpectatorGB:AddToggle("EnableSpectatorList", { 
    Text = "Spectator List", 
    Default = false, 
    Tooltip = "Shows a list of players who are currently spectating you.",
    Callback = function(v) 
        State.SpectatorList = v 
        if _G.SpecGui then _G.SpecGui.Enabled = v end
        if v then Library:Notify("Spectator List Activated!") end
    end 
})

local EnvGB = VisualTab:AddRightGroupbox("Environment Tweaks", "sun")

EnvGB:AddToggle("RemoveFog", { 
    Text = "Remove Fog", 
    Default = State.RemoveFog, 
    Tooltip = "Removes the atmospheric fog from the map.",
    Callback = function(v) 
        State.RemoveFog = v 
        if v then Library:Notify("Remove Fog Activated!") end
    end 
})
EnvGB:AddSlider("TimeOfDay", { 
    Text = "Time of Day", 
    Default = 12, Min = 0, Max = 24, Rounding = 1, 
    Tooltip = "Changes the local time of day in the game.",
    Callback = function(v) State.CustomTime = v end 
})

local SkyList = {"Default", "Night City", "Deep Space", "None", "Vaporwave", "Anime Sunset"}
EnvGB:AddDropdown("SkyboxChanger", { 
    Text = "Skybox Changer", 
    Default = "Default", 
    Values = SkyList, 
    Tooltip = "Changes the game's skybox to a custom theme.",
    Callback = function(v) _G.ApplySkybox(v) end 
})

State.CustomAmbience = State.CustomAmbience or false
State.AmbientColor = State.AmbientColor or Color3.fromRGB(100, 100, 100)
State.OutdoorAmbientColor = State.OutdoorAmbientColor or Color3.fromRGB(150, 150, 150)

local AmbienceGB = VisualTab:AddRightGroupbox("Custom Ambience", "moon")

AmbienceGB:AddToggle("EnableAmbience", {
    Text = "Custom Ambience",
    Default = State.CustomAmbience,
    Tooltip = "Overrides the game's lighting colors with your custom selections.",
    Callback = function(Value)
        State.CustomAmbience = Value
        if Value then Library:Notify("Custom Ambience Activated!") end
    end
})

AmbienceGB:AddLabel("Indoor/Shadow Ambient"):AddColorPicker("AmbientColorPicker", {
    Default = State.AmbientColor,
    Title = "Ambient Color",
    Callback = function(Value)
        State.AmbientColor = Value
    end
})

AmbienceGB:AddLabel("Outdoor Ambient"):AddColorPicker("OutdoorAmbientPicker", {
    Default = State.OutdoorAmbientColor,
    Title = "Outdoor Ambient Color",
    Callback = function(Value)
        State.OutdoorAmbientColor = Value
    end
})

EnvGB:AddDivider()

local EspStyleGB = VisualTab:AddRightGroupbox("ESP Customization", "palette")

EspStyleGB:AddLabel("Killer ESP Color"):AddColorPicker("KillerColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(v) State.ESP.KillerColor = v end
})
EspStyleGB:AddLabel("Survivor ESP Color"):AddColorPicker("SurvivorColor", {
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(v) State.ESP.SurvivorColor = v end
})
EspStyleGB:AddLabel("Generator ESP Color"):AddColorPicker("GenColor", {
    Default = Color3.fromRGB(255, 255, 0),
    Callback = function(v) State.ESP.GenColor = v end
})
EspStyleGB:AddLabel("Gate ESP Color"):AddColorPicker("GateColor", {
    Default = Color3.fromRGB(227, 227, 227), 
    Callback = function(v) State.ESP.GateColor = v end
})
EspStyleGB:AddLabel("Pallet ESP Color"):AddColorPicker("PalletColor", {
    Default = Color3.fromRGB(255, 221, 116),  
    Callback = function(v) State.ESP.PalletColor = v end
})
EspStyleGB:AddLabel("Window ESP Color"):AddColorPicker("WindowColor", {
    Default = Color3.fromRGB(255, 227, 128),  
    Callback = function(v) State.ESP.WindowColor = v end
})
EspStyleGB:AddLabel("Hook ESP Color"):AddColorPicker("HookColor", {
    Default = Color3.fromRGB(255, 45, 45),  
    Callback = function(v) State.ESP.HookColor = v end
})


--=====================================================
-- 5. MOVEMENT TAB
--=====================================================
local MoveTab = Window:AddTab("Movement","zap")

local MoveGB = MoveTab:AddLeftGroupbox("Movement Character", "move")
MoveGB:AddSlider("SpeedValue", { 
    Text = "Speed Multiplier", 
    Default = 1.03, Min = 1, Max = 5, Rounding = 2, 
    Tooltip = "Adjusts your character's walking speed multiplier.",
    Callback = function(v) State.Movement.SpeedValue = v end 
})
MoveGB:AddToggle("NoClip", { 
    Text = "No Clip", 
    Default = State.Movement.NoClip, 
    Tooltip = "Allows you to walk through walls and solid objects.",
    Callback = function(v) 
        State.Movement.NoClip = v 
        if v then Library:Notify("No Clip Activated!") end
    end 
})

MoveGB:AddSlider("FOVValue", { 
    Text = "Field of View", 
    Default = 70, 
    Min = 70, 
    Max = 120, 
    Rounding = 0, 
    Tooltip = "Adjusts the field of view for your camera.",
    Callback = function(v) 
        State.Movement.FOVValue = v 
    end 
})
-- // UI FLY (Movement Tab)
MoveGB:AddToggle("FlyEnabled", { 
    Text = "Fly", 
    Default = false, 
    Tooltip = "Allows your character to fly around the map.",
    Callback = function(v) 
        State.Movement.FlyEnabled = v 
        if v then Library:Notify("Fly Activated!") end
        if not v then State.Movement.IsCurrentlyFlying = false end
    end 
}):AddKeyPicker("FlyKey", { 
    Default = "O", 
    SyncToggleState = true, 
    Text = "Fly Key",
    Callback = function(v) State.Movement.IsCurrentlyFlying = not State.Movement.IsCurrentlyFlying end 
})

State.Movement.FlyKey = State.Movement.FlyKey or Enum.KeyCode.O

MoveGB:AddSlider("FlySpeed", { 
    Text = "Fly Speed", 
    Default = 50, Min = 10, Max = 200, Rounding = 0, 
    Tooltip = "Adjusts the speed of your flight.",
    Callback = function(v) State.Movement.FlySpeed = v end 
})

local CameraGB = MoveTab:AddLeftGroupbox("Camera Settings", "fullscreen")
CameraGB:AddSlider("MaxZoomDistance", { 
    Text = "Max Zoom Distance", 
    Default = 500, Min = 12, Max = 1000, Rounding = 0, 
    Tooltip = "Changes how far you can zoom out your camera.",
    Callback = function(v) 
        LocalPlayer.CameraMaxZoomDistance = v 
        LocalPlayer.CameraMinZoomDistance = 12
    end 
})
CameraGB:AddButton({ 
    Text = "Unlock Camera Zoom (F9 Fix)", 
    Tooltip = "Forces the camera zoom to unlock up to 1000 studs.",
    Func = function()
        LocalPlayer.CameraMaxZoomDistance = 1000
        workspace.CurrentCamera.FieldOfView = 90
        Library:Notify("Zoom Unlocked!")
    end 
})

--=====================================================
-- 1. UI: MOVEMENT RIGHT COLUMN
--=====================================================
local PhysicsGB = MoveTab:AddRightGroupbox("Physics & Jump", "arrow-up")

PhysicsGB:AddToggle("InfiniteJump", { 
    Text = "Infinite Jump", 
    Default = false, 
    Tooltip = "Allows you to jump endlessly in mid-air.",
    Callback = function(v) 
        State.InfiniteJump = v 
        if v then Library:Notify("Infinite Jump Activated!") end
    end 
})
PhysicsGB:AddSlider("JumpPower", { 
    Text = "Jump Power", 
    Default = 50, Min = 50, Max = 250, Rounding = 0, 
    Tooltip = "Adjusts the height of your jumps.",
    Callback = function(v) State.JumpPower = v end 
})
PhysicsGB:AddSlider("Gravity", { 
    Text = "Gravity Scale", 
    Default = 196.2, Min = 0, Max = 500, Rounding = 1, 
    Tooltip = "Changes the game's gravity affecting your character.",
    Callback = function(v) workspace.Gravity = v end 
})

local SpinGB = MoveTab:AddRightGroupbox("Spinbot Settings", "refresh-cw")
SpinGB:AddToggle("EnableSpinbot", { 
    Text = "Spinbot", 
    Default = false, 
    Tooltip = "Spins your character rapidly to confuse others or dodge.",
    Callback = function(v) 
        State.Spinbot = v 
        if v then Library:Notify("Spinbot Activated!") end
    end 
})
SpinGB:AddSlider("SpinSpeed", { 
    Text = "Spin Speed", 
    Default = 50, Min = 10, Max = 300, Rounding = 0, 
    Tooltip = "Adjusts how fast your character spins.",
    Callback = function(v) State.SpinSpeed = v end 
})

local MoonwalkGB = MoveTab:AddRightGroupbox("Moonwalk Settings", "user-minus")
MoonwalkGB:AddToggle("EnableMoonwalk", { 
    Text = "Moonwalk", 
    Default = false, 
    Tooltip = "Reverses your character's walking animation to look like a moonwalk.",
    Callback = function(v) 
        State.MoonwalkEnabled = v 
        if _G.MoonwalkUI then _G.MoonwalkUI.Enabled = v end -- Munculkan tombol Mobile
        UpdateMoonwalkUI() -- Pastikan UI langsung update saat toggle
        if not v then State.MoonwalkActive = false end -- Reset jika fitur mati
        if v then Library:Notify("Moonwalk Activated!") end
    end 
})

MoonwalkGB:AddLabel("Face User (MJ)"):AddKeyPicker("FaceBind", { 
    Default = "One", 
    NoUI = true, 
    Text = "Face User", 
    Callback = function() 
        if State.MoonwalkEnabled then 
            State.MoonwalkActive = true 
            UpdateMoonwalkUI() -- Visual panah ikut berubah saat pencet tombol 1
        end 
    end 
})

-- Bind 2 di PC
MoonwalkGB:AddLabel("Normal Position"):AddKeyPicker("NormalBind", { 
    Default = "Two", 
    NoUI = true, 
    Text = "Normal Position", 
    Callback = function() 
        State.MoonwalkActive = false 
        UpdateMoonwalkUI() -- Visual panah ikut berubah saat pencet tombol 2
    end 
})

--=====================================================
-- 6. MISC TAB
--=====================================================
local MiscTab = Window:AddTab("Misc","component")

local ShieldGB = MiscTab:AddLeftGroupbox("Shield System", "shield-check")
if not State.Misc then State.Misc = {} end

ShieldGB:AddToggle("AntiAFK", { 
    Text = "Anti AFK", 
    Default = State.Misc.AntiAFK, 
    Tooltip = "Prevents you from being kicked by the server for idling.",
    Callback = function(v) 
        State.Misc.AntiAFK = v 
        if v then Library:Notify("Anti AFK Activated!") end
    end 
})

ShieldGB:AddToggle("AntiFling", { 
    Text = "Anti Fling", 
    Default = State.Misc.AntiFling, 
    Tooltip = "Protects you from being flung or pushed away by other players.",
    Callback = function(v) 
        State.Misc.AntiFling = v 
        if v then Library:Notify("Anti Fling Activated!") end
    end 
})

ShieldGB:AddToggle("TouchFling", { 
    Text = "Touch Fling (Lobby Only)", 
    Default = State.Misc.TouchFling, 
    Tooltip = "Instantly flings any player that comes into direct contact with you.",
    Callback = function(v) 
        State.Misc.TouchFling = v 
        if v then Library:Notify("Touch Fling Activated!") end
    end 
})

ShieldGB:AddToggle("InvisFling", { 
    Text = "Invisible Fling", 
    Default = State.Misc.InvisFling, 
    Tooltip = "Turns your character invisible while aggressively flinging nearby players.",
    Callback = function(v) 
        State.Misc.InvisFling = v 
        if v then Library:Notify("Invisible Fling Activated!") end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = v and 1 or 0
                    if part.Name == "HumanoidRootPart" then part.Transparency = 1 end
                end
            end
        end
    end 
})

ShieldGB:AddToggle("AOEFling", { 
    Text = "AOE Fling", 
    Default = State.Misc.AOEFling, 
    Tooltip = "Flings all players within a certain radius around you.",
    Callback = function(v) 
        State.Misc.AOEFling = v 
        if v then Library:Notify("AOE Fling Activated!") end
    end 
})

ShieldGB:AddSlider("FlingRadius", { 
    Text = "Fling Radius", 
    Default = 15, Min = 5, Max = 30, Rounding = 0, 
    Tooltip = "Adjusts the effective distance for the AOE Fling.",
    Callback = function(v) State.Misc.FlingRadius = v end 
})

ShieldGB:AddToggle("AntiAdmin", { 
    Text = "Anti Admin (Auto Leave)", 
    Default = State.Misc.AntiAdmin, 
    Tooltip = "Automatically leaves the game if a group admin or moderator is detected in the server.",
    Callback = function(v) 
        State.Misc.AntiAdmin = v 
        if v then Library:Notify("Anti Admin Activated!") end
    end 
})

ShieldGB:AddButton({ 
    Text = "Rejoin Server", 
    Tooltip = "Instantly rejoins the exact same server you are currently playing in.",
    Func = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end 
})

ShieldGB:AddButton({ 
    Text = "Free Private Server (Hop)", 
    Tooltip = "Searches and hops to a server with very few players.",
    Func = function()
        Library:Notify("Finding small server...")
        local HttpService = game:GetService("HttpService")
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
        for _, s in pairs(servers) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id)
                break
            end
        end
    end 
})

local CDashGB = MiscTab:AddLeftGroupbox("Custom Dash", "wind")
CDashGB:AddToggle("EnableDash", { 
    Text = "Custom Dash", 
    Default = State.Misc.EnableDash, 
    Tooltip = "Enables a custom physical dash movement bound to a key.",
    Callback = function(v) 
        State.Misc.EnableDash = v 
        if v then Library:Notify("Custom Dash Activated!") end
    end 
}):AddKeyPicker("DashKey", { 
    Default = "Q", 
    NoUI = true, 
    Text = "Dash Key" 
})

if not State.StreamerMode then State.StreamerMode = {} end
local StreamerGB = MiscTab:AddRightGroupbox("Streamer Mode", "eye-off")

StreamerGB:AddToggle("HideUsername", {
    Text = "Hide Username",
    Default = State.StreamerMode.HideUsername or false,
    Tooltip = "Locally replaces your Roblox username on the UI to protect your identity.",
    Callback = function(Value)
        State.StreamerMode.HideUsername = Value
        if Value then Library:Notify("Hide Username Activated!") end
    end
})

StreamerGB:AddToggle("HideAvatar", {
    Text = "Hide Avatar",
    Default = State.StreamerMode.HideAvatar or false,
    Tooltip = "Locally replaces your Roblox avatar picture on the UI.",
    Callback = function(Value)
        State.StreamerMode.HideAvatar = Value
        if Value then Library:Notify("Hide Avatar Activated!") end
    end
})

--=====================================================
-- 7. SETTINGS TAB
--=====================================================
local SettingsTab = Window:AddTab("Settings", "settings")

-- // 1. MENU SETTINGS (Pindahkan ke Kiri agar tidak bentrok dengan SaveManager)
local MenuGB = SettingsTab:AddLeftGroupbox("Menu", "square-menu")

-- Menu Bind (Default G)

MenuGB:AddToggle("KeybindMenuOpen", {
	Default = Library.KeybindFrame.Visible,
	Text = "Open Keybind Menu",
    Tooltip = "Toggles the visibility of the active keybinds list on your screen.",
	Callback = function(value)
		Library.KeybindFrame.Visible = value
        if value then Library:Notify("Keybind Menu Opened!") end
	end,
})

-- Custom Cursor Toggle
MenuGB:AddToggle('CustomCursor', { 
    Text = 'Custom Cursor', 
    Default = true, 
    Tooltip = "Replaces the default Roblox mouse cursor with a custom one while the UI is open.",
    Callback = function(Value) 
        Library.ShowCustomCursor = Value 
        if Value then Library:Notify("Custom Cursor Activated!") end
    end 
})

-- Notification Side Dropdown
MenuGB:AddDropdown('NotifySide', { 
    Text = 'Notification Side', 
    Default = 'Right', 
    Values = { 'Left', 'Right' }, 
    Tooltip = "Selects whether notifications appear on the left or right side of the screen.",
    Callback = function(Value) 
        Library.NotifySide = Value 
    end 
})

-- DPI Scale Slider
MenuGB:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",
	Text = "DPI Scale",
    Tooltip = "Adjusts the overall size and scaling of the UI to fit your screen resolution.",
	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local DPI = tonumber(Value)
		Library:SetDPIScale(DPI)
	end,
})

MenuGB:AddDivider()

MenuGB:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "G",
    NoUI = true, -- Kita tidak perlu tampilkan keybind ini di UI karena sudah jelas di toggle-nya
    Text = "Menu keybind",
})

Library.ToggleKeybind = Library.Options.MenuKeybind

MenuGB:AddButton("Unload", function()
    Library:Unload()
    Library:Notify("Script Unloaded. Thanks for using!")
end)


-- // 2. SYSTEM & CREDITS
local SystemGB = SettingsTab:AddLeftGroupbox("System", "cpu")
SystemGB:AddButton({ 
    Text = "FPS Boost", 
    Tooltip = "Activates Potato Mode to maximize FPS by aggressively reducing map graphics and textures.",
    Func = function() 
        State.PotatoMode = true 
        Library:Notify("FPS Boost (Potato Mode) Triggered!")
    end 
})

local CreditGB = SettingsTab:AddLeftGroupbox("Credits & Info", "info")
CreditGB:AddButton({ 
    Text = "Discord Server", 
    Tooltip = "Copies the official Boyfinity Discord server invite link to your clipboard.",
    Func = function() 
        setclipboard("https://discord.gg/VK4qrGWtF6")
        Library:Notify("Discord link copied to clipboard!", 3) 
    end 
})

-- // 3. TEMA & SAVE MANAGER
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("BoyfinityVD")
ThemeManager:ApplyToTab(SettingsTab)

SaveManager:BuildConfigSection(SettingsTab)
SaveManager:LoadAutoloadConfig()

--=====================================================
-- EXPORT / IMPORT CONFIGURATION
--=====================================================
-- Bikin Groupbox di sebelah kanan (dibawah SaveManager)
local ConfigShareGB = SettingsTab:AddRightGroupbox("Export / Import Config", "file-text")

-- 1. BUTTON EXPORT CONFIG
ConfigShareGB:AddButton({
    Text = "Export Current Config",
    Tooltip = "Copies your currently selected configuration data to the clipboard for sharing.",
    Func = function()
        local currentConfig = SaveManager.Options.SaveManager_ConfigList and SaveManager.Options.SaveManager_ConfigList.Value
        
        if currentConfig and currentConfig ~= "" then
            local path = "BoyfinityVD/settings/" .. currentConfig .. ".json"
            
            if isfile(path) then
                local configData = readfile(path)
                setclipboard(configData)
                Library:Notify("Config '" .. currentConfig .. "' has been copied to clipboard!")
            else
                Library:Notify("Config file not found!")
            end
        else
            Library:Notify("Please select a config from the list above first!")
        end
    end
})

ConfigShareGB:AddDivider()

-- 2. INPUT IMPORT CONFIG
ConfigShareGB:AddInput("ImportConfigInput", {
    Default = "",
    Numeric = false,
    Finished = false, 
    Text = "Paste Config Here",
    Placeholder = "Paste text JSON config here...",
    Tooltip = "Paste the configuration text (JSON format) that you want to import here.",
    Callback = function(Value)
        State.ImportedConfigText = Value
    end
})

-- 3. BUTTON IMPORT CONFIG
ConfigShareGB:AddButton({
    Text = "Import Config",
    Tooltip = "Saves the pasted text as a new configuration file named 'ImportedConfig'.",
    Func = function()
        local text = State.ImportedConfigText or ""
        
        if text == "" then
            Library:Notify("Paste the text config first in the top field!")
            return
        end
        
        if not isfolder("BoyfinityVD/settings") then
            makefolder("BoyfinityVD/settings")
        end
        
        local path = "BoyfinityVD/settings/ImportedConfig.json"
        
        local success, err = pcall(function()
            writefile(path, text)
        end)
        
        if success then
            SaveManager:RefreshConfigList()
            Library:Notify("Config imported as 'ImportedConfig'!")
            Library:Notify("Silakan pilih di menu Configuration lalu klik Load.")
        else
            Library:Notify("Failed to import config: " .. tostring(err))
        end
    end
})

Library.Scheme.AccentColor = Color3.fromRGB(188, 0, 255)
Library.Scheme.MainColor = Color3.fromRGB(23, 2, 26)
Library.Scheme.BackgroundColor = Color3.fromRGB(28, 18, 45)
Library.Scheme.OutlineColor = Color3.fromRGB(80, 40, 160)
Library.Scheme.FontColor = Color3.fromRGB(220, 220, 255)

Library:UpdateColorsUsingRegistry()


--=====================================================
-- FINAL SIDEBAR USER PROFILE INJECTOR (SMART SLIDE MOBILE)
--=====================================================
task.spawn(function()
    local MainFrame = Library.ScreenGui:WaitForChild("Main", 10)
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local isMobile = UserInputService.TouchEnabled
    
    if MainFrame then
        local isPremium = State.IsPremium or false
        local isNameVisible = false
        
        local EyeIcon = Library:GetIcon("eye")
        local EyeOffIcon = Library:GetIcon("eye-off")
        local LogoutIcon = Library:GetIcon("log-out")

        -- Container Utama Profil
        local ProfileArea = Instance.new("Frame")
        ProfileArea.Name = "UserProfileContainer"
        ProfileArea.Parent = MainFrame
        ProfileArea.BackgroundColor3 = Color3.fromRGB(28, 18, 45)
        ProfileArea.BorderSizePixel = 0
        ProfileArea.Size = UDim2.new(0, 190, 0, 50)
        ProfileArea.ZIndex = 500

        local ProfileCorner = Instance.new("UICorner", ProfileArea)
        ProfileCorner.CornerRadius = UDim.new(0, 8)

        -- ==========================================
        -- 🌟 LOGIKA SLIDE (MOBILE) & STATIK (PC) 🌟
        -- ==========================================
        if isMobile then
            -- Mode Mobile: Posisi awal disembunyikan (tenggelam di bawah layar menu)
            ProfileArea.Position = UDim2.new(0, 10, 1, 60)
            
            -- Bikin tombol garis panjang kecil (Handle iOS Style)
            local SlideHandle = Instance.new("TextButton")
            SlideHandle.Name = "SlideHandleBtn"
            SlideHandle.Parent = MainFrame
            SlideHandle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            SlideHandle.Position = UDim2.new(0, 85, 1, -15) -- Nangkring manis di bawah
            SlideHandle.Size = UDim2.new(0, 40, 0, 4)
            SlideHandle.Text = ""
            SlideHandle.ZIndex = 501
            Instance.new("UICorner", SlideHandle).CornerRadius = UDim.new(1, 0)

            local isExpanded = false
            
            -- Efek Animasi Slide Up & Down
            SlideHandle.MouseButton1Click:Connect(function()
                isExpanded = not isExpanded
                
                -- Tentukan titik tujuan animasi
                local targetProfilePos = isExpanded and UDim2.new(0, 10, 1, -75) or UDim2.new(0, 10, 1, 60)
                local targetHandlePos = isExpanded and UDim2.new(0, 85, 1, -85) or UDim2.new(0, 85, 1, -15)
                
                -- Setting seberapa mulus dan gaya animasinya (Quart Out = kencang di awal, ngerem di akhir)
                local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                
                TweenService:Create(ProfileArea, tweenInfo, {Position = targetProfilePos}):Play()
                TweenService:Create(SlideHandle, tweenInfo, {Position = targetHandlePos}):Play()
                
                -- Ubah warna garis biar interaktif
                SlideHandle.BackgroundColor3 = isExpanded and Color3.fromRGB(188, 0, 255) or Color3.fromRGB(150, 150, 150)
            end)
        else
            -- Mode PC: Statik, langsung kelihatan di posisi asli tanpa garis handle
            ProfileArea.Position = UDim2.new(0, 10, 1, -75)
        end
        -- ==========================================

        -- 1. Gambar Avatar (Bulat)
        local Avatar = Instance.new("ImageLabel")
        Avatar.Name = "UserAvatar"
        Avatar.Parent = ProfileArea
        Avatar.BackgroundTransparency = 1
        Avatar.Position = UDim2.new(0, 8, 0.5, -18)
        Avatar.Size = UDim2.new(0, 36, 0, 36)
        Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. Players.LocalPlayer.UserId .. "&w=150&h=150"
        Avatar.ZIndex = 501
        Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

        -- 2. Label Nama
        local UserName = Instance.new("TextLabel")
        UserName.Name = "UserNameLabel"
        UserName.Parent = ProfileArea
        UserName.BackgroundTransparency = 1
        UserName.Position = UDim2.new(0, 52, 0, 8)
        UserName.Size = UDim2.new(0, 80, 0, 15)
        UserName.Font = Enum.Font.GothamBold
        UserName.Text = Players.LocalPlayer.Name:sub(1,3) .. "*******" 
        UserName.TextColor3 = Color3.new(1, 1, 1)
        UserName.TextSize = 12
        UserName.TextXAlignment = Enum.TextXAlignment.Left
        UserName.ZIndex = 501

        -- 3. Label Tag Status
        local TagLabel = Instance.new("TextLabel")
        TagLabel.Name = "UserStatusTag"
        TagLabel.Parent = ProfileArea
        TagLabel.Position = UDim2.new(0, 52, 0, 26)
        TagLabel.Size = UDim2.new(0, 65, 0, 16)
        TagLabel.Font = Enum.Font.GothamBold
        TagLabel.TextSize = 10
        TagLabel.ZIndex = 501
        Instance.new("UICorner", TagLabel).CornerRadius = UDim.new(0, 4)

        if isPremium then
            TagLabel.Text = "PREMIUM"
            TagLabel.BackgroundColor3 = Color3.fromRGB(188, 0, 255) 
            TagLabel.TextColor3 = Color3.new(1, 1, 1)
        else
            TagLabel.Text = "FREE"
            TagLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            TagLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        end

        -- 4. Tombol Intip Nama (Eye Icon)
        local EyeButton = Instance.new("ImageButton")
        EyeButton.Name = "ToggleNameBtn"
        EyeButton.Parent = ProfileArea
        EyeButton.BackgroundTransparency = 1
        EyeButton.Position = UDim2.new(1, -60, 0.5, -10)
        EyeButton.Size = UDim2.new(0, 20, 0, 20)
        EyeButton.Image = EyeIcon.Url
        EyeButton.ImageRectOffset = EyeIcon.ImageRectOffset
        EyeButton.ImageRectSize = EyeIcon.ImageRectSize
        EyeButton.ImageColor3 = Color3.fromRGB(150, 150, 150)
        EyeButton.ZIndex = 502

        EyeButton.MouseButton1Click:Connect(function()
            isNameVisible = not isNameVisible
            if isNameVisible then
                UserName.Text = Players.LocalPlayer.Name 
                EyeButton.Image = EyeOffIcon.Url
                EyeButton.ImageRectOffset = EyeOffIcon.ImageRectOffset
                EyeButton.ImageRectSize = EyeOffIcon.ImageRectSize
            else
                UserName.Text = Players.LocalPlayer.Name:sub(1,3) .. "*******" 
                EyeButton.Image = EyeIcon.Url
                EyeButton.ImageRectOffset = EyeIcon.ImageRectOffset
                EyeButton.ImageRectSize = EyeIcon.ImageRectSize
            end
        end)

        -- 5. Tombol Keluar Pajangan (Logout Icon)
        local LogoutButton = Instance.new("ImageButton")
        LogoutButton.Name = "LogoutBtn"
        LogoutButton.Parent = ProfileArea
        LogoutButton.BackgroundTransparency = 1
        LogoutButton.Position = UDim2.new(1, -30, 0.5, -10)
        LogoutButton.Size = UDim2.new(0, 20, 0, 20)
        LogoutButton.Image = LogoutIcon.Url
        LogoutButton.ImageRectOffset = LogoutIcon.ImageRectOffset
        LogoutButton.ImageRectSize = LogoutIcon.ImageRectSize
        LogoutButton.ImageColor3 = Color3.fromRGB(188, 0, 255) 
        LogoutButton.ZIndex = 502

        LogoutButton.MouseButton1Click:Connect(function()
            Library:Notify("Cleaning UI and Unloading... Goodbye, Bro!", 2)
            task.wait(0.5)
            Library:Unload()
        end)
    end
end)

Library:Notify({
    Title = "Violence District Ready!",
    Description = "Enjoy the game, Bro! Press G to Toggle UI.",
    Time = 3,
})

--=====================================================
-- ================ END OF KILLER FEATURES =================
-- =====================================================
-- LOGIC: INSTANT HEAL OTHERS (OBSERVER METHOD)
-- =====================================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SkillCheckResultEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")

-- Fungsi untuk mengeksekusi bypass instant heal pada target
local function performInstantHealBypass(targetChar)
    if not State.InstantHeal then return end
    
    task.spawn(function()
        -- 1. VISUAL BYPASS: Paksa bar heal di layar langsung penuh (99%)
        targetChar:SetAttribute("HealProgress", 99)
        
        -- 2. SERVER BYPASS: Spam SkillCheck success agar server mencatat heal selesai
        for i = 1, 25 do
            SkillCheckResultEvent:FireServer("success", 5, targetChar)
        end

        task.wait(0.2) -- Jeda kecil untuk memastikan server memproses heal
        
        local resetRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("Reset")
        healRemote:FireServer(targetChar:FindFirstChild("HumanoidRootPart") or targetChar.PrimaryPart, false) -- Tutup interaksi heal agar tidak ngebug
        resetRemote:FireServer(LocalPlayer) -- Reset atribut agar tidak stuck di heal

    end)
end

-- Monitor karakter survivor lain
local function monitorTeammate(plr)
    plr.CharacterAdded:Connect(function(char)
        -- Pantau perubahan attribute HealProgress pada teman
        char:GetAttributeChangedSignal("HealProgress"):Connect(function()
            if not State.InstantHeal then return end
            
            local progress = char:GetAttribute("HealProgress") or 0
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            -- Cek: Jika progress mulai jalan (>0) dan kamu berada dekat target (<10 studs)
            if progress > 0 and progress < 90 and hrp and myHrp then
                local dist = (myHrp.Position - hrp.Position).Magnitude
                if dist < 10 then 
                    performInstantHealBypass(char)
                end
            end
        end)
    end)
    
    -- Jalankan juga untuk karakter yang sudah ada saat ini
    if plr.Character then
        local char = plr.Character
        char:GetAttributeChangedSignal("HealProgress"):Connect(function()
            if not State.InstantHeal then return end
            local progress = char:GetAttribute("HealProgress") or 0
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if progress > 0 and progress < 90 and hrp and myHrp then
                local dist = (myHrp.Position - hrp.Position).Magnitude
                if dist < 10 then 
                    performInstantHealBypass(char)
                end
            end
        end)
    end
end

-- Jalankan monitor ke semua player
for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= LocalPlayer then
        monitorTeammate(player)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        monitorTeammate(player)
    end
end)
--=====================================================
-- LOGIC: SILENT AUTO-HEAL AURA (AUTOMATIC & SILENT)
--=====================================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HealEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("HealEvent")
local SkillCheckResultEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")

task.spawn(function()
    while task.wait(0.5) do -- Scan setiap 0.5 detik agar hemat CPU
        if State.SilentHeal then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end

            -- Cari Target (Teman/Survivor) dalam radius 15 studs
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    local targetChar = plr.Character
                    local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                    local targetHum = targetChar and targetChar:FindFirstChildOfClass("Humanoid")

                    if targetHRP and targetHum and targetHum.Health > 0 then
                        -- Cek apakah target butuh Heal (Injured atau Knocked)
                        local isSurvivor = (plr.Team and plr.Team.Name == "Survivors")
                        local isInjured = targetHum.Health < 100
                        local isKnocked = targetChar:GetAttribute("Knocked") or targetChar:GetAttribute("IsKnocked")
                        local isAlreadyHooked = targetChar:GetAttribute("IsHooked") or targetChar:GetAttribute("Hooked")

                        local dist = (hrp.Position - targetHRP.Position).Magnitude

                        if dist < 15 and (isInjured or isKnocked) and not isAlreadyHooked then
                            -- 1. START INTERACTION (Tanpa Animasi di Layar Lu)
                            HealEvent:FireServer(targetHRP, true)

                            -- 2. SILENT BYPASS: Hentikan Animasi Heal Karakter Lu[cite: 1, 2]
                            local animator = char:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
                            if animator then
                                task.delay(0.02, function()
                                    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                                        if track.Name:lower():find("heal") or track.Animation.AnimationId:find("heal") then
                                            track:Stop()
                                        end
                                    end
                                end)
                            end

                            -- 3. INSTANT BYPASS: Spam SkillCheck & Atribut
                            targetChar:SetAttribute("HealProgress", 99)
                            targetChar:SetAttribute("IsHealing", true)

                            for i = 1, 25 do
                                SkillCheckResultEvent:FireServer("success", 5, targetChar)
                            end

                            -- 4. CLEANUP: Tutup interaksi agar tidak ngebug[cite: 2]
                            task.wait(0.1)
                            HealEvent:FireServer(targetHRP, false)
                            targetChar:SetAttribute("HealProgress", 0)
                            targetChar:SetAttribute("IsHealing", false)
                            
                        end
                    end
                end
            end
        end
    end
end)
--=====================================================
-- RECEIVE HEAL BYPASS (Auto-99% pas di-heal teman)
--=====================================================
local LocalPlayer = game.Players.LocalPlayer

local function setupHealSensor(char)
    if not char then return end

    -- Kita pantau atribut HealProgress di badan kita sendiri
    char:GetAttributeChangedSignal("HealProgress"):Connect(function()
        if not State.InstantHeal then return end -- Cek kalau fitur lagi nyala

        local currentProgress = char:GetAttribute("HealProgress") or 0
        
        -- Kalau bar mulai naik (di-heal teman) dan belum 99%
        if currentProgress > 0 and currentProgress < 99 then
            
            -- 1. Visual: Paksa langsung 99% di layar kita
            char:SetAttribute("HealProgress", 99)
            
            -- 2. Server: Kita bantu temen kita nyepam SkillCheck dari dalam!
            pcall(function()
                local SkillCheckResultEvent = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")
                
                -- Tembak 20x skillcheck success atas nama badan kita
                for i = 1, 20 do
                    SkillCheckResultEvent:FireServer("success", 5, char)
                end
                
            end)
            
        end
    end)
end

-- Pasang sensor ke karakter yang sekarang hidup
if LocalPlayer.Character then
    setupHealSensor(LocalPlayer.Character)
end

-- Pastikan sensor dipasang ulang setiap kali kita respawn/mati
LocalPlayer.CharacterAdded:Connect(function(newChar)
    setupHealSensor(newChar)
end)
--==============================================================
--// 2. MAIN LOOP (Hitbox, Anti-Slow Physics, & Animation Speed)
--=============================================================
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    -- Anti Slowdown Physics
    if State.NoCooldown and hum and hum.WalkSpeed < 16 then
        hum.WalkSpeed = 16
    end

    -- Fast Animation Speed
    if State.NoCooldown and hum then
        for _, anim in pairs(hum:GetPlayingAnimationTracks()) do
            if anim.Name:find("Attack") or anim.Name:find("Swing") then
                anim:AdjustSpeed(100)
            end
        end
    end

    -- HITBOX LOGIC
    if State.HitboxEnabled then
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = plr.Character.HumanoidRootPart
            local myHRP = LocalPlayer.Character.HumanoidRootPart
            
            -- 1. VISUAL HITBOX (Biar keliatan gede)
            targetHRP.Size = Vector3.new(State.HitboxSize, State.HitboxSize, State.HitboxSize)
            targetHRP.Transparency = State.HitboxTransparency
            targetHRP.Shape = Enum.PartType.Ball
            targetHRP.CanCollide = true -- Coba set TRUE biar senjata lu bisa 'nempel'
            
            -- 2. REACH LOGIC (Trik Biar Pasti Kena)
            -- Jika lu lagi mukul dan jarak musuh lumayan deket (misal 20 studs)
            local dist = (myHRP.Position - targetHRP.Position).Magnitude
            if dist < State.HitboxSize and State.NoCooldown then
                -- Secara halus kita 'deketin' posisi musuh ke depan senjata kita
                -- Tapi cuma di sisi client lu doang, biar survivor-nya gak ngerasa ditarik
                -- targetHRP.CFrame = myHRP.CFrame * CFrame.new(0, 0, -2) 
            end
        end
    end
    else
        -- Reset Hitbox jika dimatikan
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local targetHRP = plr.Character.HumanoidRootPart
                targetHRP.Size = Vector3.new(2, 2, 1)
                targetHRP.Transparency = 1
                targetHRP.Shape = Enum.PartType.Block
            end
        end
    end
end)

do
--=====================================================
-- LOGIC: MISC KILLER SYSTEM
--=====================================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GenRemote = ReplicatedStorage.Remotes.Generator.BreakGenEvent

--// 1. ANTI STUN & VISUAL BLIND REMOVER (Jalan di Heartbeat)
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    
    -- B. ANTI BLIND VISUAL (Hapus Layar Putih langsung dari pusatnya)
    if State.AntiBlind then
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if PlayerGui then
            local hiddenGui = PlayerGui:FindFirstChild("Hidden")
            if hiddenGui and hiddenGui:FindFirstChild("Blind") then
                hiddenGui.Blind.Visible = false
            end
        end
    end
end)

--// 2. AUTO BREAK GENERATOR (Jalan di Loop Sendiri - Hemat CPU)
task.spawn(function()
    while task.wait(0.5) do 
        if State.AutoBreak then
            pcall(function()
                local char = LocalPlayer.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if not root then return end

                for obj in pairs(ObjectCache.Generators) do
                    if obj:IsA("Model") then
                        local genPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if genPart then
                            local distance = (root.Position - genPart.Position).Magnitude
                            if distance < 15 then
                                GenRemote:FireServer(obj)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

--// 4. ANTI SLOWDOWN (GLOBAL PROTECTION & ANTI-BLAME)
-- // PERBAIKAN CORE PHYSICS (Heartbeat)
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if char and hum then
        -- Logic No Slow Killer: Paksa WalkSpeed tetep 16 (atau lebih jika lari)
        if State.NoSlow and hum.WalkSpeed < 16 then
            hum.WalkSpeed = 16
        end
    end
end)

--// 1. ANTI STUN FISIK (DIOPTIMASI)
task.spawn(function()
    while task.wait(0.3) do
        local char = LocalPlayer.Character
        if char and State.NoStun then
            -- 🔥 Pakai GetChildren, JANGAN GetDescendants!
            for _, v in pairs(char:GetChildren()) do
                if v.Name:find("Stun") then
                    if v:IsA("GuiObject") or v:IsA("LayerCollector") then
                        pcall(function() v.Enabled = false; v.Visible = false end)
                    elseif v:IsA("BasePart") then
                        pcall(function() v.Transparency = 1; v.CanCollide = false; v.Anchored = false end)
                    end
                end
            end
        end
    end
end)

end
--===============================================
--================ SURVIVOR ================-----
--===============================================


-- ==========================================
-- 🌟 FPS-FRIENDLY AUTO SKILL CHECK & ANTI-STUCK 🌟
-- ==========================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local GenSkillEvent = remotes:WaitForChild("Generator"):WaitForChild("SkillCheckEvent")
local GenResultEvent = remotes:WaitForChild("Generator"):WaitForChild("SkillCheckResultEvent")
local repairRemote = remotes:WaitForChild("Generator"):WaitForChild("RepairEvent")

local HealSkillEvent = remotes:WaitForChild("Healing"):WaitForChild("SkillCheckEvent")
local HealResultEvent = remotes:WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")
local healRemote = remotes:WaitForChild("Healing"):WaitForChild("HealEvent")

local currentGenPoint = nil

-- [1] AUTO SUCCESS GENERATOR (TETAP PAKAI YANG LAMA KARENA SUDAH WORK)
GenSkillEvent.OnClientEvent:Connect(function(genModel, genPoint)
    if State.NoSkillCheck then
        currentGenPoint = genPoint
        task.wait(0.05)

        local args = {
            [1] = "success",
            [2] = 1,
            [3] = genModel,
            [4] = genPoint
        }
        pcall(function() GenResultEvent:FireServer(unpack(args)) end)
    end
end)

-- [2] AUTO SUCCESS HEALING (TAMBAHAN LOGIC ANTI FAIL)
HealSkillEvent.OnClientEvent:Connect(function(targetChar)
    if State.NoSkillCheck then
        task.wait(0.05)
        
        -- Anti-Fail: Jika targetChar kosong/nil, asumsikan kita healing diri sendiri atau cari player terdekat yang diheal
        if not targetChar or typeof(targetChar) ~= "Instance" then
            targetChar = LocalPlayer.Character
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local progress = player.Character:GetAttribute("HealProgress") or 0
                    if progress > 0 and hrp and myHrp and (myHrp.Position - hrp.Position).Magnitude < 10 then
                        targetChar = player.Character
                        break
                    end
                end
            end
        end

        local args = {
            [1] = "success",
            [2] = 1,
            [3] = targetChar
        }
        pcall(function() HealResultEvent:FireServer(unpack(args)) end)
    end
end)


--=====================================================
-- AUTO SKILL CHECK CORE (SYNC WITH UI)
--=====================================================

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")

local function normalize(angle)
    return (angle % 360 + 360) % 360
end

-- Remote result (support heal + gen)
local ResultEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")

-- PARAMETER
local OFFSET = 104
local WINDOW = 6
local STEP = 0.5

-- STATE
local hasTriggered = false
local lastTriggerRot = nil
local lastGoalRot = nil
local successCount = 0
local LOCKED = false

-- LOOP
RunService.Heartbeat:Connect(function()

    -- 🔥 AKTIF HANYA JIKA TOGGLE ON
    if not State.PerfectSkillCheck then 
        hasTriggered = false
        return 
    end

    local PromptGui = PlayerGui:FindFirstChild("SkillCheckPromptGui")

    if PromptGui and PromptGui.Enabled and PromptGui:FindFirstChild("Check") and PromptGui.Check.Visible then
        local Line = PromptGui.Check:FindFirstChild("Line")
        local Goal = PromptGui.Check:FindFirstChild("Goal")

        if Line and Goal then
            local currentRot = normalize(Line.Rotation)
            local goalRot = normalize(Goal.Rotation)

            local startZone = normalize(goalRot + OFFSET)
            local endZone = normalize(goalRot + OFFSET + WINDOW)

            local inZone
            if startZone <= endZone then
                inZone = (currentRot >= startZone and currentRot <= endZone)
            else
                inZone = (currentRot >= startZone or currentRot <= endZone)
            end

            local center = normalize(goalRot + 109)
            local diff = math.abs(currentRot - center)
            if diff > 180 then diff = 360 - diff end

            -- HARD FILTER
            local validMin = normalize(goalRot + 90)
            local validMax = normalize(goalRot + 130)

            local validRange
            if validMin <= validMax then
                validRange = (currentRot >= validMin and currentRot <= validMax)
            else
                validRange = (currentRot >= validMin or currentRot <= validMax)
            end

            if inZone and not hasTriggered and diff < 10 and validRange then
                hasTriggered = true

                lastTriggerRot = currentRot
                lastGoalRot = goalRot
                -- ==========================================
                -- CROSS-PLATFORM SKILL CHECK (PC & MOBILE)
                -- ==========================================
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                local survMob = playerGui and playerGui:FindFirstChild("Survivor-mob")
                local actionBtn = survMob and survMob:FindFirstChild("Controls") and survMob.Controls:FindFirstChild("action")

                if actionBtn and firesignal then    
                    pcall(function()
                        firesignal(actionBtn.MouseButton1Down)
                        firesignal(actionBtn.MouseButton1Click)
                        firesignal(actionBtn.MouseButton1Up)
                    end)
                else
                    VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)    
                end
            end
        end
    else
        hasTriggered = false
    end
end)

-- AUTO CALIBRATION
ResultEvent.OnClientEvent:Connect(function(result)
    if not State.PerfectSkillCheck then return end
    if not lastTriggerRot or not lastGoalRot then return end

    local successStart = normalize(lastGoalRot + 104)
    local successEnd = normalize(lastGoalRot + 114)

    local wasEarly = false
    local wasLate = false

    if successStart <= successEnd then
        wasEarly = lastTriggerRot < successStart
        wasLate = lastTriggerRot > successEnd
    else
        wasEarly = (lastTriggerRot < successStart and lastTriggerRot > successEnd)
    end

    if result == "success" then
        successCount += 1
        

        if successCount >= 3 and not LOCKED then
            LOCKED = true
            STEP = 0
            
        end

    elseif result == "fail" and not LOCKED then
        successCount = 0

        if wasEarly then
            OFFSET = OFFSET + STEP
            
        elseif wasLate then
            OFFSET = OFFSET - STEP
            
        else
            
        end

    elseif result == "neutral" and not LOCKED then
        OFFSET = OFFSET + (math.random(-1,1) * 0.2)
        
    end

    OFFSET = math.clamp(OFFSET, 95, 110)
end)

--// LOGIC: FAST GATE OPENER (REVISED)
local ExitRemote = game:GetService("ReplicatedStorage").Remotes.Exit.gate
local ItemGateRemote = game:GetService("ReplicatedStorage").Remotes.Items.Gate.gate

task.spawn(function()
    while task.wait(0.1) do 
        if State.FastGate then
            pcall(function()
                local char = LocalPlayer.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if not root then return end

                for obj in pairs(ObjectCache.Gates) do
                    -- Cari objek gerbang
                    if obj:IsA("Model") then
                        local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if part then
                            local dist = (root.Position - part.Position).Magnitude
                            
                            if dist < 15 then
                                -- 1. Kita tembak remote ITEM dulu (Bypass kunci/interaksi khusus)
                                ItemGateRemote:FireServer(obj)
                                
                                -- 2. Kita tembak remote EXIT (Bypass loading progress bar)
                                ExitRemote:FireServer(obj)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

--=====================================================
-- LOGIC: HEAL & REPAIR BOOST ATTRIBUTES
--=====================================================
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end

    local OP_BOOST_VALUE = 1.09 
    local NORMAL_VALUE = 1

    -- 🔥 GABUNGAN REPAIR & HEAL BOOST
    if State.PerfectSkillCheck then
        if char:GetAttribute("repairboost") ~= OP_BOOST_VALUE then
            char:SetAttribute("repairboost", OP_BOOST_VALUE)
        end
        if char:GetAttribute("healboost") ~= OP_BOOST_VALUE then
            char:SetAttribute("healboost", OP_BOOST_VALUE)
        end
    else
        -- Kembalikan ke normal kalau dimatikan biar gak sus
        if char:GetAttribute("repairboost") ~= NORMAL_VALUE then
            char:SetAttribute("repairboost", NORMAL_VALUE)
        end
        if char:GetAttribute("healboost") ~= NORMAL_VALUE then
            char:SetAttribute("healboost", NORMAL_VALUE)
        end
    end
end)

--=====================================================
-- LOGIC: AUTO DROP PALLET (SMART DETECTION)
--=====================================================
local PalletRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Pallet"):WaitForChild("PalletDropEvent")

RunService.Heartbeat:Connect(function()
    if not State.AutoPallet then return end

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for obj in pairs(ObjectCache.PalletPoints) do
        if obj and obj.Parent then
            local distToPallet = (hrp.Position - obj.Position).Magnitude
            
            -- Jarak aman lu ke pallet (sekitar 12 studs)
            if distToPallet < 12 then
                -- Cek apakah ada Killer di dekat pallet tersebut
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Team and plr.Team.Name == "Killer" then
                        local kChar = plr.Character
                        local kHRP = kChar and kChar:FindFirstChild("HumanoidRootPart")
                        
                        if kHRP then
                            local distKillerToPallet = (kHRP.Position - obj.Position).Magnitude
                            
                            -- Jika Killer masuk radius 10 studs dari pallet, JATUHKAN!
                            if distKillerToPallet < 8 then
                                pcall(function() 
                                    -- ==========================================
                                    -- CROSS-PLATFORM DROP PALLET (PC & MOBILE)
                                    -- ==========================================
                                    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                                    local survMob = playerGui and playerGui:FindFirstChild("Survivor-mob")
                                    local actionBtn = survMob and survMob:FindFirstChild("Controls") and survMob.Controls:FindFirstChild("action")

                                    if actionBtn and firesignal then
                                        -- [MODE MOBILE] Tap tombol action untuk jatuhkan pallet
                                        firesignal(actionBtn.MouseButton1Down)
                                        firesignal(actionBtn.MouseButton1Click)
                                        firesignal(actionBtn.MouseButton1Up)
                                    else
                                        -- [MODE PC] Tekan Spasi
                                        VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                                        task.wait(0.01)
                                        VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                                    end                                    
                                    
                                end)
                                
                                -- Delay sebentar agar tidak spam pallet yang sama
                                task.wait(1) 
                                break
                            end
                        end
                    end
                end
            end
        end
        end
end)

--// LOGIC: NO SLOWDOWN SURVIVOR (UPDATED)
RunService.Heartbeat:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    
    -- Tambahkan syarat "not State.IsParrying"
    -- Jadi kalau lagi nge-parry, NoSlow nggak akan maksa lu lari!
    if State.NoSlowSurv and hum and hum.WalkSpeed < 16 and not State.IsParrying and not _G.isFakeKnocked then
        hum.WalkSpeed = 16
    end
end)

--=====================================================
-- GODMODE V2 (THE IMMORTAL & ANTI-CARRY)
--=====================================================
State.GodMode = State.GodMode or false
local isReviving = false

RunService.Heartbeat:Connect(function()
    if not State.GodMode then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    -- ==========================================
    -- 1. GHOST-REVIVE (ANTI-PICKUP)
    -- ==========================================
    local isKnocked = char:GetAttribute("IsDowned") or char:GetAttribute("IsKnocked") or char:GetAttribute("State") == "Downed"
    local isCrawling = (hum.WalkSpeed > 0 and hum.WalkSpeed <= 5 and not char:GetAttribute("IsHooked"))
    
    if (isKnocked or isCrawling) and not isReviving then
        isReviving = true
        
        task.spawn(function()
           
            
            -- 🔥 KUNCI OP: Matikan collision seketika saat lu jatuh!
            -- Killer bakal tembus saat nyoba klik badan lu buat digendong (Pick Up gagal total)
            pcall(function() game:GetService("ReplicatedStorage").Remotes.Collision.DisableCollision:FireServer() end)
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local HealEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("HealEvent")
            local SkillCheckEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")
            
            -- Tembak remote mulai Heal
            pcall(function() HealEvent:FireServer(hrp, true) end)
            task.wait(0.05) 
            
            -- Suntik Instant Heal dengan spam yang lebih brutal
            pcall(function()
                char:SetAttribute("HealProgress", 99)
                for i = 1, 30 do -- Naik dari 20 ke 30 biar server gak bisa nolak
                    SkillCheckEvent:FireServer("success", 5, char)
                end
                
            end)
            
            task.wait(0.5) -- Jeda aman biar animasi berdiri selesai
            
            -- 🔥 Nyalakan collision lagi biar lu bisa interaksi sama map (lompat jendela/pallet)
            pcall(function() game:GetService("ReplicatedStorage").Remotes.Collision.EnableCollision:FireServer() end)
            
            isReviving = false
        end)
    end

    -- ==========================================
    -- 2. ANTI-CARRY (AUTO BREAK-FREE)
    -- ==========================================
    local isCarried = char:GetAttribute("IsCarried") or char:GetAttribute("Carried")
    if isCarried then
        for _, weld in pairs(hrp:GetChildren()) do
            if weld:IsA("Weld") or weld:IsA("WeldConstraint") then
                weld:Destroy()
            end
        end
        VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        task.wait(0.01)
        VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    end
end)

do
--=====================================================
-- LOGIC: COMBAT INSTINCT (ADVANCED PARRY V2)
--=====================================================
--!optimize 2
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

-- =====================================================
-- 1. HOSTILE SWING DATABASE
-- =====================================================
local HOSTILE_SWING_DB = {
    [113255068724446] = true, [74968262036854] = true,
    [96199016084581] = true, [74532620598483] = true, [117042998468241] = true, [133969373694098] = true,
    [129784271201071] = true, [132817836308238] = true,
    [118907603246885] = true, [78432063483146] = true,
    [78935059863801] = true,
    [139369275981139] = true, [110355011987939] = true,
    [105374834496520] = true, [111920872708571] = true
}

-- =====================================================
-- =====================================================
-- 3. DEFENSIVE ACTION
-- =====================================================
local function executeDefensiveStrike()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local itemBtn = playerGui and playerGui:FindFirstChild("Survivor-mob") and playerGui["Survivor-mob"].Controls:FindFirstChild("Gui-mob")
    
    if itemBtn and firesignal then
        firesignal(itemBtn.MouseButton1Down)
        firesignal(itemBtn.MouseButton1Click)
        firesignal(itemBtn.MouseButton1Up)
    else
        VIM:SendMouseButtonEvent(0, 0, 1, true, game, 0)
        task.wait(0.02)
        VIM:SendMouseButtonEvent(0, 0, 1, false, game, 0)
    end
end

local defenseCooldown = false
local daggerCooldown = false

LocalPlayer.CharacterAdded:Connect(function()
    daggerCooldown = false
end)

-- =====================================================
-- 6. COMBAT INSTINCT MAIN DETECTION LOOP
-- =====================================================
local ResetRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("Reset")

-- ⚡ LOGIC FAKE PARRY TRIGGER ⚡
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and State.FakeParry then
        -- Cek input tombol sesuai dengan yang di-set di KeyPicker Obsidian
        local fakeParryKey = (Library.Options and Library.Options.FakeParryKey and Library.Options.FakeParryKey.Value) or Enum.KeyCode.X.Name
        
        if input.KeyCode == Enum.KeyCode[fakeParryKey] then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                local animator = hum:FindFirstChildOfClass("Animator")
                if animator then
                    -- Load animasi defense standard dari gamenya secara lokal
                    local anim = Instance.new("Animation")
                    anim.AnimationId = "rbxassetid://127096285501517" -- 🔥 ID ANIMASI BARU DARI KAMU
                    local track = animator:LoadAnimation(anim)
                    
                    -- Paksa prioritas ke Action agar tidak kalah sama animasi lari/diam
                    track.Priority = Enum.AnimationPriority.Action 
                    track:Play()
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not State.AutoParry or defenseCooldown or daggerCooldown then return end

    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if not root or not hum then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team then
            local threatChar = plr.Character
            local threatHum = threatChar and threatChar:FindFirstChild("Humanoid")
            local threatRoot = threatChar and threatChar:FindFirstChild("HumanoidRootPart")

            if threatRoot and threatHum then
                local threatPos = threatRoot.Position
                local separation = (root.Position - threatPos).Magnitude

                if separation <= (State.ParryRadius or 15) then
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {threatChar, char}
                    rayParams.FilterType = Enum.RaycastFilterType.Exclude

                    -- [POINT 3] WALL CHECK
                    local hitWall = workspace:Raycast(root.Position, (threatPos - root.Position), rayParams)
                    if hitWall then continue end 

                    -- [POINT 2] AIM STRICTNESS CHECK (Seberapa lurus killer ngarahin layar ke lu)
                    local killerGaze = threatRoot.CFrame.LookVector
                    local vecToMe = (root.Position - threatPos).Unit
                    local killerAlignment = killerGaze:Dot(vecToMe)
                    
                    -- Panggil nilai State yang bener (AimStrictness)
                    local requiredLethal = 0.3 + (((State.AimStrictness or 2.6) - 1) / 2) * 0.65

                    -- [NEW LOGIC] AIM PREDICTION vs FACE KILLER SENSITIVITY
                    local premonitionPass = false
                    
                    if State.AimPrediction then
                        -- [A] Aim Prediction (Trajectory Check) - Lebih Akurat
                        local killerVel = threatRoot.AssemblyLinearVelocity
                        local futurePos = threatPos + (killerVel * 0.15)
                        local swingEnd = futurePos + (killerGaze * 8)
                        local swingRay = (swingEnd - futurePos)
                        local toPlayer = (root.Position - futurePos)

                        local t = math.clamp(toPlayer:Dot(swingRay) / swingRay:Dot(swingRay), 0, 1)
                        local nearestPt = futurePos + swingRay * t

                        premonitionPass = (root.Position - nearestPt).Magnitude <= 12
                    else
                        -- [B] Fallback: Face Killer Sensitivity (Lu harus natap killernya)
                        local myGaze = root.CFrame.LookVector
                        local vecToKiller = (threatPos - root.Position).Unit
                        local playerAlignment = myGaze:Dot(vecToKiller)
                        
                        -- Panggil nilai State yang bener (FaceKillerSens)
                        local sens = State.FaceKillerSens or -1.0
                        if playerAlignment >= sens then
                            premonitionPass = true
                        end
                    end

                    if killerAlignment >= requiredLethal and premonitionPass then
                        local animator = threatHum:FindFirstChildOfClass("Animator")
                        
                        -- PRE FIRE LOGIC : Parry instan untuk jarak dekat
                        if separation <= 8 then
                            executeDefensiveStrike() 

                            daggerCooldown = true
                            task.delay(50, function() 
                                daggerCooldown = false
                                if Library and Library.Notify then
                                    Library:Notify("Parrying Dagger is Ready !", 1)
                                end
                            end)
                        end

                        if animator then
                            for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                                local animId = tonumber(track.Animation.AnimationId:match("%d+"))
                                if HOSTILE_SWING_DB[animId] then
                                    defenseCooldown = true
                                    State.IsParrying = true

                                    ResetRemote:FireServer(LocalPlayer) 
                                    
                                    local reflexWait = State.DefensiveReflexDelay or 0
                                    if reflexWait > 0 then task.wait(reflexWait) end

                                    VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                    task.wait(0.02)

                                    local cachedSpeed = hum.WalkSpeed
                                    hum.WalkSpeed = 0 
                                    root.Velocity = Vector3.new(0, 0, 0) 
                                    root.RotVelocity = Vector3.new(0, 0, 0)

                                    executeDefensiveStrike()

                                    daggerCooldown = true
                                    task.delay(50, function()
                                        daggerCooldown = false
                                        if Library and Library.Notify then
                                            Library:Notify("Parrying Dagger is Ready!", 1)
                                        end
                                    end)


                                    local recoveryTime = track.Length / (track.Speed or 1)
                                    task.wait(recoveryTime)

                                    if hum and hum.Parent then
                                        hum.WalkSpeed = cachedSpeed
                                    end

                                    State.IsParrying = false
                                    task.wait(0.1)
                                    defenseCooldown = false
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- =====================================================
-- LOGIC: STEALTH PARRY (NO ANIMATION BLOCKER)
-- =====================================================
local DEFENSIVE_ANIM_SIG = "75939529748815"

RunService.Heartbeat:Connect(function()
    if State.ParryMode == "No Animation" then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if animator then
            for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId:match(DEFENSIVE_ANIM_SIG) then
                    track:Stop()
                end
            end
        end
    end
end)
end
--=====================================================
-- LOGIC: INSTANT FLASH
--=====================================================
--!optimize 2
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- ID Animasi Attack yang sama
local ATTACK_ANIM_IDS = {
    [113255068724446] = true, [74968262036854] = true,
    [96199016084581] = true, [74532620598483] = true, [117042998468241] = true, [133969373694098] = true,
    [129784271201071] = true, [132817836308238] = true,
    [118907603246885] = true, [78432063483146] = true,
    [78935059863801] = true,
    [139369275981139] = true, [110355011987939] = true,
    [105374834496520] = true, [111920872708571] = true
}

local flashCooldown = false

RunService.Heartbeat:Connect(function()
    if not State.InstantDash or flashCooldown then return end

    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local eChar = player.Character
            local eHum = eChar and eChar:FindFirstChild("Humanoid")
            local eRoot = eChar and eChar:FindFirstChild("HumanoidRootPart")

            if eRoot and eHum then
                local dist = (root.Position - eRoot.Position).Magnitude
                
                -- Deteksi jarak (Default 15 meter)
                if dist <= 15 then
                    local animator = eHum:FindFirstChildOfClass("Animator")
                    if animator then
                        for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                            local id = tonumber(track.Animation.AnimationId:match("%d+"))
                            
                            if ATTACK_ANIM_IDS[id] then
                                flashCooldown = true
                                
                                -- ⚡ LOGIKA TELEPORT KE BELAKANG
                                -- Kita pindahkan CFrame ke posisi sekarang + (arah belakang * jarak)
                                local distance = State.DashDistance or 20
                                root.CFrame = root.CFrame * CFrame.new(0, 0, distance)
                                
                        
                                
                                -- Cooldown agar tidak teleport terus-menerus dalam 1 detik
                                task.wait(1) 
                                flashCooldown = false
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

--=====================================================
-- LOGIC: EMOTE SYSTEM (ANIMATION & AUDIO)
--=====================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Gunakan ID angka saja di tabel agar fleksibel
-- Cari bagian EmoteData di versiGemini.lua dan ubah menjadi global
_G.EmoteData = {
    ["24 Hour Cinderella"] = {anim = "137195203725366", sound = "121099446613414"},
    ["Applause"]           = {anim = "96328361165090",  sound = "115490787020749"},
    ["Arm Swing"]          = {anim = "80552139463944",  sound = "74216458932348"},
    ["California Girls"]   = {anim = "123552803041504", sound = "87899327891544"},
    ["Ghoul"]              = {anim = "130415594909401", sound = "123004139176580"},
    ["Kyoufuu"]            = {anim = "137322894494527", sound = "129064643026442"},
    ["Mannrobics"]         = {anim = "134677515695156", sound = "109596159930017"},
    ["Quick Combo"]        = {anim = "105592621576604", sound = "88505795419631"},
    ["Schadenfreude"]      = {anim = "138303785534052", sound = "92070710839040"},
    ["Static"]             = {anim = "95096724457263",  sound = "70950516511572"},
    ["Thriller"]           = {anim = "99835792883875",  sound = "139985043810748"},
    ["Tor Monitor Ketua"]  = {anim = "81792358514569",  sound = "72665050838808"},
    ["Wave"]               = {anim = "99670106766588",  sound = nil},
    ["Backflip"]           = {anim = "74705617908505",  sound = nil},
    ["Sus"]                = {special = "Troll"}
}

--=====================================================
-- LOGIC: EMOTE SYSTEM (WAJIB DI ATAS LoadModule)
--=====================================================
local currentTrack = nil
local currentSound = nil
local trollLoop = nil

_G.playCustomEmote = function(name)
    -- Ambil data dari tabel yang ada di Emote.lua atau Global
    local data = _G.EmoteData and _G.EmoteData[name]
    if not data then return warn("emote data not found!") end

    local char = game.Players.LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if humanoid then
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

        if _G.stopEmote then _G.stopEmote() end

        -- ==========================================
    -- 🚨 LOGIKA KHUSUS: TROLL SUS EMOTE
    -- ==========================================
    if data.special == "Troll" then
        local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
        local anim = Instance.new("Animation")
        anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
        
        currentTrack = animator:LoadAnimation(anim)
        
        -- Masukkan ke task.spawn biar game lu nggak freeze karena while loop
        trollLoop = task.spawn(function()
            while currentTrack do -- Bikin animasi berulang kayak emote biasa
                currentTrack:Play()
                currentTrack:AdjustSpeed(isR15 and 0.7 or 0.65)
                currentTrack.TimePosition = 0.6
                
                task.wait(0.1)
                while currentTrack and currentTrack.TimePosition < (not isR15 and 0.65 or 0.7) do 
                    task.wait(0.1) 
                end
                
                if currentTrack then
                    currentTrack:Stop()
                end
                task.wait(0.01) -- Jeda setipis mungkin biar mulus ngulangnya
            end
        end)
        
        return -- 🔥 Stop di sini biar nggak ngejalanin logika normal di bawah
    end

        -- Play Animasi
        local animInstance = Instance.new("Animation")
        animInstance.AnimationId = "rbxassetid://" .. data.anim -- Pastikan prefix hanya satu

        currentTrack = animator:LoadAnimation(animInstance)
        currentTrack.Looped = true
        currentTrack:Play() --

        -- Play Sound
        if data.sound and root then
            currentSound = Instance.new("Sound", root)
            currentSound.SoundId = "rbxassetid://" .. data.sound
            currentSound.Volume = 2
            currentSound.Looped = true
            currentSound:Play()
        end
    end
end

_G.stopEmote = function()
    if trollLoop then task.cancel(trollLoop); trollLoop = nil end

    if currentTrack then currentTrack:Stop(); currentTrack:Destroy(); currentTrack = nil end
    if currentSound then currentSound:Stop(); currentSound:Destroy(); currentSound = nil end
end

--=====================================================
-- LISTENERS (Auto-Stop & Keybind)
--=====================================================

-- Logic Auto-Stop (Sudah benar ditaruh sebelum LoadModule)
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if hum and (currentTrack or currentSound) then
        -- Cek jika bergerak atau melompat
        if hum.MoveDirection.Magnitude > 0.1 or 
           hum:GetState() == Enum.HumanoidStateType.Jumping or 
           hum:GetState() == Enum.HumanoidStateType.Freefall then
            _G.stopEmote()
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if State.EmoteKeybind and input.KeyCode == Enum.KeyCode.V then
        if State.SelectedEmoteName then
            _G.playCustomEmote(State.SelectedEmoteName)
        end
    end
end)

--=====================================================
-- LOGIC: RAINBOW TRAIL (NEON VISUAL)
--=====================================================
local trailObject = nil

local function CreateTrail()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Buat Attachment untuk Trail
    local att0 = Instance.new("Attachment", hrp)
    att0.Name = "TrailAtt0"
    att0.Position = Vector3.new(0, 1, 0)

    local att1 = Instance.new("Attachment", hrp)
    att1.Name = "TrailAtt1"
    att1.Position = Vector3.new(0, -1, 0)

    -- Buat Objek Trail
    local trail = Instance.new("Trail", hrp)
    trail.Attachment0 = att0
    trail.Attachment1 = att1
    trail.Lifetime = 0.5 -- Jejak bertahan 0.5 detik
    trail.Width0, trail.Width1 = 0.5, 0 -- Mengecil di ujung
    trail.LightEmission = 1 -- Efek Glow Neon
    trail.Transparency = NumberSequence.new(0, 1) -- Memudar di ujung
    
    return trail
end

RunService.RenderStepped:Connect(function()
    if State.RainbowTrail then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if hrp then
            -- Pastikan Trail Ada
            if not trailObject or trailObject.Parent ~= hrp then
                trailObject = CreateTrail()
            end
            
            -- Update Warna Pelangi (HSV)
            local hue = (tick() % 3) / 3 -- Siklus warna tiap 3 detik
            trailObject.Color = ColorSequence.new(Color3.fromHSV(hue, 1, 1))
            trailObject.Enabled = true
        end
    else
        -- Matikan Trail jika Toggle OFF
        if trailObject then
            trailObject.Enabled = false
        end
    end
end)


--=====================================================
-- LOGIC: REAL-TIME GENERATOR SCANNER
--=====================================================
local function GetAllGenerators()
    local gens = {}
    for gen in pairs(ObjectCache.Generators) do
        if gen:IsA("Model") then table.insert(gens, gen) end
    end
    return gens
end

local lastGenScan = 0
RunService.Heartbeat:Connect(function()
    if tick() - lastGenScan < 1 then return end -- Update progress max 1 detik sekali (Mengurangi drop FPS)
    lastGenScan = tick()
    
    local generators = GetAllGenerators()
    local statusTable = {}

    for i, gen in ipairs(generators) do
        -- Ambil progress dari atribut 'RepairProgress' (Sesuai decompile source 49, 51)
        local progress = gen:GetAttribute("RepairProgress") or 0
        local isCompleted = progress >= 100
        
        table.insert(statusTable, {
            Name = "G " .. i,
            Progress = math.floor(progress),
            Instance = gen,
            Status = isCompleted and "✔️" or "⏳"
        })
    end
    
    State.GeneratorData = statusTable
end)

-- =====================================================
-- LOGIKA AUTO DODGE ABYSSWALKER (AUTO CROUCH - CTRL/MOBILE)
-- =====================================================
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = game.Players.LocalPlayer

-- ID Animasi Tebasan Abysswalker
local ABYSS_DODGE_ID = 80411309607666

task.spawn(function()
    while task.wait(0.1) do
        if State.AutoDodge then
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            
            if root then
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
                        local eChar = player.Character
                        local eHum = eChar and eChar:FindFirstChild("Humanoid")
                        local eRoot = eChar and eChar:FindFirstChild("HumanoidRootPart")

                        if eRoot and eHum then
                            local dist = (root.Position - eRoot.Position).Magnitude
                            
                            -- Deteksi dalam radius 20 unit
                            if dist <= 20 then 
                                for _, track in pairs(eHum:GetPlayingAnimationTracks()) do
                                    local animId = tonumber(track.Animation.AnimationId:match("%d+"))
                                    
                                    if animId == ABYSS_DODGE_ID then
                                        -- 🔥 AKSI: Nunduk (PC/Mobile)
                                        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                                        local crouchBtn = playerGui 
                                            and playerGui:FindFirstChild("Survivor-mob") 
                                            and playerGui["Survivor-mob"].Controls:FindFirstChild("crouch")

                                        if crouchBtn and firesignal then
                                            -- Mobile: Tahan tombol crouch
                                            firesignal(crouchBtn.MouseButton1Down)
                                            task.wait(1.2)
                                            firesignal(crouchBtn.MouseButton1Up)
                                        else
                                            -- PC: Tahan tombol LeftControl
                                            VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                                            task.wait(1.2)
                                            VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                                        end

                                        -- Cooldown singkat agar tidak glitchy
                                        task.wait(0.5)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

do
--=====================================================
-- AIMBOT V2 (NORMAL & FLASHLIGHT INTEGRATED)
--=====================================================

-- 1. KONFIGURASI STATE
getgenv().State = getgenv().State or {
    -- Normal Aimbot (Key E)
    AimbotOn = true,
    AimbotPart = "Head", -- "Head", "HumanoidRootPart"
    AimbotKey = Enum.KeyCode.E,
    
    -- 🔥 FLASHLIGHT AIMBOT CONFIG 🔥
    FlashlightAimbot = false, -- Default ON
    FlashlightAimPart = "Head", -- "Head" atau "UpperTorso" (Paling stabil)
    FlashlightAimKey = Enum.UserInputType.MouseButton2, -- Klik Kanan
    FlashlightAccuracy = 1, -- 1 = 100% Kunci Total, 0.5 = Agak smooth
    
    -- General
    AimbotFOV = 15,
    ShowFOV = true
}


local isNormalAiming = false
local isFlashlightAiming = false -- 🔥 Variabel baru buat detect Klik Kanan

--=====================================================
-- 🔦 FLASHLIGHT AIMBOT (100% ACCURACY TO HEAD/EYES)
--=====================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- Konfigurasi Awal
getgenv().State = getgenv().State or {}
State.FlashlightAimbot = false -- Ubah ke false kalau mau dimatiin dari UI

local isFlashlightAiming = false

--// FUNGSI: MENCARI KEPALA KILLER TERDEKAT (Dari kursor mouse)
local function getKillerHead()
    local nearestDist = math.huge
    local targetHead = nil
    
    for _, plr in ipairs(Players:GetPlayers()) do
        -- Cek kalau dia musuh (Tim Killer) dan karakternya masih hidup
        if plr ~= LocalPlayer and plr.Team and plr.Team.Name == "Killer" then
            local char = plr.Character
            local head = char and char:FindFirstChild("Head")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if head and hum and hum.Health > 0 then
                -- Pastikan Killernya ada di layar kita
                local screenPoint, onScreen = Camera:WorldToViewportPoint(head.Position)
                
                if onScreen then
                    -- Hitung jarak dari kursor mouse kita ke Killer
                    local mousePos = UserInputService:GetMouseLocation()
                    local dist = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                    
                    if dist < nearestDist then
                        nearestDist = dist
                        targetHead = head
                    end
                end
            end
        end
    end
    return targetHead
end

--// DETEKSI KLIK KANAN MOUSE DITEKAN
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isFlashlightAiming = true
    end
end)

--// DETEKSI KLIK KANAN MOUSE DILEPAS
UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isFlashlightAiming = false
    end
end)

-- 🔥 TAMBAHAN: Deteksi Tombol 'Gui-mob' khusus Senter di HP
local currentFlashBtn = nil
local flashBtnDownConn = nil
local flashBtnUpConn = nil
_G.FlashAimMobile = false

RunService.Heartbeat:Connect(function()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local itemBtn = playerGui and playerGui:FindFirstChild("Survivor-mob") and playerGui["Survivor-mob"]:FindFirstChild("Controls") and playerGui["Survivor-mob"].Controls:FindFirstChild("Gui-mob")

    if currentFlashBtn and not currentFlashBtn.Parent then
        _G.FlashAimMobile = false
        currentFlashBtn = nil
    end

    if itemBtn and itemBtn ~= currentFlashBtn then
        if flashBtnDownConn then flashBtnDownConn:Disconnect() end
        if flashBtnUpConn then flashBtnUpConn:Disconnect() end
        
        currentFlashBtn = itemBtn
        
        flashBtnDownConn = currentFlashBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                _G.FlashAimMobile = true
            end
        end)
        
        flashBtnUpConn = currentFlashBtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                _G.FlashAimMobile = false
            end
        end)
    end
end)

--// CORE LOGIC: EKSEKUSI AIMBOT (Berjalan terus menerus setiap frame)
RunService.RenderStepped:Connect(function()
    local myChar = LocalPlayer.Character
    local hrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    
    if not myChar or not hrp or not hum then return end

    if State.FlashlightAimbot and (isFlashlightAiming or _G.FlashAimMobile) then
        -- Opsional: Cek apakah kita lagi pegang senter. 
        -- (Kalau nama senternya beda, lu bisa ganti tulisan "Flashlight" di bawah ini)
        local holdingFlashlight = myChar:FindFirstChild("Flashlight") 
        
        if holdingFlashlight then
            local targetHead = getKillerHead()
            
            if targetHead then
                -- 1. MATIKAN AUTOROTATE BAWAAN ROBLOX
                -- Biar gerakan kita ga bentrok sama engine game pas lagi jalan
                hum.AutoRotate = false
                
                -- 2. BODY LOCK (Fisik)
                -- Ratakan sumbu Y biar karakter kita nggak nunduk/ndangak ke tanah
                local targetBodyPos = Vector3.new(targetHead.Position.X, hrp.Position.Y, targetHead.Position.Z)
                hrp.CFrame = CFrame.lookAt(hrp.Position, targetBodyPos)
                
                -- 3. CAMERA LOCK (Visual & Raycast Mata)
                -- Kunci kamera LANGSUNG ke matanya/kepalanya. 
                -- Lerp 0.8 biar nempelnya brutal tapi masih dapet frame yang mulus.
                local lookCFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)
                Camera.CFrame = Camera.CFrame:Lerp(lookCFrame, 0.8)
            end
        else
            -- Kalau nggak pegang senter, normalkan gerakan
            hum.AutoRotate = true
        end
    else
        -- Normalkan gerakan kalau klik kanan dilepas
        if hum then hum.AutoRotate = true end
    end
end)

--=====================================================
-- INFINITE FLASHLIGHT (PURE USER LOGIC - THE REAL OP)
--=====================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local FlashlightRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Items"):WaitForChild("Flashlight"):WaitForChild("Activate")
local isAiming = false

-- Deteksi klik kanan
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and (input.UserInputType == Enum.UserInputType.MouseButton2 or input.KeyCode == Enum.KeyCode.ButtonL2) then
        isAiming = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if not gpe and (input.UserInputType == Enum.UserInputType.MouseButton2 or input.KeyCode == Enum.KeyCode.ButtonL2) then
        isAiming = false
    end
end)

-- 🔥 1. BODYGUARD BATERAI (MURNI LOGIC LU)
task.spawn(function()
    while task.wait(0.5) do
        local State = _G.SharedState or getgenv().State
        if State and State.InfiniteFlashlight then
            local char = LocalPlayer.Character
            local flashlight = char and char:FindFirstChild("Flashlight")
            
            -- Kasih tag biar eventnya ga ketumpuk-tumpuk
            if flashlight and not flashlight:GetAttribute("_Dijaga") then
                flashlight:SetAttribute("_Dijaga", true)
                
                -- Kasih angka gede biar cahayanya maksimal
                flashlight:SetAttribute("remaining", 100)
                
                -- KODE ASLI LU: Jaga baterai kalau mau habis
                flashlight:GetAttributeChangedSignal("remaining"):Connect(function()
                    if flashlight:GetAttribute("remaining") <= 5 then
                        flashlight:SetAttribute("remaining", 100)
                    end
                end)
            end
        end
    end
end)

-- 💥 2. THE REMOTE SPAMMER (BONUS OP LU)
task.spawn(function()
    while task.wait(0.1) do -- Kecepatan brutal 0.1 detik sesuai racikan lu
        local State = _G.SharedState or getgenv().State
        
        if State and State.InfiniteFlashlight and (isAiming or _G.FlashAimMobile) then
            local char = LocalPlayer.Character
            local flashlight = char and char:FindFirstChild("Flashlight")
            
            if flashlight then
                pcall(function()
                    -- Trik Reset Konsisten lu: False lalu True!
                    FlashlightRemote:FireServer(flashlight, false)
                    FlashlightRemote:FireServer(flashlight, true)
                end)
            end
        end
    end
end)
end

-- =====================================================
-- 🔫 TWIST OF FATE AIMBOT (HOLD RIGHT CLICK) - XENO/SOLARA SAFE
-- =====================================================
do 
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    
    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera

    local ToF_Target = nil
    local ToF_IsAiming = false

-- [1] Deteksi Hold Klik Kanan (Mouse) - 🔥 FIX GPE BLOCK
    UserInputService.InputBegan:Connect(function(input, gpe)
        -- Hapus 'not gpe' agar klik kanan TETAP JALAN walaupun kursor kena UI transparan
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            ToF_IsAiming = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input, gpe)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            ToF_IsAiming = false
        end
    end)
    -- [3] Main Loop: Lock-on Camera & Body (BRUTAL MODE - TEMBUS TEMBOK)
    RunService.RenderStepped:Connect(function()
        local S = _G.SharedState or getgenv().State
        if not S or not S.TwistOfFateAimbot then return end

        local myChar = LocalPlayer.Character
        local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myChar or not myHum or not myRoot then return end

        if ToF_IsAiming then
            local bestPart = nil
            local bestScore = math.huge
            local targetTeam = S.TargetTeam or "Killer"
            local targetPartName = S.TargetPart or "HumanoidRootPart"

            -- Cari Target Paling Dekat ke Mouse/Crosshair (Bodo amat sama tembok & layar)
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == LocalPlayer then continue end
                local pChar = plr.Character
                if not pChar then continue end

                local hum = pChar:FindFirstChildOfClass("Humanoid")
                local targetNode = pChar:FindFirstChild(targetPartName)

                if hum and hum.Health > 0 and targetNode then
                    local isKiller = (plr.Team and plr.Team.Name == "Killer")
                    local validTeam = (targetTeam == "Killer" and isKiller) or (targetTeam == "Survivor" and not isKiller)

                    if validTeam then
                        -- Dapatkan titik koordinat target di layar (walaupun di balik tembok)
                        local screenPoint, _ = Camera:WorldToViewportPoint(targetNode.Position)
                        
                        -- 🔥 SYARAT ONSCREEN & TEMBOK DIHAPUS 🔥
                        -- Langsung hitung jarak dari kursor ke target
                        local mousePos = UserInputService:GetMouseLocation()
                        local distFromMouse = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude

                        -- Kunci yang paling dekat dengan bidikan
                        if distFromMouse < bestScore then
                            bestScore = distFromMouse
                            bestPart = targetNode
                        end
                    end
                end
            end

            ToF_Target = bestPart

            -- Eksekusi Lock-On Jika Ada Target
            if ToF_Target then
                myHum.AutoRotate = false -- Matikan kontrol rotasi bawaan game
                
                -- Posisi absolut target (Tengah dada atau Kepala)
                local aimPosition = ToF_Target.Position
                if targetPartName ~= "Head" then
                    aimPosition = aimPosition + Vector3.new(0, 0.5, 0) 
                end

                -- 💥 KUNCI MUTLAK (Snap Instan)
                local lookCFrame = CFrame.new(Camera.CFrame.Position, aimPosition)
                Camera.CFrame = lookCFrame
                
                -- Putar Badan Karakter secara instan
                local targetBodyPos = Vector3.new(aimPosition.X, myRoot.Position.Y, aimPosition.Z)
                myRoot.CFrame = CFrame.lookAt(myRoot.Position, targetBodyPos)
            else
                myHum.AutoRotate = true
            end
        else
            -- Jika klik kanan dilepas
            ToF_Target = nil
            if myHum then myHum.AutoRotate = true end
        end
    end)
end

--=====================================================

--=============================================================
---                  AIMBOT  
--=============================================================

local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

--=====================================================
-- 3. LOGIC: SMART TARGETING (OVERRIDE)
--=====================================================
-- Fungsi ini meng-update logic pencarian target agar mematuhi FOV dan Filter
local function GetSmartTarget()
    local target = nil
    local shortestScore = math.huge
    local mousePos = UserInputService:GetMouseLocation()

    for _, plr in pairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        
        -- Filter Tim
        if State.TeamCheck and plr.Team == LocalPlayer.Team then continue end

        local char = plr.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if char and hum and root and hum.Health > 0 then
            -- Filter Knocked
            local isKnocked = char:GetAttribute("Knocked") or char:GetAttribute("IsKnocked")
            if State.IgnoreKnocked and isKnocked then continue end

            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                local distFromMouse = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                local distFromMe = (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude

                -- Cek apakah target berada di dalam radius FOV
                if distFromMouse <= (State.AimbotFOV or 150) then
                    local score = (State.TargetPriority == "Distance") and distFromMe or distFromMouse
                    
                    if score < shortestScore then
                        shortestScore = score
                        target = root
                    end
                end
            end
        end
    end
    return target
end

--=====================================================
-- UPDATED: SMART AIMBOT LOOP
--=====================================================
local Aiming = false

RunService.RenderStepped:Connect(function()
    -- Pastikan fitur Aktif dan Tombol ditekan (atau Toggle ON)[cite: 1]
    if State.AimbotEnabled and Aiming then
        -- Inject: Kita panggil fungsi GetSmartTarget di sini[cite: 1]
        local target = GetSmartTarget() 
        
        if target then
            -- Arahkan kamera ke target dengan halus (Smoothness)[cite: 1]
            -- Lo bisa nambahin Lerp di sini biar nggak kelihatan kaku[cite: 1]
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)

--=====================================================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == State.AimbotKeybind then
        if State.AimbotToggleMode then
            Aiming = not Aiming -- Mode Toggle
        else
            Aiming = true -- Mode Tahan
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == State.AimbotKeybind and not State.AimbotToggleMode then
        Aiming = false
    end
end)

-- =====================================================
-- 🎯 CUSTOM CROSSHAIR (XENO & SOLARA SAFE)
-- =====================================================
task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    local RunService = game:GetService("RunService")

    -- Hapus crosshair lama kalau ada (biar ga numpuk)
    if CoreGui:FindFirstChild("BoyfinityCrosshair") then
        CoreGui.BoyfinityCrosshair:Destroy()
    end

    -- Buat UI Crosshair
    local CrosshairGui = Instance.new("ScreenGui")
    CrosshairGui.Name = "BoyfinityCrosshair"
    CrosshairGui.Parent = CoreGui
    CrosshairGui.IgnoreGuiInset = true
    CrosshairGui.Enabled = false -- Default mati

    -- Warna ungu khas Boyfinity
    local crosshairColor = Color3.fromRGB(188, 0, 255)

    -- Garis Horizontal
    local LineH = Instance.new("Frame")
    LineH.Name = "HorizontalLine"
    LineH.Size = UDim2.new(0, 14, 0, 2)
    LineH.Position = UDim2.new(0.5, -7, 0.5, -1)
    LineH.BackgroundColor3 = crosshairColor
    LineH.BorderSizePixel = 0
    LineH.Parent = CrosshairGui

    -- Garis Vertikal
    local LineV = Instance.new("Frame")
    LineV.Name = "VerticalLine"
    LineV.Size = UDim2.new(0, 2, 0, 14)
    LineV.Position = UDim2.new(0.5, -1, 0.5, -7)
    LineV.BackgroundColor3 = crosshairColor
    LineV.BorderSizePixel = 0
    LineV.Parent = CrosshairGui

    -- Titik Tengah (Opsional, bikin bidikan lebih akurat)
    local CenterDot = Instance.new("Frame")
    CenterDot.Name = "CenterDot"
    CenterDot.Size = UDim2.new(0, 4, 0, 4)
    CenterDot.Position = UDim2.new(0.5, -2, 0.5, -2)
    CenterDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Warna putih di tengah
    CenterDot.BorderSizePixel = 0
    CenterDot.Parent = CrosshairGui
    Instance.new("UICorner", CenterDot).CornerRadius = UDim.new(1, 0)

    -- Loop untuk mendeteksi nyala/mati dari Toggle UI
    RunService.RenderStepped:Connect(function()
        local State = _G.SharedState or getgenv().State
        if State and State.EnableCrosshair then
            CrosshairGui.Enabled = true
        else
            CrosshairGui.Enabled = false
        end
    end)
end)

--=====================================================
-- VISUAL
--=====================================================
local Lighting = game:GetService("Lighting")

--=====================================================
-- VISUAL LOGIC (Force Override)
--=====================================================
RunService.RenderStepped:Connect(function()
    -- Full Bright Logic: Terus-menerus paksa nilai terang setiap frame
    if State.FullBright and State.FullBright > 0 then
        Lighting.Brightness = 2 + (State.FullBright * 0.1)
        Lighting.ClockTime = 12 -- Paksa jadi jam 12 siang
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        
        -- Hapus rintangan visual lainnya
        for _, obj in pairs(Lighting:GetChildren()) do
            if obj:IsA("Bloom") or obj:IsA("BlurEffect") or obj:IsA("SunRaysEffect") then
                obj.Enabled = false 
            elseif obj:IsA("Atmosphere") then
                -- Atmosphere tidak punya .Enabled, jadi kita set Density ke 0
                -- atau bisa di-Destroy/di-Parent-kan ke tempat lain agar hilang
                obj.Density = 0 
            elseif obj:IsA("ColorCorrectionEffect") then
                obj.Brightness = (State.FullBright or 0) * 0.01
                obj.Contrast = 0
                obj.Enabled = true
            end
        end
    end
end)

-- Fungsi No Fog yang lebih kuat
local function DisableFog(enable)
    if enable then
        -- Set fog ke nilai sangat besar (efektif menghilangkan fog)
        game:GetService("Lighting").FogEnd = 1e5
        
        -- Hapus semua Atmosphere
        for _, v in pairs(game:GetService("Lighting"):GetDescendants()) do
            if v:IsA("Atmosphere") then
                pcall(function() v:Destroy() end)
            end
        end
        
        -- Set property lain yang terkait fog
        game:GetService("Lighting").FogStart = 0
    else
        -- Kembalikan ke default (nilai ini bisa disesuaikan dengan game)
        game:GetService("Lighting").FogEnd = 100000  -- nilai default biasa
        game:GetService("Lighting").FogStart = 0
        -- Catatan: Atmosphere yang sudah dihapus tidak bisa dikembalikan
    end
end


     --=====================================================
    -- 🌟 ULTRA ROBUST ESP SYSTEM (ANTI-CRASH, CORE-GUI) 🌟
    --=====================================================
    local CoreGui = game:GetService("CoreGui")
    local ESPFolder = CoreGui:FindFirstChild("VD_ESP_Folder")
    if not ESPFolder then
        ESPFolder = Instance.new("Folder")
        ESPFolder.Name = "VD_ESP_Folder"
        ESPFolder.Parent = CoreGui
    end

    local espCache = { Highlights = {}, Labels = {} }

    local function clearESP(obj)
        if espCache.Highlights[obj] then espCache.Highlights[obj]:Destroy() espCache.Highlights[obj] = nil end
        if espCache.Labels[obj] then espCache.Labels[obj]:Destroy() espCache.Labels[obj] = nil end
    end

    local function checkSelected(key)
        local sel = State.ESP.Selected
        if type(sel) ~= "table" then return true end
        return table.find(sel, key) or sel[key] == true
    end

-- // 1. UPDATE PLAYER ESP (OPTIMIZED TEXT RENDERING)
    local function updatePlayer(plr, currentCam)
        if not State.ESP.Enabled then clearESP(plr) return end
        
        local char = plr.Character
        local head = char and char:FindFirstChild("Head")
        if not char or not head then clearESP(plr) return end

        -- Filter Tim
        local team = plr.Team
        local isKiller = (team and team.Name == "Killer")
        local isSurvivor = (team and team.Name == "Survivors")

        if isKiller and not checkSelected("Killer") then clearESP(plr) return end
        if isSurvivor and not checkSelected("Survivor") then clearESP(plr) return end
        if not isKiller and not isSurvivor then clearESP(plr) return end

        local color = Color3.fromRGB(255, 255, 255)

        -- Kalkulasi Warna Dasar
        if isKiller then
            color = State.ESP.KillerColor or Color3.fromRGB(255, 0, 0)
        elseif isSurvivor then
            local hooked = char:GetAttribute("IsHooked") or char:GetAttribute("Hooked")
            local knocked = char:GetAttribute("Knocked") or char:GetAttribute("IsKnocked")
            if hooked then 
                color = State.ESP.HookedColor or Color3.fromRGB(255, 80, 0)
            elseif knocked then 
                color = State.ESP.KnockedColor or Color3.fromRGB(255, 255, 0)
            else 
                color = State.ESP.SurvivorColor or Color3.fromRGB(0, 255, 0)
            end
        end

        -- Render Highlight (Tiap Frame biar posisinya nempel mulus)
        if not espCache.Highlights[plr] then
            local hl = Instance.new("Highlight")
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.OutlineTransparency = 0
            hl.FillTransparency = 0.5
            hl.Parent = ESPFolder
            espCache.Highlights[plr] = hl
        end
        espCache.Highlights[plr].Adornee = char
        espCache.Highlights[plr].FillColor = color
        espCache.Highlights[plr].OutlineColor = color
        espCache.Highlights[plr].Enabled = true

        -- Bikin Billboard Teks jika belum ada
        if not espCache.Labels[plr] then
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0, 200, 0, 50)
            bill.StudsOffset = Vector3.new(0, 1.8, 0)
            bill.AlwaysOnTop = true
            bill.Parent = ESPFolder
            
            local txt = Instance.new("TextLabel", bill)
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Font = Enum.Font.SourceSansBold
            txt.TextSize = 13
            txt.TextStrokeTransparency = 0.2
            txt.TextStrokeColor3 = Color3.new(0, 0, 0)
            txt.TextYAlignment = Enum.TextYAlignment.Bottom
            espCache.Labels[plr] = bill
        end

        local bill = espCache.Labels[plr]
        local txt = bill:FindFirstChildOfClass("TextLabel")
        bill.Adornee = head
        txt.TextColor3 = color
        txt.Visible = true

        -- 🔥 OPTIMASI: Hitung teks & jarak HANYA tiap 0.2 detik
        local now = os.clock()
        local lastUpdate = txt:GetAttribute("LastUpdate") or 0
        
        if now - lastUpdate > 0.2 then
            txt:SetAttribute("LastUpdate", now)
            
            local line1 = State.ESP.Names and plr.Name or ""
            local line2 = ""
            local line3 = ""
            
            if isKiller then
                local killerName = plr:GetAttribute("SelectedKiller") or "Killer"
                line2 = "[" .. killerName .. "]"
            elseif isSurvivor then
                local knocked = char:GetAttribute("Knocked") or char:GetAttribute("IsKnocked")
                local hooked = char:GetAttribute("IsHooked") or char:GetAttribute("Hooked")
                local item = plr:GetAttribute("EquippedItem") or plr:GetAttribute("Item")

                if hooked then line2 = "[HOOKED]"
                elseif knocked then line2 = "[KNOCKED]"
                elseif item and item ~= "" and item ~= "None" then line2 = "[" .. tostring(item) .. "]" end
            end

            if State.ESP.Studs then
                local myRoot = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    local d = math.floor((head.Position - myRoot.Position).Magnitude)
                    line3 = "[" .. d .. "m]"
                end
            end
            
            local finalText = line1
            if line3 ~= "" then finalText = finalText ~= "" and (finalText .. " " .. line3) or line3 end
            if line2 ~= "" then finalText = finalText ~= "" and (finalText .. "\n" .. line2) or line2 end
            
            txt.Text = finalText
            if finalText == "" then txt.Visible = false end
        end
    end
 
   -- // 2. UPDATE OBJECT ESP (OPTIMIZED TEXT RENDERING)
    local function updateObject(obj, objType, currentCam)
        if not State.ESP.Enabled or not checkSelected(objType) then 
            clearESP(obj) 
            return 
        end

        -- Pewarnaan berdasarkan Tipe
        local color = Color3.fromRGB(255, 255, 255)
        if objType == "Generators" then 
            local prog = obj:GetAttribute("RepairProgress") or 0
            color = Color3.fromRGB(255 * (1 - (prog/100)), 255, 0)
        elseif objType == "Gates" then color = State.ESP.GateColor or Color3.fromRGB(227, 227, 227)
        elseif objType == "Pallets" then color = State.ESP.PalletColor or Color3.fromRGB(255, 221, 116)
        elseif objType == "Hooks" then color = State.ESP.HookColor or Color3.fromRGB(255, 45, 45)
        elseif objType == "Windows" then color = State.ESP.WindowColor or Color3.fromRGB(255, 227, 128) end

        -- Visual ESP (Box/Highlight)
        if objType == "Windows" then
            local targetPart = obj
            if obj:IsA("Model") or obj:IsA("Folder") then
                targetPart = obj:FindFirstChild("Bottom", true) or (obj:IsA("Model") and obj.PrimaryPart) or obj:FindFirstChildWhichIsA("BasePart", true)
            end

            if not targetPart or not targetPart:IsA("BasePart") then clearESP(obj) return end

            if not espCache.Highlights[obj] or not espCache.Highlights[obj]:IsA("BoxHandleAdornment") then
                if espCache.Highlights[obj] then espCache.Highlights[obj]:Destroy() end
                local box = Instance.new("BoxHandleAdornment")
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Transparency = 0.5
                box.Parent = ESPFolder
                espCache.Highlights[obj] = box
            end
            espCache.Highlights[obj].Adornee = targetPart
            espCache.Highlights[obj].Size = targetPart.Size + Vector3.new(0.05, 0.05, 0.05)
            espCache.Highlights[obj].Color3 = color
            espCache.Highlights[obj].Visible = true
        else
            if not espCache.Highlights[obj] or not espCache.Highlights[obj]:IsA("Highlight") then
                if espCache.Highlights[obj] then espCache.Highlights[obj]:Destroy() end
                local hl = Instance.new("Highlight")
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.OutlineTransparency = (objType == "Generators") and 0 or 1 
                hl.FillTransparency = (objType == "Hooks") and 0.6 or 0.5
                hl.Parent = ESPFolder
                espCache.Highlights[obj] = hl
            end
            espCache.Highlights[obj].Adornee = obj
            espCache.Highlights[obj].FillColor = color
            espCache.Highlights[obj].OutlineColor = color
            espCache.Highlights[obj].Enabled = true
        end

        -- 🔥 OPTIMASI TEKS: Cuma render tulisan Generator & update jarak tiap 0.2s
        if objType == "Generators" then
            if not espCache.Labels[obj] then
                local bill = Instance.new("BillboardGui")
                bill.Size = UDim2.new(0, 150, 0, 30)
                bill.StudsOffset = Vector3.new(0, 3.5, 0)
                bill.AlwaysOnTop = true
                bill.Parent = ESPFolder
                
                local txt = Instance.new("TextLabel", bill)
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.BackgroundTransparency = 1
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 13
                txt.TextStrokeTransparency = 0.4
                espCache.Labels[obj] = bill
            end
            
            local bill = espCache.Labels[obj]
            local txt = bill:FindFirstChildOfClass("TextLabel")
            
            bill.Adornee = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true) or obj
            txt.TextColor3 = color
            txt.Visible = true

            -- Throttle Update Teks
            local now = os.clock()
            local lastUpdate = txt:GetAttribute("LastUpdate") or 0
            
            if now - lastUpdate > 0.2 then
                txt:SetAttribute("LastUpdate", now)
                
                local prog = obj:GetAttribute("RepairProgress") or 0
                local nameStr = string.format("Generator [%.1f%%]", prog)
                
                if State.ESP.Studs then
                    local myRoot = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local hitPos = bill.Adornee and (bill.Adornee:IsA("BasePart") and bill.Adornee.Position or bill.Adornee:GetPivot().Position) or Vector3.zero
                    local dist = myRoot and math.floor((hitPos - myRoot.Position).Magnitude) or 0
                    txt.Text = nameStr .. " [" .. dist .. "m]"
                else
                    txt.Text = nameStr
                end
            end
        else
            if espCache.Labels[obj] then
                espCache.Labels[obj]:Destroy()
                espCache.Labels[obj] = nil
            end
        end
    end
    --=====================================================
    -- ESP MAIN RENDER LOOP
    --=====================================================
    RunService.RenderStepped:Connect(function()
        local currentCam = workspace.CurrentCamera
        if not currentCam then return end

        if not State.ESP.Enabled then
            -- Jika ESP dimatikan, bersihkan semua yang aktif di cache
            for obj, _ in pairs(espCache.Highlights) do clearESP(obj) end
            return
        end

        -- Players
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Players.LocalPlayer then updatePlayer(plr, currentCam) end
        end

        -- Objects
        for gen in pairs(ObjectCache.Generators) do 
            if gen.Parent then updateObject(gen, "Generators", currentCam) else clearESP(gen); ObjectCache.Generators[gen] = nil end 
        end
        for gate in pairs(ObjectCache.Gates) do 
            if gate.Parent then updateObject(gate, "Gates", currentCam) else clearESP(gate); ObjectCache.Gates[gate] = nil end 
        end
        for pallet in pairs(ObjectCache.Pallets) do 
            if pallet.Parent then updateObject(pallet, "Pallets", currentCam) else clearESP(pallet); ObjectCache.Pallets[pallet] = nil end 
        end
        for hook in pairs(ObjectCache.Hooks) do 
            if hook.Parent then updateObject(hook, "Hooks", currentCam) else clearESP(hook); ObjectCache.Hooks[hook] = nil end 
        end
        for win in pairs(ObjectCache.Windows) do 
            if win.Parent then updateObject(win, "Windows", currentCam) else clearESP(win); ObjectCache.Windows[win] = nil end 
        end
    end)

    Players.PlayerRemoving:Connect(clearESP)

--=====================================================
-- INTEGRATED MOVEMENT: SPEED, NOCLIP, & CAMERA
--=====================================================
local manualSprinting = false

-- 1. Deteksi Shift Manual
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.LeftShift then
        manualSprinting = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        manualSprinting = false
    end
end)

-- 2. Main Loop (Heartbeat)
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end

    -- [A] LOGIC SPEED MULTIPLIER (Hanya Aktif saat Lari)[cite: 1]
    local isCurrentlySprinting = manualSprinting or State.AutoRun
    if isCurrentlySprinting then
        local customSpeed = State.Movement.SpeedValue or 1.03
        if char:GetAttribute("speedboost") ~= customSpeed then
            char:SetAttribute("speedboost", customSpeed)
        end
    else
        if char:GetAttribute("speedboost") ~= 1 then
            char:SetAttribute("speedboost", 1)
        end
    end

    -- [B] LOGIC NOCLIP
    if State.Movement.NoClip then
        for _, part in ipairs(char:GetChildren()) do -- 🔥 GANTI DI SINI
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end

    -- [C] LOGIC CAMERA ZOOM[cite: 1]
    if LocalPlayer.CameraMaxZoomDistance ~= State.Movement.MaxZoomValue then
        LocalPlayer.CameraMaxZoomDistance = State.Movement.MaxZoomValue or 500
    end
end)

--=====================================================
-- 3. AUTO RUN VIM & MOBILE (CROSS-PLATFORM)
--=====================================================
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = game:GetService("Players").LocalPlayer

task.spawn(function()
    local isHoldingSprint = false

    while task.wait(0.1) do
        -- Ambil state global kamu
        local State = _G.SharedState or getgenv().State
        if not State then continue end

        -- Cari tombol sprint mobile dengan aman (menggunakan FindFirstChild agar tidak error)
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        local survMob = playerGui and playerGui:FindFirstChild("Survivor-mob")
        local sprintBtn = survMob and survMob:FindFirstChild("Controls") and survMob.Controls:FindFirstChild("sprint")

        if State.AutoRun then
            -- Jika fitur AutoRun NYALA tapi skrip belum menekan tombolnya
            if not isHoldingSprint then
                isHoldingSprint = true

                if sprintBtn and firesignal then
                    -- [MODE MOBILE] Tahan tombol sprint layar
                    pcall(function()
                        firesignal(sprintBtn.MouseButton1Down)
                    end)
                else
                    -- [MODE PC] Tahan tombol LeftShift keyboard
                    VIM:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                end
            end
        else
            -- Jika fitur AutoRun MATI tapi skrip masih menahan tombolnya
            if isHoldingSprint then
                isHoldingSprint = false

                if sprintBtn and firesignal then
                    -- [MODE MOBILE] Lepas tombol sprint layar
                    pcall(function()
                        firesignal(sprintBtn.MouseButton1Up)
                    end)
                else
                    -- [MODE PC] Lepas tombol LeftShift keyboard
                    VIM:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
                end
            end
        end
    end
end)

    --=====================================================
    -- FIXED CAMERA FOV (NO JITTERING)
    --=====================================================
    -- Gunakan RenderStepped biar menang lawan script game
    RunService.RenderStepped:Connect(function()
        if State.Movement and State.Movement.FOVValue then
            -- Langsung paksa tanpa 'if', biar script game kalah telak
            workspace.CurrentCamera.FieldOfView = State.Movement.FOVValue
        end
    end)

    
    --=====================================================
    -- NOCLIP CLEANER (Reset saat dimatikan)
    --=====================================================
    local function getCharacter()
        return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    end

    local function resetCollision()
        -- Ketika NoClip dimatikan, kita harus pastikan semua part utama karakter bisa collides lagi agar tidak jatuh menembus lantai
        local char = getCharacter() -- Pastikan kita dapet karakter terbaru (kalau mati respawn)
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    -- Kembalikan collision part utama agar tidak jatuh menembus lantai
                    if part.Name == "HumanoidRootPart" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head" then
                        part.CanCollide = true
                    end
                end
            end
        end
    end

    -- Fast Vault
    local char = LocalPlayer.Character or workspace:FindFirstChild(LocalPlayer.Name) -- Mencari objek player 
    
    if char then
        -- Jika Toggle ON, set speed ke 1.2 (3x lebih cepat di engine game ini) 
        if State.FastVault then
            if char:GetAttribute("vaultspeed") ~= 1.2 then
                char:SetAttribute("vaultspeed", 1.2)
            end
        else
            -- Jika Toggle OFF, kembalikan ke speed normal (1) 
            if char:GetAttribute("vaultspeed") ~= 1 then
                char:SetAttribute("vaultspeed", 1)
            end
        end
    end

    -- Monitor saat NoClip dimatikan (Background Task)
    task.spawn(function()
        local lastState = State.Movement.NoClip
        while task.wait(0.1) do
            if lastState == true and State.Movement.NoClip == false then
                resetCollision()
            end
            lastState = State.Movement.NoClip
        end
    end)

--=====================================================
-- LOGIC: FLIGHT SYSTEM (EMPEROR / GOD MODE WASD)
--=====================================================
local flyBV, flyBG = nil, nil
local flyAnimTrack = nil
local UserInputService = game:GetService("UserInputService")

-- ID Animasi Melayang (Bisa lu ganti kalau punya ID pose dewa lain)
local EMPEROR_ANIM_ID = "rbxassetid://3137836269" 
-- Opsi ID lain kalau mau nyoba pose berbeda: "rbxassetid://8563914515" atau "rbxassetid://10860555615"

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    local isFlying = State.Movement.FlyEnabled or State.Movement.IsCurrentlyFlying

    if not (isFlying and hrp and hum) then 
        -- Bersihkan semua efek saat Fly dimatikan
        if flyBV then flyBV:Destroy(); flyBV = nil end
        if flyBG then flyBG:Destroy(); flyBG = nil end
        if flyAnimTrack then 
            flyAnimTrack:Stop() 
            flyAnimTrack:Destroy()
            flyAnimTrack = nil 
        end
        if hum then 
            hum.AutoRotate = true 
            hum.PlatformStand = false 
        end
        return 
    end

    -- Setup Fisika & Animasi (Hanya dieksekusi sekali pas baru nyala)
    if not flyBV then
        flyBV = Instance.new("BodyVelocity", hrp)
        flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        flyBG = Instance.new("BodyGyro", hrp)
        flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyBG.P = 9000

        -- ✨ MAGIC: LOAD ANIMASI DEWA ✨
        local animator = hum:FindFirstChildOfClass("Animator")
        if animator and not flyAnimTrack then
            local anim = Instance.new("Animation")
            anim.AnimationId = EMPEROR_ANIM_ID
            flyAnimTrack = animator:LoadAnimation(anim)
            flyAnimTrack.Priority = Enum.AnimationPriority.Action4 -- Paksa numpuk animasi lain
            flyAnimTrack.Looped = true
            flyAnimTrack:Play()
            flyAnimTrack:AdjustSpeed(0.2) -- Bikin gerakannya slow-mo biar auranya kerasa
        end
    end

    -- Bikin karakter kaku biar animasi dewa-nya berjalan mulus
    hum.AutoRotate = false
    hum.PlatformStand = true 

    -- 🔥 FIX MOBILE: Gunakan MoveDirection (Membaca Joystick HP dan WASD PC)
    local moveDir = hum.MoveDirection
    
    if moveDir.Magnitude > 0 then
        flyBV.Velocity = moveDir * (State.Movement.FlySpeed or 50)
    else
        flyBV.Velocity = Vector3.zero
    end

    -- Fix Spinbot: Kunci badan menghadap lurus ke depan kamera secara stabil
    local cam = workspace.CurrentCamera
    local camLook = cam.CFrame.LookVector
    local flatLook = Vector3.new(camLook.X, 0, camLook.Z).Unit
    
    if flatLook.Magnitude > 0 then
        -- Gunakan CFrame.lookAt agar tidak error / spinbot
        flyBG.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + flatLook)
    end
end)

-- Bersihkan jika mati/respawn
LocalPlayer.CharacterAdded:Connect(function()
    if flyBV then flyBV:Destroy(); flyBV = nil end
    if flyBG then flyBG:Destroy(); flyBG = nil end
    if flyAnimTrack then flyAnimTrack:Stop(); flyAnimTrack:Destroy(); flyAnimTrack = nil end
end)

--=====================================================
-- MISC SHIELD SYSTEM LOGIC
--=====================================================

-- 1. ANTI AFK
LocalPlayer.Idled:Connect(function()
    if State.Misc.AntiAFK then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end
end)

-- 2. ANTI ADMIN (Detection - UserID Based)
local AdminUserIDs = {
    [239360597] = true, [46285306] = true, [739618054] = true, [1731111957] = true,
    [271036866] = true, [4069187142] = true, [2579663690] = true, [3435625601] = true,
    [1076732745] = true, [115342213] = true, [1806115340] = true, [396125889] = true,
    [1500845039] = true, [1260363902] = true, [566513703] = true, [1243527439] = true,
    [194122127] = true, [2377987690] = true, [119799297] = true, [204813847] = true,
    [410062232] = true, [16644591] = true
}

local function CheckAdmin(plr)
    if State.Misc.AntiAdmin then
        -- Cek berdasarkan UserID Admin Violence District atau indikasi nama mencurigakan
        if AdminUserIDs[plr.UserId] or plr.Name:lower():find("admin") or plr.Name:lower():find("mod") then
            LocalPlayer:Kick("\n[Shield System]\nViolence District Admin/Moderator Detected: " .. plr.Name)
        end
    end
end

-- Deteksi admin jika mereka masuk ke server setelah kamu
Players.PlayerAdded:Connect(CheckAdmin)

-- Loop pengecekan pemain yang sudah ada di server (Aktif jika kamu menyalakan toggle telat)
task.spawn(function()
    while task.wait(5) do
        if State.Misc.AntiAdmin then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    CheckAdmin(plr)
                end
            end
        end
    end
end)

-- 3. ANTI FLING & TOUCH FLING LOOP
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not root or not hum then return end

    -- FIX: Tambahkan pengecekan State.Misc agar tidak nil
    if State.Misc.AntiFling then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                pcall(function() 
                    for _, part in pairs(p.Character:GetChildren()) do -- 🔥 GANTI DI SINI
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                            part.Velocity = Vector3.new(0,0,0)
                            part.RotVelocity = Vector3.new(0,0,0)
                        end
                    end
                end)
            end
        end
    end
    
    -- TOUCH FLING
    if State.Misc.TouchFling then
        local oldV = root.Velocity
        root.Velocity = Vector3.new(20000, 40000, 20000)
        RunService.RenderStepped:Wait()
        root.Velocity = oldV
    end

    -- LOGIC INVISIBLE FLING
    if State.Misc.InvisFling then
        -- Teknik Desync: Paksa state ke Physics agar server kehilangan track posisi akurat
        hum:ChangeState(Enum.HumanoidStateType.Physics)
            
        -- Manipulasi Velocity gila-gilaan
        root.Velocity = Vector3.new(500000, 500000, 500000)
        root.RotVelocity = Vector3.new(500000, 500000, 500000)
            
        -- Bikin badan nembus lantai dikit biar makin ga keliatan
        root.CFrame = root.CFrame * CFrame.new(0, -0.1, 0)
    end

-- 3. AOE FLING LOGIC (Sekarang di dalam loop)
    if State.Misc.AOEFling then
        local radius = State.Misc.FlingRadius or 15
        root.RotVelocity = Vector3.new(0, 50000, 0) -- Spin horizontal super cepat

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local targetHRP = p.Character.HumanoidRootPart
                local dist = (targetHRP.Position - root.Position).Magnitude

                if dist <= radius then
                    -- Dorong target menjauh dengan tenaga raksasa
                    local dir = (targetHRP.Position - root.Position).Unit
                    root.Velocity = dir * 100000 + Vector3.new(0, 50000, 0)
                end
            end
        end
    end

    -- RESET PHYSICS (Jika semua fling mati)
    if not State.Misc.InvisFling and not State.Misc.TouchFling and not State.Misc.AOEFling then
        if root.Velocity.Magnitude > 1000 then
            root.Velocity = Vector3.zero
            root.RotVelocity = Vector3.zero
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end      
end)

--=====================================================
-- LOGIC: POTATO MODE (GOD-TIER FPS BOOST)
--=====================================================
-- Kita pakai task.spawn biar loop ini jalan di background nungguin tombol ditekan
task.spawn(function()
    while task.wait(1) do
        if State.PotatoMode == true then
            -- Langsung ubah ke "Done" biar script ga nge-loop ngeksekusi ini berkali-kali
            State.PotatoMode = "Done" 
            
            local Lighting = game:GetService("Lighting")
            local Terrain = workspace:FindFirstChildOfClass("Terrain")
            
            -- 1. BANTAI LIGHTING & SHADOWS
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.ShadowSoftness = 0
            
            
            for _, v in pairs(Lighting:GetDescendants()) do
                if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                    v.Enabled = false
                end
            end
            
            -- 2. RATAKAN AIR & TERRAIN
            if Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 0
            end
            
            -- 3. THE ULTIMATE TEXTURE KILLER
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                    obj.CastShadow = false
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = 1 
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                    obj.Enabled = false
                end
            end
            
            -- 4. PENJAGA GERBANG (Otomatis ratakan objek baru)
            workspace.DescendantAdded:Connect(function(obj)
                if obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.CastShadow = false
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    obj.Enabled = false
                end
            end)
            
        end
    end
end)

    -- ==========================================
    -- Fungsi Efek Bayangan (Afterimages)
    -- ==========================================
    local function CreateAfterimages(char, duration)
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local visualFolder = Workspace:FindFirstChild("DashVisuals")
        if not visualFolder then
            visualFolder = Instance.new("Folder")
            visualFolder.Name = "DashVisuals"
            visualFolder.Parent = Workspace
        end

        local startTime = os.clock()
        -- Loop selama durasi dash buat bikin bayangan setiap beberapa detik
        task.spawn(function()
            while os.clock() - startTime < duration do
                if not char:FindFirstChild("HumanoidRootPart") then break end
                
                -- Bikin model baru buat bayangan
                local shadowModel = Instance.new("Model")
                shadowModel.Name = "Shadow"
                shadowModel.Parent = visualFolder

                -- Copy semua BasePart yang ada di karakter (Tangan, Kaki, Torso, Head)
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        local clone = part:Clone()
                        clone.Anchored = true
                        clone.CanCollide = false
                        -- Set warna bayangan (biru pudar biar estetik kayak chakra)
                        clone.Color = Color3.fromRGB(100, 150, 255)
                        clone.Material = Enum.Material.Neon
                        clone.Transparency = 0.6
                        clone.Parent = shadowModel
                        
                        -- Hapus Attachment/Script kalau ada yang ikut ter-clone
                        for _, child in pairs(clone:GetChildren()) do
                            if child:IsA("Attachment") or child:IsA("Script") then
                                child:Destroy()
                            end
                        end
                    end
                end
                
                -- Posisikan model bayangan di lokasi karakter saat ini
                local cframe, size = char:GetBoundingBox()
                shadowModel:MoveTo(cframe.p)

                -- Hapus model bayangan setelah pudar
                task.delay(0.15, function() -- Bayangan bertahan 0.15 detik
                    if shadowModel then
                        -- Efek pudarnya
                        for _, p in pairs(shadowModel:GetChildren()) do
                            if p:IsA("BasePart") then
                                p.Transparency = 1
                            end
                        end
                        task.wait(0.05)
                        shadowModel:Destroy()
                    end
                end)

                -- Jeda bikin bayangan berikutnya (makin kecil angkanya makin rapat bayangannya)
                task.wait(0.04) 
            end
        end)
    end
--=====================================================
-- ⚡ FIXED DASH LOGIC (REVISED) ⚡
--=====================================================
local isDashing = false
local DASH_ANIM_1 = "rbxassetid://656118852" 
local DASH_ANIM_2 = "rbxassetid://656117878" 
local DASH_DURATION = 0.35
local DASH_COOLDOWN = 0.5

-- Listener ini langsung menggunakan _G.SharedState agar sinkron dengan UI
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- Kita tetap gunakan _G.SharedState agar update dari UI langsung terbaca
    local State = _G.SharedState
    
    -- Menggunakan Q sebagai default jika DashKey belum ter-set
    local dashKey = (State and State.DashKey) or Enum.KeyCode.Q
    
    if input.KeyCode == dashKey then
        -- Jika EnableDash aktif, jalankan logika
        if State and State.Misc and State.Misc.EnableDash then
            
            -- Debugging: Jika masih tidak muncul, berarti script ini tidak teregistrasi
            
            
            if isDashing then return end
            
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if not hrp or not hum or hum.Health <= 0 then return end
            
            isDashing = true
            
            -- Visual Afterimages (Fungsi ini harus ada di skrip Anda)
            if CreateAfterimages then
                CreateAfterimages(char, DASH_DURATION)
            end
            
            -- Play Animations
            local animator = hum:FindFirstChildOfClass("Animator")
            local track1, track2
            if animator then
                local anim1 = Instance.new("Animation"); anim1.AnimationId = DASH_ANIM_1
                local anim2 = Instance.new("Animation"); anim2.AnimationId = DASH_ANIM_2
                track1 = animator:LoadAnimation(anim1)
                track2 = animator:LoadAnimation(anim2)
                track1:Play()
                track2:Play()
            end
            
            -- Physical Dash Force
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e5, 0, 1e5) 
            bv.Velocity = hrp.CFrame.LookVector * (State.Misc.DashSpeed or 80)
            bv.Parent = hrp
            
            -- Stop Dash & Clean Up
            task.delay(DASH_DURATION, function()
                if bv then bv:Destroy() end
                if track1 then track1:Stop() end
                if track2 then track2:Stop() end
            end)
            
            -- Cooldown Reset
            task.wait(DASH_COOLDOWN)
            isDashing = false
        end
    end
end)
-- Loop untuk stop emote kalau player jalan/loncat
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if hum and (currentTrack or currentSound) then
        if hum.MoveDirection.Magnitude > 0.1 or 
           hum:GetState() == Enum.HumanoidStateType.Jumping or 
           hum:GetState() == Enum.HumanoidStateType.Freefall then
            _G.stopEmote()
        end
    end
end)

--=====================================================
-- LISTENERS: EMOTE KEYBIND DYNAMIC
--=====================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    
    -- Pastikan toggle keybind emote-nya nyala
    if State.EmoteKeybind then
        -- Ambil tombol yang lu setel di UI (Kalau belum di-set, otomatis balik ke V)
        local emoteKeyName = (Library.Options and Library.Options.CustomEmoteKey and Library.Options.CustomEmoteKey.Value) or Enum.KeyCode.V.Name
        
        -- Cek apakah tombol yang ditekan sesuai sama yang di UI
        if input.KeyCode == Enum.KeyCode[emoteKeyName] then
            if State.SelectedEmote then
                _G.playCustomEmote(State.SelectedEmote)
            end
        end
    end
end)

do
--=====================================================
-- LOGIC: ADVANCED KILL AURA & SMART HOOK (PERFECT V3)
--=====================================================
-- Alur: Hunting (Legit/TP) → Knocked → Carry → Teleport Hook (Anchored) → Hook → Reset & Repeat

local UsedHooks = {} 
local CarryRemote = game:GetService("ReplicatedStorage").Remotes.Carry.CarrySurvivorEvent
local HookRemote = game:GetService("ReplicatedStorage").Remotes.Carry.HookEvent
local AttackRemote = game:GetService("ReplicatedStorage").Remotes.Attacks.BasicAttack
local HitRemote = game:GetService("ReplicatedStorage").Remotes.Attacks.hit

-- State internal untuk tracking carry (lebih reliable daripada attribute saja)
State.isCarrying = false

-- Fungsi mencari tiang hook terdekat (Global Search - OPTIMIZED)
local function GetNearestSafeHook(myPos)
    local nearest, nearestDist = nil, math.huge
    
    -- 🔥 FIX: Jangan pakai workspace:GetDescendants()! Pakai ObjectCache lu.
    for obj in pairs(ObjectCache.Hooks) do 
        if obj and obj.Parent then 
            local hookPos = nil
            if obj:IsA("Model") and obj.PrimaryPart then
                hookPos = obj.PrimaryPart.Position 
            elseif obj:IsA("BasePart") then
                hookPos = obj.Position 
            end

            if hookPos then
                local isAlreadyUsed = false
                for _, usedPos in ipairs(UsedHooks) do
                    if (hookPos - usedPos).Magnitude < 15 then
                        isAlreadyUsed = true
                        break
                    end
                end

                if not isAlreadyUsed then
                    local dist = (myPos - hookPos).Magnitude 
                    if dist < nearestDist then
                        nearestDist = dist 
                        nearest = obj 
                    end
                end
            end
        end
    end
    return nearest
end

-- 🔥 SAFETY RESET: Bersihkan semua state carry setelah hook selesai
local function SafetyResetCarry(char, hrp)
    -- 1. Paksa state internal false
    State.isCarrying = false
    
    -- 2. Paksa attribute carry false
    pcall(function() char:SetAttribute("IsCarrying", false) end)
    pcall(function() char:SetAttribute("Carrying", false) end)
    
    -- 3. Hapus SEMUA Weld di HumanoidRootPart (termasuk CarryWeld)
    if hrp then
        for _, child in pairs(hrp:GetChildren()) do
            if child:IsA("Weld") or child:IsA("WeldConstraint") then
                pcall(function() child:Destroy() end)
            end
        end
    end
    
    -- 4. Pastikan hrp tidak ter-anchor
    if hrp then
        hrp.Anchored = false
    end
    
    
end

-- 🔍 DETEKSI CARRY AKURAT: Cek attribute DAN weld fisik
local function IsCurrentlyCarrying(char, hrp)
    -- Cek attribute dari server
    if char:GetAttribute("IsCarrying") or char:GetAttribute("Carrying") then
        return true
    end
    -- Cek internal state
    if State.isCarrying then
        return true
    end
    -- Cek fisik: ada CarryWeld di HRP
    if hrp then
        for _, child in pairs(hrp:GetChildren()) do
            if child:IsA("Weld") or child:IsA("WeldConstraint") then
                if child.Name == "CarryWeld" or child.Name:find("Carry") then
                    return true
                end
            end
        end
    end
    return false
end

local function GetKillerMobileActionBtn()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return nil end
    
    -- Daftar GUI dari riset kamu bro!
    local possibleGuis = {"Hidden-mob", "Slasher-mob", "Killer-mob", "Masked-mob"}
    
    for _, guiName in ipairs(possibleGuis) do
        local killerGui = playerGui:FindFirstChild(guiName)
        if killerGui then
            local actionBtn = killerGui:FindFirstChild("Controls") and killerGui.Controls:FindFirstChild("action")
            if actionBtn then
                return actionBtn
            end
        end
    end
    return nil
end

-- 🏗️ FUNGSI HOOK: Teleport ke tiang hook, stabilkan, lalu hook via VIM
local function PerformHook(char, hrp)
    local hookPart = GetNearestSafeHook(hrp.Position)
    if not hookPart then 
        
        SafetyResetCarry(char, hrp)
        return 
    end
    
    -- Cari survivor yang sedang di-carry (buat verifikasi nanti)
    local carriedSurvivor = nil
    for _, weld in pairs(hrp:GetChildren()) do
        if (weld:IsA("Weld") or weld:IsA("WeldConstraint")) and weld.Part1 then
            local potentialSurvivor = weld.Part1.Parent
            if potentialSurvivor and potentialSurvivor:FindFirstChildOfClass("Humanoid") then
                carriedSurvivor = potentialSurvivor
                break
            end
        end
    end
    -- Fallback: cari dari semua knocked survivors
    if not carriedSurvivor then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Team and p.Team.Name == "Survivors" then
                local pChar = p.Character
                if pChar and (pChar:GetAttribute("Knocked") or pChar:GetAttribute("IsKnocked")) 
                   and not (pChar:GetAttribute("IsHooked") or pChar:GetAttribute("Hooked")) then
                    carriedSurvivor = pChar
                    break
                end
            end
        end
    end
    
    -- Resolve hook target part
    local hookTarget = hookPart:IsA("Model") and (hookPart.PrimaryPart or hookPart:FindFirstChildWhichIsA("BasePart")) or hookPart
    if not hookTarget then
        
        SafetyResetCarry(char, hrp)
        return
    end
    
    -- 1. Stop semua momentum
    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
    
    -- 2. Teleport & SNAP ke depan tiang hook + brief anchor untuk stabilkan posisi
    hrp.CFrame = hookTarget.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(0, math.pi, 0)
    hrp.Anchored = true
    
    task.wait(0.5) -- Brief anchor biar server registrasi posisi
    
    -- 3. UNANCHOR sebelum tekan Space (WAJIB! Prompt tidak muncul kalau anchored)
    hrp.Anchored = false
    task.wait(0.1) -- Kasih waktu biar prompt interaction muncul
    
    -- 4. SPAM VIM SPACE untuk trigger hook interaction (retry sampai berhasil)
    local hookSuccess = false
    local maxAttempts = 8 -- Coba sampai 8x
    
    for attempt = 1, maxAttempts do
        -- Koreksi posisi setiap attempt (biar tetep nempel di depan hook)
        hrp.Velocity = Vector3.zero
        hrp.CFrame = hookTarget.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(0, math.pi, 0)
        
        -- ==========================================
        -- CROSS-PLATFORM HOOK ACTION (PC & MOBILE)
        -- ==========================================
        local actionBtn = GetKillerMobileActionBtn()

        if actionBtn and firesignal then
            -- [MODE MOBILE] Eksekusi tombol action Killer secara dinamis
            pcall(function()
                firesignal(actionBtn.MouseButton1Down)
                firesignal(actionBtn.MouseButton1Click)
                firesignal(actionBtn.MouseButton1Up)
            end)
        else
            -- [MODE PC] Tekan & lepas Space
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end
        -- ==========================================    
        -- Tunggu sebentar lalu cek apakah hook berhasil
        task.wait(0.4)
        
        -- Verifikasi: Cek apakah survivor sudah dapat attribute "IsHooked"
        if carriedSurvivor then
            local isHooked = carriedSurvivor:GetAttribute("IsHooked") or carriedSurvivor:GetAttribute("Hooked")
            if isHooked then
                hookSuccess = true
                -- warn("✅ [Kill Aura] Hook BERHASIL! Survivor: " .. carriedSurvivor.Name)
                break
            end
        end
        
        -- Cek juga apakah kita masih carry (kalau sudah tidak carry = hook berhasil)
        local stillCarrying = IsCurrentlyCarrying(char, hrp)
        if not stillCarrying and attempt > 1 then
            hookSuccess = true
            -- warn("✅ [Kill Aura] Hook berhasil (carry state cleared)")
            break
        end
    end
    
    if hookSuccess then
        -- Hook berhasil! Tunggu animasi selesai
        task.wait(1.0)
        
        -- Catat hook yang sudah dipakai
        table.insert(UsedHooks, hookTarget.Position)
        if #UsedHooks > 20 then table.remove(UsedHooks, 1) end
        -- warn("🪝 [Kill Aura] Hook recorded. Total used: " .. #UsedHooks)
    else
        -- warn("❌ [Kill Aura] Hook GAGAL setelah " .. maxAttempts .. " attempts! Skip hook ini.")
        -- JANGAN masukkan ke UsedHooks biar bisa dicoba lagi nanti
    end
    
    -- 5. SAFETY RESET (selalu dijalankan, berhasil atau gagal)
    SafetyResetCarry(char, hrp)
    
    -- 6. Jeda sebelum loop cari target baru
    -- warn("⏳ [Kill Aura] Cooldown 1 detik sebelum hunting lagi...")
    task.wait(1)
end

-- ═══════════════════════════════════════════════════
-- MAIN KILL AURA LOOP
-- ═══════════════════════════════════════════════════
task.spawn(function()
    while task.wait(0.1) do
        if not State.KillAura then continue end

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp or (LocalPlayer.Team and LocalPlayer.Team.Name ~= "Killer") then continue end

        -- ═══════════════════════════════════════════
        -- CEK STATUS: Apakah lagi gendong survivor?
        -- ═══════════════════════════════════════════
        local carrying = IsCurrentlyCarrying(char, hrp)
        
        if carrying then
            -- ==========================================
            -- 🧲 FASE HOOK: Teleport ke hook & gantung
            -- ==========================================
            PerformHook(char, hrp)
            -- Setelah PerformHook selesai, loop otomatis lanjut ke hunting
            
        else
            -- ==========================================
            -- ⚔️ FASE HUNTING: Cari & serang survivor
            -- ==========================================
            
            -- 🔥 MODE LEGIT: SELALU SWING setiap iterasi (constant animation)
            -- AttackRemote ditembak tanpa peduli ada musuh atau tidak
            if State.AttackMode == "Legit" then
                AttackRemote:FireServer()
            end

            -- Cari target survivor terbaik
            local bestTarget = nil
            local bestDist = math.huge
            local bestChar, bestHrp, bestHum = nil, nil, nil
            local bestIsKnocked = false

            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Team and p.Team.Name == "Survivors" then
                    local pChar = p.Character
                    local pHum = pChar and pChar:FindFirstChildOfClass("Humanoid")
                    local pHrp = pChar and pChar:FindFirstChild("HumanoidRootPart")
                    
                    if not pHrp or not pHum or pHum.Health <= 0 then continue end

                    local isHooked = pChar:GetAttribute("IsHooked") or pChar:GetAttribute("Hooked")
                    if isHooked then continue end

                    local dist = (hrp.Position - pHrp.Position).Magnitude
                    local isKnocked = pChar:GetAttribute("Knocked") == true or pChar:GetAttribute("IsKnocked") == true

                    -- Prioritas: Standing survivor > Knocked survivor
                    if not isKnocked then
                        if dist < bestDist then
                            bestDist = dist
                            bestChar = pChar
                            bestHrp = pHrp
                            bestHum = pHum
                            bestIsKnocked = false
                        end
                    elseif not bestChar or (bestIsKnocked and dist < bestDist) then
                        -- Hanya ambil knocked kalau belum ada standing target
                        if bestIsKnocked or not bestChar then
                            bestDist = dist
                            bestChar = pChar
                            bestHrp = pHrp
                            bestHum = pHum
                            bestIsKnocked = true
                        end
                    end
                end
            end

            -- Proses target yang ditemukan
            local spamCount = State.SpamHitCount or 1

            if bestChar and not bestIsKnocked then
                -- ==========================================
                -- 🔥 ATTACK MODE: Serang survivor berdiri
                -- ==========================================
                if State.AttackMode == "Teleport" then
                    -- Mode TP: Samperin dulu baru spam swing & hit
                    hrp.CFrame = bestHrp.CFrame * CFrame.new(0, 0, 2.5)
                    for i = 1, spamCount do
                        AttackRemote:FireServer()
                        HitRemote:FireServer(bestChar, bestHrp)
                    end
                
                elseif State.AttackMode == "Legit" then
                    -- Mode Legit: Spam HitRemote sesuai slider, HANYA kalau target deket (< 15 studs)
                    -- AttackRemote sudah di-fire di atas (constant swing)
                    if bestDist < 15 then
                        for i = 1, spamCount do
                            HitRemote:FireServer(bestChar, bestHrp)
                        end
                    end
                end
                
            elseif bestChar and bestIsKnocked then
                -- ==========================================
                -- 🔥 CARRY: Angkat survivor yang knocked
                -- ==========================================
                task.wait(0.8) -- Delay setelah knocked agar animasi selesai
                
                -- Re-verify target masih knocked & masih ada
                local stillValid = bestChar and bestChar.Parent
                    and bestHrp and bestHrp.Parent
                    and (bestChar:GetAttribute("Knocked") == true or bestChar:GetAttribute("IsKnocked") == true)
                    and not (bestChar:GetAttribute("IsHooked") or bestChar:GetAttribute("Hooked"))
                
                if stillValid then
                    local currentDist = (hrp.Position - bestHrp.Position).Magnitude
                    
                    if State.AttackMode == "Teleport" or currentDist < 15 then
                        -- Teleport ke target knocked
                        hrp.Velocity = Vector3.zero
                        hrp.CFrame = bestHrp.CFrame * CFrame.new(0, 0, 1)
                        task.wait(0.5) -- Jeda sebelum angkat
                        
                        -- Fire carry remote
                        CarryRemote:FireServer(bestChar)
                        State.isCarrying = true
                        --warn("🏋️ [Kill Aura] Carrying " .. bestChar.Name .. "!")
                        
                        -- Tunggu confirmation dari server (attribute update)
                        task.wait(1.5)
                        
                        -- Double check: kalau attribute belum update tapi ada weld, anggap carry berhasil
                        if not IsCurrentlyCarrying(char, hrp) then
                            -- warn("⚠️ [Kill Aura] Carry mungkin gagal, reset...")
                            State.isCarrying = false
                        end
                    end
                end
            end
        end
    end
end)

--=====================================================
-- LOGIC: ADVANCED HOOK SYSTEM
--=====================================================

task.spawn(function()
    while task.wait(0.1) do
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        -- Cek apakah kita sedang membawa survivor (Carry)
        if char and hrp and IsCurrentlyCarrying(char, hrp) then
            
            -- 1. SILENT HOOK (Hapus Animasi Gantung)
            if State.SilentHook then
                local animator = char:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                        if track.Name:lower():find("hook") or track.Animation.AnimationId:find("hook") then
                            track:Stop()
                        end
                    end
                end
            end

            -- 2. HOOK SPAM & FORCE KILL
            if State.HookSpam or State.ForceKillCarried then
                local nearestHook = GetNearestSafeHook(hrp.Position)
                if nearestHook then
                    local amount = State.HookSpam and State.HookAmount or 1
                    
                    -- Spam tembakan ke remote hook
                    for i = 1, amount do
                        HookRemote:FireServer(nearestHook)
                    end
                    
                    -- Jika Force Kill aktif, kita anggap gantung berkali-kali sampai mati
                    if State.ForceKillCarried then
                        for i = 1, 50 do
                            HookRemote:FireServer(nearestHook)
                        end
                        Library:Notify("Survivor Force Killed!")
                    end
                    
                    task.wait(0.5) -- Cooldown singkat
                end
            end
        end
    end
end)

end
--=====================================================
-- HELPER: SMART POSITIONING (ANTI-WALL DETECTION)
--=====================================================
local function GetOpenPosition(genPart)
    local offsets = {
        CFrame.new(0, 0, 4.5),   -- Depan
        CFrame.new(0, 0, -4.5),  -- Belakang
        CFrame.new(4.5, 0, 0),   -- Kanan
        CFrame.new(-4.5, 0, 0)   -- Kiri
    }
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {genPart.Parent, LocalPlayer.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude

    for _, offset in ipairs(offsets) do
        local targetPos = (genPart.CFrame * offset).Position
        local result = workspace:Raycast(genPart.Position, (targetPos - genPart.Position), raycastParams)
        
        if not result then
            return genPart.CFrame * offset
        end
    end
    return genPart.CFrame * CFrame.new(0, 6, 0) -- Fallback ke atas gen
end

--=====================================================
-- MAIN LOGIC: REPAIR & ESCAPE (CROSS-PLATFORM)
--=====================================================
local VIM = game:GetService("VirtualInputManager")
local isInteracting = false

task.spawn(function()
    
    -- Fungsi mini buat ngatur klik/tahan tombol repair dengan aman
    local function SetRepairInteraction(state)
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        local survMob = playerGui and playerGui:FindFirstChild("Survivor-mob")
        local controls = survMob and survMob:FindFirstChild("Controls")
        local actionBtn = controls and controls:FindFirstChild("action")

        if state then
            -- Tahan tombol repair
            if not isInteracting then
                isInteracting = true
                if actionBtn and firesignal then
                    pcall(function() firesignal(actionBtn.MouseButton1Down) end)
                else
                    VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                end
            end
        else
            -- Lepas tombol repair
            if isInteracting then
                isInteracting = false
                if actionBtn and firesignal then
                    pcall(function() firesignal(actionBtn.MouseButton1Up) end)
                else
                    VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end
            end
        end
    end

    while task.wait(0.3) do
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if not hrp or not State.AutoRepair then 
            SetRepairInteraction(false) -- Lepas klik kalau mati atau fitur dimatikan
            continue 
        end

        -- 🏃 1. PRIORITAS: PANIC ESCAPE
        local killerNear = nil
        if State.PanicEscape then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Team and plr.Team.Name == "Killer" then
                    local kRoot = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if kRoot and (hrp.Position - kRoot.Position).Magnitude < (State.KillerDistance or 30) then
                        killerNear = kRoot
                        break
                    end
                end
            end
        end

        if killerNear then
            SetRepairInteraction(false) -- Lepas tangan dari mesin biar bisa kabur!
            
            local safeGen = nil
            local maxDist = -math.huge
            for gen in pairs(ObjectCache.Generators) do
                local p = gen.PrimaryPart or gen:FindFirstChildWhichIsA("BasePart")
                if p then
                    local d = (p.Position - killerNear.Position).Magnitude
                    if d > maxDist then maxDist = d; safeGen = p end
                end
            end

            if safeGen then
                hrp.CFrame = safeGen.CFrame * CFrame.new(0, 10, 0)
                task.wait(0.5)
                continue -- Loncat ke iterasi berikutnya setelah kabur
            end
        end

        -- 🛠️ 2. AUTO REPAIR (SISTEM KLIK/TAP)
        local nearestGen = nil
        local minDist = math.huge

        for gen in pairs(ObjectCache.Generators) do
            local genPart = gen.PrimaryPart or gen:FindFirstChildWhichIsA("BasePart")
            local progress = gen:GetAttribute("RepairProgress") or 0
            if genPart and progress < 100 then
                local d = (hrp.Position - genPart.Position).Magnitude
                if d < minDist then minDist = d; nearestGen = gen end
            end
        end

        if nearestGen then
            local genPart = nearestGen.PrimaryPart or nearestGen:FindFirstChildWhichIsA("BasePart")
            
            -- Dekati Generator
            if minDist > 6 then
                SetRepairInteraction(false)
                hrp.CFrame = GetOpenPosition(genPart)
                task.wait(0.4)
            end

            -- Mulai Klik/Repair/Tap
            if not isInteracting then
                task.wait(0.1)
                SetRepairInteraction(true)
                
                -- Panggil remote buat mastiin server regis perbaikan
                game:GetService("ReplicatedStorage").Remotes.Generator.RepairEvent:FireServer(nearestGen, true)
            end

            -- Handle Skillcheck (Mode Silent)
            if State.RepairMethod == "Silent" then
                local SkillCheckRemote = game:GetService("ReplicatedStorage").Remotes.Generator.SkillCheckResultEvent
                SkillCheckRemote:FireServer("success", 5, nearestGen)
            end
        else
            -- Kalau nggak ada generator, pastikan lepas tombolnya
            SetRepairInteraction(false)
        end
    end
end)

--=====================================================
-- LOGIC: DYNAMIC BYPASS LEVER & AUTO-CANCEL
--=====================================================
local isPullingLever = false
local currentLever = nil

task.spawn(function()
    local leverEvent = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Exit"):WaitForChild("LeverEvent")

    while task.wait(0.3) do
        -- 1. Cek Toggle UI
        if not State.BypassLever then 
            if isPullingLever and currentLever then
                leverEvent:FireServer(currentLever, false)
                isPullingLever = false
                currentLever = nil
            end
            continue 
        end

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then continue end

        -- 2. Deteksi Pergerakan untuk Cancel (PC: WASD / Mobile: Joystick)
        -- Jika MoveDirection > 0, berarti user sedang mencoba bergerak
        if hum.MoveDirection.Magnitude > 0 then
            if isPullingLever and currentLever then
                leverEvent:FireServer(currentLever, false) -- Kirim sinyal batal ke server
                isPullingLever = false
                currentLever = nil
                -- warn("🚫 Pull Lever Canceled!")
            end
            continue -- Jangan lanjut ke proses tarik jika sedang bergerak
        end

        -- 3. Cari Tuas Secara Dinamis (Menghindari Error Map/Rooftop)
        local foundLever = nil
        local mapFolder = workspace:FindFirstChild("Map")
        if mapFolder then
            -- Mencari semua objek bernama "ExitLever" di mana saja di dalam folder Map
            for _, desc in pairs(mapFolder:GetDescendants()) do
                if desc.Name == "ExitLever" then
                    local mainPart = desc:FindFirstChild("Main")
                    if mainPart then
                        local dist = (hrp.Position - mainPart.Position).Magnitude
                        if dist < 15 then -- Jarak deteksi 15 studs
                            foundLever = mainPart
                            break
                        end
                    end
                end
            end
        end

        -- 4. Eksekusi Tarik Tuas
        if foundLever and not isPullingLever then
            currentLever = foundLever
            isPullingLever = true
            
            -- Kirim sinyal mulai tarik (True)
            leverEvent:FireServer(currentLever, true)
            Library:Notify("Bypass Lever !")
            -- warn("Sent signal : " .. currentLever:GetFullName())
        
        elseif not foundLever and isPullingLever then
            -- Jika menjauh dari tuas tanpa bergerak (misal terdorong), reset status
            isPullingLever = false
            currentLever = nil
        end
    end
end)


--=====================================================
-- MAIN LOGIC: INSTANT SELF HEAL (LOOP SYSTEM)
--=====================================================

task.spawn(function()

    local healRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("HealEvent")
    local skillRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("SkillCheckResultEvent")
    local resetRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Healing"):WaitForChild("Reset") -- Remote baru yang kamu temukan
    while task.wait(0.3) do
        -- Hanya berjalan jika State aktif
        if State.InstantSelfHeal then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            -- Syarat: Karakter ada dan tidak sedang digantung
            if hrp and not char:GetAttribute("IsHooked") then
                

                -- 1. Mulai interaksi Heal
                healRemote:FireServer(hrp, true)
                

                -- BYPASS PROGRESS: Paksa atribut heal langsung ke 99% dan set healing state (biar server anggap lagi proses heal)[cite: 3]
                char:SetAttribute("HealProgress", 99)
                char:SetAttribute("IsHealing", true)

                local animator = hum:FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                        if track.Name:lower():find("heal") or track.Animation.AnimationId:find("heal") then
                            track:Stop()
                        end
                    end
                end

                task.wait(0.1) -- Jeda sinkronisasi tipis
                -- 2. Spam Success SkillCheck[cite: 3]
                pcall(function()
                    for i = 1, 30 do
                        skillRemote:FireServer("success", 5, char)
                    end
                end)

                task.wait(0.3) -- Jeda sebelum tutup interaksi

                -- 3. Tutup interaksi & Bersihkan status[cite: 3]
                healRemote:FireServer(hrp, false)

                resetRemote:FireServer(LocalPlayer) -- Reset status heal di server (remote baru)
                char:SetAttribute("HealProgress", 0)
                char:SetAttribute("IsHealing", false)


                -- 4. MATIKAN STATE (Karena ini 'Instant', kita matikan setelah sekali jalan)[cite: 3]
                State.InstantSelfHeal = false
                
                -- Update tampilan UI agar centangnya hilang (Off) secara visual[cite: 3]
                if Library.Toggles and Library.Toggles.InstantSelfHeal then
                    Library.Toggles.InstantSelfHeal:SetValue(false)
                end

                Library:Notify("Instant Self Heal Success!")
            else
                -- Jika karakter mati/tidak ada, matikan paksa statenya biar gak nyangkut[cite: 3]
                State.InstantSelfHeal = false
                if Library.Toggles and Library.Toggles.InstantSelfHeal then
                    Library.Toggles.InstantSelfHeal:SetValue(false)
                end
            end
        end
    end
end)


-- Sets the draggable label visibility
--=====================================================
-- WATERMARK SYSTEM & UI TOGGLE
--=====================================================
-- 1. Setup Watermark Label
local DraggableLabel = Library:AddDraggableLabel("boyfinity")
DraggableLabel:SetVisible(true)
 
local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60
 
-- 2. Logic Update FPS & Ping
game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1
 
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameTimer = tick()
        FrameCounter = 0
    end
 
    DraggableLabel:SetText(('boyfinity | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)

-- 3. Tambahkan Toggle ke Settings Tab (MenuGB)
-- Karena MenuGB udah dideklarasiin di atas, kita bisa langsung panggil di sini
if MenuGB then
    MenuGB:AddToggle("ShowWatermark", {
        Text = "Show Watermark",
        Default = true,
        Tooltip = "Tampilkan label watermark boyfinity | fps | ping",
        Callback = function(Value)
            -- Sembunyikan atau tampilkan label sesuai status toggle
            DraggableLabel:SetVisible(Value)
        end
    })
end

--=====================================================
-- 1. SKYBOX DATA & APPLY FUNCTION
--=====================================================
local SkyData = {
    ["Night City"] = { -- Mapped dari "Night" di gambar lo
        ["CelestialBodiesShown"] = false,
        ["StarCount"] = 0,
        ["MoonAngularSize"] = 11,
        ["MoonTextureId"] = "rbxasset://sky/moon.jpg",
        ["SunAngularSize"] = 21,
        ["SunTextureId"] = "rbxasset://sky/sun.jpg",
        ["SkyboxBk"] = "http://www.roblox.com/asset/?id=12064107",
        ["SkyboxDn"] = "http://www.roblox.com/asset/?id=12064152",
        ["SkyboxFt"] = "http://www.roblox.com/asset/?id=12064121",
        ["SkyboxLf"] = "http://www.roblox.com/asset/?id=12063984",
        ["SkyboxRt"] = "http://www.roblox.com/asset/?id=12064115",
        ["SkyboxUp"] = "http://www.roblox.com/asset/?id=12064131",
    },
    ["Deep Space"] = { -- Mapped dari "Space" di gambar lo
        ["CelestialBodiesShown"] = false,
        ["StarCount"] = 3000,
        ["MoonAngularSize"] = 11,
        ["MoonTextureId"] = "rbxasset://sky/moon.jpg",
        ["SunAngularSize"] = 21,
        ["SunTextureId"] = "rbxasset://sky/sun.jpg",
        ["SkyboxBk"] = "http://www.roblox.com/asset/?id=149397692",
        ["SkyboxDn"] = "http://www.roblox.com/asset/?id=149397686",
        ["SkyboxFt"] = "http://www.roblox.com/asset/?id=149397697",
        ["SkyboxLf"] = "http://www.roblox.com/asset/?id=149397684",
        ["SkyboxRt"] = "http://www.roblox.com/asset/?id=149397688",
        ["SkyboxUp"] = "http://www.roblox.com/asset/?id=149397702",
    },
    ["None"] = { -- Mode polosan dari gambar lo
        ["CelestialBodiesShown"] = false,
        ["StarCount"] = 0,
        ["SkyboxBk"] = "http://www.roblox.com/asset/?id=2675785344",
        ["SkyboxDn"] = "http://www.roblox.com/asset/?id=2675785344",
        ["SkyboxFt"] = "http://www.roblox.com/asset/?id=2675785344",
        ["SkyboxLf"] = "http://www.roblox.com/asset/?id=2675785344",
        ["SkyboxRt"] = "http://www.roblox.com/asset/?id=2675785344",
        ["SkyboxUp"] = "http://www.roblox.com/asset/?id=2675785344",
    },
    -- Untuk yang lain, gue pake format properti yang sama biar aktif
    ["Anime Sunset"] = {
        ["SkyboxBk"] = "rbxassetid://12064573", ["SkyboxDn"] = "rbxassetid://12064521", 
        ["SkyboxFt"] = "rbxassetid://12064548", ["SkyboxLf"] = "rbxassetid://12064596", 
        ["SkyboxRt"] = "rbxassetid://12064611", ["SkyboxUp"] = "rbxassetid://12064631"
    },
    ["Vaporwave"] = {
        ["SkyboxBk"] = "rbxassetid://1417491756", ["SkyboxDn"] = "rbxassetid://1417491410", 
        ["SkyboxFt"] = "rbxassetid://1417492131", ["SkyboxLf"] = "rbxassetid://1417491958", 
        ["SkyboxRt"] = "rbxassetid://1417492330", ["SkyboxUp"] = "rbxassetid://1417492582"
    }
}

--=====================================================
-- UPDATED APPLY FUNCTION (FULL INJECTION)
--=====================================================
_G.ApplySkybox = function(name)
    local Lighting = game:GetService("Lighting")
    
    -- Bersihkan Skybox lama
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end
    
    if name == "Default" then return end
    
    local data = SkyData[name]
    if data then
        local newSky = Instance.new("Sky")
        -- Inject semua properti (StarCount, SkyboxBk, dll)
        for prop, val in pairs(data) do
            pcall(function()
                newSky[prop] = val
            end)
        end
        newSky.Parent = Lighting
    end
end

--=====================================================
-- 2. ENVIRONMENT ENFORCEMENT LOOP
--=====================================================
RunService.RenderStepped:Connect(function()
    local S = _G.SharedState
    if not S then return end

    -- Logic Jam (Time of Day)
    if S.CustomTime then
        game:GetService("Lighting").ClockTime = S.CustomTime
    end

    -- Logic Hapus Kabut (Remove Fog)
    if S.RemoveFog then
        game:GetService("Lighting").FogEnd = 100000
        for _, obj in pairs(game:GetService("Lighting"):GetChildren()) do
            if obj:IsA("Atmosphere") then
                obj.Density = 0
            end
        end
    end
end)

--=====================================================
-- 3. DYNAMIC ESP COLOR INJECTION
--=====================================================
-- Pastikan tabel warna terinisialisasi agar tidak error saat pertama load
State.ESP.KillerColor = State.ESP.KillerColor or Color3.fromRGB(255, 0, 0)
State.ESP.SurvivorColor = State.ESP.SurvivorColor or Color3.fromRGB(0, 255, 0)
State.ESP.GenColor = State.ESP.GenColor or Color3.fromRGB(255, 255, 0)
State.ESP.GateColor = State.ESP.GateColor or Color3.fromRGB(227, 227, 227)
State.ESP.PalletColor = State.ESP.PalletColor or Color3.fromRGB(255, 221, 116)
State.ESP.WindowColor = State.ESP.WindowColor or Color3.fromRGB(255, 227, 128)
State.ESP.HookColor = State.ESP.HookColor or Color3.fromRGB(255, 45, 45) 

-- Fungsi Helper untuk mendapatkan warna ESP yang dipilih user di UI
local function GetESPColor(objType, isKiller, isSurvivor, specialStatus)
    local E = State.ESP
    
    if isKiller then return E.KillerColor end
    if isSurvivor then
        -- Jika survivor sedang dihook atau knocked, lo bisa pilih pake warna custom atau warna picker
        if specialStatus == "Hooked" then return Color3.fromRGB(255, 80, 0) end
        if specialStatus == "Knocked" then return Color3.fromRGB(255, 255, 0) end
        return E.SurvivorColor
    end
    
    -- Warna untuk Objek
    if objType == "Generators" then return E.GenColor end
    if objType == "Gates" then return E.GateColor end
    if objType == "Pallets" then return E.PalletColor end
    if objType == "Windows" then return E.WindowColor end
    if objType == "Hooks" then return E.HookColor end
    
    return Color3.fromRGB(255, 255, 255) -- Putih jika tidak terdefinisi
end

--=====================================================
-- 2. LOGIC: PHYSICS, SPIN & MOONWALK
--=====================================================
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

UserInputService.JumpRequest:Connect(function()
    -- 1. Cek aman apakah State dan toggle-nya benar-benar ada dan aktif
    if State and State.InfiniteJump then
        local char = Players.LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            -- 2. Gunakan pcall agar jika ChangeState diblokir/nil, game tidak crash
            if hum then
                pcall(function()
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end)
            end
        end
    end
end)

-- [B] MAIN MOVEMENT LOOP
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    -- Update JumpPower
    if State.JumpPower then hum.JumpPower = State.JumpPower end

    -- Spinbot Logic
    if State.Spinbot then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(State.SpinSpeed or 50), 0)
    end

    -- Moonwalk Logic: Karakter menghadap kamera (Mundur)
    if State.MoonwalkEnabled and State.MoonwalkActive then
        hum.AutoRotate = false -- Matikan rotasi otomatis agar tidak bentrok
        
        local camLook = camera.CFrame.LookVector
        -- Karakter menghadap sebaliknya dari arah kamera (Mundur)
        local targetRotation = CFrame.lookAt(hrp.Position, hrp.Position + Vector3.new(camLook.X, 0, camLook.Z)) * CFrame.Angles(0, math.pi, 0)
        
        -- Gunakan LERP (0.2) agar transisi rotasi halus, tidak kaku saat digerakkan WASD
        hrp.CFrame = hrp.CFrame:Lerp(targetRotation, 0.2)
    else
        -- Kembalikan kontrol rotasi ke game jika fitur mati atau mode normal
        if not State.Spinbot then 
            hum.AutoRotate = true 
        end
    end
end)

do
--=====================================================
-- BOYFINITY ULTRA-STEALTH: ANTI-CAMP FOLLOW V10 (FINAL SUCCESS)
--=====================================================
local isStealthActive = false
local fakeBody = nil
local originalHookCFrame = nil
local originalCameraCFrame = nil
local visualState = {}

-- 1. FUNGSI VISIBILITY (ANTI-WHITE CHARACTER)
local function SetCharVisibility(char, hide)
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Texture") then
            if hide then
                visualState[part] = part.Transparency
                part.Transparency = 1
            else
                part.Transparency = visualState[part] or 0
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 0
                end
            end
        end
    end

    if not hide then
        table.clear(visualState) -- Bersihkan cache
    end
end

-- 2. FUNGSI CLONE (GHOST BODY)
local function CreateFakeBody(char)
    if fakeBody then fakeBody:Destroy() end
    char.Archivable = true
    fakeBody = char:Clone()
    fakeBody.Name = "Boyfinity_Ghost"

    for _, obj in pairs(fakeBody:GetDescendants()) do
        if obj:IsA("LuaSourceContainer") or obj:IsA("Sound") then
            obj:Destroy()
        end
    end

    fakeBody.Parent = workspace
    for _, part in pairs(fakeBody:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = true
            part.CanCollide = false
        end
    end
    return fakeBody
end

-- 3. MAIN LOGIC ANTI-CAMP (DEBUG MODE)
task.spawn(function()
    while task.wait(0.2) do
        local S = _G.SharedState
        if not S or not S.AntiCampFollow then continue end

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local isHooked = char and (char:GetAttribute("IsHooked") or char:GetAttribute("Hooked"))

        if isHooked and not isStealthActive then
            isStealthActive = true
            originalHookCFrame = hrp.CFrame
            originalCameraCFrame = workspace.CurrentCamera.CFrame

            -- STEP 1: Deploy Ghost & Hide Original
            local ghost = CreateFakeBody(char)
            local ghostHum = ghost:FindFirstChildOfClass("Humanoid")
            SetCharVisibility(char, true)

            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
            workspace.CurrentCamera.CFrame = originalCameraCFrame

            -- STEP 2: TELEPORT KE GENERATOR (Mancing Charge)
            local targetGen = nil
            for gen in pairs(ObjectCache.Generators) do
                local genPart = gen.PrimaryPart or gen:FindFirstChildWhichIsA("BasePart", true)
                if genPart and (gen:GetAttribute("RepairProgress") or 0) < 100 then
                    targetGen = gen
                    break
                end
            end

            if targetGen then
                local genPart = targetGen.PrimaryPart or targetGen:FindFirstChildWhichIsA("BasePart", true)
                local openPos = GetOpenPosition(genPart)
                hrp.CFrame = openPos
                task.wait(0.5)

                -- =====================================================
                -- PANCING REPAIR GENERATOR (CROSS-PLATFORM PC & MOBILE)
                -- =====================================================
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                local survMob = playerGui and playerGui:FindFirstChild("Survivor-mob")
                local actionBtn = survMob and survMob:FindFirstChild("Controls") and survMob.Controls:FindFirstChild("action")
                
                if actionBtn and firesignal then
                    -- [MODE MOBILE] Pencet tombol repair di layar HP
                    pcall(function()
                        firesignal(actionBtn.MouseButton1Down)
                        firesignal(actionBtn.MouseButton1Click)
                        task.wait(0.1)
                        firesignal(actionBtn.MouseButton1Up)
                    end)
                else
                    -- [MODE PC] Klik kiri (Mouse) pakai VIM
                    VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(0.1)
                    VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end
                -- =====================================================
            end

            -- STEP 3: UNDERGROUND STALKER LOOP
            while State.AntiCampFollow and isStealthActive do
                local killer = nil
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p.Team and p.Team.Name == "Killer" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        killer = p.Character.HumanoidRootPart
                        break
                    end
                end

                if killer and hrp then
                    hrp.Velocity = Vector3.zero
                    hrp.CFrame = killer.CFrame * CFrame.new(0, -18, 0)
                end

                local charge = LocalPlayer:GetAttribute("anticampCharge") or 0

                -- Trigger lepas diri kalau sudah 100%
                if charge >= 100 then
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                    if hum then workspace.CurrentCamera.CameraSubject = hum end

                    if hrp then
                        hrp.Anchored = true 
                        hrp.Velocity = Vector3.zero
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        hrp.CFrame = originalHookCFrame * CFrame.new(0, 4, 0) -- Angkat sedikit lebih tinggi
                    end
                    task.wait(0.1)

                    if fakeBody then fakeBody:Destroy(); fakeBody = nil end
                    SetCharVisibility(char, false)

                    task.wait(0.1)
                    ReplicatedStorage.Remotes.Carry.SelfUnHookEvent:FireServer()

                    local timeout = 0
                    repeat
                        task.wait(0.1)
                        timeout = timeout + 0.1
                        hrp.CFrame = originalHookCFrame
                    until not (char:GetAttribute("IsHooked") or char:GetAttribute("Hooked")) or timeout > 2
                    
                    if hrp then hrp.Anchored = false end
                    break
                end

                -- Emergency break kalau unhooked manual sama temen
                if not (char:GetAttribute("IsHooked") or char:GetAttribute("Hooked")) then break end
                task.wait()
            end

            -- STEP 4: FINAL CLEANUP & RESTORE
            if fakeBody then
                fakeBody:Destroy()
                fakeBody = nil
            end

            local camera = workspace.CurrentCamera
            task.spawn(function()
                -- Kita spam restore subject selama 0.5 detik biar nggak dikalahin script game
                local resetTime = 0
                while resetTime < 0.5 do
                    camera.CameraType = Enum.CameraType.Custom
                    camera.CameraSubject = hum -- Balikin ke Humanoid asli lu
                    task.wait(0.1)
                    resetTime = resetTime + 0.1
                end
            end)

            task.wait(0.3)

            if hrp then
                hrp.Velocity = Vector3.zero
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.CFrame = originalHookCFrame * CFrame.new(0, 3, 0)
            end

            SetCharVisibility(char, false)

            isStealthActive = false
            S.AntiCampFollow = false
            if Library.Toggles.AntiCampFollow then
                Library.Toggles.AntiCampFollow:SetValue(false)
            end
        end
    end
end)

end 

--=====================================================
-- LOGIC: SPECTATOR LIST (TEAM BASED)
--=====================================================
local lastSpectatorUpdate = tick()

RunService.RenderStepped:Connect(function()
    -- Kalau toggle di UI dimatikan, sembunyikan total
    if not State.SpectatorList then 
        if _G.SpecFrame then _G.SpecFrame.Visible = false end
        return 
    end
    
    -- Kalau toggle nyala, pastikan kotaknya selalu terlihat
    if _G.SpecFrame then _G.SpecFrame.Visible = true end
    
    if tick() - lastSpectatorUpdate >= 0.5 then
        lastSpectatorUpdate = tick()
        local spectators = {}

        local myTeam = LocalPlayer.Team
        local teamName = myTeam and myTeam.Name or ""
        
        -- Cek apakah kita sedang di dalam match
        local isPlayingMatch = (teamName == "Survivors" or teamName == "Killer")

        -- ⚡ LOGIC BARU: Kalau kita lagi main, kumpulkan semua orang yang ada di tim Spectator
        if isPlayingMatch then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local pTeam = player.Team
                    local pTeamName = pTeam and pTeam.Name or ""
                    
                    -- Masukkan player ke daftar jika dia adalah Spectator
                    if pTeamName == "Spectator" or pTeamName == "Spectators" then
                        table.insert(spectators, player.Name)
                    end
                end
            end
        end
        -- Kalau isPlayingMatch false (lu lagi di lobby/spectator), 'spectators' bakal tetap kosong

        -- Update UI Text & Size (Kotak tetep draggable dari logic sebelumnya)
        if _G.SpecListLabel and _G.SpecFrame then
            if #spectators > 0 then
                _G.SpecListLabel.Text = table.concat(spectators, "\n")
                _G.SpecFrame.Size = UDim2.new(0, 150, 0, 30 + (#spectators * 15)) 
            else
                _G.SpecListLabel.Text = "None"
                _G.SpecFrame.Size = UDim2.new(0, 150, 0, 45)
            end
        end
    end
end)


do
--=====================================================
-- LOGIC: AIMBOT GLOBAL (SMART CAMERA LOCK)
--=====================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Bikin State Table kalau belum ada (biar gak error)
local State = _G.SharedState or getgenv().State
if not State.GlobalAim then State.GlobalAim = {} end

-- Variabel Status Tombol
local isAimKeyDown = false

-- 2. DETEKSI INPUT (HOLD KLIK KIRI)
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    -- MouseButton1 = Klik Kiri
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isAimKeyDown = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isAimKeyDown = false
    end
end)

local currentAttackBtn = nil
local atkBtnDownConn = nil
local atkBtnUpConn = nil
_G.GlobalAimMobile = false

RunService.Heartbeat:Connect(function()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return end

    -- Kumpulan nama GUI Mobile dari semua tipe Killer
    local killerGuis = {"Hidden-mob", "Slasher-mob", "Killer-mob", "Masked-mob"}
    local activeAttackBtn = nil

    -- Cari mana GUI yang lagi aktif di layar sekarang
    for _, guiName in ipairs(killerGuis) do
        local mobGui = playerGui:FindFirstChild(guiName)
        if mobGui then
            local controls = mobGui:FindFirstChild("Controls")
            if controls then
                activeAttackBtn = controls:FindFirstChild("attack")
                if activeAttackBtn then break end -- Ketemu tombolnya! Langsung stop pencarian
            end
        end
    end

    -- Safety Reset jika tombol hilang (misal match selesai atau mati)
    if currentAttackBtn and not currentAttackBtn.Parent then
        _G.GlobalAimMobile = false
        currentAttackBtn = nil
    end

    -- Pasang mata-mata (Listener) ke tombol attack yang baru ketemu
    if activeAttackBtn and activeAttackBtn ~= currentAttackBtn then
        if atkBtnDownConn then atkBtnDownConn:Disconnect() end
        if atkBtnUpConn then atkBtnUpConn:Disconnect() end
        
        currentAttackBtn = activeAttackBtn
        
        atkBtnDownConn = currentAttackBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                _G.GlobalAimMobile = true
            end
        end)
        
        atkBtnUpConn = currentAttackBtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                _G.GlobalAimMobile = false
            end
        end)
    end
end)

-- 3. FUNGSI CEK VISIBILITY (TEMBUS TEMBOK ATAU NGGAK)
local function IsTargetVisible(targetPart)
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, rayParams)
    
    -- Kalau nabrak sesuatu dan itu bagian dari karakter target, berarti KELIHATAN
    if result and result.Instance then
        if result.Instance:IsDescendantOf(targetPart.Parent) then
            return true
        else
            return false -- Nabrak tembok/pohon
        end
    end
    return true
end

-- 4. FUNGSI MENCARI TARGET TERDEKAT DARI KURSOR (FOV)
local function GetGlobalAimTarget()
    local bestTarget = nil
    local shortestDist = State.GlobalAim.AimFOV or 150
    local mousePos = UserInputService:GetMouseLocation()
    
    local targetPartName = State.GlobalAim.TargetPart or "Head"

    for _, plr in pairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        
        -- Filter Tim: Jangan aim temen sendiri
        if plr.Team == LocalPlayer.Team then continue end
        
        local char = plr.Character
        if not char then continue end
        
        local hum = char:FindFirstChildOfClass("Humanoid")
        local targetNode = char:FindFirstChild(targetPartName)
        
        if hum and hum.Health > 0 and targetNode then
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetNode.Position)
            
            if onScreen then
                local distFromMouse = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                
                if distFromMouse < shortestDist then
                    -- Cek Visibility kalau fiturnya dinyalain di UI
                    if State.GlobalAim.VisibilityCheck then
                        if not IsTargetVisible(targetNode) then continue end
                    end
                    
                    shortestDist = distFromMouse
                    bestTarget = targetNode
                end
            end
        end
    end
    return bestTarget
end

-- 5. MAIN LOOP (RENDER STEPPED)
RunService.RenderStepped:Connect(function()
    local S = State.GlobalAim
    if not S then return end

    local mousePos = UserInputService:GetMouseLocation()

    -- [B] CARI TARGET JIKA TOMBOL DITAHAN (PC & MOBILE)
    local currentTarget = nil
    if S.Aimlock and (isAimKeyDown or _G.GlobalAimMobile) then
        currentTarget = GetGlobalAimTarget()
    end

    -- [C] EKSEKUSI AIMBOT & DRAWING
    if currentTarget then
        local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
        
        -- LOGIC CAMERA LOCK & SMOOTHING
        -- Rumus: Makin kecil Smoothing, makin instan. Makin besar (10), makin pelan/halus
        local smoothingValue = S.Smoothing or 1
        local lerpFactor = 1 / smoothingValue
        
        -- Kalau smoothing 1, anggap instan aja biar nggak delay sama sekali
        if smoothingValue == 1 then lerpFactor = 1 end 

        -- Kunci target!
        local lookCFrame = CFrame.new(Camera.CFrame.Position, currentTarget.Position)
        Camera.CFrame = Camera.CFrame:Lerp(lookCFrame, lerpFactor)
        
    end
end)
end


--=====================================================
-- LOGIC: CUSTOM AMBIENCE (FIXED)
--=====================================================
local Lighting = game:GetService("Lighting")

-- 1. Simpan warna original bawaan game saat script pertama kali jalan
local OriginalAmbient = Lighting.Ambient
local OriginalOutdoorAmbient = Lighting.OutdoorAmbient

-- 2. Tracker untuk ngecek apakah sebelumnya fitur ini nyala
local wasCustomAmbienceOn = false

RunService.RenderStepped:Connect(function()
    -- Pastikan toggle-nya nyala
    if State.CustomAmbience then
        -- Mencegah bentrok: Kalau FullBright lagi jalan dengan persentase tinggi, 
        -- biasanya dia bakal maksa ambient ke putih (1,1,1). 
        -- Logic ini bakal nimpa FullBright buat urusan warna ambience-nya.
        Lighting.Ambient = State.AmbientColor
        Lighting.OutdoorAmbient = State.OutdoorAmbientColor
        wasCustomAmbienceOn = true
    else
        -- Jika dimatikan, balikin ke warna aslinya HANYA SEKALI biar ga bentrok
        if wasCustomAmbienceOn then
            Lighting.Ambient = OriginalAmbient
            Lighting.OutdoorAmbient = OriginalOutdoorAmbient
            wasCustomAmbienceOn = false
        end
    end
end)

--=====================================================
-- LOGIC: GENERATOR TELEPORT VIA KEYBIND
--=====================================================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    -- Cek apakah toggle fiturnya nyala
    if not State.EnableGenTP then return end
    
    -- Ambil tombol yang diset di UI Obsidian
    local tpKeyName = (Library.Options and Library.Options.GenTPKeybind and Library.Options.GenTPKeybind.Value) or Enum.KeyCode.T.Name
    
    if input.KeyCode == Enum.KeyCode[tpKeyName] then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        -- 1. Kumpulin semua generator yang belum selesai (progress < 100)
        local validGens = {}
        for gen in pairs(ObjectCache.Generators) do
            local genPart = gen.PrimaryPart or gen:FindFirstChildWhichIsA("BasePart")
            local progress = gen:GetAttribute("RepairProgress") or 0
            
            if genPart and progress < 100 then
                table.insert(validGens, genPart)
            end
        end
        
        -- Kalau udah kelar semua
        if #validGens == 0 then
            Library:Notify("Semua generator sudah selesai atau tidak ditemukan!")
            return
        end
        
        local targetGenPart = nil
        
        -- 2. Seleksi Target Berdasarkan Mode
        if State.GenTPMode == "Nearest" then
            local shortestDist = math.huge
            for _, part in ipairs(validGens) do
                local dist = (hrp.Position - part.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    targetGenPart = part
                end
            end
        elseif State.GenTPMode == "Random" then
            -- Pilih acak dari list generator yang masih nyala
            local randomIndex = math.random(1, #validGens)
            targetGenPart = validGens[randomIndex]
        end
        
        -- 3. Eksekusi Teleport
        if targetGenPart then
            -- Teleport 10 studs di atas generator biar gak nyangkut
            hrp.CFrame = targetGenPart.CFrame + Vector3.new(0, 10, 0)
            Library:Notify("⚡ Teleported to " .. State.GenTPMode .. " Generator!")
        end
    end
end)

--=====================================================
-- LOGIC: FAKE KNOCKDOWN
--=====================================================
_G.isFakeKnocked = false
local fakeKnockedTrack = nil

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and State.FakeKnockdown then
        local keyStr = (Library.Options and Library.Options.FakeKnockKey and Library.Options.FakeKnockKey.Value) or Enum.KeyCode.Z.Name
        
        if input.KeyCode == Enum.KeyCode[keyStr] then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if hum and hum.Health > 0 then
                if _G.isFakeKnocked then
                    -- ⬆️ BANGUN
                    _G.isFakeKnocked = false
                    if fakeKnockedTrack then
                        fakeKnockedTrack:Stop()
                        fakeKnockedTrack:Destroy()
                        fakeKnockedTrack = nil
                    end
                    -- Kembalikan kecepatan normal
                    hum.WalkSpeed = 16
                    hum.JumpPower = 50
                else
                    -- ⬇️ JATUH PURA-PURA MATI
                    _G.isFakeKnocked = true
                    local animator = hum:FindFirstChildOfClass("Animator")
                    if animator then
                        local anim = Instance.new("Animation")
                        anim.AnimationId = "rbxassetid://126526181422628" -- ID Animasi dari lu
                        fakeKnockedTrack = animator:LoadAnimation(anim)
                        
                        -- Paksa Action4 biar nipanya kuat dan ngeloop terus
                        fakeKnockedTrack.Priority = Enum.AnimationPriority.Action4
                        fakeKnockedTrack.Looped = true
                        fakeKnockedTrack:Play()
                    end
                    
                    -- Bikin kecepatan melambat drastis kayak orang ngerangkak/jatuh
                    hum.WalkSpeed = 3
                    hum.JumpPower = 0
                end
            end
        end
    end
end)

-- Bersihkan memori saat respawn agar tidak error
LocalPlayer.CharacterAdded:Connect(function()
    _G.isFakeKnocked = false
    fakeKnockedTrack = nil
end)

--=====================================================
-- 📱 MOBILE ACTION BUTTONS (INDEPENDENT DRAGGABLE)
--=====================================================
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled -- Deteksi apakah device support layar sentuh

-- 🔥 BUNGKUS SEMUA KODE DI BAWAH INI PAKAI IF isMobile 🔥
if isMobile then
    if _G.MobileActionGui then _G.MobileActionGui:Destroy() end

    local MobileActionGui = Instance.new("ScreenGui")
    MobileActionGui.Name = "BoyfinityMobileActions"
    MobileActionGui.Parent = game:GetService("CoreGui")
    _G.MobileActionGui = MobileActionGui

    -- Fungsi Pembuat Tombol Independen (Setiap tombol punya drag sendiri)
    local function CreateIndependentButton(name, icon, label, defaultPos, callback)
        -- ... (ISI FUNGSI INI BIARKAN SAMA SEPERTI ASLINYA) ...
        -- 🛠️ FIX TOTAL: Proteksi pergeseran argumen karena emoji hilang
        if type(defaultPos) == "function" then
            callback = defaultPos
            defaultPos = label
            label = icon
            icon = ""
        end

        icon = type(icon) == "string" and icon or ""
        label = type(label) == "string" and label or ""
        if typeof(defaultPos) ~= "UDim2" then 
            defaultPos = UDim2.new(0, 15, 0.4, 0)
        end

        local Wrapper = Instance.new("Frame")
        Wrapper.Name = name .. "_Wrapper"
        Wrapper.Parent = MobileActionGui
        Wrapper.BackgroundTransparency = 1
        Wrapper.Position = defaultPos 
        Wrapper.Size = UDim2.new(0, 55, 0, 65) 
        Wrapper.Visible = false 

        local DragHandle = Instance.new("Frame")
        DragHandle.Name = "DragHandle"
        DragHandle.Parent = Wrapper
        DragHandle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        DragHandle.Size = UDim2.new(0, 30, 0, 5) 
        DragHandle.Position = UDim2.new(0.5, -15, 0, 0) 
        DragHandle.Active = true
        Instance.new("UICorner", DragHandle).CornerRadius = UDim.new(1, 0)

        local dragging, dragInput, dragStart, startPos

        DragHandle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Wrapper.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        DragHandle.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                Wrapper.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Parent = Wrapper
        btn.BackgroundColor3 = Color3.fromRGB(28, 18, 45)
        btn.Position = UDim2.new(0, 0, 0, 10) 
        btn.Size = UDim2.new(1, 0, 1, -10) 
        
        btn.Font = Enum.Font.GothamBold
        if icon == "" then
            btn.Text = label
        else
            btn.Text = icon .. "\n" .. label 
        end
        btn.TextColor3 = Color3.fromRGB(220, 220, 255)
        btn.TextSize = 11 
        btn.TextWrapped = true 
        btn.AutoButtonColor = true

        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local stroke = Instance.new("UIStroke")
        stroke.Parent = btn
        stroke.Color = Color3.fromRGB(70, 36, 138)
        stroke.Thickness = 1.5
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        btn.MouseButton1Click:Connect(callback)
        
        return Wrapper
    end

    -- =====================================================
    -- BIKIN TOMBOL-TOMBOLNYA
    -- =====================================================
    _G.MobileBtns = {
        FakeParry = CreateIndependentButton("FakeParryBtn", "Parry", UDim2.new(0, 15, 0.35, 0), function()
            -- (ISI FUNGSI BIARKAN SAMA)
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                local animator = hum:FindFirstChildOfClass("Animator")
                if animator then
                    local anim = Instance.new("Animation")
                    anim.AnimationId = "rbxassetid://127096285501517" 
                    local track = animator:LoadAnimation(anim)
                    track.Priority = Enum.AnimationPriority.Action 
                    track:Play()
                end
            end
        end),
        
        Emote = CreateIndependentButton("EmoteBtn", "Emote", UDim2.new(0, 15, 0.35, 75), function()
            local S = _G.SharedState
            if S and S.SelectedEmote then
                _G.playCustomEmote(S.SelectedEmote)
            end
        end),
        
        FakeKnock = CreateIndependentButton("FakeKnockBtn", "Knock", UDim2.new(0, 15, 0.35, 150), function()
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                if _G.isFakeKnocked then
                    _G.isFakeKnocked = false
                    if _G.fakeKnockedTrackMobile then
                        _G.fakeKnockedTrackMobile:Stop()
                        _G.fakeKnockedTrackMobile:Destroy()
                        _G.fakeKnockedTrackMobile = nil
                    end
                    hum.WalkSpeed = 16
                    hum.JumpPower = 50
                else
                    _G.isFakeKnocked = true
                    local animator = hum:FindFirstChildOfClass("Animator")
                    if animator then
                        local anim = Instance.new("Animation")
                        anim.AnimationId = "rbxassetid://126526181422628"
                        _G.fakeKnockedTrackMobile = animator:LoadAnimation(anim)
                        _G.fakeKnockedTrackMobile.Priority = Enum.AnimationPriority.Action4
                        _G.fakeKnockedTrackMobile.Looped = true
                        _G.fakeKnockedTrackMobile:Play()
                    end
                    hum.WalkSpeed = 3
                    hum.JumpPower = 0
                end
            end
        end),
        
        GenTP = CreateIndependentButton("GenTPBtn","TP Gen", UDim2.new(0, 15, 0.35, 225), function()
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            local validGens = {}
            for gen in pairs(ObjectCache.Generators) do
                local genPart = gen.PrimaryPart or gen:FindFirstChildWhichIsA("BasePart")
                if genPart and (gen:GetAttribute("RepairProgress") or 0) < 100 then
                    table.insert(validGens, genPart)
                end
            end
            if #validGens == 0 then return end
            
            local target = nil
            if _G.SharedState.GenTPMode == "Nearest" then
                local sDist = math.huge
                for _, p in ipairs(validGens) do
                    local d = (hrp.Position - p.Position).Magnitude
                    if d < sDist then sDist = d; target = p end
                end
            else
                target = validGens[math.random(1, #validGens)]
            end
            
            if target then
                hrp.CFrame = target.CFrame + Vector3.new(0, 10, 0)
            end
        end),

        Dash = CreateIndependentButton("DashBtn","Dash", UDim2.new(0, 15, 0.35, 300), function()
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if not hrp or not hum or hum.Health <= 0 then return end
            
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e5, 0, 1e5) 
            bv.Velocity = hrp.CFrame.LookVector * (_G.SharedState.Misc.DashSpeed or 80)
            bv.Parent = hrp
            
            local animator = hum:FindFirstChildOfClass("Animator")
            if animator then
                local anim1 = Instance.new("Animation"); anim1.AnimationId = "rbxassetid://656118852"
                local anim2 = Instance.new("Animation"); anim2.AnimationId = "rbxassetid://656117878"
                local t1 = animator:LoadAnimation(anim1); t1:Play()
                local t2 = animator:LoadAnimation(anim2); t2:Play()
                
                task.delay(0.35, function()
                    if bv then bv:Destroy() end
                    if t1 then t1:Stop() end
                    if t2 then t2:Stop() end
                end)
            end
        end)
    }

    -- Deteksi Kapan Tombol Harus Muncul/Hilang
    game:GetService("RunService").Heartbeat:Connect(function()
        local S = _G.SharedState
        if not S then return end
        
        -- Tombol akan otomatis muncul HANYA jika toggle di UI Obsidian sedang aktif!
        if _G.MobileBtns.FakeParry then _G.MobileBtns.FakeParry.Visible = (S.FakeParry == true) end
        if _G.MobileBtns.Emote then _G.MobileBtns.Emote.Visible = (S.EmoteKeybind == true) end
        if _G.MobileBtns.FakeKnock then _G.MobileBtns.FakeKnock.Visible = (S.FakeKnockdown == true) end
        if _G.MobileBtns.GenTP then _G.MobileBtns.GenTP.Visible = (S.EnableGenTP == true) end
        if _G.MobileBtns.Dash then _G.MobileBtns.Dash.Visible = (S.Misc.EnableDash == true) end
    end)
end -- 🔥 TUTUP IF ISMOBILE DI SINI 🔥

--=====================================================
-- LOGIC: BRANDING INJECTOR (STREAMER MODE)
--=====================================================
-- 1. Siapkan tempat untuk menyimpan data original UI
local OriginalStreamerData = {
    AvatarImage = nil,
    UsernameText = nil,
    UsernameColor = nil
}

local function InjectBoyfinityBranding()
    local success, err = pcall(function()
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if not PlayerGui then return end

        -- Cari ScreenGui bernama "Survivor"
        local SurvivorGui = PlayerGui:FindFirstChild("Survivor")
        if not SurvivorGui then return end

        -- Cari objek bernama "Frame"
        local Frame = SurvivorGui:FindFirstChild("Frame")
        if not Frame then return end

        -- Cari objek bernama "Survivor1" 
        local Target = Frame:FindFirstChild("Survivor1")
        if not Target then return end

        local avatar = Target:FindFirstChildOfClass("ImageLabel")
        local nameLabel = Target:FindFirstChildOfClass("TextLabel")

        -- 2. SIMPAN DATA ORIGINAL SEBELUM DIUBAH
        if avatar and OriginalStreamerData.AvatarImage == nil and avatar.Image ~= "rbxassetid://120508213351603" then
            OriginalStreamerData.AvatarImage = avatar.Image
        end
        if nameLabel and OriginalStreamerData.UsernameText == nil and nameLabel.Text ~= "boyfinity" then
            OriginalStreamerData.UsernameText = nameLabel.Text
            OriginalStreamerData.UsernameColor = nameLabel.TextColor3
        end

        -- 3. LOGIC HIDE AVATAR (ON / OFF)
        if State.StreamerMode and State.StreamerMode.HideAvatar then
            if avatar and avatar.Image ~= "rbxassetid://120508213351603" then
                avatar.Image = "rbxassetid://120508213351603"
            end
        else
            -- KEMBALIKAN KE AVATAR ASLI
            if avatar and OriginalStreamerData.AvatarImage and avatar.Image ~= OriginalStreamerData.AvatarImage then
                avatar.Image = OriginalStreamerData.AvatarImage
            end
        end

        -- 4. LOGIC HIDE USERNAME (ON / OFF)
        if State.StreamerMode and State.StreamerMode.HideUsername then
            if nameLabel and nameLabel.Text ~= "boyfinity" then
                nameLabel.Text = "boyfinity"
                nameLabel.TextColor3 = Color3.fromRGB(188, 0, 255) 
            end
        else
            -- KEMBALIKAN KE NAMA & WARNA ASLI
            if nameLabel and OriginalStreamerData.UsernameText and nameLabel.Text ~= OriginalStreamerData.UsernameText then
                nameLabel.Text = OriginalStreamerData.UsernameText
                nameLabel.TextColor3 = OriginalStreamerData.UsernameColor or Color3.new(1, 1, 1)
            end
        end
    end)

    if not success then
        warn("Boyfinity Streamer Mode Debug: " .. tostring(err))
    end
end

-- Jalankan di background
task.spawn(function()
    while task.wait(0.5) do
        InjectBoyfinityBranding()
    end
end)

--=====================================================
-- FIXED MOBILE UI: PURE ARROW (NO BOX)
--=====================================================
local function CreateMoonwalkMobileUI()
    if _G.MoonwalkUI then _G.MoonwalkUI:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local FaceBtn = Instance.new("ImageButton")
    local NormBtn = Instance.new("ImageButton")

    ScreenGui.Name = "BoyfinityMoonwalkUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Enabled = false 
    _G.MoonwalkUI = ScreenGui

    Frame.Parent = ScreenGui
    Frame.BackgroundTransparency = 1 -- Transparan total biar kotaknya ilang
    Frame.Position = UDim2.new(1, -80, 0.5, -60) 
    Frame.Size = UDim2.new(0, 60, 0, 130)

    -- Tombol PANAH ATAS (MJ Mode)
    FaceBtn.Name = "FaceUserBtn"
    FaceBtn.Parent = Frame
    FaceBtn.BackgroundTransparency = 1 -- Kotak Hilang![cite: 2]
    FaceBtn.Size = UDim2.new(0, 60, 0, 60)
    FaceBtn.Image = "rbxassetid://118655273900373" -- Asset lo: ArrowUp[cite: 2]
    FaceBtn.ImageColor3 = Color3.fromRGB(150, 150, 150) -- Default Abu
    FaceBtn.ZIndex = 25 -- Pastikan paling depan[cite: 2]

    -- Tombol PANAH BAWAH (Normal Mode)
    NormBtn.Name = "NormalBtn"
    NormBtn.Parent = Frame
    NormBtn.BackgroundTransparency = 1 -- Kotak Hilang![cite: 2]
    NormBtn.Position = UDim2.new(0, 0, 0, 70)
    NormBtn.Size = UDim2.new(0, 60, 0, 60)
    NormBtn.Image = "rbxassetid://95252172620653" -- Asset lo: ArrowDown[cite: 2]
    NormBtn.ImageColor3 = Color3.fromRGB(188, 0, 255) -- Default Aktif Ungu
    NormBtn.ZIndex = 25 -- Pastikan paling depan[cite: 2]

    -- Logic Ganti Warna & State[cite: 2]
    FaceBtn.MouseButton1Click:Connect(function() 
        State.MoonwalkActive = true 
        FaceBtn.ImageColor3 = Color3.fromRGB(188, 0, 255) 
        NormBtn.ImageColor3 = Color3.fromRGB(150, 150, 150)
    end)

    NormBtn.MouseButton1Click:Connect(function() 
        State.MoonwalkActive = false 
        NormBtn.ImageColor3 = Color3.fromRGB(188, 0, 255) 
        FaceBtn.ImageColor3 = Color3.fromRGB(150, 150, 150)
    end)
end

CreateMoonwalkMobileUI()
