--!strict
-- Local-only Monster ESP for known The Mimic chapter object paths.
-- Targets are resolved from chapter-specific AI folders; Player characters are excluded.
-- This module creates client-side Highlight/BillboardGui instances only.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local MonsterESP = {}
MonsterESP.__index = MonsterESP

local RED = Color3.fromRGB(255, 65, 75)

local function childPath(root: Instance, path: {string}): Instance?
	local current: Instance? = root
	for _, name in ipairs(path) do
		if not current then return nil end
		current = current:FindFirstChild(name)
	end
	return current
end

local function addModel(list, seen, instance)
	if not instance or not instance.Parent or seen[instance] then return end
	if not (instance:IsA("Model") or instance:IsA("BasePart")) then return end
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character and (instance == player.Character or instance:IsDescendantOf(player.Character)) then
			return
		end
	end
	seen[instance] = true
	table.insert(list, instance)
end

local function addChildren(list, seen, folder, modelsOnly)
	if not folder then return end
	for _, item in ipairs(folder:GetChildren()) do
		if not modelsOnly or item:IsA("Model") then addModel(list, seen, item) end
	end
end

local function resolve(context)
	local result, seen = {}, {}
	local group = context.Group
	local world = Workspace

	if group == "B1C1" or group == "B1C2" or group == "B1C3" or group == "B1C4" then
		addChildren(result, seen, world:FindFirstChild("GameAI"), false)
		addChildren(result, seen, world:FindFirstChild("GameAI2"), true)
		if group == "B1C3" then
			local train = childPath(world, {"omukadeMAIN", "damagepart"})
			addModel(result, seen, train)
		end
	elseif group == "B2C1" then
		addModel(result, seen, childPath(world, {"Section2", "Monsters", "Futakuchi"}))
	elseif group == "B2C2" then
		addModel(result, seen, childPath(world, {"Section2", "Monsters", "Ashina"}))
	elseif group == "B2C3" then
		local maze = childPath(world, {"Section1", "Maze"})
		if maze then
			-- Resolve whichever variant is actually replicated to this client.
			addModel(result, seen, maze:FindFirstChild("GrinDemon"))
			addModel(result, seen, maze:FindFirstChild("GrinDemonNM"))
		end
		local statues = childPath(world, {"Section4", "StatueMonsters"})
		addChildren(result, seen, statues, true)
	elseif group == "B2C4" then
		addModel(result, seen, childPath(world, {"Section1", "EnzukaiSneakSequence", "Monster", "Enzukai"}))
	elseif group == "Jigoku" then
		addModel(result, seen, childPath(world, {"GameAI", "AI", "HumanoidRootPart"}))
	elseif group == "WitchTrial" then
		local ai = world:FindFirstChild("GameAI")
		if ai then
			for _, item in ipairs(ai:GetChildren()) do
				if item:IsA("Model") and item:FindFirstChild("AI") then addModel(result, seen, item) end
			end
		else
			for _, item in ipairs(world:GetChildren()) do
				if item:IsA("Model") and string.find(item.Name, "AI", 1, true) and item:FindFirstChild("AI") then
					addModel(result, seen, item)
				end
			end
		end
	elseif group == "HalloweenTrial" then
		addChildren(result, seen, world:FindFirstChild("GameAI"), false)
		addChildren(result, seen, world:FindFirstChild("AI"), true)
	end

	return result
end

local function getAdornee(instance: Instance): Instance?
	if instance:IsA("BasePart") then return instance end
	if instance:IsA("Model") then
		return instance.PrimaryPart
			or instance:FindFirstChild("HumanoidRootPart")
			or instance:FindFirstChildWhichIsA("BasePart", true)
	end
	return nil
end

