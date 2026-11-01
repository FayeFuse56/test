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

local godEnabled     = false
local noclipEnabled  = false
local hpBoostEnabled = false
local hitboxEnabled  = false
local aimbotEnabled  = false

local function getHumanoid()
	if character then
		return character:FindFirstChildOfClass("Humanoid")
	end
	return nil
end

-- ============================================
-- God Mode — กันตายจริง + เงียบเสียงโดนตีทันที
-- ============================================
local godModeConnection = nil   -- HealthChanged
local godHeartbeatConn  = nil   -- Heartbeat (ชั้นกันซ้อน set HP 100 ทุกเฟรม)
local godSoundConnection = nil  -- DescendantAdded (ดักเสียงใหม่)

local function isHitSoundName(name)
	local n = name:lower()
	return n:find("hit") or n:find("damage") or n:find("pain") or n:find("hurt") or n:find("attack") or n:find("scream")
end

local mutedSounds = {}  -- [sound] = true, กันไม่ให้ผูก event ซ้ำ

local function watchAndMuteSound(s)
	if mutedSounds[s] then
		s.Volume = 0
		return
	end
	mutedSounds[s] = true
	if s:GetAttribute("OriginalVolume") == nil then
		s:SetAttribute("OriginalVolume", s.Volume)
	end
	s.Volume = 0
	-- เกมมักตั้ง Volume คืนก่อนเล่นเสียงใหม่ทุกครั้ง ต้องบังคับ 0 ซ้ำทุกครั้งที่มันพยายามเล่น/เปลี่ยนค่า
	s.Played:Connect(function()
		if godEnabled then s.Volume = 0 end
	end)
	s:GetPropertyChangedSignal("Volume"):Connect(function()
		if godEnabled and s.Volume > 0 then s.Volume = 0 end
	end)
end

local function muteExistingHitSounds()
	for _, s in ipairs(Workspace:GetDescendants()) do
		if s:IsA("Sound") and isHitSoundName(s.Name) then
			watchAndMuteSound(s)
		end
	end
end

local function enableGodMode()
	if godModeConnection then return end
	local hum = getHumanoid()
	if not hum then return end

	hum.Health = hum.MaxHealth

	-- ปิด Dead state
	hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	
	-- Override TakeDamage ให้ไม่ apply damage เลย
	local origTakeDamage = hum.TakeDamage
	hum.TakeDamage = function(self, amount)
		if godEnabled then
			return
		end
		return origTakeDamage(self, amount)
	end
	
	-- เซ็ต Health = max ทุกเฟรม (Heartbeat เพียงอันเดียว เร็วสุด)
	godHeartbeatConn = RunService.Heartbeat:Connect(function()
		if not godEnabled then return end
		if hum and hum.Parent then
			hum.Health = hum.MaxHealth
		end
	end)

	-- Mute damage sounds
	muteExistingHitSounds()
	godSoundConnection = Workspace.DescendantAdded:Connect(function(obj)
		if not godEnabled then return end
		if obj:IsA("Sound") and isHitSoundName(obj.Name) then
			watchAndMuteSound(obj)
		end
	end)
end

local function disableGodMode()
	if godModeConnection then
		godModeConnection:Disconnect()
		godModeConnection = nil
	end
	if godHeartbeatConn then
		godHeartbeatConn:Disconnect()
		godHeartbeatConn = nil
	end
	if godSoundConnection then
		godSoundConnection:Disconnect()
		godSoundConnection = nil
	end
	local hum = getHumanoid()
	if hum then
		hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)  -- คืนสถานะตายปกติ
	end
	-- คืนเสียง
	for _, sound in ipairs(Workspace:GetDescendants()) do
		if sound:IsA("Sound") and sound:GetAttribute("OriginalVolume") ~= nil then
			sound.Volume = sound:GetAttribute("OriginalVolume")
		end
	end
end

-- ============================================
-- HP Boost — set Health = 100 ทุกเฟรม (แยกจาก God Mode)
-- ============================================
local hpBoostConnection = nil

local function enableHPBoost()
	if hpBoostConnection then return end
	hpBoostConnection = RunService.Heartbeat:Connect(function()
		if not hpBoostEnabled then return end
		local hum = getHumanoid()
		if hum then
			hum.Health = 100
		end
	end)
end

