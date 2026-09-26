-- COKEBOYS → RAY FIELD | Delta Mobile Working Script
-- Optimized for touch screens | 2026-09-26
-- NOTE: For educational use only

-- ════════ SERVICES ════════
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

-- ════════ ENVIRONMENT ════════
_G.__CokeboysBypassMode = "full"
_G.__CokeboysLoaded = true

-- ════════ STATE ════════
local State = {
    Key = "",
    Verified = false,
    Experience = "lite",
    Checking = false
}

-- ════════ TRANSLATIONS ════════
local T = setmetatable({
    Title = "COKEBOYS",
    EnterKey = "Enter Access Key",
    Validate = "Validate Key",
    GetKey = "Get Key",
    Discord = "Discord",
    FullExp = "Full Experience",
    LiteExp = "Core Experience",
    Launch = "Launch",
    Verified = "✓ Key Accepted",
    Invalid = "✗ Invalid Key",
    Checking = "Checking...",
    KeyRequired = "Please enter a key",
    Ready = "Ready!"
}, {__index = function(_, k) return k end})

-- ════════ MOBILE UI SETTINGS ════════
local W, H = workspace.CurrentCamera.ViewportSize.X, workspace.CurrentCamera.ViewportSize.Y
local IsMobile = W < 550
local CardW = IsMobile and math.min(W - 40, 340) or 340
local FontS = IsMobile and 13 or 14
local BtnH = IsMobile and 52 or 50

-- ════════ DESTROY OLD UI ════════
local function ClearOld()
    for _, v in ipairs(PlayerGui:GetChildren()) do
        if v.Name:find("RayField_Cokeboys") or v.Name:find("CokeboysKeySystem") then
            pcall(function() v:Destroy() end)
        end
    end
end
ClearOld()

-- ════════ CREATE SCREEN GUI ════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RayField_Cokeboys"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Backdrop
local Backdrop = Instance.new("Frame")
Backdrop.Name = "Backdrop"
Backdrop.Size = UDim2.fromScale(1, 1)
Backdrop.BackgroundColor3 = Color3.fromRGB(4, 4, 7)
Backdrop.BackgroundTransparency = 0.45
Backdrop.Parent = ScreenGui

-- Main Card
local MainCard = Instance.new("Frame")
MainCard.Name = "MainCard"
MainCard.Size = UDim2.fromOffset(CardW, IsMobile and 440 or 420)
MainCard.AnchorPoint = Vector2.new(0.5, 0.5)
MainCard.Position = UDim2.fromScale(0.5, 0.5)
MainCard.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
MainCard.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainCard

local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(255, 210, 31)
Border.Thickness = 1.5
Border.Transparency = 0.2
Border.Parent = MainCard

-- Helper: make button
local function MakeBtn(name, y, text, bg, h, parent)
    h = h or BtnH
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, -40, 0, h)
    btn.Position = UDim2.new(0, 20, 0, y)
    btn.BackgroundColor3 = bg
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = FontS
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.Parent = parent or MainCard
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    return btn
end

-- ════════ BUILD UI ════════
-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.fromOffset(20, 15)
Title.BackgroundTransparency = 1
Title.Text = T.Title
Title.TextColor3 = Color3.fromRGB(255, 210, 31)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = MainCard

-- Key Input
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -40, 0, 52)
KeyInput.Position = UDim2.fromOffset(20, 70)
KeyInput.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
KeyInput.Text = ""
KeyInput.PlaceholderText = T.EnterKey
KeyInput.TextColor3 = Color3.fromRGB(245, 245, 245)
KeyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
KeyInput.TextSize = FontS
KeyInput.Font = Enum.Font.Gotham
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = MainCard
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 8)

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -40, 0, 24)
Status.Position = UDim2.fromOffset(20, 132)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(170, 170, 180)
Status.TextSize = 12
Status.Font = Enum.Font.GothamMedium
Status.Parent = MainCard

-- Validate Button
local ValidateBtn = MakeBtn("Validate", 165, T.Validate, Color3.fromRGB(255, 210, 31))
ValidateBtn.TextColor3 = Color3.fromRGB(20, 17, 0)

-- Section Label
local ExpLabel = Instance.new("TextLabel")
ExpLabel.Size = UDim2.new(1, -40, 0, 22)
ExpLabel.Position = UDim2.fromOffset(20, 235)
ExpLabel.BackgroundTransparency = 1
ExpLabel.Text = "EXPERIENCE"
ExpLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
ExpLabel.TextSize = 11
ExpLabel.Font = Enum.Font.GothamBold
ExpLabel.TextXAlignment = Enum.TextXAlignment.Left
ExpLabel.Parent = MainCard

-- Experience Options
local LiteBtn = MakeBtn("Lite", 260, "◉ " .. T.LiteExp, Color3.fromRGB(35, 32, 15), 44)
LiteBtn.TextColor3 = Color3.fromRGB(255, 210, 31)

