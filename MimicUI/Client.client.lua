--!strict
-- Place this LocalScript beside the Core folder in StarterPlayerScripts.
-- Required sibling: Core (Folder) containing the MimicUI Core ModuleScripts.

local coreFolder = script.Parent:WaitForChild("Core")
local Bootstrap = require(coreFolder:WaitForChild("Bootstrap"))

local runtime = Bootstrap.Start({
	ShowNames = true,
	ShowDistance = true,
	EnableMonsterESP = false,
	GuiName = "MimicUIChapterPanel",
})

print("[MimicUI] Started. Detected group:", runtime:GetState().ActiveGroup)

script.Destroying:Connect(function()
	runtime:Destroy()
end)
