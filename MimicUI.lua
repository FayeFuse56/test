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
local aimbotEnabled  = false
local espHighlights  = {}
local itemHighlights = {}

local function getHumanoid()
	if character then
		return character:FindFirstChildOfClass("Humanoid")
	end
	return nil
end

-- ============================================
-- God Mode — Health ไม่ต่ำกว่า 1 + ไม่มีเสียง
-- ============================================
local godModeConnection = nil

local function enableGodMode()
	if godModeConnection then return end
	local hum = getHumanoid()
	if not hum then return end
	
	-- ล็อก Health ไม่ให้ต่ำกว่า 1
	hum.Health = hum.MaxHealth
	
	local godModeTimer = 0
	godModeConnection = RunService.Heartbeat:Connect(function(dt)
		if not godEnabled then return end
		if hum and hum.Health < 1 then
			hum.Health = 1  -- ล็อกไว้ที่ 1 ต่ำสุด
		end
		-- Mute damage sounds (คำนวนทุก 2 วิ แทนทุกเฟรม ลดแลค)
		godModeTimer += dt
		if godModeTimer >= 2 then
			godModeTimer = 0
			for _, sound in ipairs(Workspace:GetDescendants()) do
				if sound:IsA("Sound") and (sound.Name:lower():find("hit") or sound.Name:lower():find("damage") or sound.Name:lower():find("pain")) then
					sound.Volume = 0
				end
			end
		end
	end)
end

local function disableGodMode()
	if godModeConnection then
		godModeConnection:Disconnect()
		godModeConnection = nil
	end
	-- คืนเสียง
	for _, sound in ipairs(Workspace:GetDescendants()) do
		if sound:IsA("Sound") then
			sound.Volume = (sound:GetAttribute("OriginalVolume") or 0.5)
		end
	end
end

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
-- Monster ESP + Tracer lines
-- ============================================
local espHighlights = {}
local espTracers    = {}
local xrayEnabled   = false

local function clearESP()
	for obj, h in pairs(espHighlights) do h:Destroy(); espHighlights[obj] = nil end
	for obj, t in pairs(espTracers)    do t:Destroy(); espTracers[obj]    = nil end
end

local function refreshESP()
	clearESP()
	if not espEnabled then return end
	local myRoot = character and character:FindFirstChild("HumanoidRootPart")
	if not myRoot then return end

	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("Model") and obj ~= character then

			-- เช็คระยะห่าง ต้องไม่เกิน 500 studs
			local objPos = obj:FindFirstChildWhichIsA("BasePart")
			if not objPos then continue end
			local dist = (objPos.Position - myRoot.Position).Magnitude
			if dist > 500 then continue end

			-- ข้ามผู้เล่นจริง
			local isPlayer = false
			for _, p in ipairs(Players:GetPlayers()) do
				if p.Character == obj then isPlayer = true; break end
			end
			if isPlayer then continue end

			-- เช็คหลายวิธี: Humanoid / AnimationController / HumanoidRootPart / Script ที่เคลื่อนไหว
			local hasHum    = obj:FindFirstChildOfClass("Humanoid") ~= nil
			local hasAnim   = obj:FindFirstChildOfClass("AnimationController") ~= nil
			local hasRoot   = obj:FindFirstChild("HumanoidRootPart") ~= nil
			local hasScript = obj:FindFirstChildOfClass("Script") ~= nil or obj:FindFirstChildOfClass("LocalScript") ~= nil

			local isTarget = hasHum or hasAnim or (hasRoot and hasScript)

			if isTarget and not espHighlights[obj] then
				local npcRoot = obj:FindFirstChild("HumanoidRootPart")
					or obj:FindFirstChildWhichIsA("BasePart")

				-- กล่องสีแดง
				local h = Instance.new("SelectionBox")
				h.Adornee             = obj
				h.Color3              = Color3.fromRGB(255, 50, 50)
				h.LineThickness       = 0.06
				h.SurfaceTransparency = 0.85
				h.SurfaceColor3       = Color3.fromRGB(255, 80, 80)
				h.Parent              = Workspace
				espHighlights[obj]    = h

				-- เส้น tracer โยงมาที่ตัวเรา
				if myRoot and npcRoot then
					local hum = obj:FindFirstChildOfClass("Humanoid")
					if hum then
						local beam = Instance.new("SelectionPartLasso")
						beam.Part      = myRoot
						beam.Humanoid  = hum
						beam.Color     = BrickColor.new("Bright red")
						beam.Thickness = 2
						beam.Parent    = Workspace
						espTracers[obj] = beam
					end
				end
			end
		end
	end
