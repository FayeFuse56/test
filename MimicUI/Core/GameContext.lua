--!strict
-- Owns the current local game context and character lifecycle.
-- This module observes client-visible state only; it does not alter server game state.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local GameContext = {}
GameContext.__index = GameContext

export type ContextSnapshot = {
	PlaceId: number,
	JobId: string,
	GameId: number,
	Group: string?,
	SubMap: string?,
	IsKnown: boolean,
	Player: Player,
	Character: Model?,
	Humanoid: Humanoid?,
	RootPart: BasePart?,
	Workspace: Workspace,
}

function GameContext.new(detector)
	local self = setmetatable({}, GameContext)
	self._detector = assert(detector, "GameDetector is required")
	self._player = Players.LocalPlayer
	self._connections = {}
	self._characterConnections = {}
	self._destroyed = false
	self._revision = 0
	self.Changed = Instance.new("BindableEvent")
	self.CharacterChanged = Instance.new("BindableEvent")
	self._snapshot = nil

	self:_refresh("Initial")
	self:_connect(self._player.CharacterAdded, function(character)
		self:_bindCharacter(character)
		self:_refresh("CharacterAdded")
	end)
	self:_connect(self._player.CharacterRemoving, function()
		self:_clearCharacterConnections()
		self:_refresh("CharacterRemoving")
	end)

	return self
end

function GameContext:_connect(signal, callback)
	local connection = signal:Connect(callback)
	table.insert(self._connections, connection)
	return connection
end

function GameContext:_clearCharacterConnections()
	for _, connection in ipairs(self._characterConnections) do
		connection:Disconnect()
	end
	table.clear(self._characterConnections)
end

function GameContext:_bindCharacter(character)
	self:_clearCharacterConnections()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	if not humanoid then
		local c = character.ChildAdded:Connect(function(child)
			if child:IsA("Humanoid") then self:_refresh("HumanoidAdded") end
		end)
		table.insert(self._characterConnections, c)
	end
	if not root then
		local c = character.ChildAdded:Connect(function(child)
			if child.Name == "HumanoidRootPart" then self:_refresh("RootPartAdded") end
		end)
		table.insert(self._characterConnections, c)
	end
	self.CharacterChanged:Fire(character)
end

function GameContext:_refresh(reason)
	if self._destroyed then return end
	local player = self._player
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid") or nil
	local rootPart = character and character:FindFirstChild("HumanoidRootPart") or nil
	local detected = self._detector.Detect(game.PlaceId, game.JobId, game.GameId)

	self._revision += 1
	local snapshot = {
		PlaceId = detected.PlaceId,
		JobId = detected.JobId or "",
		GameId = detected.GameId or 0,
		Group = detected.Group,
		SubMap = detected.SubMap,
		IsKnown = detected.IsKnown,
		Player = player,
		Character = character,
		Humanoid = humanoid,
		RootPart = rootPart,
		Workspace = Workspace,
		Revision = self._revision,
		Reason = reason,
	}
	self._snapshot = table.freeze(snapshot)
	self.Changed:Fire(self._snapshot, reason)
end

function GameContext:Get()
	return self._snapshot
end

function GameContext:Destroy()
	if self._destroyed then return end
	self._destroyed = true
	self:_clearCharacterConnections()
	for _, connection in ipairs(self._connections) do
		connection:Disconnect()
	end
	table.clear(self._connections)
	self.Changed:Destroy()
	self.CharacterChanged:Destroy()
	self._snapshot = nil
end

return GameContext
