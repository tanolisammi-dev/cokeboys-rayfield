-- COKEBOYS → RAY FIELD UI | DELTA MOBILE
-- ✅ KEY VALIDATION REMOVED — INSTANT ACCESS
-- Educational use only

-- ════════ SERVICES ════════
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")

-- ════════ ENV ════════
getgenv().__CokeboysBypassMode = getgenv().__CokeboysBypassMode or "full"
getgenv().__CokeboysPVPLaunchJobId = tostring(game.JobId)

-- ════════ STATE ════════
local State = {
    Experience = "lite",
    Verified = true -- ✅ Auto-verified
}

-- ════════ TRANSLATIONS ════════
local T = {
    Title = "COKEBOYS",
    Home = "Home",
    Movement = "Movement",
    Glitches = "Glitches",
    Aim = "Aim",
    Visuals = "Visuals",
    Combat = "Combat",
    Misc = "Misc",
    Settings = "Settings",
    Experience = "EXPERIENCE",
    LiteExp = "Core Experience",
    FullExp = "Full Experience",
    Launch = "Launch",
    GetKey = "Get Key",
    Discord = "Discord",
    Ready = "Ready!"
}

-- ════════ MOBILE DETECT ════════
local W = workspace.CurrentCamera.ViewportSize.X
local IsMobile = W < 550
local CardW = IsMobile and math.min(W - 40, 340) or 340

-- ════════ CLEAR OLD UI ════════
for _, c in ipairs(PlayerGui:GetChildren()) do
    if c.Name:match("RayField_Cokeboys") then pcall(function() c:Destroy() end) end
end

-- ════════ CREATE UI ════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RayField_Cokeboys"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Background
local Backdrop = Instance.new("Frame")
Backdrop.Size = UDim2.fromScale(1, 1)
Backdrop.BackgroundColor3 = Color3.fromRGB(4, 4, 7)
Backdrop.BackgroundTransparency = 0.5
Backdrop.Parent = ScreenGui

-- Main Card
local MainCard = Instance.new("Frame")
MainCard.Size = UDim2.fromOffset(CardW, 400)
MainCard.AnchorPoint = Vector2.new(0.5, 0.5)
MainCard.Position = UDim2.fromScale(0.5, 0.5)
MainCard.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
MainCard.Parent = ScreenGui
Instance.new("UICorner", MainCard).CornerRadius = UDim.new(0, 12)
local Border = Instance.new("UIStroke", MainCard)
Border.Color = Color3.fromRGB(255, 210, 31)
Border.Thickness = 1.5

-- ════════ UI HELPERS ════════
local function Label(y, txt, size, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -40, 0, size or 24)
    lbl.Position = UDim2.fromOffset(20, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = txt
    lbl.TextColor3 = color or Color3.fromRGB(180, 180, 190)
    lbl.Font = Enum.Font.GothamMedium
    lbl.Parent = MainCard
    return lbl
end

local function Btn(y, txt, bg, w)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, w or -40, 0, 50)
    btn.Position = UDim2.new(0, 20, 0, y)
    btn.BackgroundColor3 = bg
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.Parent = MainCard
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- ════════ BUILD MENU ════════
-- Title
Label(15, T.Title, 40, Color3.fromRGB(255, 210, 31)).TextSize = 22

-- Experience Section
Label(70, T.Experience, 22, Color3.fromRGB(150,150,160)).TextSize = 11

local LiteBtn = Btn(95, "◉ "..T.LiteExp, Color3.fromRGB(35, 32, 15))
LiteBtn.TextColor3 = Color3.fromRGB(255, 210, 31)

local FullBtn = Btn(152, "○ "..T.FullExp, Color3.fromRGB(26, 26, 30))
FullBtn.TextColor3 = Color3.fromRGB(180, 180, 190)

-- Quick Nav
Label(210, "QUICK NAV", 22, Color3.fromRGB(150,150,160)).TextSize = 11

local HomeBtn = Btn(235, T.Home, Color3.fromRGB(30, 30, 35))
local CombatBtn = Btn(290, T.Combat, Color3.fromRGB(30, 30, 35))
local VisualsBtn = Btn(290, T.Visuals, Color3.fromRGB(30, 30, 35), -175)
VisualsBtn.Position = UDim2.new(1, -185, 0, 290)

-- Bottom Row
local DiscordBtn = Btn(345, T.Discord, Color3.fromRGB(88, 101, 242), -175)
local LaunchBtn = Btn(345, T.Launch, Color3.fromRGB(60, 180, 80))
LaunchBtn.Position = UDim2.new(1, -185, 0, 345)

-- ════════ LOGIC ════════
local function SelectExp(exp)
    State.Experience = exp
    LiteBtn.Text = exp=="lite" and "◉ "..T.LiteExp or "○ "..T.LiteExp
    LiteBtn.BackgroundColor3 = exp=="lite" and Color3.fromRGB(35,32,15) or Color3.fromRGB(26,26,30)
    LiteBtn.TextColor3 = exp=="lite" and Color3.fromRGB(255,210,31) or Color3.fromRGB(180,180,190)
    
    FullBtn.Text = exp=="full" and "◉ "..T.FullExp or "○ "..T.FullExp
    FullBtn.BackgroundColor3 = exp=="full" and Color3.fromRGB(35,32,15) or Color3.fromRGB(26,26,30)
    FullBtn.TextColor3 = exp=="full" and Color3.fromRGB(255,210,31) or Color3.fromRGB(180,180,190)
end

LiteBtn.Activated:Connect(function() SelectExp("lite") end)
FullBtn.Activated:Connect(function() SelectExp("full") end)

DiscordBtn.Activated:Connect(function()
    if setclipboard then pcall(setclipboard, "https://discord.gg/VfEn7Zywmd") end
end)

LaunchBtn.Activated:Connect(function()
    -- ════════ YOUR FEATURES HERE ════════
    print("✅ "..State.Experience.." loaded")
    -- Add your script/features here
    task.wait(0.5)
    -- ScreenGui:Destroy() -- uncomment to close on launch
end)

-- Default
SelectExp("lite")

print("✅ Ray Field Menu Loaded — No Key Needed")