end

local espTimer = 0
RunService.Heartbeat:Connect(function(dt)
	if not espEnabled then return end
	espTimer += dt
	if espTimer >= 2 then espTimer = 0; refreshESP() end
end)

-- จับผีที่ spawn ขึ้นมาใหม่ระหว่างเกม
Workspace.DescendantAdded:Connect(function(obj)
	if not espEnabled then return end
	task.wait(0.5) -- รอให้ model โหลดครบก่อน
	refreshESP()
end)

-- ============================================
-- Noclip + Y-Axis Control
-- ============================================
local noclipConn  = nil
local yMoveDir    = 0
local Y_SPEED     = 20
local bodyVel     = nil  -- BodyVelocity สำหรับต้าน gravity

local function enableNoclip()
	if noclipConn then return end

	-- สร้าง BodyVelocity ใน HumanoidRootPart เพื่อล็อก Y
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if root then
		bodyVel = Instance.new("BodyVelocity")
		bodyVel.Velocity       = Vector3.new(0, 0, 0)
		bodyVel.MaxForce       = Vector3.new(0, math.huge, 0)  -- แค่แกน Y
		bodyVel.P              = math.huge
		bodyVel.Parent         = root
	end

	noclipConn = RunService.Stepped:Connect(function()
		if not character then return end

		-- ปิด CanCollide ทุก part
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end

		-- อัปเดต Y velocity ผ่าน BodyVelocity
		if bodyVel and bodyVel.Parent then
			bodyVel.Velocity = Vector3.new(0, yMoveDir * Y_SPEED, 0)
		end
	end)
end

local function disableNoclip()
	-- ลบ BodyVelocity
	if bodyVel then
		bodyVel:Destroy()
		bodyVel = nil
	end
	if noclipConn then
		noclipConn:Disconnect()
		noclipConn = nil
	end
	-- คืน collision
	if character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = true end
		end
	end
	yMoveDir = 0
end

-- respawn แล้ว noclip ยังเปิดอยู่ ให้รีสตาร์ท
player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid  = newChar:WaitForChild("Humanoid")
	humanoid.WalkSpeed = currentSpeed
	if noclipEnabled then
		if bodyVel then bodyVel:Destroy(); bodyVel = nil end
		if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
		task.wait(0.5)
		enableNoclip()
	end
