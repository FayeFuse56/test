--!strict
-- Safe, declarative chapter catalog. Feature entries describe the UI roadmap;
-- only entries marked Ready should be wired to active controls.

local ChapterCatalog = {}

local function feature(id: string, title: string, description: string, status: string)
	return {
		Id = id,
		Title = title,
		Description = description,
		Status = status,
	}
end

local COMMON = {
	feature("context", "Game Context", "PlaceId, chapter, map and character status", "Ready"),
	feature("runtime-monitor", "Runtime Monitor", "Observe client-visible Instance changes", "Existing"),
	feature("object-browser", "Object Browser", "Inspect selected Workspace objects and properties", "Planned"),
	feature("local-esp", "Local ESP", "Highlight selected client-visible NPCs and objects", "Planned"),
}

local function chapterFeatures(extra)
	local result = table.clone(COMMON)
	for _, item in ipairs(extra or {}) do table.insert(result, item) end
	return result
end

local CATALOG = {
	B1C1 = chapterFeatures(),
	B1C2 = chapterFeatures(),
	B1C3 = chapterFeatures(),
	B1C4 = chapterFeatures({
		feature("map-stage", "Map Stage", "Show the detected B1C4 map stage", "Ready"),
	}),
	B2C1 = chapterFeatures(),
	B2C2 = chapterFeatures(),
	B2C3 = chapterFeatures({
		feature("game-mode", "Game Mode", "Display the client-visible GamemodeMode attribute", "Planned"),
	}),
	B2C4 = chapterFeatures(),
	B3C1 = chapterFeatures(),
	NMCS = chapterFeatures(),
	Ken = chapterFeatures(),
	Jigoku = chapterFeatures(),
	WitchTrial = chapterFeatures(),
	HalloweenTrial = chapterFeatures({
		feature("stage", "Trial Stage", "Show the detected Halloween Trial stage", "Ready"),
	}),
	Lobby = {
		feature("context", "Lobby Context", "Display current lobby PlaceId and session", "Ready"),
	},
	GLobby = {
		feature("context", "Lobby Context", "Display current lobby PlaceId and session", "Ready"),
	},
}

function ChapterCatalog.Get(groupName: string?)
	if not groupName then return {feature("unknown", "Unknown Place", "No chapter mapping exists for this PlaceId", "Info")} end
	return table.clone(CATALOG[groupName] or {})
end

function ChapterCatalog.GetGroups()
	local result = {}
	for groupName in pairs(CATALOG) do table.insert(result, groupName) end
	table.sort(result)
	return result
end

return ChapterCatalog
