-- ============================================
--   MimicUI.lua — The Mimic Book 3
--   ใส่ใน StarterPlayerScripts (LocalScript)
-- ============================================

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local Lighting         = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")

local player    = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid  = character:WaitForChild("Humanoid")

-- ============================================
-- ค่าเริ่มต้น
-- ============================================
local DEFAULT_BRIGHTNESS         = 2
local DEFAULT_SPEED              = 16
local MIN_BRIGHTNESS, MAX_BRIGHTNESS = 0, 10
local MIN_SPEED,      MAX_SPEED      = 4, 100

local currentBrightness = DEFAULT_BRIGHTNESS
local currentSpeed      = DEFAULT_SPEED
local isUIOpen          = true

local espEnabled     = false
local noclipEnabled  = false
local itemEspEnabled = false
local espHighlights  = {}
local itemHighlights = {}

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid  = newChar:WaitForChild("Humanoid")
	humanoid.WalkSpeed = currentSpeed
end)

-- ============================================
-- Monster ESP
-- ============================================
local MONSTER_KEYWORDS = {
	"Akako","Kuchisake","Shaku","Yomotsu","Enenra",
	"Monster","Enemy","Boss","Chaser","Stalker","Oni",
	"Yurei","Gashadokuro","Jorogumo","Yamabiko","Mimic",
}

local function isMonster(model)
	local name = model.Name:lower()
	for _, kw in ipairs(MONSTER_KEYWORDS) do
		if name:find(kw:lower()) then return true end
	end
	return false
end

local function clearESP()
	for model, h in pairs(espHighlights) do
		h:Destroy(); espHighlights[model] = nil
	end
end

local function refreshESP()
	clearESP()
	if not espEnabled then return end
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("Model") and isMonster(obj) then
			local h = Instance.new("SelectionBox")
			h.Adornee             = obj
			h.Color3              = Color3.fromRGB(255, 50, 50)
			h.LineThickness       = 0.06
			h.SurfaceTransparency = 0.85
			h.SurfaceColor3       = Color3.fromRGB(255, 80, 80)
			h.Parent              = Workspace
			espHighlights[obj]    = h
		end
	end
end

local espTimer = 0
RunService.Heartbeat:Connect(function(dt)
	if not espEnabled then return end
	espTimer += dt
	if espTimer >= 3 then espTimer = 0; refreshESP() end
end)

-- ============================================
-- Noclip
-- ============================================
RunService.Stepped:Connect(function()
	if not noclipEnabled or not character then return end
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then part.CanCollide = false end
	end
end)

-- ============================================
-- Item ESP
-- ============================================
local ITEM_KEYWORDS = {
	"Key","Orb","Crystal","Lantern","Letter","Note",
	"Artifact","Relic","Scroll","Charm","Item",
	"Collectible","Pickup","Objective","Lore","Page","Token",
}

local function isImportantItem(obj)
	local name = obj.Name:lower()
	for _, kw in ipairs(ITEM_KEYWORDS) do
		if name:find(kw:lower()) then return true end
	end
	return false
end

local function clearItemESP()
	for obj, h in pairs(itemHighlights) do
		h:Destroy(); itemHighlights[obj] = nil
	end
end

local function refreshItemESP()
	clearItemESP()
	if not itemEspEnabled then return end
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if (obj:IsA("BasePart") or obj:IsA("Model")) and isImportantItem(obj) then
			local h = Instance.new("SelectionBox")
			h.Adornee             = obj
			h.Color3              = Color3.fromRGB(255, 220, 0)
			h.LineThickness       = 0.05
			h.SurfaceTransparency = 0.8
			h.SurfaceColor3       = Color3.fromRGB(255, 240, 80)
			h.Parent              = Workspace
			itemHighlights[obj]   = h
		end
	end
end

local itemTimer = 0
RunService.Heartbeat:Connect(function(dt)
	if not itemEspEnabled then return end
	itemTimer += dt
	if itemTimer >= 4 then itemTimer = 0; refreshItemESP() end
end)

-- ============================================
-- ScreenGui
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name           = "MimicUI"
screenGui.ResetOnSpawn   = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent         = player.PlayerGui

-- ปุ่ม Toggle
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size             = UDim2.new(0, 44, 0, 44)
toggleBtn.Position         = UDim2.new(1, -54, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.TextColor3       = Color3.fromRGB(255, 255, 255)
toggleBtn.Text             = "⚙"
toggleBtn.Font             = Enum.Font.GothamBold
toggleBtn.TextSize         = 22
toggleBtn.BorderSizePixel  = 0
toggleBtn.ZIndex           = 10
toggleBtn.Parent           = screenGui
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 10)
local ts = Instance.new("UIStroke", toggleBtn)
ts.Color = Color3.fromRGB(100, 120, 255); ts.Thickness = 1.5