local function disableHPBoost()
	if hpBoostConnection then
		hpBoostConnection:Disconnect()
		hpBoostConnection = nil
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
-- (Monster ESP ถูกลบออกแล้ว — ใช้งานไม่ดี)
-- ============================================
local xrayEnabled   = false

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
-- Lightweight moving-target ESP (Humanoid + dynamic parts)
-- ============================================
local hitboxEnabled = false
local moveEspEnabled = false
local trackedModels = {}
local trackedParts = {}
local espTimer = 0
local ESP_RANGE = 140
local ESP_MAX = 45
local ESP_INTERVAL = 0.65
local function espRoot()
    return character and character:FindFirstChild("HumanoidRootPart")
end
local function clearVisuals(registry)
    for obj, visual in pairs(registry) do
        visual:Destroy()
        registry[obj] = nil
    end
end
local function clearHitbox()
    clearVisuals(trackedModels)
    clearVisuals(trackedParts)
end
local function makeHighlight(target, color)
    local h = Instance.new("Highlight")
    h.Name = "FayMovingESP"
    h.Adornee = target
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.85
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = screenGui
    return h
end
local function refreshHitbox()
    local root = espRoot()
    if not root then clearHitbox(); return end
    local activeModels, activeParts = {}, {}
    local params = OverlapParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {character}
    params.MaxParts = 250
    local nearby = Workspace:GetPartBoundsInRadius(root.Position, ESP_RANGE, params)
    local count = 0
    for _, part in ipairs(nearby) do
        if count >= ESP_MAX then break end
        local model = part:FindFirstAncestorOfClass("Model")
        local hum = model and model:FindFirstChildOfClass("Humanoid")
        if hitboxEnabled and hum and model ~= character and hum.Health > 0 then
            if not activeModels[model] then
                activeModels[model] = true
                if not trackedModels[model] then
                    local isPlayer = Players:GetPlayerFromCharacter(model) ~= nil
                    trackedModels[model] = makeHighlight(model, isPlayer and Color3.fromRGB(50,255,120) or Color3.fromRGB(255,145,50))
                end
                count += 1
            end
        elseif moveEspEnabled and not hum and not part.Anchored and part.AssemblyLinearVelocity.Magnitude > 1.5 then
            local target = part.AssemblyRootPart or part
            if not activeParts[target] and not target:IsDescendantOf(character) then
                activeParts[target] = true
                if not trackedParts[target] then
                    trackedParts[target] = makeHighlight(target, Color3.fromRGB(90,195,255))
                end
                count += 1
            end
        end
    end
    for model, h in pairs(trackedModels) do
        if not activeModels[model] then h:Destroy(); trackedModels[model] = nil end
    end
    for part, h in pairs(trackedParts) do
        if not activeParts[part] then h:Destroy(); trackedParts[part] = nil end
    end
