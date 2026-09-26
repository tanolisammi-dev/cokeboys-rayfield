-- COKEBOYS → RAY FIELD | FULL FEATURES — NO KEY ✅
-- Direct Main UI — No Selection Page
-- Delta Mobile Optimized
-- Educational use only

-- ════════ SERVICES ════════
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ════════ CLEANUP ════════
for _, c in ipairs(PlayerGui:GetChildren()) do
    if c.Name:find("RayField") then pcall(function() c:Destroy() end) end
end

-- ════════ SETTINGS ════════
local Settings = {
    -- Movement
    Speed = false,
    SpeedAmount = 32,
    Jump = false,
    JumpPower = 50,
    NoSlow = false,
    -- Combat
    AutoClick = false,
    ClickDelay = 0.05,
    KillAura = false,
    AuraRange = 15,
    -- Visuals
    ESP = false,
    ShowNames = true,
    ShowDistance = true,
    -- Misc
    NoClip = false,
    InfiniteY = false
}

-- ════════ MOBILE DETECT ════════
local W = workspace.CurrentCamera.ViewportSize.X
local IsMobile = W < 550
local CardW = IsMobile and math.min(W - 40, 340) or 340
local BtnH = IsMobile and 48 or 44

-- ════════ MAIN UI ════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RayField_Cokeboys"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Background
local Backdrop = Instance.new("Frame")
Backdrop.Size = UDim2.fromScale(1, 1)
Backdrop.BackgroundColor3 = Color3.fromRGB(4, 4, 7)
Backdrop.BackgroundTransparency = 0.4
Backdrop.Parent = ScreenGui

-- Main Card
local MainCard = Instance.new("Frame")
MainCard.Size = UDim2.fromOffset(CardW, IsMobile and 480 or 460)
MainCard.AnchorPoint = Vector2.new(0.5, 0.5)
MainCard.Position = UDim2.fromScale(0.5, 0.5)
MainCard.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
MainCard.Parent = ScreenGui
Instance.new("UICorner", MainCard).CornerRadius = UDim.new(0, 14)
local Border = Instance.new("UIStroke", MainCard)
Border.Color = Color3.fromRGB(255, 210, 31)
Border.Thickness = 1.5

