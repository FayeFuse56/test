-- ============================================
--   MimicUI v2 — The Mimic Book 3
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
local DEFAULT_BRIGHTNESS = 10   -- 0-30 (ClockTime-based)
local DEFAULT_SPEED      = 16
local MIN_BRIGHTNESS, MAX_BRIGHTNESS = 0, 30
local MIN_SPEED,      MAX_SPEED      = 4, 200

local currentSpeed  = DEFAULT_SPEED
local isUIOpen      = true

local espEnabled     = false
local noclipEnabled  = false
local itemEspEnabled = false
local godEnabled     = false
local hitboxEnabled  = false
local espHighlights  = {}
local itemHighlights = {}

local function getHumanoid()
	if character then
		return character:FindFirstChildOfClass("Humanoid")
	end
	return nil
end

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid  = newChar:WaitForChild("Humanoid")
	humanoid.WalkSpeed = currentSpeed
end)

-- ============================================
-- God Mode — ล็อก HP เต็มทุก frame
-- ============================================
RunService.Heartbeat:Connect(function()
	if not godEnabled then return end
	local hum = getHumanoid()
	if hum and hum.Health < hum.MaxHealth then
		hum.Health = hum.MaxHealth
	end
end)

-- ============================================
-- ฟังก์ชัน setBrightness (สว่างจริง)
-- ============================================
local function setBrightness(val)
	-- val 0-30
	-- ClockTime 0=เที่ยงคืน, 14=บ่าย2 (สว่างสุด), 6=เช้า
	local ratio = val / 30
	Lighting.ClockTime  = 6 + ratio * 8   -- 6 (เช้า) ถึง 14 (บ่าย)
	Lighting.Brightness = 1 + ratio * 4   -- 1 ถึง 5
	Lighting.Ambient    = Color3.fromRGB(
		math.floor(ratio * 120),
		math.floor(ratio * 120),
		math.floor(ratio * 140)
	)
	Lighting.OutdoorAmbient = Color3.fromRGB(
		math.floor(80 + ratio * 100),
		math.floor(80 + ratio * 100),
		math.floor(90 + ratio * 110)
	)
end

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
	for model, h in pairs(espHighlights) do h:Destroy(); espHighlights[model] = nil end
end
local function refreshESP()
	clearESP()
	if not espEnabled then return end
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("Model") and isMonster(obj) then
			local h = Instance.new("SelectionBox")
			h.Adornee = obj; h.Color3 = Color3.fromRGB(255,50,50)
			h.LineThickness = 0.06; h.SurfaceTransparency = 0.85
			h.SurfaceColor3 = Color3.fromRGB(255,80,80); h.Parent = Workspace
			espHighlights[obj] = h
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
-- Noclip + Y-Axis Control
-- ============================================
local noclipConn  = nil
local yAxisActive = false   -- true = ล็อก Y (ลอยอยู่กับที่)
local yMoveDir    = 0       -- 1=ขึ้น, -1=ลง, 0=หยุด
local Y_SPEED     = 20

local function enableNoclip()
	if noclipConn then return end
	local ws = game:GetService("Workspace")
	noclipConn = RunService.Stepped:Connect(function()
		if not character then return end
		-- ปิด CanCollide ทุก part
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
		local root = character:FindFirstChild("HumanoidRootPart")
		local hum  = getHumanoid()
		if not root or not hum then return end
		-- ปิด Humanoid physics ไม่ให้มันดึงลง
		hum.PlatformStand = true
		-- จัดการ velocity Y
		local vel = root.AssemblyLinearVelocity
		if yMoveDir ~= 0 then
			-- กำลังขึ้น/ลง
			root.AssemblyLinearVelocity = Vector3.new(vel.X, yMoveDir * Y_SPEED, vel.Z)
		else
			-- ล็อก Y ไว้ที่ 0 ไม่ให้ตก
			root.AssemblyLinearVelocity = Vector3.new(vel.X, 0, vel.Z)
		end
	end)
end