end
RunService.Heartbeat:Connect(function(dt)
    if not hitboxEnabled and not moveEspEnabled then return end
    espTimer += dt
    if espTimer >= ESP_INTERVAL then
        espTimer = 0
        refreshHitbox()
    end
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
-- (Item Highlight ถูกลบออกแล้ว — ใช้งานไม่ดี)

-- ============================================
-- Fog remover (reversible, client-side)
-- ============================================
local fogEnabled = false
local fogBackup = nil
local fogConn = nil
local function applyNoFog()
    Lighting.FogStart = 0
    Lighting.FogEnd = 1000000
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Atmosphere") then
            obj.Density = 0
            obj.Haze = 0
            obj.Glare = 0
        end
    end
end
local function setNoFog(on)
    fogEnabled = on
    if on then
        fogBackup = {start = Lighting.FogStart, finish = Lighting.FogEnd, atmosphere = {}}
        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("Atmosphere") then
                fogBackup.atmosphere[obj] = {density = obj.Density, haze = obj.Haze, glare = obj.Glare}
            end
        end
        applyNoFog()
        if fogConn then fogConn:Disconnect() end
        fogConn = Lighting.ChildAdded:Connect(function(obj)
            if obj:IsA("Atmosphere") then
                task.defer(function()
                    if fogEnabled and obj.Parent then
                        fogBackup.atmosphere[obj] = {density = obj.Density, haze = obj.Haze, glare = obj.Glare}
                        applyNoFog()
                    end
                end)
            end
        end)
    else
        if fogConn then fogConn:Disconnect(); fogConn = nil end
        if fogBackup then
            Lighting.FogStart = fogBackup.start
            Lighting.FogEnd = fogBackup.finish
            for obj, values in pairs(fogBackup.atmosphere) do
                if obj.Parent then
                    obj.Density = values.density
                    obj.Haze = values.haze
                    obj.Glare = values.glare
                end
            end
        end
        fogBackup = nil
    end
end

-- ============================================
-- ScreenGui
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MimicUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 1000 -- ให้อยู่เหนือ UI เกม; สามารถลากหลบได้
screenGui.Parent = player.PlayerGui

-- ============================================
-- Fay Runtime Inspector + Puzzle Behavior Analyzer
-- Client-side observation only: records visible Instance/property changes.
local runtimeEnabled = false
local runtimeConnections = {}
local runtimeObjectConnections = {}
local runtimeWatched = {}
local runtimeWatchedCount = 0
local runtimeLogs = {}
local runtimeSession = {}
local runtimeSessionActive = false
local runtimeSeenSounds = {}
local runtimeMarkButton
local RUNTIME_MAX_LOGS = 140
local RUNTIME_MAX_WATCHED = 2200

local runtimeRoots = {
    {name = "Workspace", instance = Workspace},
    {name = "ReplicatedStorage", instance = game:GetService("ReplicatedStorage")},
    {name = "ReplicatedFirst", instance = game:GetService("ReplicatedFirst")},
    {name = "Lighting", instance = Lighting},
    {name = "SoundService", instance = game:GetService("SoundService")},
    {name = "PlayerGui", instance = player:WaitForChild("PlayerGui")},
}

local runtimePanel = Instance.new("Frame")
runtimePanel.Name = "FayRuntimeInspector"
runtimePanel.Size = UDim2.new(0, 330, 0, 270)
runtimePanel.Position = UDim2.new(1, -340, 1, -280)
runtimePanel.BackgroundColor3 = Color3.fromRGB(16, 18, 29)
runtimePanel.BorderSizePixel = 0
runtimePanel.Visible = false
runtimePanel.ZIndex = 20
runtimePanel.Parent = screenGui
Instance.new("UICorner", runtimePanel).CornerRadius = UDim.new(0, 10)
local runtimeStroke = Instance.new("UIStroke", runtimePanel)
runtimeStroke.Color = Color3.fromRGB(80, 110, 220)
runtimeStroke.Thickness = 1.3

local runtimeHeader = Instance.new("Frame", runtimePanel)
runtimeHeader.Size = UDim2.new(1, 0, 0, 34)
runtimeHeader.BackgroundColor3 = Color3.fromRGB(30, 36, 62)
runtimeHeader.BorderSizePixel = 0
runtimeHeader.ZIndex = 21
Instance.new("UICorner", runtimeHeader).CornerRadius = UDim.new(0, 10)

local runtimeTitle = Instance.new("TextLabel", runtimeHeader)
runtimeTitle.Size = UDim2.new(1, -158, 1, 0)
runtimeTitle.Position = UDim2.new(0, 9, 0, 0)
runtimeTitle.BackgroundTransparency = 1
runtimeTitle.Text = "Fay Runtime Inspector"
runtimeTitle.TextColor3 = Color3.fromRGB(215, 225, 255)
runtimeTitle.Font = Enum.Font.GothamBold
runtimeTitle.TextSize = 11
runtimeTitle.TextXAlignment = Enum.TextXAlignment.Left
runtimeTitle.ZIndex = 22

local function runtimeButton(text, x, width)
    local b = Instance.new("TextButton", runtimeHeader)
    b.Size = UDim2.new(0, width, 0, 23)
    b.Position = UDim2.new(1, x, 0, 5)
    b.BackgroundColor3 = Color3.fromRGB(55, 65, 100)
    b.TextColor3 = Color3.fromRGB(240, 240, 255)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 9
    b.BorderSizePixel = 0
    b.ZIndex = 23
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    return b
end

runtimeMarkButton = runtimeButton("MARK", -202, 44)
local runtimeExport = runtimeButton("EXPORT", -153, 50)
local runtimeClear = runtimeButton("CLEAR", -98, 46)
local runtimeClose = runtimeButton("×", -47, 38)

local runtimeScroll = Instance.new("ScrollingFrame", runtimePanel)
runtimeScroll.Position = UDim2.new(0, 6, 0, 40)
runtimeScroll.Size = UDim2.new(1, -12, 1, -46)
runtimeScroll.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
runtimeScroll.BackgroundTransparency = 0.15
runtimeScroll.BorderSizePixel = 0
runtimeScroll.ScrollBarThickness = 3
runtimeScroll.ScrollBarImageColor3 = Color3.fromRGB(90, 115, 210)
runtimeScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
runtimeScroll.ZIndex = 21
Instance.new("UICorner", runtimeScroll).CornerRadius = UDim.new(0, 6)

local runtimeText = Instance.new("TextLabel", runtimeScroll)
runtimeText.Position = UDim2.new(0, 5, 0, 4)
runtimeText.Size = UDim2.new(1, -10, 0, 20)
runtimeText.BackgroundTransparency = 1
runtimeText.Text = "Runtime Monitor พร้อมทำงาน"
runtimeText.TextColor3 = Color3.fromRGB(175, 195, 235)
runtimeText.Font = Enum.Font.Code
runtimeText.TextSize = 10
runtimeText.TextXAlignment = Enum.TextXAlignment.Left
runtimeText.TextYAlignment = Enum.TextYAlignment.Top
runtimeText.TextWrapped = true
runtimeText.ZIndex = 22

local function runtimePath(obj)
    local ok, result = pcall(function() return obj:GetFullName() end)
    return ok and result or obj.Name
end

local function runtimeScopedPath(rootName, obj)
    local path = runtimePath(obj)
    if string.sub(path, 1, #rootName + 1) == rootName .. "." then
        return path
    end
    return rootName .. "." .. path
end

local function runtimeLog(message, eventType)
    local stamp = os.date("%H:%M:%S")
    local line = "[" .. stamp .. "] " .. tostring(message)
    table.insert(runtimeLogs, line)
    if runtimeSessionActive then
        table.insert(runtimeSession, {line = line, type = eventType or "OTHER"})
        if #runtimeSession > 600 then table.remove(runtimeSession, 1) end
    end
    while #runtimeLogs > RUNTIME_MAX_LOGS do
        table.remove(runtimeLogs, 1)
    end
    runtimeText.Text = table.concat(runtimeLogs, "\n")
    local height = math.max(20, #runtimeLogs * 14 + 8)
    runtimeText.Size = UDim2.new(1, -10, 0, height)
    runtimeScroll.CanvasSize = UDim2.new(0, 0, 0, height + 8)
    runtimeScroll.CanvasPosition = Vector2.new(0, math.max(0, height - runtimeScroll.AbsoluteSize.Y))
end

local function runtimeInteresting(obj)
    return obj:IsA("Model")
        or obj:IsA("BasePart")
        or obj:IsA("Decal")
        or obj:IsA("Texture")
        or obj:IsA("BillboardGui")
        or obj:IsA("SurfaceGui")
        or obj:IsA("ParticleEmitter")
        or obj:IsA("Humanoid")
        or obj:IsA("RemoteEvent")
        or obj:IsA("RemoteFunction")
        or obj:IsA("Sound")
        or obj:IsA("ValueBase")
        or obj:IsA("ProximityPrompt")
        or obj:IsA("ClickDetector")
        or obj:IsA("Tool")
end

local function runtimeShouldLogSound(obj, rootName)
    -- Footstep/ambient loops add noise and rarely identify puzzle logic.
    local name = string.lower(obj.Name)
    local noisy = {"footstep", "footsteps", "step", "walking", "walk", "running", "run", "chase", "heartbeat", "ambience", "ambient"}
    for _, word in ipairs(noisy) do
        if string.find(name, word, 1, true) then return false end
    end
    local key = runtimeScopedPath(rootName, obj)
    if runtimeSeenSounds[key] then return false end
    runtimeSeenSounds[key] = true
    return true
end

local function runtimePuzzleName(text)
    local n = string.lower(text)
    local words = {
        "puzzle", "lever", "switch", "button", "door", "lock", "key",
        "ring", "rune", "symbol", "code", "plate", "statue", "altar",
        "crystal", "orb", "torch", "lantern", "valve", "wheel",
        "correct", "success", "complete", "opened", "solved",
    }
    for _, word in ipairs(words) do
        if string.find(n, word, 1, true) then return true end
    end
    return false
end

local function runtimeValue(value)
    if typeof(value) == "Vector3" then
        return string.format("(%.1f, %.1f, %.1f)", value.X, value.Y, value.Z)
    elseif typeof(value) == "CFrame" then
        local p = value.Position
        return string.format("pos(%.1f, %.1f, %.1f)", p.X, p.Y, p.Z)
    elseif typeof(value) == "Instance" then
        return value:GetFullName()
    end
    return tostring(value)
end

local function runtimeProperties(obj)
    if obj:IsA("BasePart") then
        return {"Transparency", "LocalTransparencyModifier", "Anchored", "CanCollide", "CanTouch", "CanQuery", "CFrame", "Size"}
    elseif obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        return {"Text", "Visible"}
    elseif obj:IsA("GuiObject") then
        return {"Visible"}
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        return {"Transparency"}
    elseif obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
        return {"Enabled"}
    elseif obj:IsA("ParticleEmitter") then
        return {"Enabled", "Rate"}
    elseif obj:IsA("Sound") then
        return {"Playing", "Volume"}
    elseif obj:IsA("Humanoid") then
        return {"Health", "WalkSpeed", "JumpPower"}
    elseif obj:IsA("ValueBase") then
        return {"Value"}
    elseif obj:IsA("ProximityPrompt") then
        return {"Enabled", "ActionText", "ObjectText", "HoldDuration"}
    elseif obj:IsA("ClickDetector") then
        return {"MaxActivationDistance"}
    elseif obj:IsA("Tool") then
        return {"Enabled"}
    end
    return {}
end

local function runtimeDescribePart(obj)
    if not obj:IsA("BasePart") then return "" end
    local p = obj.Position
    local parentName = obj.Parent and obj.Parent:GetFullName() or "nil"
    return string.format(" | parent=%s | pos=(%.1f,%.1f,%.1f) size=(%.1f,%.1f,%.1f) T=%s C=%s Touch=%s",
        parentName, p.X, p.Y, p.Z, obj.Size.X, obj.Size.Y, obj.Size.Z,
        tostring(obj.Transparency), tostring(obj.CanCollide), tostring(obj.CanTouch))
end

local function runtimeDescribeGui(obj)
    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        local value = string.gsub(obj.Text, "[\\r\\n]", " ")
        if #value > 90 then value = string.sub(value, 1, 90) .. "..." end
        return " | text='" .. value .. "'"
    end
    return ""
end

local function runtimeDisconnectObject(obj)
    local connections = runtimeObjectConnections[obj]
    if connections then
        for _, connection in ipairs(connections) do
            connection:Disconnect()
        end
        runtimeObjectConnections[obj] = nil
    end
    if runtimeWatched[obj] then
        runtimeWatched[obj] = nil
        runtimeWatchedCount = math.max(0, runtimeWatchedCount - 1)
    end
end

local function watchRuntimeObject(obj, rootName)
    if not runtimeEnabled or runtimeWatched[obj] or runtimeWatchedCount >= RUNTIME_MAX_WATCHED then return end
    if not runtimeInteresting(obj) then return end

    runtimeWatched[obj] = true
    runtimeWatchedCount += 1
    local connections = {}
    runtimeObjectConnections[obj] = connections
    local path = runtimeScopedPath(rootName, obj)

    for _, property in ipairs(runtimeProperties(obj)) do
        local initialOk, previousValue = pcall(function() return obj[property] end)
        local ok, signal = pcall(function() return obj:GetPropertyChangedSignal(property) end)
        if ok and signal then
            local connection = signal:Connect(function()
                if not runtimeEnabled or not obj.Parent then return end
                local valueOk, value = pcall(function() return obj[property] end)
                if valueOk then
                    local before = initialOk and runtimeValue(previousValue) or "?"
                    local after = runtimeValue(value)
                    local kind = obj:IsA("ValueBase") and "STATE" or "PROPERTY"
                    runtimeLog(kind .. " " .. property .. ": " .. before .. " -> " .. after .. " | " .. path, kind)
                    previousValue = value
                    initialOk = true
                end
            end)
            table.insert(connections, connection)
        end
    end
end

local function runtimeSessionSummary()
    local counts = {}
    local puzzleNamed = 0
    local remoteInstances = 0
    local stateChanges = 0
    local interactions = 0
    local effects = 0
    for _, event in ipairs(runtimeSession) do
        counts[event.type] = (counts[event.type] or 0) + 1
        if string.find(string.lower(event.line), "remoteevent", 1, true)
            or string.find(string.lower(event.line), "remotefunction", 1, true) then
            remoteInstances += 1
        end
        if event.type == "STATE" then stateChanges += 1 end
        if event.type == "INTERACTION" then interactions += 1 end
        if event.type == "EFFECT" then effects += 1 end
        if runtimePuzzleName(event.line) then puzzleNamed += 1 end
    end

    runtimeLog("===== SESSION EVIDENCE SUMMARY =====", "SUMMARY")
    runtimeLog("Events: " .. #runtimeSession .. " | state changes: " .. stateChanges, "SUMMARY")
    runtimeLog("Interactions: " .. interactions .. " | visual/audio effects: " .. effects, "SUMMARY")
    runtimeLog("Puzzle-keyword matches: " .. puzzleNamed .. " | Remote instances added/removed: " .. remoteInstances, "SUMMARY")
    if stateChanges > 0 then
        runtimeLog("LEAD: state/property transitions observed; inspect exact paths and values.", "SUMMARY")
    end
    if interactions > 0 then
        runtimeLog("LEAD: prompt/click/tool changes observed; sequence may indicate partial interaction.", "SUMMARY")
    end
    if effects > 0 then
        runtimeLog("LEAD: effects observed; treat as correlated output, not proof of cause.", "SUMMARY")
    end
    if remoteInstances == 0 then
        runtimeLog("LIMIT: no Remote instance lifecycle change observed. Remote calls are NOT monitored by this client logger.", "SUMMARY")
    end
    runtimeLog("TRACE: compare ADDED/REMOVED BasePart entries, property changes, and UI text such as MISS/SUCCESS in timestamp order.", "SUMMARY")
    runtimeLog("LIMIT: client-visible logs cannot identify which script caused an event or prove server-side puzzle state.", "SUMMARY")
    runtimeLog("===== END SUMMARY =====", "SUMMARY")
end

local function stopRuntimeMonitor()
    runtimeEnabled = false
    for _, connection in ipairs(runtimeConnections) do
        connection:Disconnect()
    end
    table.clear(runtimeConnections)
    for obj in pairs(runtimeObjectConnections) do
        runtimeDisconnectObject(obj)
    end
    table.clear(runtimeWatched)
    runtimeWatchedCount = 0
    runtimeSessionActive = false
    runtimeMarkButton.Text = "MARK"
    runtimePanel.Visible = false
end

local function startRuntimeMonitor()
    if runtimeEnabled then return end
    runtimeEnabled = true
    runtimePanel.Visible = true
    runtimeLog("MONITOR STARTED — client-visible observation only", "SYSTEM")
    runtimeLog("Tap MARK before using the other tool; tap again after puzzle result.", "SYSTEM")

    for _, rootInfo in ipairs(runtimeRoots) do
        local root = rootInfo.instance
        for _, obj in ipairs(root:GetDescendants()) do
            watchRuntimeObject(obj, rootInfo.name)
            if runtimeWatchedCount >= RUNTIME_MAX_WATCHED then break end
        end
        local added = root.DescendantAdded:Connect(function(obj)
            if not runtimeEnabled then return end
            if runtimeInteresting(obj) then
                local path = runtimeScopedPath(rootInfo.name, obj)
                local isSound = obj:IsA("Sound")
                local shouldLog = not isSound or runtimeShouldLogSound(obj, rootInfo.name)
                if shouldLog then
                    local kind = (isSound or obj:IsA("ParticleEmitter")) and "EFFECT"
                        or (obj:IsA("ProximityPrompt") or obj:IsA("ClickDetector") or obj:IsA("Tool")) and "INTERACTION"
                        or "ADDED"
                    runtimeLog("ADDED " .. obj.ClassName .. " | " .. path .. runtimeDescribePart(obj) .. runtimeDescribeGui(obj), kind)
                end
                watchRuntimeObject(obj, rootInfo.name)
            end
        end)
        local removing = root.DescendantRemoving:Connect(function(obj)
            if runtimeEnabled and runtimeInteresting(obj) then
                -- Sound cleanup is intentionally silent: looping/temporary SFX flood the timeline.
                if not obj:IsA("Sound") then
                    local path = runtimeScopedPath(rootInfo.name, obj)
                    local kind = obj:IsA("ParticleEmitter") and "EFFECT"
                        or (obj:IsA("ProximityPrompt") or obj:IsA("ClickDetector") or obj:IsA("Tool")) and "INTERACTION"
                        or "REMOVED"
                    runtimeLog("REMOVED " .. obj.ClassName .. " | " .. path .. runtimeDescribePart(obj) .. runtimeDescribeGui(obj), kind)
                end
                runtimeDisconnectObject(obj)
            end
        end)
        table.insert(runtimeConnections, added)
        table.insert(runtimeConnections, removing)
    end
end

runtimeMarkButton.MouseButton1Click:Connect(function()
    if not runtimeEnabled then return end
    if not runtimeSessionActive then
        table.clear(runtimeSession)
        table.clear(runtimeSeenSounds)
        runtimeSessionActive = true
        runtimeMarkButton.Text = "END"
        runtimeLog("===== PUZZLE TEST START — activate bypass now =====", "MARKER")
    else
        runtimeLog("===== PUZZLE TEST END — result recorded =====", "MARKER")
        runtimeSessionActive = false
        runtimeMarkButton.Text = "MARK"
        runtimeSessionSummary()
    end
end)

-- Export logs: prefer Delta file APIs; fall back to clipboard when unavailable.
runtimeExport.MouseButton1Click:Connect(function()
    local output = {}
    table.insert(output, "MimicUI Runtime Log")
    table.insert(output, "Exported: " .. os.date("%Y-%m-%d %H:%M:%S"))
    table.insert(output, "========================================")

    table.insert(output, "")
    table.insert(output, "[RECENT LOGS]")
    for _, line in ipairs(runtimeLogs) do
        table.insert(output, line)
    end

    if #runtimeSession > 0 then
        table.insert(output, "")
        table.insert(output, "[MARKED SESSION]")
        for _, entry in ipairs(runtimeSession) do
            table.insert(output, entry.line or tostring(entry))
        end
    end

    local contents = table.concat(output, "\\n")
    local filename = "MimicUI_Log_" .. os.date("%Y%m%d_%H%M%S") .. ".txt"
    local saved = false
    local saveError = nil

    if type(writefile) == "function" then
        local ok, err = pcall(function()
            if type(makefolder) == "function" then
                pcall(makefolder, "MimicUI")
                filename = "MimicUI/" .. filename
            end
            writefile(filename, contents)
        end)
        saved = ok
        if not ok then saveError = tostring(err) end
    end

    if saved then
        runtimeExport.Text = "SAVED!"
        runtimeLog("LOG EXPORTED: " .. filename, "SYSTEM")
    elseif type(setclipboard) == "function" then
        local ok, err = pcall(setclipboard, contents)
        if ok then
            runtimeExport.Text = "COPIED"
            runtimeLog("FILE API unavailable; log copied to clipboard", "SYSTEM")
        else
            runtimeExport.Text = "FAILED"
            runtimeLog("EXPORT FAILED: " .. tostring(err or saveError or "unknown error"), "SYSTEM")
        end
    else
        runtimeExport.Text = "NO API"
        runtimeLog("EXPORT unavailable: Delta file/clipboard API not found", "SYSTEM")
    end

    task.delay(2, function()
        if runtimeExport and runtimeExport.Parent then runtimeExport.Text = "EXPORT" end
    end)
end)

runtimeClear.MouseButton1Click:Connect(function()
    table.clear(runtimeLogs)
    runtimeText.Text = ""
    if runtimeSessionActive then table.clear(runtimeSession) end
    runtimeLog("LOG CLEARED", "SYSTEM")
end)

runtimeClose.MouseButton1Click:Connect(function()
    runtimePanel.Visible = false
end)

-- Drag the inspector by its header
local runtimeDragging = false
local runtimeDragStart, runtimeStartPos
runtimeHeader.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        runtimeDragging = true
        runtimeDragStart = input.Position
        runtimeStartPos = runtimePanel.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if runtimeDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - runtimeDragStart
        runtimePanel.Position = UDim2.new(runtimeStartPos.X.Scale, runtimeStartPos.X.Offset + delta.X, runtimeStartPos.Y.Scale, runtimeStartPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        runtimeDragging = false
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
scroll.CanvasSize = UDim2.new(0,0,0,632)  -- ความสูงเนื้อหาทั้งหมด
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ZIndex = 6
scroll.Parent = panel

-- ============================================
-- Drag + Resize logic (รองรับเมาส์และจอสัมผัส)
-- ============================================
local draggingPanel = false
local resizingPanel = false
local dragStart, startPos
local resizeStart, startSize

local function getViewportSize()
	local cameraNow = Workspace.CurrentCamera
	return cameraNow and cameraNow.ViewportSize or Vector2.new(800, 600)
end

local function clampPanelPosition()
	local viewport = getViewportSize()
	local size = panel.AbsoluteSize
	local x = math.clamp(panel.Position.X.Offset, 0, math.max(0, viewport.X - size.X))
	local y = math.clamp(panel.Position.Y.Offset, 0, math.max(0, viewport.Y - size.Y))
	panel.Position = UDim2.fromOffset(x, y)
end

-- มุมจับปรับขนาด
local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "ResizeHandle"
resizeHandle.Size = UDim2.fromOffset(28, 28)
resizeHandle.AnchorPoint = Vector2.new(1, 1)
resizeHandle.Position = UDim2.new(1, -3, 1, -3)
resizeHandle.BackgroundColor3 = Color3.fromRGB(45, 55, 95)
resizeHandle.BackgroundTransparency = 0.08
resizeHandle.BorderSizePixel = 0
resizeHandle.Text = "◢"
resizeHandle.TextColor3 = Color3.fromRGB(170, 190, 255)
resizeHandle.TextSize = 16
resizeHandle.Font = Enum.Font.GothamBold
resizeHandle.AutoButtonColor = true
resizeHandle.Active = true
resizeHandle.ZIndex = 30
resizeHandle.Parent = panel
Instance.new("UICorner", resizeHandle).CornerRadius = UDim.new(0, 7)

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		draggingPanel = true
		dragStart = input.Position
		startPos = panel.Position
	end
end)

resizeHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		resizingPanel = true
		resizeStart = input.Position
		startSize = panel.AbsoluteSize
	end
end)

UserInputService.InputChanged:Connect(function(input)
	local pointerInput = input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	if not pointerInput then return end

	if draggingPanel then
		local delta = input.Position - dragStart
		local viewport = getViewportSize()
		local width, height = panel.AbsoluteSize.X, panel.AbsoluteSize.Y
		local x = math.clamp(startPos.X.Offset + delta.X, 0, math.max(0, viewport.X - width))
		local y = math.clamp(startPos.Y.Offset + delta.Y, 0, math.max(0, viewport.Y - height))
		panel.Position = UDim2.fromOffset(x, y)
	elseif resizingPanel then
		local delta = input.Position - resizeStart
		local viewport = getViewportSize()
		local maxWidth = math.max(240, viewport.X - panel.AbsolutePosition.X - 8)
		local maxHeight = math.max(300, viewport.Y - panel.AbsolutePosition.Y - 8)
		local width = math.clamp(startSize.X + delta.X, 240, math.min(520, maxWidth))
		local height = math.clamp(startSize.Y + delta.Y, 300, math.min(760, maxHeight))
		panel.Size = UDim2.fromOffset(width, height)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		draggingPanel = false
		resizingPanel = false
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

createToggleButton(scroll, "Noclip", "👻", 175, function(state)
	noclipEnabled = state
	if state then enableNoclip() else disableNoclip() end
end)

createToggleButton(scroll, "God Mode", "🛡", 217, function(state)
	godEnabled = state
	if state then enableGodMode() else disableGodMode() end
end)

createToggleButton(scroll, "Humanoid ESP", "📦", 259, function(state)
	hitboxEnabled = state
	if state then refreshHitbox() else if not moveEspEnabled then clearHitbox() end end
end)

createToggleButton(scroll, "X-Ray (ทะลุพื้น)", "🔍", 301, function(state)
	xrayEnabled = state
	if state then enableXray() else disableXray() end
end)

createToggleButton(scroll, "FPS Boost", "⚡", 343, function(state)
	fpsBoostEnabled = state
	if state then enableFPSBoost() else disableFPSBoost() end
end)

createToggleButton(scroll, "Set HP 100", "❤", 385, function(state)
	hpBoostEnabled = state
	if state then enableHPBoost() else disableHPBoost() end
end)


createToggleButton(scroll, "Moving Object ESP", "🎯", 427, function(state)
    moveEspEnabled = state
    if state then refreshHitbox() elseif not hitboxEnabled then clearHitbox() else refreshHitbox() end
end)

createToggleButton(scroll, "Remove Fog", "☁", 469, function(state)
    setNoFog(state)
end)

createToggleButton(scroll, "Runtime Monitor", "🧪", 511, function(state)
    if state then startRuntimeMonitor() else stopRuntimeMonitor() end
end)

local divider2 = Instance.new("Frame", scroll)
divider2.Size = UDim2.new(1,-24,0,1); divider2.Position = UDim2.new(0,12,0,556)
divider2.BackgroundColor3 = Color3.fromRGB(50,55,90); divider2.BorderSizePixel = 0; divider2.ZIndex = 6

local hint = Instance.new("TextLabel", scroll)
hint.Size = UDim2.new(1,-24,0,60); hint.Position = UDim2.new(0,12,0,564)
hint.BackgroundTransparency = 1
hint.Text = "ESP: orange NPC, green player, blue moving parts\nRemove Fog: clears local fog/atmosphere\nUp/Down buttons: jump / fly"
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