-- ════════ UI HELPERS ════════
local function Section(y, title)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -40, 0, 22)
    lbl.Position = UDim2.fromOffset(20, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = title
    lbl.TextColor3 = Color3.fromRGB(150, 150, 160)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = MainCard
    return y + 26
end

local function Toggle(y, name, settingKey)
    local cont = Instance.new("Frame")
    cont.Size = UDim2.new(1, -40, 0, BtnH)
    cont.Position = UDim2.fromOffset(20, y)
    cont.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
    cont.Parent = MainCard
    Instance.new("UICorner", cont).CornerRadius = UDim.new(0, 10)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.fromOffset(16, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(230, 230, 235)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = cont

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.fromOffset(24, 24)
    indicator.AnchorPoint = Vector2.new(1, 0.5)
    indicator.Position = UDim2.new(1, -16, 0.5, 0)
    indicator.BackgroundColor3 = Settings[settingKey] and Color3.fromRGB(60, 180, 80) or Color3.fromRGB(60, 60, 65)
    indicator.Parent = cont
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(0, 6)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = cont

    btn.Activated:Connect(function()
        Settings[settingKey] = not Settings[settingKey]
        indicator.BackgroundColor3 = Settings[settingKey] and Color3.fromRGB(60, 180, 80) or Color3.fromRGB(60, 60, 65)
    end)

    return y + BtnH + 10
end

-- ════════ BUILD ALL FEATURES DIRECTLY ════════
local Y = 15

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 36)
Title.Position = UDim2.fromOffset(20, Y)
Title.BackgroundTransparency = 1
Title.Text = "COKEBOYS"
Title.TextColor3 = Color3.fromRGB(255, 210, 31)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 26
Title.Parent = MainCard
Y += 46

-- Movement
Y = Section(Y, "🏃 MOVEMENT")
Y = Toggle(Y, "Speed Boost", "Speed")
Y = Toggle(Y, "Jump Boost", "Jump")
Y = Toggle(Y, "No Slowdown", "NoSlow")

-- Combat
Y = Section(Y, "⚔️ COMBAT")
Y = Toggle(Y, "Auto Click", "AutoClick")
Y = Toggle(Y, "Kill Aura", "KillAura")

-- Visuals
Y = Section(Y, "👁️ VISUALS")
Y = Toggle(Y, "Player ESP", "ESP")

-- Misc
Y = Section(Y, "⚙️ MISC")
Y = Toggle(Y, "No Clip", "NoClip")
Y = Toggle(Y, "Infinite Y", "InfiniteY")

-- ════════ ESP SYSTEM ════════
local ESPObjects = {}
local function CreateESP(player)
    local Drawing = Drawing.new("Text")
    Drawing.Center = true
    Drawing.Outline = true
    Drawing.Font = 2
    Drawing.Size = 13
    ESPObjects[player] = Drawing
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then task.spawn(CreateESP, p) end end
Players.PlayerAdded:Connect(function(p) task.wait(1) CreateESP(p) end)
Players.PlayerRemoving:Connect(function(p) if ESPObjects[p] then ESPObjects[p]:Remove(); ESPObjects[p] = nil end end)

-- ════════ MAIN LOOP ════════
local LastClick = 0
RunService.Heartbeat:Connect(function()
    local Char = LocalPlayer.Character
    if not Char then return end
    local Human = Char:FindFirstChild("Humanoid")
    local Root = Char:FindFirstChild("HumanoidRootPart")
    if not Human or not Root then return end

    -- Speed
    if Settings.Speed then Human.WalkSpeed = Settings.SpeedAmount else Human.WalkSpeed = 16 end
    -- Jump
    if Settings.Jump then Human.JumpPower = Settings.JumpPower else Human.JumpPower = 50 end
    -- NoClip
    if Settings.NoClip then Human:SetStateEnabled(Enum.HumanoidStateType.Climbing, false) end
    if Settings.NoClip then
        for _, d in ipairs(Char:GetDescendants()) do
            if d:IsA("BasePart") then d.CanCollide = false end
        end
    end
    -- Infinite Y
    if Settings.InfiniteY then Root.CFrame = CFrame.new(Root.Position.X, math.huge, Root.Position.Z) end
    -- AutoClick
    if Settings.AutoClick and os.clock() - LastClick > Settings.ClickDelay then
        pcall(function() LocalPlayer:Click() end)
        LastClick = os.clock()
    end
    -- KillAura
    if Settings.KillAura then
        local MyPos = Root.Position
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local Pos = p.Character.HumanoidRootPart.Position
                if (MyPos - Pos).Magnitude <= Settings.AuraRange then
                    pcall(function() LocalPlayer:Click(p.Character) end)
                end
            end
        end
    end
    -- ESP
    if Settings.ESP then
        for p, d in pairs(ESPObjects) do
            if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local RPos = p.Character.HumanoidRootPart.Position
                local VPos, OnScr = workspace.CurrentCamera:WorldToViewportPoint(RPos)
                if OnScr then
                    d.Position = Vector2.new(VPos.X, VPos.Y - 30)
                    local Dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - RPos).Magnitude)
                    d.Text = p.Name .. " [" .. Dist .. "m]"
                    d.Color = p.Team and p.Team.Color or Color3.fromRGB(255, 80, 80)
                    d.Visible = true
                else d.Visible = false end
            else d.Visible = false end
        end
    else
        for _, d in pairs(ESPObjects) do d.Visible = false end
    end
end)

print("✅ COKEBOYS | Full Features Loaded — No Key")