end)

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

					-- อัปเดต HP label ทุก 2 วิ (ลดภาระการคำนวน)
					local hpTimer = 0
					RunService.Heartbeat:Connect(function(dt)
						if not hitboxEnabled or not hum or not hum.Parent then
							bb:Destroy(); return
						end
						hpTimer += dt
						if hpTimer >= 2 then
							hpTimer = 0
							lbl.Text = string.format("❤ %d/%d", math.floor(hum.Health), math.floor(hum.MaxHealth))
						end
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
-- FPS Boost — ลบ object ห่างไกล (500+ studs)
-- ============================================
local fpsBoostEnabled = false
local destroyedObjects = {}

local function enableFPSBoost()
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj:IsDescendantOf(character) then
			local dist = (obj.Position - root.Position).Magnitude
			if dist > 500 then
				-- ไม่ลบจริงๆ แค่ซ่อน
				obj.Transparency = 1
				obj.CanCollide = false
				destroyedObjects[obj] = {trans = obj.Transparency, collision = obj.CanCollide}
			end
		end
	end
end

local function disableFPSBoost()
	for obj, data in pairs(destroyedObjects) do
		if obj and obj.Parent then
			obj.Transparency = 0
			obj.CanCollide = true
		end
	end
	destroyedObjects = {}
end

local fpsBoostTimer = 0
RunService.Heartbeat:Connect(function(dt)
	if not fpsBoostEnabled then return end
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	-- อัปเดต object ไกล ทุก 2 วิ
	fpsBoostTimer += dt
	if fpsBoostTimer >= 2 then
		fpsBoostTimer = 0
		enableFPSBoost()
	end
end)
local xrayObjects = {}

local function enableXray()
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Transparency < 0.9 then
			-- ข้าม part ของตัวละครเราเอง
			local inChar = character and character:IsAncestorOf(obj)
			if not inChar then
				xrayObjects[obj] = obj.Transparency
				obj.Transparency = 0.85
			end
		end
	end
end

local function disableXray()
	for obj, origTrans in pairs(xrayObjects) do
		if obj and obj.Parent then
			obj.Transparency = origTrans
		end
	end
	xrayObjects = {}
end
-- Aimbot — ล็อก camera ไปที่ NPC ใกล้สุด
-- ============================================
local aimbotEnabled = false
local camera        = Workspace.CurrentCamera

local function getNearestNPC()
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then return nil end

	local nearest, nearestDist = nil, math.huge
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("Model") and obj ~= character then
			local hum     = obj:FindFirstChildOfClass("Humanoid")
			local npcRoot = obj:FindFirstChild("HumanoidRootPart")
			-- เอาเฉพาะ NPC ที่ยังมีชีวิต ไม่ใช่ผู้เล่นจริง
			if hum and npcRoot and hum.Health > 0 then
				local isPlayer = false
				for _, p in ipairs(Players:GetPlayers()) do
					if p.Character == obj then isPlayer = true; break end
				end
				if not isPlayer then
					local dist = (npcRoot.Position - root.Position).Magnitude
					if dist < nearestDist then
						nearestDist = dist
						nearest     = npcRoot
					end
				end
			end
		end
	end
	return nearest
end

RunService.RenderStepped:Connect(function()
	if not aimbotEnabled then return end
	local target = getNearestNPC()
	if not target then return end
	-- หมุน camera ไปที่เป้า
	local camPos = camera.CFrame.Position
	camera.CFrame = CFrame.lookAt(camPos, target.Position)
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

-- ============================================
-- Object Details Inspector — กด Part เพื่อดู ID/ชื่อ/ค่าต่างๆ
-- ============================================
local inspectFrame = Instance.new("Frame")
inspectFrame.Name = "InspectPanel"
inspectFrame.Size = UDim2.new(0,280,0,260)
inspectFrame.Position = UDim2.new(0,10,0,300)
inspectFrame.BackgroundColor3 = Color3.fromRGB(14,14,22)
inspectFrame.BorderSizePixel = 0
inspectFrame.ZIndex = 12
inspectFrame.Parent = screenGui
Instance.new("UICorner",inspectFrame).CornerRadius = UDim.new(0,10)
local inspStroke = Instance.new("UIStroke",inspectFrame)
inspStroke.Color = Color3.fromRGB(80,180,100); inspStroke.Thickness = 1.5

-- Title bar (ใช้ลาก)
local inspTitle = Instance.new("TextLabel",inspectFrame)
inspTitle.Name = "TitleBar"
inspTitle.Size = UDim2.new(1,-40,0,24); inspTitle.Position = UDim2.new(0,0,0,0)
inspTitle.BackgroundColor3 = Color3.fromRGB(20,40,20)
inspTitle.Text = "🔍 Object Inspector"
inspTitle.TextColor3 = Color3.fromRGB(100,255,100)
inspTitle.Font = Enum.Font.GothamBold; inspTitle.TextSize = 12; inspTitle.ZIndex = 13
Instance.new("UICorner",inspTitle).CornerRadius = UDim.new(0,10)

-- ปุ่ม Close
local closeBtn = Instance.new("TextButton",inspectFrame)
closeBtn.Size = UDim2.new(0,36,0,24); closeBtn.Position = UDim2.new(1,-36,0,0)
closeBtn.BackgroundColor3 = Color3.fromRGB(80,20,20)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255,100,100)
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 14; closeBtn.ZIndex = 13
closeBtn.BorderSizePixel = 0
Instance.new("UICorner",closeBtn).CornerRadius = UDim.new(0,10)

local inspLbl = Instance.new("TextLabel",inspectFrame)
inspLbl.Size = UDim2.new(1,-8,1,-72); inspLbl.Position = UDim2.new(0,4,0,28)
inspLbl.BackgroundTransparency = 1
inspLbl.Text = "Click object to inspect"
inspLbl.TextColor3 = Color3.fromRGB(150,255,150)
inspLbl.Font = Enum.Font.Gotham; inspLbl.TextSize = 11; inspLbl.ZIndex = 13
inspLbl.TextXAlignment = Enum.TextXAlignment.Left
inspLbl.TextYAlignment = Enum.TextYAlignment.Top
inspLbl.TextWrapped = true

-- เส้นแบ่ง
local divider = Instance.new("Frame",inspectFrame)
divider.Size = UDim2.new(1,-16,0,1)
divider.Position = UDim2.new(0,8,1,-42)
divider.BackgroundColor3 = Color3.fromRGB(60,90,60)
divider.BorderSizePixel = 0
divider.ZIndex = 13

-- ส่วน Position (รวมอยู่ในกล่องเดียวกัน)
local posTitle = Instance.new("TextLabel",inspectFrame)
posTitle.Size = UDim2.new(1,-8,0,16); posTitle.Position = UDim2.new(0,4,1,-38)
posTitle.BackgroundTransparency = 1
posTitle.Text = "📍 Position"
posTitle.TextColor3 = Color3.fromRGB(150,170,255)
posTitle.Font = Enum.Font.GothamBold; posTitle.TextSize = 11; posTitle.ZIndex = 13

local posLbl = Instance.new("TextLabel",inspectFrame)
posLbl.Size = UDim2.new(1,-8,0,20); posLbl.Position = UDim2.new(0,4,1,-20)
posLbl.BackgroundTransparency = 1
posLbl.Text = "X: 0  Y: 0  Z: 0"
posLbl.TextColor3 = Color3.fromRGB(200,220,255)
posLbl.Font = Enum.Font.Gotham; posLbl.TextSize = 12; posLbl.ZIndex = 13
posLbl.TextXAlignment = Enum.TextXAlignment.Left
posLbl.TextWrapped = true

-- Drag logic
local draggingInsp = false
local dragStartInsp, startPosInsp

inspTitle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingInsp = true
		dragStartInsp = input.Position
		startPosInsp = inspectFrame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingInsp and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStartInsp
		inspectFrame.Position = UDim2.new(
			startPosInsp.X.Scale, startPosInsp.X.Offset + delta.X,
			startPosInsp.Y.Scale, startPosInsp.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingInsp = false
	end
end)

-- Close button
closeBtn.MouseButton1Click:Connect(function()
	inspectFrame.Visible = not inspectFrame.Visible
	closeBtn.BackgroundColor3 = inspectFrame.Visible and Color3.fromRGB(80,20,20) or Color3.fromRGB(40,40,60)
end)

-- Raycast เพื่อเลือก object
local mouse = player:GetMouse()
mouse.Button1Down:Connect(function()
	local camera = Workspace.CurrentCamera
	local ray = camera:ScreenPointToRay(mouse.X, mouse.Y)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {character}
	
	local hit = Workspace:Raycast(ray.Origin, ray.Direction * 500, raycastParams)
	if hit then
		local obj = hit.Instance
		local parent = obj.Parent
		local details = {
			"Name: " .. obj.Name,
			"Type: " .. obj.ClassName,
			"Parent: " .. (parent and parent.Name or "nil"),
		}
		if obj:IsA("BasePart") then
			table.insert(details, "Pos: (" .. math.floor(obj.Position.X) .. ", " .. math.floor(obj.Position.Y) .. ", " .. math.floor(obj.Position.Z) .. ")")
		end
		if parent and parent:FindFirstChildOfClass("Humanoid") then
			table.insert(details, "Has Humanoid: YES")
		end
		inspLbl.Text = table.concat(details, "\n")
	end
end)
-- อัปเดต position ทุก 2 วิ (ลดภาระการคำนวน)
local posTimer = 0
RunService.Heartbeat:Connect(function(dt)
	posTimer += dt
	if posTimer >= 2 then
		posTimer = 0
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root then
			local p = root.Position
			posLbl.Text = string.format("X: %.1f  Y: %.1f  Z: %.1f", p.X, p.Y, p.Z)
		end
	end
end)

-- ปุ่ม ⬆ ขึ้น/กระโดด (ซ้ายบน)
local floatUp = Instance.new("TextButton")
floatUp.Size = UDim2.new(0,44,0,44)
floatUp.Position = UDim2.new(0,10,0,10)
floatUp.BackgroundColor3 = Color3.fromRGB(30,50,80)
floatUp.TextColor3 = Color3.fromRGB(200,220,255)
floatUp.Text = "⬆"
floatUp.Font = Enum.Font.GothamBold
floatUp.TextSize = 20
floatUp.BorderSizePixel = 0
floatUp.ZIndex = 10
floatUp.Parent = screenGui
Instance.new("UICorner",floatUp).CornerRadius = UDim.new(0,10)
local fus = Instance.new("UIStroke",floatUp)
fus.Color = Color3.fromRGB(80,120,255); fus.Thickness = 1.5

-- ปุ่ม ⬇ ลง
local floatDown = Instance.new("TextButton")
floatDown.Size = UDim2.new(0,44,0,44)
floatDown.Position = UDim2.new(0,10,0,60)
floatDown.BackgroundColor3 = Color3.fromRGB(80,30,30)
floatDown.TextColor3 = Color3.fromRGB(255,200,200)
floatDown.Text = "⬇"
floatDown.Font = Enum.Font.GothamBold
floatDown.TextSize = 20
floatDown.BorderSizePixel = 0
floatDown.ZIndex = 10
floatDown.Parent = screenGui
Instance.new("UICorner",floatDown).CornerRadius = UDim.new(0,10)
local fds = Instance.new("UIStroke",floatDown)
fds.Color = Color3.fromRGB(180,60,60); fds.Thickness = 1.5

-- ปุ่ม Teleport Down 50 Studs
local teleDown = Instance.new("TextButton")
teleDown.Size = UDim2.new(0,44,0,44)
teleDown.Position = UDim2.new(0,10,0,110)
teleDown.BackgroundColor3 = Color3.fromRGB(80,60,20)
teleDown.TextColor3 = Color3.fromRGB(255,220,100)
teleDown.Text = "⬇️↻"
teleDown.Font = Enum.Font.GothamBold
teleDown.TextSize = 16
teleDown.BorderSizePixel = 0
teleDown.ZIndex = 10
teleDown.Parent = screenGui
Instance.new("UICorner",teleDown).CornerRadius = UDim.new(0,10)
local tds = Instance.new("UIStroke",teleDown)
tds.Color = Color3.fromRGB(200,160,60); tds.Thickness = 1.5

floatUp.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
		if noclipEnabled then yMoveDir=1 else local hum=getHumanoid() if hum then hum.Jump=true end end
	end
end)
floatUp.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then yMoveDir=0 end
end)