function MonsterESP.new(context, options)
	options = options or {}
	local self = setmetatable({}, MonsterESP)
	self.Context = assert(context, "GameContext is required")
	self.Color = options.Color or RED
	self.ShowNames = options.ShowNames ~= false
	self.ShowDistance = options.ShowDistance ~= false
	self.Enabled = false
	self._entries = {}
	self.Changed = Instance.new("BindableEvent")
	self._destroyed = false
	self._connections = {}
	self._refreshQueued = false
	self._distanceAccumulator = 0
	table.insert(self._connections, self.Context.Changed.Event:Connect(function()
		if self.Enabled then self:Refresh() end
	end))
	local function queueRefresh()
		if not self.Enabled or self._refreshQueued or self._destroyed then return end
		self._refreshQueued = true
		task.defer(function()
			self._refreshQueued = false
			if self.Enabled and not self._destroyed then self:Refresh() end
		end)
	end
	table.insert(self._connections, Workspace.DescendantAdded:Connect(queueRefresh))
	table.insert(self._connections, Workspace.DescendantRemoving:Connect(queueRefresh))
	table.insert(self._connections, RunService.Heartbeat:Connect(function(deltaTime)
		if not self.Enabled or not self.ShowDistance then return end
		self._distanceAccumulator += deltaTime
		if self._distanceAccumulator < 0.25 then return end
		self._distanceAccumulator = 0
		self:_updateDistances()
	end))
	return self
end

function MonsterESP:_remove(instance)
	local entry = self._entries[instance]
	if not entry then return end
	if entry.Highlight then entry.Highlight:Destroy() end
	if entry.Billboard then entry.Billboard:Destroy() end
	self._entries[instance] = nil
end

function MonsterESP:_add(instance)
	if self._entries[instance] or not instance.Parent then return end
	local adornee = getAdornee(instance)
	if not adornee then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = "MimicUI_MonsterHighlight"
	highlight.Adornee = instance
	highlight.FillColor = self.Color
	highlight.OutlineColor = self.Color
	highlight.FillTransparency = 0.72
	highlight.OutlineTransparency = 0.05
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = adornee

	local billboard
	if self.ShowNames or self.ShowDistance then
		billboard = Instance.new("BillboardGui")
		billboard.Name = "MimicUI_MonsterLabel"
		billboard.Adornee = adornee
		billboard.Size = UDim2.fromOffset(180, 30)
		billboard.StudsOffset = Vector3.new(0, 3, 0)
		billboard.AlwaysOnTop = true
		billboard.Parent = adornee

		local label = Instance.new("TextLabel")
		label.Name = "Label"
		label.BackgroundTransparency = 1
		label.Size = UDim2.fromScale(1, 1)
		label.Font = Enum.Font.GothamBold
		label.TextColor3 = self.Color
		label.TextStrokeTransparency = 0.25
		label.TextSize = 12
		label.Parent = billboard
		local playerRoot = self.Context:Get() and self.Context:Get().RootPart
		local text = self.ShowNames and instance.Name or "MONSTER"
		if self.ShowDistance and playerRoot then
			local distance = (playerRoot.Position - adornee.Position).Magnitude
			text ..= string.format("  [%.0fm]", distance)
		end
		label.Text = text
	end

	self._entries[instance] = {Highlight = highlight, Billboard = billboard}
end

function MonsterESP:_updateDistances()
	local snapshot = self.Context:Get()
	local root = snapshot and snapshot.RootPart
	if not root then return end
	for instance, entry in pairs(self._entries) do
		local adornee = getAdornee(instance)
		local label = entry.Billboard and entry.Billboard:FindFirstChild("Label")
		if adornee and label and label:IsA("TextLabel") then
			local name = self.ShowNames and instance.Name or "MONSTER"
			local distance = (root.Position - adornee.Position).Magnitude
			label.Text = string.format("%s  [%.0fm]", name, distance)
		end
	end
end

function MonsterESP:Refresh()
	if self._destroyed or not self.Enabled then return 0 end
	for instance in pairs(self._entries) do self:_remove(instance) end
	local snapshot = self.Context:Get()
	if not snapshot or not snapshot.IsKnown then return 0 end
	local targets = resolve(snapshot)
	for _, instance in ipairs(targets) do self:_add(instance) end
	self.Changed:Fire(self.Enabled, self:GetCount())
	return self:GetCount()
end

function MonsterESP:SetEnabled(enabled: boolean)
	if self._destroyed then return 0 end
	self.Enabled = enabled
	if enabled then
		return self:Refresh()
	end
	for instance in pairs(self._entries) do self:_remove(instance) end
	self.Changed:Fire(false, 0)
	return 0
end

function MonsterESP:GetCount()
	local count = 0
	for _ in pairs(self._entries) do count += 1 end
	return count
end

function MonsterESP:Destroy()
	if self._destroyed then return end
	self:SetEnabled(false)
	self._destroyed = true
	for _, connection in ipairs(self._connections) do connection:Disconnect() end
	table.clear(self._connections)
	self.Changed:Destroy()
end

return MonsterESP