-- Panel
local panel = Instance.new("Frame")
panel.Name             = "Panel"
panel.Size             = UDim2.new(0, 290, 0, 380)
panel.Position         = UDim2.new(1, -304, 0, 64)
panel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
panel.BorderSizePixel  = 0
panel.ZIndex           = 5
panel.Parent           = screenGui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)
local ps = Instance.new("UIStroke", panel)
ps.Color = Color3.fromRGB(80, 100, 220); ps.Thickness = 1.5
local grad = Instance.new("UIGradient", panel)
grad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 22, 38)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 14, 24)),
})
grad.Rotation = 135

-- Title Bar
local titleBar = Instance.new("Frame", panel)
titleBar.Size             = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 34, 60)
titleBar.BorderSizePixel  = 0; titleBar.ZIndex = 6
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)
local tbFix = Instance.new("Frame", titleBar)
tbFix.Size = UDim2.new(1, 0, 0.5, 0); tbFix.Position = UDim2.new(0, 0, 0.5, 0)
tbFix.BackgroundColor3 = Color3.fromRGB(30, 34, 60)
tbFix.BorderSizePixel = 0; tbFix.ZIndex = 6
local titleLbl = Instance.new("TextLabel", titleBar)
titleLbl.Size = UDim2.new(1, 0, 1, 0); titleLbl.BackgroundTransparency = 1
titleLbl.Text = "⚙  Mimic Assistant"
titleLbl.TextColor3 = Color3.fromRGB(200, 210, 255)
titleLbl.Font = Enum.Font.GothamBold; titleLbl.TextSize = 14; titleLbl.ZIndex = 7

-- ============================================
-- Helper: Section Label
-- ============================================
local function sectionLabel(parent, text, yPos)
	local lbl = Instance.new("TextLabel", parent)
	lbl.Size = UDim2.new(1, -24, 0, 18); lbl.Position = UDim2.new(0, 12, 0, yPos)
	lbl.BackgroundTransparency = 1; lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(100, 120, 200)
	lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 10
	lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 7
end

-- ============================================
-- Helper: Slider
-- ============================================
local function createSlider(parent, labelText, unit, minVal, maxVal, defaultVal, yPos, onChanged)
	local lf = Instance.new("Frame", parent)
	lf.Size = UDim2.new(1, -24, 0, 20); lf.Position = UDim2.new(0, 12, 0, yPos)
	lf.BackgroundTransparency = 1; lf.ZIndex = 6

	local lbl = Instance.new("TextLabel", lf)
	lbl.Size = UDim2.new(0.65, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.Text = labelText
	lbl.TextColor3 = Color3.fromRGB(180, 190, 240); lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 7

	local valLbl = Instance.new("TextLabel", lf)
	valLbl.Size = UDim2.new(0.35, 0, 1, 0); valLbl.Position = UDim2.new(0.65, 0, 0, 0)
	valLbl.BackgroundTransparency = 1; valLbl.Text = tostring(defaultVal) .. unit
	valLbl.TextColor3 = Color3.fromRGB(120, 160, 255); valLbl.Font = Enum.Font.GothamBold
	valLbl.TextSize = 12; valLbl.TextXAlignment = Enum.TextXAlignment.Right; valLbl.ZIndex = 7

	local track = Instance.new("Frame", parent)
	track.Size = UDim2.new(1, -24, 0, 6); track.Position = UDim2.new(0, 12, 0, yPos + 24)
	track.BackgroundColor3 = Color3.fromRGB(45, 45, 65); track.BorderSizePixel = 0; track.ZIndex = 6
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame", track)
	fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(100, 130, 255); fill.BorderSizePixel = 0; fill.ZIndex = 7
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
	local fg = Instance.new("UIGradient", fill)
	fg.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 120, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 100, 255)),
	})

	local knob = Instance.new("Frame", track)
	knob.Size = UDim2.new(0, 18, 0, 18); knob.AnchorPoint = Vector2.new(0.5, 0.5)
	knob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 0.5, 0)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); knob.BorderSizePixel = 0; knob.ZIndex = 8
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
	local ks = Instance.new("UIStroke", knob); ks.Color = Color3.fromRGB(120, 150, 255); ks.Thickness = 2

	local dragging = false
	local function upd(x)
		local r  = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		local v  = math.floor(minVal + r * (maxVal - minVal) + 0.5)
		local dr = (v - minVal) / (maxVal - minVal)
		fill.Size = UDim2.new(dr, 0, 1, 0)
		knob.Position = UDim2.new(dr, 0, 0.5, 0)
		valLbl.Text = tostring(v) .. unit
		onChanged(v)
	end

	knob.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end
	end)
	track.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true; upd(i.Position.X) end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then upd(i.Position.X) end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)
end

