local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- ========== FULL BRIGHT ==========
local defaultLighting = {
    Brightness = game.Lighting.Brightness,
    ClockTime = game.Lighting.ClockTime,
    FogEnd = game.Lighting.FogEnd,
    GlobalShadows = game.Lighting.GlobalShadows,
    Ambient = game.Lighting.Ambient,
    OutdoorAmbient = game.Lighting.OutdoorAmbient,
}
local fullBrightOn = false

local function toggleFullBright()
    fullBrightOn = not fullBrightOn
    if fullBrightOn then
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
        game.Lighting.FogEnd = 100000
        game.Lighting.GlobalShadows = false
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        game.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        for k, v in pairs(defaultLighting) do
            game.Lighting[k] = v
        end
    end
end

-- ========== NO CLIP ==========
local noclipOn = false
RunService.Stepped:Connect(function()
    if noclipOn then
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- ========== ANTI FALL ==========
RunService.Heartbeat:Connect(function()
    if antiFallOn then
        local char = player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root and root.Position.Y < minY then
                root.CFrame = CFrame.new(
                    root.Position.X, 
                    minY,  -- lock Y ไว้ตรงนี้เลย
                    root.Position.Z
                )
                root.Velocity = Vector3.new(
                    root.Velocity.X, 
                    0,  -- หยุด velocity แกน Y
                    root.Velocity.Z
                )
            end
        end
    end
end)

-- ========== UI ==========
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Mini button (เมื่อปิด UI)
local miniBtn = Instance.new("TextButton", screenGui)
miniBtn.Size = UDim2.new(0, 40, 0, 40)
miniBtn.Position = UDim2.new(0, 10, 0, 10)
miniBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.8)
miniBtn.TextColor3 = Color3.new(1, 1, 1)
miniBtn.Text = "🌟"
miniBtn.Visible = false
miniBtn.Active = true
miniBtn.Draggable = true

-- Main Frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 260, 0, 280)
frame.Position = UDim2.new(0.5, -130, 0.5, -140)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.Active = true
frame.Draggable = true

-- Title bar
local titleBar = Instance.new("TextLabel", frame)
titleBar.Text = "🌟 Fay Script"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.8)
titleBar.TextColor3 = Color3.new(1, 1, 1)

-- ปุ่มปิด UI
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "✖"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -32, 0, 2)
closeBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
closeBtn.TextColor3 = Color3.new(1, 1, 1)

-- ========== SPEED SLIDER ==========
local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Text = "Speed: 16"
speedLabel.Size = UDim2.new(1, 0, 0, 25)
speedLabel.Position = UDim2.new(0, 0, 0.18, 0)
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.BackgroundTransparency = 1

local sliderTrack = Instance.new("Frame", frame)
sliderTrack.Size = UDim2.new(0.85, 0, 0, 10)
sliderTrack.Position = UDim2.new(0.075, 0, 0.32, 0)
sliderTrack.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)

local sliderFill = Instance.new("Frame", sliderTrack)
sliderFill.Size = UDim2.new(0, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.new(0.2, 0.6, 1)

local knob = Instance.new("TextButton", sliderTrack)
knob.Size = UDim2.new(0, 20, 0, 20)
knob.Position = UDim2.new(0, -10, 0.5, -10)
knob.BackgroundColor3 = Color3.new(1, 1, 1)
knob.Text = ""

local minSpeed = 16
local maxSpeed = 200
local speed = 16
local dragging = false

local function applySpeed(val)
    speed = math.floor(val)
    speedLabel.Text = "Speed: " .. speed
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speed
    end
    local pct = (speed - minSpeed) / (maxSpeed - minSpeed)
    sliderFill.Size = UDim2.new(pct, 0, 1, 0)
    knob.Position = UDim2.new(pct, -10, 0.5, -10)
end

knob.MouseButton1Down:Connect(function() dragging = true end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
RunService.RenderStepped:Connect(function()
    if dragging then
        local trackPos = sliderTrack.AbsolutePosition.X
        local trackSize = sliderTrack.AbsoluteSize.X
        local pct = math.clamp((mouse.X - trackPos) / trackSize, 0, 1)
        applySpeed(minSpeed + pct * (maxSpeed - minSpeed))
    end
end)

-- ========== TOGGLE BUTTONS ==========
local function makeToggle(text, posY, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = "❌ " .. text
    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.BackgroundColor3 = on and Color3.new(0.2, 0.8, 0.2) or Color3.new(0.8, 0.2, 0.2)
        btn.Text = (on and "✅ " or "❌ ") .. text
        callback(on)
    end)
    return btn
end

makeToggle("Full Bright", 0.45, function(on)
    fullBrightOn = on
    toggleFullBright()
    fullBrightOn = on -- reset เพราะ toggle flip 2 ครั้ง
    if on then
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
        game.Lighting.FogEnd = 100000
        game.Lighting.GlobalShadows = false
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        game.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        for k, v in pairs(defaultLighting) do
            game.Lighting[k] = v
        end
    end
end)

makeToggle("No Clip", 0.62, function(on)
    noclipOn = on
end)

makeToggle("Anti Fall (Y≥" .. minY .. ")", 0.79, function(on)
    antiFallOn = on
end)

-- ========== OPEN/CLOSE ==========
closeBtn.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(frame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0)
    })
    tween:Play()
    tween.Completed:Connect(function()
        frame.Visible = false
        frame.Size = UDim2.new(0, 260, 0, 280)
        miniBtn.Visible = true
    end)
end)

miniBtn.MouseButton1Click:Connect(function()
    miniBtn.Visible = false
    frame.Visible = true
    frame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(frame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 260, 0, 280)
    }):Play()
end)
