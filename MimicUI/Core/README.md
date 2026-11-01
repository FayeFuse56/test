# MimicUI Core

These modules are the first modular foundation for the existing MimicUI project.

## Files

- GameDetector.lua — maps known The Mimic PlaceIds to logical groups and known sub-map labels.
- GameContext.lua — exposes a snapshot of the current place and local character, and refreshes it on character lifecycle events.
- UIRegistry.lua — stores feature descriptors by chapter group and exposes the active group to a UI renderer.

## Studio layout

Create a MimicUI folder with a Core folder containing these three ModuleScripts. Require them from the client entrypoint:

```lua
local Core = script.Parent:WaitForChild("Core")
local GameDetector = require(Core:WaitForChild("GameDetector"))
local GameContext = require(Core:WaitForChild("GameContext"))
local UIRegistry = require(Core:WaitForChild("UIRegistry"))

local context = GameContext.new(GameDetector)
local registry = UIRegistry.new()

local snapshot = context:Get()
registry:SetActiveGroup(snapshot.Group)

context.Changed.Event:Connect(function(nextSnapshot)
    registry:SetActiveGroup(nextSnapshot.Group)
end)

-- On shutdown:
-- context:Destroy()
-- registry:Destroy()
```

The modules are not yet wired into the existing MimicUI.lua UI. That integration is the next step.

## Safety and test status

The detector only identifies the current PlaceId. The context reports client-visible state. The registry only stores local feature descriptors. These modules do not call game remotes, invoke exploit APIs, bypass anti-cheat, or claim to complete game objectives.

PlaceId mappings are transcribed from the project's reviewed reference script. Unknown PlaceIds intentionally return Group = nil. Static review only; not yet validated in a live Roblox session.