floatDown.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then yMoveDir=-1 end
end)
floatDown.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then yMoveDir=0 end
end)

-- Teleport Down 50 Studs (เปลี่ยนเป็น Tween)
teleDown.MouseButton1Click:Connect(function()
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if root then
		local targetPos = root.CFrame + Vector3.new(0,-10,0)
		local tweenInfo = TweenInfo.new(
			0.3,  -- 0.3 วิ ลื่นๆ
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.InOut
		)
		local tween = game:GetService("TweenService"):Create(root, tweenInfo, {CFrame = targetPos})
		tween:Play()
	end
end)

-- Panel (กรอบนอก ขนาดคงที่ ไม่ยืด)
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0,290,0,480)   -- ความสูงที่เห็นบนหน้าจอ
panel.Position = UDim2.new(0,20,0,64)
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

-- Title Bar (ลาก UI ได้)
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

-- ScrollingFrame (เนื้อหาด้านใน เลื่อนได้)
local scroll = Instance.new("ScrollingFrame",panel)
scroll.Name = "Scroll"
scroll.Size = UDim2.new(1,0,1,-40)        -- เต็มความกว้าง ลบ titlebar
scroll.Position = UDim2.new(0,0,0,40)     -- อยู่ใต้ titlebar
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(80,100,220)
scroll.CanvasSize = UDim2.new(0,0,0,520)  -- ความสูงเนื้อหาทั้งหมด
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ZIndex = 6
scroll.Parent = panel

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
-- วาง Widgets (ใน scroll ทั้งหมด)
-- ============================================
sectionLabel(scroll, "── PLAYER ──────────────────", 8)

