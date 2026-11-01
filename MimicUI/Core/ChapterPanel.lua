--!strict
-- Runtime chapter panel for the MimicUI modular core.
-- Displays context and catalog metadata only; it does not execute feature actions.

local Players = game:GetService("Players")

local ChapterPanel = {}
ChapterPanel.__index = ChapterPanel

local COLORS = {
	Panel = Color3.fromRGB(13, 18, 35),
	Header = Color3.fromRGB(22, 31, 58),
	Row = Color3.fromRGB(25, 32, 54),
	Text = Color3.fromRGB(235, 240, 255),
	Muted = Color3.fromRGB(145, 158, 190),
	Accent = Color3.fromRGB(95, 130, 255),
	Ready = Color3.fromRGB(80, 200, 145),
	Existing = Color3.fromRGB(235, 185, 90),
	Planned = Color3.fromRGB(135, 150, 180),
}

local function make(className, properties, parent)
	local object = Instance.new(className)
	for key, value in pairs(properties) do object[key] = value end
	object.Parent = parent
	return object
end

function ChapterPanel.new(context, registry, options)
	options = options or {}
	local self = setmetatable({}, ChapterPanel)
	self.Context = assert(context, "GameContext is required")
	self.Registry = assert(registry, "UIRegistry is required")
	self.MonsterESP = options.MonsterESP
	self._connections = {}
	self._destroyed = false

	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	local gui = make("ScreenGui", {
		Name = options.Name or "MimicUIChapterPanel",
		ResetOnSpawn = false,
		IgnoreGuiInset = false,
		DisplayOrder = 30,
	}, playerGui)
	self.Gui = gui

	local panel = make("Frame", {
		Name = "Panel",
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -18, 0, 18),
		Size = UDim2.fromOffset(310, 420),
		BackgroundColor3 = COLORS.Panel,
		BorderSizePixel = 0,
	}, gui)
	self.Panel = panel
	make("UICorner", {CornerRadius = UDim.new(0, 12)}, panel)
	make("UIStroke", {Color = COLORS.Accent, Transparency = 0.35, Thickness = 1}, panel)

	local header = make("Frame", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, 76),
		BackgroundColor3 = COLORS.Header,
		BorderSizePixel = 0,
	}, panel)
	make("UICorner", {CornerRadius = UDim.new(0, 12)}, header)

	self.Title = make("TextLabel", {
		Name = "Title",
		Position = UDim2.fromOffset(14, 9),
		Size = UDim2.new(1, -28, 0, 25),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		Text = "MIMICUI / CONTEXT",
		TextColor3 = COLORS.Text,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, header)

	self.Subtitle = make("TextLabel", {
		Name = "Subtitle",
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -28, 0, 28),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		Text = "Detecting place...",
		TextColor3 = COLORS.Muted,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
	}, header)

	self.ESPButton = make("TextButton", {
		Name = "MonsterESPButton",
		Position = UDim2.fromOffset(14, 84),
		Size = UDim2.new(1, -28, 0, 32),
		BackgroundColor3 = COLORS.Row,
		BorderSizePixel = 0,
		Font = Enum.Font.GothamBold,
		Text = "MONSTER ESP  •  OFF",
		TextColor3 = COLORS.Muted,
		TextSize = 11,
		AutoButtonColor = true,
	}, panel)
	make("UICorner", {CornerRadius = UDim.new(0, 8)}, self.ESPButton)
	make("UIStroke", {Color = COLORS.Accent, Transparency = 0.55, Thickness = 1}, self.ESPButton)
	self.ESPButton.Activated:Connect(function()
		if not self.MonsterESP then return end
		self.MonsterESP:SetEnabled(not self.MonsterESP.Enabled)
		self:_render()
	end)

	self.List = make("ScrollingFrame", {
		Name = "FeatureList",
		Position = UDim2.fromOffset(10, 124),
		Size = UDim2.new(1, -20, 1, -134),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = COLORS.Accent,
	}, panel)
	make("UIListLayout", {
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, self.List)
	make("UIPadding", {
		PaddingTop = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 6),
		PaddingLeft = UDim.new(0, 2),
		PaddingRight = UDim.new(0, 4),
	}, self.List)

	self:_render()
	table.insert(self._connections, self.Context.Changed.Event:Connect(function()
		self:_render()
	end))
	table.insert(self._connections, self.Registry:OnChanged():Connect(function()
		self:_render()
	end))
	return self
end

function ChapterPanel:_clearRows()
	for _, child in ipairs(self.List:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end
end

function ChapterPanel:_render()
	if self._destroyed then return end
	local snapshot = self.Context:Get()
	if not snapshot then return end
	local groupName, features = self.Registry:GetActiveGroup()
	local displayName = groupName == "__unknown" and "Unknown Place" or (groupName or "Unknown Place")
	local mapName = snapshot.SubMap and (" / " .. snapshot.SubMap) or ""
	self.Title.Text = "MIMICUI  /  " .. string.upper(displayName)
	self.Subtitle.Text = string.format("PlaceId: %d%s  •  %s", snapshot.PlaceId, mapName, snapshot.Character and "Character ready" or "Waiting for character")
	local espEnabled = self.MonsterESP and self.MonsterESP.Enabled
	local espCount = self.MonsterESP and self.MonsterESP:GetCount() or 0
	self.ESPButton.Text = string.format("MONSTER ESP  •  %s  (%d)", espEnabled and "ON" or "OFF", espCount)
	self.ESPButton.TextColor3 = espEnabled and COLORS.Ready or COLORS.Muted
	self.ESPButton.BackgroundColor3 = espEnabled and Color3.fromRGB(26, 55, 53) or COLORS.Row

	self:_clearRows()
	for index, feature in ipairs(features) do
		local row = make("Frame", {
			Name = "Feature_" .. feature.Id,
			Size = UDim2.new(1, -2, 0, 62),
			BackgroundColor3 = COLORS.Row,
			BorderSizePixel = 0,
			LayoutOrder = index,
		}, self.List)
		make("UICorner", {CornerRadius = UDim.new(0, 8)}, row)
		make("TextLabel", {
			Position = UDim2.fromOffset(10, 7),
			Size = UDim2.new(1, -94, 0, 19),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamSemibold,
			Text = feature.Title or feature.Id,
			TextColor3 = COLORS.Text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, row)
		make("TextLabel", {
			Position = UDim2.fromOffset(10, 28),
			Size = UDim2.new(1, -18, 0, 25),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			Text = feature.Description or "",
			TextColor3 = COLORS.Muted,
			TextSize = 10,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		}, row)
		local status = feature.Status or "Info"
		local statusColor = COLORS[status] or COLORS.Planned
		make("TextLabel", {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -8, 0, 8),
			Size = UDim2.fromOffset(66, 18),
			BackgroundColor3 = statusColor,
			BackgroundTransparency = 0.82,
			Font = Enum.Font.GothamBold,
			Text = string.upper(status),
			TextColor3 = statusColor,
			TextSize = 8,
			BorderSizePixel = 0,
		}, row)
	end
end

function ChapterPanel:SetVisible(visible: boolean)
	if self.Gui then self.Gui.Enabled = visible end
end

function ChapterPanel:Destroy()
	if self._destroyed then return end
	self._destroyed = true
	for _, connection in ipairs(self._connections) do connection:Disconnect() end
	table.clear(self._connections)
	if self.Gui then self.Gui:Destroy() self.Gui = nil end
end

return ChapterPanel
