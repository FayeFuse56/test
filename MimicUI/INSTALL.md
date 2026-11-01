# MimicUI install

## Roblox Studio hierarchy

In Explorer, create this structure:

```
StarterPlayer
└── StarterPlayerScripts
    ├── Client (LocalScript; use Client.client.lua)
    └── Core (Folder)
        ├── Bootstrap (ModuleScript)
        ├── GameDetector (ModuleScript)
        ├── GameContext (ModuleScript)
        ├── UIRegistry (ModuleScript)
        ├── ChapterCatalog (ModuleScript)
        ├── Controller (ModuleScript)
        ├── ChapterPanel (ModuleScript)
        └── MonsterESP (ModuleScript)
```

Copy the matching files from this repository into those instances. The file extension shown in GitHub does not change the Roblox instance type: all files under `Core` are ModuleScripts; `Client.client.lua` is a LocalScript.

## Run

The supplied `Client.client.lua` starts the system. A dark-blue chapter panel appears in the top-right. Click **MONSTER ESP** to toggle local highlights. Names and distances are enabled by default.

## Current chapter resolver coverage

- Book 1 Chapters 1–4: `Workspace.GameAI`, `GameAI2`; B1C3 also checks `omukadeMAIN.damagepart`.
- Book 2 Chapter 1: Futakuchi.
- Book 2 Chapter 2: Ashina.
- Book 2 Chapter 3: Grin Demon variants and Statue Monsters.
- Book 2 Chapter 4: Enzukai.
- Jigoku: Shinigami root part.
- Witch Trial: AI models with an `AI` child.
- Halloween Trial: `GameAI` and `AI` folders.

A chapter with no verified resolver path may show zero targets. Book 3, NMCS, Ken and Egao do not yet have verified Monster ESP paths in this implementation; do not interpret zero as proof that no monster is present.

## Limitations

- Client-side only: highlights are local and do not alter server state.
- The resolver depends on replicated Workspace names and hierarchy. Game updates may change them.
- The source has been statically reviewed, but not run in a live Roblox Studio session or The Mimic server. Test each chapter and report the actual Explorer path if a monster is missed.
- This is a separate modular panel; it does not replace or patch the older monolithic `MimicUI.lua` automatically.