-- ============================================
-- Helper: Toggle Button (ON/OFF)
-- ============================================
local function createToggleButton(parent, labelText, emoji, yPos, onToggle)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(1, -24, 0, 34); btn.Position = UDim2.new(0, 12, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(30, 32, 52)
	btn.Text = ""; btn.BorderSizePixel = 0; btn.ZIndex = 7
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	local bs = Instance.new("UIStroke", btn); bs.Color = Color3.fromRGB(60, 65, 100); bs.Thickness = 1

	local innerLbl = Instance.new("TextLabel", btn)
	innerLbl.Size = UDim2.new(0.75, 0, 1, 0); innerLbl.Position = UDim2.new(0, 10, 0, 0)
	innerLbl.BackgroundTransparency = 1; innerLbl.Text = emoji .. "  " .. labelText
	innerLbl.TextColor3 = Color3.fromRGB(200, 200, 230); innerLbl.Font = Enum.Font.Gotham
	innerLbl.TextSize = 13; innerLbl.TextXAlignment = Enum.TextXAlignment.Left; innerLbl.ZIndex = 8

	local badge = Instance.new("TextLabel", btn)
	badge.Size = UDim2.new(0, 46, 0, 22); badge.AnchorPoint = Vector2.new(1, 0.5)
	badge.Position = UDim2.new(1, -8, 0.5, 0)
	badge.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	badge.TextColor3 = Color3.fromRGB(160, 160, 180)
	badge.Font = Enum.Font.GothamBold; badge.TextSize = 11
	badge.Text = "OFF"; badge.ZIndex = 9; badge.BorderSizePixel = 0
	Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 6)

	local state = false
	local function updateVisual()
		if state then
			btn.BackgroundColor3   = Color3.fromRGB(28, 40, 70)
			bs.Color               = Color3.fromRGB(90, 120, 255)
			badge.BackgroundColor3 = Color3.fromRGB(70, 110, 255)
			badge.TextColor3       = Color3.fromRGB(255, 255, 255)
			badge.Text             = "ON"
		else
			btn.BackgroundColor3   = Color3.fromRGB(30, 32, 52)
			bs.Color               = Color3.fromRGB(60, 65, 100)
			badge.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
			badge.TextColor3       = Color3.fromRGB(160, 160, 180)
			badge.Text             = "OFF"
		end
	end

	btn.Activated:Connect(function()
		state = not state; updateVisual(); onToggle(state)
	end)
end

-- ============================================
-- วาง Widgets
-- ============================================
sectionLabel(panel, "── PLAYER ──────────────────", 46)

createSlider(panel, "☀  Brightness", "", MIN_BRIGHTNESS, MAX_BRIGHTNESS, DEFAULT_BRIGHTNESS, 66, function(v)
	currentBrightness = v; Lighting.Brightness = v
end)
createSlider(panel, "⚡  Walk Speed", "", MIN_SPEED, MAX_SPEED, DEFAULT_SPEED, 108, function(v)
	currentSpeed = v; if humanoid then humanoid.WalkSpeed = v end
end)

sectionLabel(panel, "── THE MIMIC BOOK 3 ────────", 155)

createToggleButton(panel, "Monster ESP", "👁", 175, function(state)
	espEnabled = state
	if state then refreshESP() else clearESP() end
end)

createToggleButton(panel, "Noclip", "👻", 217, function(state)
	noclipEnabled = state
	if not state and character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = true end
		end
	end
end)

createToggleButton(panel, "Item Highlight", "✨", 259, function(state)
	itemEspEnabled = state
	if state then refreshItemESP() else clearItemESP() end
end)

-- Divider
local divider = Instance.new("Frame", panel)
divider.Size = UDim2.new(1, -24, 0, 1); divider.Position = UDim2.new(0, 12, 0, 308)
divider.BackgroundColor3 = Color3.fromRGB(50, 55, 90); divider.BorderSizePixel = 0; divider.ZIndex = 6

-- Hint text
local hint = Instance.new("TextLabel", panel)
hint.Size = UDim2.new(1, -24, 0, 55); hint.Position = UDim2.new(0, 12, 0, 316)
hint.BackgroundTransparency = 1
hint.Text = "🔴 Monster ESP = กล่องแดงรอบมอนสเตอร์\n🟡 Item Highlight = กล่องเหลืองรอบไอเทม\n👻 Noclip = ลอดกำแพงได้ (ปิดเมื่อไม่ใช้)"
hint.TextColor3 = Color3.fromRGB(90, 100, 140)
hint.Font = Enum.Font.Gotham; hint.TextSize = 10
hint.TextWrapped = true; hint.ZIndex = 7

-- ============================================
-- Toggle Panel (ปุ่ม ⚙)
-- ============================================
local function toggleUI()
	isUIOpen = not isUIOpen
	panel.Visible = isUIOpen
	toggleBtn.Text = isUIOpen and "✕" or "⚙"
	toggleBtn.BackgroundColor3 = isUIOpen
		and Color3.fromRGB(40, 40, 60)
		or  Color3.fromRGB(30, 30, 40)
end

toggleBtn.Activated:Connect(toggleUI)
toggleBtn.MouseEnter:Connect(function()
	toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 90)
end)
toggleBtn.MouseLeave:Connect(function()
	toggleBtn.BackgroundColor3 = isUIOpen and Color3.fromRGB(40, 40, 60) or Color3.fromRGB(30, 30, 40)
end)

-- ============================================
-- Init
-- ============================================
Lighting.Brightness = DEFAULT_BRIGHTNESS
if humanoid then humanoid.WalkSpeed = DEFAULT_SPEED end

print("[MimicUI] โหลดสำเร็จ ✓")