local function disableNoclip()
	if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
	if character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = true end
		end
		local hum = getHumanoid()
		if hum then hum.PlatformStand = false end
	end
	yMoveDir = 0
end

-- keyboard: Space = ขึ้น, Shift = ลง (เฉพาะตอน noclip เปิด)
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe or not noclipEnabled then return end
	if input.KeyCode == Enum.KeyCode.Space      then yMoveDir =  1 end
	if input.KeyCode == Enum.KeyCode.LeftShift  then yMoveDir = -1 end
end)
UserInputService.InputEnded:Connect(function(input)
	if not noclipEnabled then return end
	if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then
		yMoveDir = 0
	end
end)

-- ============================================
-- Hitbox ESP — ทุก Model ที่มี Humanoid
-- ============================================
local hitboxEnabled    = false
local hitboxHighlights = {}

local function clearHitbox()
	for obj, h in pairs(hitboxHighlights) do
		h:Destroy(); hitboxHighlights[obj] = nil
	end
end

local function refreshHitbox()
	clearHitbox()
	if not hitboxEnabled then return end
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("Model") then
			local hum = obj:FindFirstChildOfClass("Humanoid")
			-- ข้ามตัวละครของผู้เล่นเอง
			if hum and obj ~= character then
				local isPlayer = false
				for _, p in ipairs(Players:GetPlayers()) do
					if p.Character == obj then isPlayer = true; break end
				end
				-- สีต่างกัน: เขียว = player อื่น, ส้ม = NPC/monster
				local col = isPlayer
					and Color3.fromRGB(0, 255, 100)
					or  Color3.fromRGB(255, 140, 0)

				local h = Instance.new("SelectionBox")
				h.Adornee             = obj
				h.Color3              = col
				h.LineThickness       = 0.04
				h.SurfaceTransparency = 0.9
				h.SurfaceColor3       = col
				h.Parent              = Workspace
				hitboxHighlights[obj] = h

				-- แสดง HP บน HumanoidRootPart
				local root = obj:FindFirstChild("HumanoidRootPart")
				if root then
					local bb = Instance.new("BillboardGui")
					bb.Name          = "HitboxLabel"
					bb.Adornee       = root
					bb.Size          = UDim2.new(0, 80, 0, 28)
					bb.StudsOffset   = Vector3.new(0, 3, 0)
					bb.AlwaysOnTop   = true
					bb.Parent        = Workspace

					local lbl = Instance.new("TextLabel", bb)
					lbl.Size                = UDim2.new(1, 0, 1, 0)
					lbl.BackgroundTransparency = 1
					lbl.TextColor3          = col
					lbl.Font                = Enum.Font.GothamBold
					lbl.TextSize            = 14
					lbl.TextStrokeTransparency = 0
					lbl.TextStrokeColor3    = Color3.fromRGB(0,0,0)

					-- อัปเดต HP label ทุก frame
					RunService.Heartbeat:Connect(function()
						if not hitboxEnabled or not hum or not hum.Parent then
							bb:Destroy(); return
						end
						lbl.Text = string.format("❤ %d/%d", math.floor(hum.Health), math.floor(hum.MaxHealth))
					end)

					hitboxHighlights[obj .. "_bb"] = bb
				end
			end
		end
	end
end

local hitboxTimer = 0
RunService.Heartbeat:Connect(function(dt)
	if not hitboxEnabled then return end
	hitboxTimer += dt
	if hitboxTimer >= 3 then hitboxTimer = 0; refreshHitbox() end
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
	for obj, h in pairs(itemHighlights) do h:Destroy(); itemHighlights[obj] = nil end
end
local function refreshItemESP()
	clearItemESP()
	if not itemEspEnabled then return end
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if (obj:IsA("BasePart") or obj:IsA("Model")) and isImportantItem(obj) then
			local h = Instance.new("SelectionBox")
			h.Adornee = obj; h.Color3 = Color3.fromRGB(255,220,0)
			h.LineThickness = 0.05; h.SurfaceTransparency = 0.8
			h.SurfaceColor3 = Color3.fromRGB(255,240,80); h.Parent = Workspace
			itemHighlights[obj] = h
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
screenGui.Name = "MimicUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player.PlayerGui

-- ปุ่ม Toggle (เฉพาะซ่อน/แสดง panel เท่านั้น)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0,44,0,44)
toggleBtn.Position = UDim2.new(1,-54,0,10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,40)
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Text = "⚙"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 22
toggleBtn.BorderSizePixel = 0
toggleBtn.ZIndex = 10
toggleBtn.Parent = screenGui
Instance.new("UICorner",toggleBtn).CornerRadius = UDim.new(0,10)
local ts = Instance.new("UIStroke",toggleBtn)
ts.Color = Color3.fromRGB(100,120,255); ts.Thickness = 1.5

