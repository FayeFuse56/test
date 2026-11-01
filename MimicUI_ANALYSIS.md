# MimicUI — The Mimic Reference Analysis

> Status: static source review of the reference script and current MimicUI. This document describes observed structure and responsibilities; it is not a claim that every feature has been tested in a live server.

## Scope reviewed

- Reference: `มันใช่โค้ดของคนอื่นป่ะ.lua` — 4,886 lines.
- Current project: `MimicUI.lua` — 1,541 lines.
- Current README: Runtime Inspector scope and limitations.
- Reference version marker: `TheMimicV3.D15`.

## Main finding

The reference is a multi-place hub. It detects the active experience using `game.PlaceId`, maps it to a logical chapter/mode, initializes chapter-specific dependencies in `GameValidate`, and builds the matching menu pack. Shared helpers are reused across chapters; chapter mechanics remain specialized.

This is why one script can support many chapters without implementing every mechanic as one universal function.

## Detected game routing

| Logical group | PlaceId routing present in source |
|---|---|
| Book 1 | B1C1, B1C2, B1C3, B1C4 |
| Book 2 | B2C1, B2C2, B2C3, B2C4 |
| Book 3 | B3C1 |
| Special | NMCS, Ken, Jigoku, WitchTrial, HalloweenTrial |
| Other | Lobby, GLobby |

B1C4 and HalloweenTrial further branch their menu contents by individual PlaceId. B2C3 reads the `GamemodeMode` attribute. The source therefore distinguishes logical chapter selection from sub-map/stage selection.

## Shared core function inventory

| Function | Observed responsibility |
|---|---|
| SKey / OKey / CKey | Virtual key press/release helpers |
| PairingSections | Builds teleport/section shortcuts from chapter section data |
| GetPing | Reads client-visible data ping |
| GameValidate | Initializes chapter-specific tools, state, game mode and dependencies |
| FreeCam | Camera takeover/free-camera state helper |
| FreeYourself | Sends the interaction key when the grabbed UI is visible |
| FirePrompt | Positions character/camera and activates a proximity prompt |
| ToolNow | Equips a cached tool if it is not currently equipped |
| ToolActive | Activates a cached tool |
| AutoCompleteBook1 | PlaceId-specific Book 1 route/interaction sequence |
| ESPMonsterBook1 | Displays Book 1 monster targets |
| ESPItemsBook1 | Displays Book 1 item targets |

## Chapter-specific function inventory

| Chapter/mode | Functions observed | Main responsibility inferred from implementation names and inspected code |
|---|---|---|
| B1C1–B1C4 | AutoCompleteBook1, ESPMonsterBook1, ESPItemsBook1 | Book 1 stage routes, item/monster visualization and selected interactions |
| B2C1 | B2C1Validate, B2C1Get, B2C1Func, B2C1ESP | Book 2 Chapter 1 state discovery, item/object interactions and ESP |
| B2C2 | GetFromCook, PlaceCoun, ToStove, TurnInFood, B2C2Func, B2C2ESP | Cooking/ingredient workflow, chapter interactions and ESP |
| B2C3 | INVBP, B2C3CanCraft, B2C3Click, B2C3Func, B2C3ESP | Inventory/crafting checks, interaction sequences and mode-dependent chapter behavior |
| B2C4 | B2C4BP1, B2C4BP2, GetBowLook, MagicArrowHit, B2C4Func, B2C4ESP | Bow/weapon helpers, puzzle and chapter interactions, ESP |
| B3C1 | B3C1Func, B3C1ESP | Book 3 Chapter 1 stage interactions and target visualization |
| NMCS | NMCSFunc | Clown games, Dimitra puzzles/statues and boss interaction |
| Ken | KenFunc | Lever/note interactions and navigation shortcuts |
| Jigoku | JigokuFunc, JigokuESP | Jigoku mode tasks and ESP |
| Egao | EgaoFunc | Egao-related movement/look and collection helpers |
| WitchTrial | WitchTrialFunc, WitchTrialESP | Trial completion helpers and monster ESP |
| HalloweenTrial | HalloweenTrialFunc, HalloweenTrialESP | Candy/potion/trial helpers and ESP |

