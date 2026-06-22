-- ============================================
--   PlayerSettingsUI.lua
--   ใส่ใน StarterPlayerScripts หรือ LocalScript
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- ตั้งค่าเริ่มต้น
local DEFAULT_BRIGHTNESS = 2
local DEFAULT_SPEED = 16
local MIN_BRIGHTNESS = 0
local MAX_BRIGHTNESS = 10
local MIN_SPEED = 4
local MAX_SPEED = 100

local currentBrightness = DEFAULT_BRIGHTNESS
local currentSpeed = DEFAULT_SPEED
local isUIOpen = true

-- อัปเดต character เมื่อ respawn
player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = newChar:WaitForChild("Humanoid")
	humanoid.WalkSpeed = currentSpeed
end)

-- ============================================
-- สร้าง ScreenGui
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerSettingsUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player.PlayerGui

-- ============================================
-- ปุ่ม Toggle (เปิด/ปิด UI) — อยู่มุมขวาบน
-- ============================================
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 44, 0, 44)
toggleBtn.Position = UDim2.new(1, -54, 0, 10)
toggleBtn.AnchorPoint = Vector2.new(0, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "⚙"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 22
toggleBtn.BorderSizePixel = 0
toggleBtn.ZIndex = 10
toggleBtn.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleCorner.Parent = toggleBtn

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(100, 120, 255)
toggleStroke.Thickness = 1.5
toggleStroke.Parent = toggleBtn

-- ============================================
-- Panel หลัก
-- ============================================
local panel = Instance.new("Frame")
panel.Name = "SettingsPanel"
panel.Size = UDim2.new(0, 280, 0, 200)
panel.Position = UDim2.new(1, -294, 0, 64)
panel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
panel.BorderSizePixel = 0
panel.ZIndex = 5
panel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 14)
panelCorner.Parent = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(80, 100, 220)
panelStroke.Thickness = 1.5
panelStroke.Parent = panel

-- gradient พื้นหลัง
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 22, 38)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 14, 24)),
})
gradient.Rotation = 135
gradient.Parent = panel

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 34, 60)
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 6
titleBar.Parent = panel

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 14)
titleBarCorner.Parent = titleBar

-- ปิดส่วนล่างของ titleBar corner
local titleBarFix = Instance.new("Frame")
titleBarFix.Size = UDim2.new(1, 0, 0.5, 0)
titleBarFix.Position = UDim2.new(0, 0, 0.5, 0)
titleBarFix.BackgroundColor3 = Color3.fromRGB(30, 34, 60)
titleBarFix.BorderSizePixel = 0
titleBarFix.ZIndex = 6
titleBarFix.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚙  Player Settings"
titleLabel.TextColor3 = Color3.fromRGB(200, 210, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.ZIndex = 7
titleLabel.Parent = titleBar

-- ============================================
-- ฟังก์ชันสร้าง Slider
-- ============================================
local function createSlider(parent, labelText, unit, minVal, maxVal, defaultVal, yPos, onChanged)
	-- Label + Value
	local labelFrame = Instance.new("Frame")
	labelFrame.Size = UDim2.new(1, -24, 0, 20)
	labelFrame.Position = UDim2.new(0, 12, 0, yPos)
	labelFrame.BackgroundTransparency = 1
	labelFrame.ZIndex = 6
	labelFrame.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.6, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(180, 190, 240)
	label.Font = Enum.Font.Gotham
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 7
	label.Parent = labelFrame

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0.4, 0, 1, 0)
	valueLabel.Position = UDim2.new(0.6, 0, 0, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(defaultVal) .. unit
	valueLabel.TextColor3 = Color3.fromRGB(120, 160, 255)
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 12
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.ZIndex = 7
	valueLabel.Parent = labelFrame

	-- Track
	local track = Instance.new("Frame")
	track.Size = UDim2.new(1, -24, 0, 6)
	track.Position = UDim2.new(0, 12, 0, yPos + 24)
	track.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
	track.BorderSizePixel = 0
	track.ZIndex = 6
	track.Parent = parent

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	-- Fill
	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(100, 130, 255)
	fill.BorderSizePixel = 0
	fill.ZIndex = 7
	fill.Parent = track

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local fillGrad = Instance.new("UIGradient")
	fillGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 120, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 100, 255)),
	})
	fillGrad.Parent = fill

	-- Knob
	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.AnchorPoint = Vector2.new(0.5, 0.5)
	knob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 0.5, 0)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.ZIndex = 8
	knob.Parent = track

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local knobStroke = Instance.new("UIStroke")
	knobStroke.Color = Color3.fromRGB(120, 150, 255)
	knobStroke.Thickness = 2
	knobStroke.Parent = knob

	-- Drag logic
	local dragging = false

	local function updateSlider(inputX)
		local trackAbsPos = track.AbsolutePosition.X
		local trackAbsSize = track.AbsoluteSize.X
		local ratio = math.clamp((inputX - trackAbsPos) / trackAbsSize, 0, 1)
		local value = math.floor(minVal + ratio * (maxVal - minVal) + 0.5)
		local displayRatio = (value - minVal) / (maxVal - minVal)

		fill.Size = UDim2.new(displayRatio, 0, 1, 0)
		knob.Position = UDim2.new(displayRatio, 0, 0.5, 0)
		valueLabel.Text = tostring(value) .. unit
		onChanged(value)
	end

	knob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
		end
	end)

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			updateSlider(input.Position.X)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging then
			if input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch then
				updateSlider(input.Position.X)
			end
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

-- ============================================
-- สร้าง Sliders
-- ============================================

-- Slider ความสว่าง
createSlider(panel, "☀  Brightness", "", MIN_BRIGHTNESS, MAX_BRIGHTNESS, DEFAULT_BRIGHTNESS, 52, function(val)
	currentBrightness = val
	Lighting.Brightness = val
end)

-- Slider ความเร็ว
createSlider(panel, "⚡  Walk Speed", "", MIN_SPEED, MAX_SPEED, DEFAULT_SPEED, 118, function(val)
	currentSpeed = val
	if humanoid then
		humanoid.WalkSpeed = val
	end
end)

-- ============================================
-- Logic ปุ่ม Toggle
-- ============================================
local function toggleUI()
	isUIOpen = not isUIOpen
	panel.Visible = isUIOpen
	toggleBtn.Text = isUIOpen and "✕" or "⚙"
	toggleBtn.BackgroundColor3 = isUIOpen
		and Color3.fromRGB(40, 40, 60)
		or Color3.fromRGB(30, 30, 40)
end

-- ใช้ทั้ง Activated และ MouseButton1Click เผื่อ environment ต่างกัน
toggleBtn.Activated:Connect(toggleUI)

-- Hover effect บนปุ่ม toggle
toggleBtn.MouseEnter:Connect(function()
	toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 90)
end)
toggleBtn.MouseLeave:Connect(function()
	toggleBtn.BackgroundColor3 = isUIOpen
		and Color3.fromRGB(40, 40, 60)
		or Color3.fromRGB(30, 30, 40)
end)

-- ตั้งค่าเริ่มต้น
Lighting.Brightness = DEFAULT_BRIGHTNESS
if humanoid then
	humanoid.WalkSpeed = DEFAULT_SPEED
end

print("[PlayerSettingsUI] โหลดสำเร็จ!")
