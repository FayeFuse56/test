--!strict
-- Connects GameContext, GameDetector and UIRegistry.
-- Rendering remains the responsibility of the existing MimicUI interface.

local Controller = {}
Controller.__index = Controller

function Controller.new(gameDetector, gameContext, uiRegistry, chapterCatalog)
	local self = setmetatable({}, Controller)
	self.Detector = assert(gameDetector, "GameDetector is required")
	self.Context = assert(gameContext, "GameContext is required")
	self.Registry = assert(uiRegistry, "UIRegistry is required")
	self.Catalog = assert(chapterCatalog, "ChapterCatalog is required")
	self._connection = nil
	self._destroyed = false

	for _, groupName in ipairs(self.Catalog.GetGroups()) do
		self.Registry:RegisterGroup(groupName, self.Catalog.Get(groupName))
	end

	self:_apply(self.Context:Get())
	self._connection = self.Context.Changed.Event:Connect(function(snapshot)
		self:_apply(snapshot)
	end)
	return self
end

function Controller:_apply(snapshot)
	if self._destroyed or not snapshot then return end
	local groupName = snapshot.Group
	if groupName and #self.Catalog.Get(groupName) > 0 then
		self.Registry:SetActiveGroup(groupName)
	else
		self.Registry:RegisterGroup("__unknown", self.Catalog.Get(nil))
		self.Registry:SetActiveGroup("__unknown")
	end
end

function Controller:GetState()
	local snapshot = self.Context:Get()
	local groupName, features = self.Registry:GetActiveGroup()
	return {
		Context = snapshot,
		ActiveGroup = groupName,
		Features = features,
	}
end

function Controller:Destroy()
	if self._destroyed then return end
	self._destroyed = true
	if self._connection then
		self._connection:Disconnect()
		self._connection = nil
	end
end

return Controller