createSlider(scroll, "☀  Brightness", "", MIN_BRIGHTNESS, MAX_BRIGHTNESS, DEFAULT_BRIGHTNESS, 28, function(v)
	setBrightness(v)
end)

createToggleButton(scroll, "Full Brightness", "🌕", 62, function(state)
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

createSlider(scroll, "⚡  Walk Speed", "", MIN_SPEED, MAX_SPEED, DEFAULT_SPEED, 108, function(v)
	currentSpeed = v
end)

RunService.Heartbeat:Connect(function()
	local hum = getHumanoid()
	if hum and currentSpeed ~= DEFAULT_SPEED then
		hum.WalkSpeed = currentSpeed
	end
end)

sectionLabel(scroll, "── THE MIMIC BOOK 3 ────────", 155)

createToggleButton(scroll, "Monster ESP", "👁", 175, function(state)
	espEnabled = state
	if state then refreshESP() else clearESP() end
end)

createToggleButton(scroll, "Item Highlight", "✨", 217, function(state)
	itemEspEnabled = state
	if state then refreshItemESP() else clearItemESP() end
end)

-- ลบ Monster ESP และ Item Highlight ออกจาก UI เพราะบอกว่า ใช้งานไม่ได้
-- ตัวปุ่มกำลังแสดง แต่ผู้ใช้อยากลบมัน ถ้าต้องการให้ลบเอาก็สามารถคอมเมนต์บรรทัด 175 และ 217

createToggleButton(scroll, "Noclip", "👻", 217, function(state)
	noclipEnabled = state
	if state then enableNoclip() else disableNoclip() end
end)

createToggleButton(scroll, "Item Highlight", "✨", 259, function(state)
	itemEspEnabled = state
	if state then refreshItemESP() else clearItemESP() end
end)

createToggleButton(scroll, "God Mode", "🛡", 301, function(state)
	godEnabled = state
	if state then enableGodMode() else disableGodMode() end
end)

createToggleButton(scroll, "Hitbox ESP", "📦", 343, function(state)
	hitboxEnabled = state
	if state then refreshHitbox() else clearHitbox() end
end)

createToggleButton(scroll, "X-Ray (ทะลุพื้น)", "🔍", 385, function(state)
	xrayEnabled = state
	if state then enableXray() else disableXray() end
end)

createToggleButton(scroll, "FPS Boost", "⚡", 427, function(state)
	fpsBoostEnabled = state
	if state then enableFPSBoost() else disableFPSBoost() end
end)
divider.Size = UDim2.new(1,-24,0,1); divider.Position = UDim2.new(0,12,0,434)
divider.BackgroundColor3 = Color3.fromRGB(50,55,90); divider.BorderSizePixel = 0; divider.ZIndex = 6

local hint = Instance.new("TextLabel", scroll)
hint.Size = UDim2.new(1,-24,0,70); hint.Position = UDim2.new(0,12,0,440)
hint.BackgroundTransparency = 1
hint.Text = "🔴 ESP = กล่อง+เส้นโยงมาเรา\n🔍 X-Ray = มองทะลุพื้น/กำแพง\n📍 Position แสดงมุมซ้ายล่าง\n⬆⬇ มุมขวาบน: กระโดด/บิน"
hint.TextColor3 = Color3.fromRGB(90,100,140)
hint.Font = Enum.Font.Gotham; hint.TextSize = 10
hint.TextWrapped = true; hint.ZIndex = 7

-- ============================================
-- ปุ่ม Toggle UI (⚙ / ✕) — เปิด/ปิด panel
-- ============================================
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0,44,0,44)
toggleBtn.Position = UDim2.new(0,64,0,10)
toggleBtn.AnchorPoint = Vector2.new(0,0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Text = "✕"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 20
toggleBtn.BorderSizePixel = 0
toggleBtn.ZIndex = 10
toggleBtn.Parent = screenGui
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,10)
local tgs = Instance.new("UIStroke", toggleBtn)
tgs.Color = Color3.fromRGB(80,100,220); tgs.Thickness = 1.5

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