The table is an inventory, not a guarantee that every listed function is complete or currently compatible with the live game.

## Menu pack inventory

The reference constructs separate dynamic menu packs for:

- `PackNMCS`
- `PackKen`
- `PackJigoku`
- `PackEgao`
- `PackB1C1`, `PackB1C2`, `PackB1C3`, `PackB1C4`
- `PackB2C1`, `PackB2C2`, `PackB2C3`, `PackB2C4`
- `PackB3C1`
- `PackWitchTrial`, `PackHalloweenTrial`

These are selected when the hub builds its tabs. The presence of a menu entry only proves that the UI exposes an option; the callback and runtime dependencies determine whether it actually works.

## Important implementation patterns

1. **PlaceId router:** converts the current place into a chapter key.
2. **Shared helpers:** input, prompt, tool, camera, teleport and ESP helpers are reused.
3. **Chapter initialization:** `GameValidate` waits for or caches chapter-specific objects/tools and reads mode state.
4. **Chapter function modules:** each chapter has its own interaction logic and target scanning.
5. **Dynamic menu packs:** the active chapter determines which controls are presented.
6. **Background tasks:** selected toggles start loops/tasks that repeatedly inspect the current workspace and run the associated behavior.
7. **Respawn handling:** character references are refreshed and validation is rerun after CharacterAdded.

## Current MimicUI comparison

Current MimicUI is a client-side utility panel plus Runtime Inspector. It currently includes:

- Brightness / Full Bright
- Noclip and vertical movement controls
- Client-side visual helpers, including moving-object/humanoid ESP and Xray
- FPS-related local object handling and fog controls
- A camera-targeting helper
- Runtime Monitor that records client-visible Instance lifecycle and selected property changes

It does **not** yet contain the reference's complete PlaceId router, per-chapter menu packs, chapter-specific object adapters, or complete chapter feature set.

The Runtime Inspector is useful for observing client-visible changes, but it is not a remote-call tracer, decompiler, server-state reader, or proof that a server accepted an action. A changed sound, particle, GUI, or Instance is correlation, not proof of causation.

## Safe development architecture for MimicUI

Recommended layout:

```text
MimicUI/
  Core/
    GameDetector.lua
    GameContext.lua
    CharacterService.lua
    InteractionObserver.lua
    ESPService.lua
    UIRegistry.lua
  Chapters/
    Book1/Chapter1.lua ... Chapter4.lua
    Book2/Chapter1.lua ... Chapter4.lua
    Book3/Chapter1.lua
    Special/NMCS.lua
    Special/Ken.lua
    Special/Jigoku.lua
    Special/Egao.lua
    Special/WitchTrial.lua
    Special/HalloweenTrial.lua
  UI/
    Main.lua
    ChapterMenus.lua
  MimicUI.client.lua
```

Each chapter module should expose a consistent interface such as:

- `CanRun(context)` — confirms that the expected chapter context exists.
- `Init(context)` — caches references and connects observers.
- `GetFeatures()` — returns the controls/features supported by that module.
- `Destroy()` — disconnects events and clears temporary visuals.

Core services should own shared UI, character references, cleanup, and client-side visualization. Chapter modules should own only their own object discovery and chapter-specific presentation/observation. This avoids duplicating shared systems and prevents one chapter's object paths from breaking another.

## Build order

1. Implement and test the PlaceId-to-chapter detector.
2. Add a GameContext lifecycle that refreshes after respawn and cleans up on place/context changes.
3. Add dynamic chapter menu registration.
4. Port shared, client-side utilities into Core modules.
5. Add chapter modules one at a time, beginning with object discovery and ESP/observer features.
6. Validate each module against current in-game object hierarchies and remove stale paths.
7. Add a status/debug panel showing detected chapter, mode, required objects found/missing, and active connections.

## Not claimed / still needs validation

- No live-game test was performed during this static review.
- No guarantee that the reference's PlaceIds or object paths remain current.
- No claim that a menu toggle's visual appearance means its feature succeeds.
- No server-authoritative outcome can be inferred from client-only logs.
- No third-party source code has been copied into MimicUI by this analysis.