-- Panel
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0,290,0,580)
panel.Position = UDim2.new(0,20,0,64)   -- ซ้ายบน ขยับได้
panel.BackgroundColor3 = Color3.fromRGB(18,18,28)
panel.BorderSizePixel = 0
panel.ZIndex = 5
panel.Parent = screenGui
Instance.new("UICorner",panel).CornerRadius = UDim.new(0,14)
local ps = Instance.new("UIStroke",panel)
ps.Color = Color3.fromRGB(80,100,220); ps.Thickness = 1.5
local grad = Instance.new("UIGradient",panel)
grad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(22,22,38)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(14,14,24)),
}); grad.Rotation = 135

-- Title Bar (ใช้ลาก UI)
local titleBar = Instance.new("Frame",panel)
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1,0,0,40)
titleBar.BackgroundColor3 = Color3.fromRGB(30,34,60)
titleBar.BorderSizePixel = 0; titleBar.ZIndex = 6
Instance.new("UICorner",titleBar).CornerRadius = UDim.new(0,14)
local tbFix = Instance.new("Frame",titleBar)
tbFix.Size = UDim2.new(1,0,0.5,0); tbFix.Position = UDim2.new(0,0,0.5,0)
tbFix.BackgroundColor3 = Color3.fromRGB(30,34,60); tbFix.BorderSizePixel = 0; tbFix.ZIndex = 6

local titleLbl = Instance.new("TextLabel",titleBar)
titleLbl.Size = UDim2.new(1,-40,1,0)
titleLbl.Position = UDim2.new(0,10,0,0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "✥  Mimic Assistant  (ลากได้)"
titleLbl.TextColor3 = Color3.fromRGB(200,210,255)
titleLbl.Font = Enum.Font.GothamBold; titleLbl.TextSize = 13; titleLbl.ZIndex = 7
titleLbl.TextXAlignment = Enum.TextXAlignment.Left

-- ============================================
-- Drag logic (ลาก panel)
-- ============================================
local draggingPanel = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		draggingPanel = true
		dragStart  = input.Position
		startPos   = panel.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingPanel and (
		input.UserInputType == Enum.UserInputType.MouseMovement or
		input.UserInputType == Enum.UserInputType.Touch
	) then
		local delta = input.Position - dragStart
		panel.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		draggingPanel = false
	end
end)

-- ============================================
-- Helpers
-- ============================================
local function sectionLabel(parent, text, yPos)
	local lbl = Instance.new("TextLabel",parent)
	lbl.Size = UDim2.new(1,-24,0,18); lbl.Position = UDim2.new(0,12,0,yPos)
	lbl.BackgroundTransparency = 1; lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(100,120,200)
	lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 10
	lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 7
end

