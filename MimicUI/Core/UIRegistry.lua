--!strict
-- Lightweight registry for chapter-specific UI feature descriptors.
-- Feature callbacks are supplied by trusted local modules; this registry does not execute remotes.

local UIRegistry = {}
UIRegistry.__index = UIRegistry

function UIRegistry.new()
	return setmetatable({
		_groups = {},
		_activeGroup = nil,
		_changed = Instance.new("BindableEvent"),
		_destroyed = false,
	}, UIRegistry)
end

function UIRegistry:RegisterGroup(groupName: string, features: {any})
	assert(not self._destroyed, "UIRegistry is destroyed")
	assert(type(groupName) == "string" and groupName ~= "", "groupName must be a non-empty string")
	assert(type(features) == "table", "features must be a table")

	local ids = {}
	for _, feature in ipairs(features) do
		assert(type(feature) == "table", "each feature must be a table")
		assert(type(feature.Id) == "string" and feature.Id ~= "", "feature.Id is required")
		assert(not ids[feature.Id], "duplicate feature Id: " .. feature.Id)
		ids[feature.Id] = true
	end

	self._groups[groupName] = table.clone(features)
	self._changed:Fire(groupName, self._groups[groupName])
end

function UIRegistry:SetActiveGroup(groupName: string?)
	assert(not self._destroyed, "UIRegistry is destroyed")
	if groupName ~= nil and self._groups[groupName] == nil then
		groupName = nil
	end
	self._activeGroup = groupName
	self._changed:Fire(groupName, groupName and self._groups[groupName] or {})
end

function UIRegistry:GetActiveGroup()
	local groupName = self._activeGroup
	return groupName, groupName and table.clone(self._groups[groupName]) or {}
end

function UIRegistry:GetGroup(groupName: string)
	return table.clone(self._groups[groupName] or {})
end

function UIRegistry:OnChanged()
	return self._changed.Event
end

function UIRegistry:Destroy()
	if self._destroyed then return end
	self._destroyed = true
	table.clear(self._groups)
	self._activeGroup = nil
	self._changed:Destroy()
end

return UIRegistry