local FullBtn = MakeBtn("Full", 312, "○ " .. T.FullExp, Color3.fromRGB(26, 26, 30), 44)
FullBtn.TextColor3 = Color3.fromRGB(180, 180, 190)

-- Bottom Row
local GetKeyBtn = MakeBtn("GetKey", 365, T.GetKey, Color3.fromRGB(238, 67, 84), 50)
GetKeyBtn.Size = UDim2.new(0.47, -5, 0, 50)
GetKeyBtn.Position = UDim2.new(0, 20, 0, 365)

local DiscordBtn = MakeBtn("Discord", 365, T.Discord, Color3.fromRGB(88, 101, 242), 50)
DiscordBtn.Size = UDim2.new(0.47, -5, 0, 50)
DiscordBtn.Position = UDim2.new(1, -20 - CardW*0.47, 0, 365)

-- Launch Button
local LaunchBtn = MakeBtn("Launch", 365, T.Launch, Color3.fromRGB(60, 180, 80), 50)
LaunchBtn.Visible = false
LaunchBtn.Active = false

-- ════════ LOGIC ════════
local function SetStatus(text, color)
    Status.Text = text or ""
    Status.TextColor3 = color or Color3.fromRGB(170, 170, 180)
end

local function SelectExperience(exp)
    State.Experience = exp
    if exp == "lite" then
        LiteBtn.BackgroundColor3 = Color3.fromRGB(35, 32, 15)
        LiteBtn.TextColor3 = Color3.fromRGB(255, 210, 31)
        LiteBtn.Text = "◉ " .. T.LiteExp
        FullBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
        FullBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
        FullBtn.Text = "○ " .. T.FullExp
    else
        FullBtn.BackgroundColor3 = Color3.fromRGB(35, 32, 15)
        FullBtn.TextColor3 = Color3.fromRGB(255, 210, 31)
        FullBtn.Text = "◉ " .. T.FullExp
        LiteBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
        LiteBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
        LiteBtn.Text = "○ " .. T.LiteExp
    end
end

-- Mock key validation — replace with real check
local function ValidateKey(key)
    task.wait(1.2) -- simulate network delay
    -- Replace with your actual validation logic
    return #key >= 8 and not key:find("^%s*$")
end

-- Events
LiteBtn.Activated:Connect(function() SelectExperience("lite") end)
FullBtn.Activated:Connect(function() SelectExperience("full") end)

ValidateBtn.Activated:Connect(function()
    if State.Checking then return end
    local key = KeyInput.Text:gsub("%s+", "")
    
    if key == "" then
        SetStatus(T.KeyRequired, Color3.fromRGB(239, 98, 111))
        return
    end
    
    State.Checking = true
    SetStatus(T.Checking, Color3.fromRGB(100, 200, 255))
    ValidateBtn.Text = "..."
    ValidateBtn.Active = false
    
    local Valid = ValidateKey(key)
    
    State.Checking = false
    if Valid then
        State.Verified = true
        State.Key = key
        SetStatus(T.Verified, Color3.fromRGB(112, 213, 151))
        ValidateBtn.Visible = false
        GetKeyBtn.Visible = false
        DiscordBtn.Visible = false
        LaunchBtn.Visible = true
        LaunchBtn.Active = true
        SelectExperience(State.Experience)
    else
        SetStatus(T.Invalid, Color3.fromRGB(239, 98, 111))
        ValidateBtn.Text = T.Validate
        ValidateBtn.Active = true
    end
end)

-- Launch → Your actual script goes here
LaunchBtn.Activated:Connect(function()
    SetStatus("Loading "..State.Experience.."...", Color3.fromRGB(112, 213, 151))
    task.wait(0.8)
    
    -- ════════ INSERT YOUR SCRIPT/LOADSTRING HERE ════════
    -- Example: loadstring(game:HttpGet("YOUR_URL_HERE"))()
    -- ═══════════════════════════════════════════════════════
    
    SetStatus(T.Ready, Color3.fromRGB(112, 213, 151))
    task.wait(1)
    ScreenGui:Destroy()
end)

GetKeyBtn.Activated:Connect(function()
    local Link = "https://linktr.ee/cokeboysclient"
    if setclipboard then pcall(setclipboard, Link) end
    SetStatus("Link copied!", Color3.fromRGB(112, 213, 151))
    task.wait(2)
    SetStatus("")
end)

DiscordBtn.Activated:Connect(function()
    local Link = "https://discord.gg/VfEn7Zywmd"
    if setclipboard then pcall(setclipboard, Link) end
    SetStatus("Discord copied!", Color3.fromRGB(112, 213, 151))
    task.wait(2)
    SetStatus("")
end)

-- Default
SelectExperience("lite")

print("✅ Ray Field UI Loaded | Delta Mobile Ready")
