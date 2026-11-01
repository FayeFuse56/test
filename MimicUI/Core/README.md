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

- `ChapterPanel.lua` — renders a compact dark-blue panel with the detected chapter, map, PlaceId, character readiness, and feature catalog.

## Showing the panel

After creating the context, registry and controller, create the panel:

```lua
local ChapterPanel = require(Core:WaitForChild("ChapterPanel"))
local panel = ChapterPanel.new(context, registry)

-- Optional:
-- panel:SetVisible(false)
-- panel:Destroy()
```

The panel is a read-only status/catalog view. It does not turn Planned or Existing catalog entries into working controls. Existing MimicUI functionality still needs to be migrated and connected separately.

- `MonsterESP.lua` — chapter-aware, client-side highlights for known monster/NPC paths. It excludes player characters and creates only local Highlight and BillboardGui instances.

## Monster ESP

Create the module after `context`:

```lua
local MonsterESP = require(Core:WaitForChild("MonsterESP"))
local monsterESP = MonsterESP.new(context, {
    ShowNames = true,
    ShowDistance = true,
})

-- Enable and get the number of detected targets:
local count = monsterESP:SetEnabled(true)
print("Monsters highlighted:", count)

-- Re-scan after the chapter finishes loading:
monsterESP:Refresh()

-- Disable / cleanup:
-- monsterESP:SetEnabled(false)
-- monsterESP:Destroy()
```

The resolver uses chapter-specific Workspace paths reviewed in the reference source (Book 1 AI folders, named Book 2 monsters, Jigoku, Witch Trial and Halloween Trial). The B2C3 Nightmare/Normal Grin Demon selection falls back to the Normal model if the mode is not exposed as the expected attribute. Object names and folder layouts can change between game updates; verify each chapter in Studio before relying on the result. This module is not yet connected to a toggle in the existing MimicUI menu.

## Feature status

Catalog entries marked `Ready` describe context fields already supplied by the core. `Existing` refers to functionality present in the older MimicUI script but not yet integrated into this modular core. `Planned` entries are UI roadmap items, not working controls yet.

## Scope and test status

These modules inspect client-visible state and organize local UI metadata. They do not invoke game remotes, exploit APIs, anti-cheat bypasses, or automated objective completion. PlaceId mappings are transcribed from the reviewed reference script; unknown IDs intentionally return no chapter group. Static review only — not yet validated in a live Roblox session.
