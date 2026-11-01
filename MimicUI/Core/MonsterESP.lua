--!strict
-- Local-only Monster ESP for known The Mimic chapter object paths.
-- Targets are resolved from chapter-specific AI folders; Player characters are excluded.
-- This module creates client-side Highlight/BillboardGui instances only.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

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
		local mode = maze and maze:GetAttribute("GameMode")
		local grinName = mode == "Nightmare" and "GrinDemonNM" or "GrinDemon"
		addModel(result, seen, maze and maze:FindFirstChild(grinName))
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
	self._destroyed = false
	self._connection = self.Context.Changed.Event:Connect(function()
		if self.Enabled then self:Refresh() end
	end)
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

function MonsterESP:Refresh()
	if self._destroyed or not self.Enabled then return 0 end
	for instance in pairs(self._entries) do self:_remove(instance) end
	local snapshot = self.Context:Get()
	if not snapshot or not snapshot.IsKnown then return 0 end
	local targets = resolve(snapshot)
	for _, instance in ipairs(targets) do self:_add(instance) end
	return #targets
end

function MonsterESP:SetEnabled(enabled: boolean)
	if self._destroyed then return 0 end
	self.Enabled = enabled
	if enabled then
		return self:Refresh()
	end
	for instance in pairs(self._entries) do self:_remove(instance) end
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
	if self._connection then self._connection:Disconnect() self._connection = nil end
end

return MonsterESP
