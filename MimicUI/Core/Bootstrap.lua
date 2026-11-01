--!strict
-- One-call client bootstrap for the modular MimicUI core.
-- Run from a LocalScript in Roblox Studio; all ESP adornments are local.

local Bootstrap = {}

function Bootstrap.Start(options)
	options = options or {}
	local Core = script.Parent

	local GameDetector = require(Core:WaitForChild("GameDetector"))
	local GameContext = require(Core:WaitForChild("GameContext"))
	local UIRegistry = require(Core:WaitForChild("UIRegistry"))
	local ChapterCatalog = require(Core:WaitForChild("ChapterCatalog"))
	local Controller = require(Core:WaitForChild("Controller"))
	local ChapterPanel = require(Core:WaitForChild("ChapterPanel"))
	local MonsterESP = require(Core:WaitForChild("MonsterESP"))

	local context = GameContext.new(GameDetector)
	local registry = UIRegistry.new()
	local controller = Controller.new(GameDetector, context, registry, ChapterCatalog)
	local monsterESP = MonsterESP.new(context, {
		ShowNames = options.ShowNames ~= false,
		ShowDistance = options.ShowDistance ~= false,
		Color = options.MonsterColor,
	})
	local panel = ChapterPanel.new(context, registry, {
		Name = options.GuiName or "MimicUIChapterPanel",
		MonsterESP = monsterESP,
	})

	local runtime = {
		Context = context,
		Registry = registry,
		Controller = controller,
		MonsterESP = monsterESP,
		Panel = panel,
		Destroyed = false,
	}

	function runtime:SetMonsterESPEnabled(enabled: boolean)
		if self.Destroyed then return 0 end
		return self.MonsterESP:SetEnabled(enabled)
	end

	function runtime:GetState()
		return self.Controller:GetState()
	end

	function runtime:Destroy()
		if self.Destroyed then return end
		self.Destroyed = true
		self.Panel:Destroy()
		self.MonsterESP:Destroy()
		self.Controller:Destroy()
		self.Context:Destroy()
		self.Registry:Destroy()
	end

	if options.EnableMonsterESP then
		monsterESP:SetEnabled(true)
	end

	return runtime
end

return Bootstrap