local function createSlider(parent, labelText, unit, minVal, maxVal, defaultVal, yPos, onChanged)
	local lf = Instance.new("Frame",parent)
	lf.Size = UDim2.new(1,-24,0,20); lf.Position = UDim2.new(0,12,0,yPos)
	lf.BackgroundTransparency = 1; lf.ZIndex = 6

	local lbl = Instance.new("TextLabel",lf)
	lbl.Size = UDim2.new(0.65,0,1,0); lbl.BackgroundTransparency = 1; lbl.Text = labelText
	lbl.TextColor3 = Color3.fromRGB(180,190,240); lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 7

	local valLbl = Instance.new("TextLabel",lf)
	valLbl.Size = UDim2.new(0.35,0,1,0); valLbl.Position = UDim2.new(0.65,0,0,0)
	valLbl.BackgroundTransparency = 1; valLbl.Text = tostring(defaultVal)..unit
	valLbl.TextColor3 = Color3.fromRGB(120,160,255); valLbl.Font = Enum.Font.GothamBold
	valLbl.TextSize = 12; valLbl.TextXAlignment = Enum.TextXAlignment.Right; valLbl.ZIndex = 7

	local track = Instance.new("Frame",parent)
	track.Size = UDim2.new(1,-24,0,6); track.Position = UDim2.new(0,12,0,yPos+24)
	track.BackgroundColor3 = Color3.fromRGB(45,45,65); track.BorderSizePixel = 0; track.ZIndex = 6
	Instance.new("UICorner",track).CornerRadius = UDim.new(1,0)

	local fill = Instance.new("Frame",track)
	fill.Size = UDim2.new((defaultVal-minVal)/(maxVal-minVal),0,1,0)
	fill.BackgroundColor3 = Color3.fromRGB(100,130,255); fill.BorderSizePixel = 0; fill.ZIndex = 7
	Instance.new("UICorner",fill).CornerRadius = UDim.new(1,0)
	local fg = Instance.new("UIGradient",fill)
	fg.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0,Color3.fromRGB(90,120,255)),
		ColorSequenceKeypoint.new(1,Color3.fromRGB(160,100,255)),
	})

	local knob = Instance.new("Frame",track)
	knob.Size = UDim2.new(0,18,0,18); knob.AnchorPoint = Vector2.new(0.5,0.5)
	knob.Position = UDim2.new((defaultVal-minVal)/(maxVal-minVal),0,0.5,0)
	knob.BackgroundColor3 = Color3.fromRGB(255,255,255); knob.BorderSizePixel = 0; knob.ZIndex = 8
	Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)
	local ks = Instance.new("UIStroke",knob); ks.Color = Color3.fromRGB(120,150,255); ks.Thickness = 2

	local sliderDragging = false
	local function upd(x)
		local r = math.clamp((x-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)
		local v = math.floor(minVal+r*(maxVal-minVal)+0.5)
		local dr = (v-minVal)/(maxVal-minVal)
		fill.Size = UDim2.new(dr,0,1,0)
		knob.Position = UDim2.new(dr,0,0.5,0)
		valLbl.Text = tostring(v)..unit
		onChanged(v)
	end

	knob.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			sliderDragging=true
		end
	end)
	track.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			sliderDragging=true; upd(i.Position.X)
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if sliderDragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
			upd(i.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			sliderDragging=false
		end
	end)
end

local function createToggleButton(parent, labelText, emoji, yPos, onToggle)
	local btn = Instance.new("TextButton",parent)
	btn.Size = UDim2.new(1,-24,0,34); btn.Position = UDim2.new(0,12,0,yPos)
	btn.BackgroundColor3 = Color3.fromRGB(30,32,52); btn.Text = ""
	btn.BorderSizePixel = 0; btn.ZIndex = 7
	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)
	local bs = Instance.new("UIStroke",btn); bs.Color = Color3.fromRGB(60,65,100); bs.Thickness = 1

	local innerLbl = Instance.new("TextLabel",btn)
	innerLbl.Size = UDim2.new(0.75,0,1,0); innerLbl.Position = UDim2.new(0,10,0,0)
	innerLbl.BackgroundTransparency = 1; innerLbl.Text = emoji.."  "..labelText
	innerLbl.TextColor3 = Color3.fromRGB(200,200,230); innerLbl.Font = Enum.Font.Gotham
	innerLbl.TextSize = 13; innerLbl.TextXAlignment = Enum.TextXAlignment.Left; innerLbl.ZIndex = 8

	local badge = Instance.new("TextLabel",btn)
	badge.Size = UDim2.new(0,46,0,22); badge.AnchorPoint = Vector2.new(1,0.5)
	badge.Position = UDim2.new(1,-8,0.5,0)
	badge.BackgroundColor3 = Color3.fromRGB(60,60,80)
	badge.TextColor3 = Color3.fromRGB(160,160,180)
	badge.Font = Enum.Font.GothamBold; badge.TextSize = 11
	badge.Text = "OFF"; badge.ZIndex = 9; badge.BorderSizePixel = 0
	Instance.new("UICorner",badge).CornerRadius = UDim.new(0,6)

	local state = false
	local function updateVisual()
		if state then
			btn.BackgroundColor3 = Color3.fromRGB(28,40,70)
			bs.Color = Color3.fromRGB(90,120,255)
			badge.BackgroundColor3 = Color3.fromRGB(70,110,255)
			badge.TextColor3 = Color3.fromRGB(255,255,255)
			badge.Text = "ON"
		else
			btn.BackgroundColor3 = Color3.fromRGB(30,32,52)
			bs.Color = Color3.fromRGB(60,65,100)
			badge.BackgroundColor3 = Color3.fromRGB(60,60,80)
			badge.TextColor3 = Color3.fromRGB(160,160,180)
			badge.Text = "OFF"
		end
	end

	-- ใช้ MouseButton1Click แทน Activated เพื่อกันการ bubble ขึ้น panel
	btn.MouseButton1Click:Connect(function()
		state = not state; updateVisual(); onToggle(state)
	end)
