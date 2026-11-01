--!strict
-- MimicUI Core: maps known The Mimic PlaceIds to logical game contexts.
-- IDs are transcribed from the project's reviewed reference file; unknown IDs stay unknown.

local GameDetector = {}

local PLACE_GROUPS: {[string]: {number}} = {
	B1C1 = {6296321810, 6479231833, 6301638949, 6480994221},
	B1C2 = {6373539583, 6485055338, 6406571212, 6485055836, 6425178683, 6485056556},
	B1C3 = {6472459099, 6688734180, 6682163754, 6688734313, 6682164423, 6688734395},
	B1C4 = {7251865082, 7265396387, 7251866503, 7265396805, 7251867155, 7265397072, 7251867574, 7265397848},
	B2C1 = {8056702588},
	B2C2 = {13489800654},
	B2C3 = {15962819441},
	B2C4 = {96354063422506},
	B3C1 = {128715637193371},
	Jigoku = {7618863566},
	WitchTrial = {7068738088, 7068951438, 7068739000, 7068951914, 7068740106, 7068952294},
	HalloweenTrial = {7633631103, 7633631351, 7633631511},
	NMCS = {11126398230},
	Ken = {16750505007},
	Lobby = {6243699076},
	GLobby = {7068737459},
}

local PLACE_TO_GROUP: {[number]: string} = {}
for group, ids in pairs(PLACE_GROUPS) do
	for _, placeId in ipairs(ids) do
		PLACE_TO_GROUP[placeId] = group
	end
end

local function getSubMap(group: string?, placeId: number): string?
	if group == "B1C4" then
		if placeId == 7251865082 or placeId == 7265396387 then return "Map1" end
		if placeId == 7251866503 or placeId == 7265396805 then return "Map2" end
		if placeId == 7251867155 or placeId == 7265397072 then return "Map3" end
		if placeId == 7251867574 or placeId == 7265397848 then return "Map4" end
	elseif group == "HalloweenTrial" then
		if placeId == 7633631103 then return "Stage1" end
		if placeId == 7633631351 then return "Stage2" end
		if placeId == 7633631511 then return "Stage3" end
	end
	return nil
end

function GameDetector.Detect(placeId: number, jobId: string?, gameId: number?)
	local group = PLACE_TO_GROUP[placeId]
	return {
		PlaceId = placeId,
		JobId = jobId,
		GameId = gameId,
		Group = group,
		SubMap = getSubMap(group, placeId),
		IsKnown = group ~= nil,
	}
end

function GameDetector.GetKnownPlaceIds()
	local result = {}
	for placeId, group in pairs(PLACE_TO_GROUP) do
		table.insert(result, {PlaceId = placeId, Group = group})
	end
	table.sort(result, function(a, b) return a.PlaceId < b.PlaceId end)
	return result
end

return GameDetector
