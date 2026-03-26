-- UI + Full Bright + Speed Slider
local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
local mouse = player:GetMouse()

-- Full Bright
game.Lighting.Brightness = 2
game.Lighting.ClockTime = 14
game.Lighting.FogEnd = 100000
game.Lighting.GlobalShadows = false
game.Lighting.Ambient = Color3.new(1, 1, 1)
game.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)

-- UI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 160)
frame.Position = UDim2.new(0.5, -125, 0.5, -80)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "🌟 Fay Script"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.8)
title.TextColor3 = Color3.new(1, 1, 1)

-- Speed Label
local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Text = "Speed: 16"
speedLabel.Size = UDim2.new(1, 0, 0, 25)
speedLabel.Position = UDim2.new(0, 0, 0.28, 0)
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.BackgroundTransparency = 1

-- Slider Track
local sliderTrack = Instance.new("Frame", frame)
sliderTrack.Size = UDim2.new(0.85, 0, 0, 10)
sliderTrack.Position = UDim2.new(0.075, 0, 0.58, 0)
sliderTrack.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)

-- Slider Fill
local sliderFill = Instance.new("Frame", sliderTrack)
sliderFill.Size = UDim2.new(0.1, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.new(0.2, 0.6, 1)

-- Slider Knob
local knob = Instance.new("TextButton", sliderTrack)
knob.Size = UDim2.new(0, 20, 0, 20)
knob.Position = UDim2.new(0.1, -10, 0.5, -10)
knob.BackgroundColor3 = Color3.new(1, 1, 1)
knob.Text = ""

-- Speed range
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
    -- อัปเดต slider
    local pct = (speed - minSpeed) / (maxSpeed - minSpeed)
    sliderFill.Size = UDim2.new(pct, 0, 1, 0)
    knob.Position = UDim2.new(pct, -10, 0.5, -10)
end

knob.MouseButton1Down:Connect(function()
    dragging = true
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if dragging then
        local trackPos = sliderTrack.AbsolutePosition.X
        local trackSize = sliderTrack.AbsoluteSize.X
        local mouseX = mouse.X
        local pct = math.clamp((mouseX - trackPos) / trackSize, 0, 1)
        local val = minSpeed + pct * (maxSpeed - minSpeed)
        applySpeed(val)
    end
end)