end

-- ============================================
-- วาง Widgets
-- ============================================
sectionLabel(panel, "── PLAYER ──────────────────", 46)

createSlider(panel, "☀  Brightness", "", MIN_BRIGHTNESS, MAX_BRIGHTNESS, DEFAULT_BRIGHTNESS, 66, function(v)
	setBrightness(v)
end)

createToggleButton(panel, "Full Brightness", "🌕", 100, function(state)
	if state then
		Lighting.Brightness = 10
		Lighting.ClockTime = 14
		Lighting.Ambient = Color3.fromRGB(255,255,255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
		for _, obj in ipairs(Lighting:GetChildren()) do
			if obj:IsA("BlurEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("Atmosphere") then
				obj.Enabled = false
			end
		end
	else
		setBrightness(DEFAULT_BRIGHTNESS)
		for _, obj in ipairs(Lighting:GetChildren()) do
			if obj:IsA("BlurEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("Atmosphere") then
				obj.Enabled = true
			end
		end
	end
end)

createSlider(panel, "⚡  Walk Speed", "", MIN_SPEED, MAX_SPEED, DEFAULT_SPEED, 148, function(v)
	currentSpeed = v
end)

-- บังคับ WalkSpeed ทุก frame สู้กับ script ของเกมที่ reset ค่า
RunService.Heartbeat:Connect(function()
	local hum = getHumanoid()
	if hum and currentSpeed ~= DEFAULT_SPEED then
		hum.WalkSpeed = currentSpeed
	end
end)

sectionLabel(panel, "── THE MIMIC BOOK 3 ────────", 200)

createToggleButton(panel, "Monster ESP", "👁", 220, function(state)
	espEnabled = state
	if state then refreshESP() else clearESP() end
end)

createToggleButton(panel, "Noclip", "👻", 262, function(state)
	noclipEnabled = state
	if state then enableNoclip() else disableNoclip() end
end)

-- Y-Axis label
local yLabel = Instance.new("TextLabel", panel)
yLabel.Size = UDim2.new(1,-24,0,16); yLabel.Position = UDim2.new(0,12,0,303)
yLabel.BackgroundTransparency = 1
yLabel.Text = "  📐 Y-Axis (ค้างปุ่มเพื่อขึ้น/ลง เฉพาะตอน Noclip)"
yLabel.TextColor3 = Color3.fromRGB(100,120,200)
yLabel.Font = Enum.Font.GothamBold; yLabel.TextSize = 10
yLabel.TextXAlignment = Enum.TextXAlignment.Left; yLabel.ZIndex = 7

-- ปุ่ม UP
local btnUp = Instance.new("TextButton", panel)
btnUp.Size = UDim2.new(0.44,0,0,34); btnUp.Position = UDim2.new(0,12,0,322)
btnUp.BackgroundColor3 = Color3.fromRGB(40,60,100); btnUp.Text = "⬆  ขึ้น"
btnUp.TextColor3 = Color3.fromRGB(200,220,255); btnUp.Font = Enum.Font.GothamBold
btnUp.TextSize = 13; btnUp.BorderSizePixel = 0; btnUp.ZIndex = 7
Instance.new("UICorner", btnUp).CornerRadius = UDim.new(0,8)

-- ปุ่ม DOWN
local btnDown = Instance.new("TextButton", panel)
btnDown.Size = UDim2.new(0.44,0,0,34); btnDown.Position = UDim2.new(0.5,2,0,322)
btnDown.BackgroundColor3 = Color3.fromRGB(80,40,40); btnDown.Text = "⬇  ลง"
btnDown.TextColor3 = Color3.fromRGB(255,200,200); btnDown.Font = Enum.Font.GothamBold
btnDown.TextSize = 13; btnDown.BorderSizePixel = 0; btnDown.ZIndex = 7
Instance.new("UICorner", btnDown).CornerRadius = UDim.new(0,8)

btnUp.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then yMoveDir=1 end
end)
btnUp.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then yMoveDir=0 end
end)
btnDown.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then yMoveDir=-1 end
end)
btnDown.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then yMoveDir=0 end
end)

