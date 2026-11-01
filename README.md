# MimicUI v2 — The Mimic Book 3

Client-side Roblox LocalScript for the MimicUI interface and Fay Runtime Inspector.

## Fay Runtime Inspector

The Runtime Monitor observes client-visible Instance lifecycle and selected property changes in:

- Workspace
- ReplicatedStorage
- ReplicatedFirst
- Lighting
- SoundService
- LocalPlayer.PlayerGui

It records Added/Removed events and selected changes on ValueBase, ProximityPrompt, ClickDetector, Tool, Sound, ParticleEmitter, Humanoid, GUI, and BasePart instances.

### Puzzle test workflow

1. Enable **Runtime Monitor** from MimicUI.
2. Press **MARK** immediately before activating the third-party puzzle tool.
3. Use the tool and wait until the puzzle result is visible.
4. Press **END** (the MARK button changes to END during capture).
5. Review the session summary and the event sequence immediately before it.
6. Repeat the same puzzle once without the third-party tool when possible; compare the two timelines.

The marker bounds the captured test session. Logs are kept in memory only and are cleared when the LocalScript stops or the user clears them.

## Important limitations

- This is an observer of client-visible changes, not a decompiler or script tracer.
- It cannot identify which script caused an observed change.
- It does not intercept RemoteEvent:FireServer or RemoteFunction:InvokeServer calls.
- It cannot inspect server-only state, ServerStorage, or prove that a client-side change was accepted by the server.
- Sound and particle events are correlated effects, not proof of puzzle logic.
- A missing event does not prove that no server-side action occurred.

Use controlled before/after comparisons and treat all automated classifications as leads that require verification.
