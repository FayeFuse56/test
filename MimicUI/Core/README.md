# MimicUI Core

## Modules

- `GameDetector.lua` — maps known The Mimic PlaceIds to logical groups and sub-map labels.
- `GameContext.lua` — provides a snapshot of the current place and local character, refreshing on character lifecycle events.
- `UIRegistry.lua` — stores feature descriptors by chapter group.
- `ChapterCatalog.lua` — declarative list of common and chapter-specific inspector features, with implementation status.
- `Controller.lua` — connects context changes to the active catalog group.

## Studio layout

Place these ModuleScripts in `MimicUI/Core`. The LocalScript entrypoint can initialize them as follows:

```lua
local Core = script.Parent:WaitForChild("Core")
local GameDetector = require(Core:WaitForChild("GameDetector"))
local GameContext = require(Core:WaitForChild("GameContext"))
local UIRegistry = require(Core:WaitForChild("UIRegistry"))
local ChapterCatalog = require(Core:WaitForChild("ChapterCatalog"))
local Controller = require(Core:WaitForChild("Controller"))

local context = GameContext.new(GameDetector)
local registry = UIRegistry.new()
local controller = Controller.new(GameDetector, context, registry, ChapterCatalog)

local state = controller:GetState()
print("MimicUI context:", state.ActiveGroup, state.Context.PlaceId)

-- On shutdown:
-- controller:Destroy()
-- context:Destroy()
-- registry:Destroy()
```

## Feature status

Catalog entries marked `Ready` describe context fields already supplied by the core. `Existing` refers to functionality present in the older MimicUI script but not yet integrated into this modular core. `Planned` entries are UI roadmap items, not working controls yet.

## Scope and test status

These modules inspect client-visible state and organize local UI metadata. They do not invoke game remotes, exploit APIs, anti-cheat bypasses, or automated objective completion. PlaceId mappings are transcribed from the reviewed reference script; unknown IDs intentionally return no chapter group. Static review only — not yet validated in a live Roblox session.