createToggleButton(panel, "Item Highlight", "✨", 366, function(state)
	itemEspEnabled = state
	if state then refreshItemESP() else clearItemESP() end
end)

createToggleButton(panel, "God Mode", "🛡", 408, function(state)
	godEnabled = state
end)

createToggleButton(panel, "Hitbox ESP", "📦", 450, function(state)
	hitboxEnabled = state
	if state then refreshHitbox() else clearHitbox() end
end)

local divider = Instance.new("Frame",panel)
divider.Size = UDim2.new(1,-24,0,1); divider.Position = UDim2.new(0,12,0,498)
divider.BackgroundColor3 = Color3.fromRGB(50,55,90); divider.BorderSizePixel = 0; divider.ZIndex = 6

local hint = Instance.new("TextLabel",panel)
hint.Size = UDim2.new(1,-24,0,60); hint.Position = UDim2.new(0,12,0,505)
hint.BackgroundTransparency = 1
hint.Text = "🔴 ESP=มอนสเตอร์  🟡 Item=ไอเทม\n👻 Noclip: Space=ขึ้น Shift=ลง (PC)\n   กดค้าง ⬆⬇ เพื่อบิน (มือถือ)"
hint.TextColor3 = Color3.fromRGB(90,100,140)
hint.Font = Enum.Font.Gotham; hint.TextSize = 10
hint.TextWrapped = true; hint.ZIndex = 7

-- ============================================
-- Toggle Panel — แยกอิสระจากปุ่มอื่นทั้งหมด
-- ============================================
local function toggleUI()
	isUIOpen = not isUIOpen
	panel.Visible = isUIOpen
	toggleBtn.Text = isUIOpen and "✕" or "⚙"
	toggleBtn.BackgroundColor3 = isUIOpen
		and Color3.fromRGB(40,40,60)
		or  Color3.fromRGB(30,30,40)
end

-- ใช้ MouseButton1Click บน toggleBtn โดยตรง ไม่ bubble ไปที่อื่น
toggleBtn.MouseButton1Click:Connect(toggleUI)
toggleBtn.MouseEnter:Connect(function() toggleBtn.BackgroundColor3 = Color3.fromRGB(50,55,90) end)
toggleBtn.MouseLeave:Connect(function()
	toggleBtn.BackgroundColor3 = isUIOpen and Color3.fromRGB(40,40,60) or Color3.fromRGB(30,30,40)
end)

-- ============================================
-- Init
-- ============================================
setBrightness(DEFAULT_BRIGHTNESS)
if humanoid then humanoid.WalkSpeed = DEFAULT_SPEED end

print("[MimicUI v2] โหลดสำเร็จ ✓")
