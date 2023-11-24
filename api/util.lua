local AddonName, Addon = ...;


local Translate = Addon.API.Translate;


local function GetMythicTierID()
	return C_MythicPlus.IsMythicPlusActive() and EJ_GetNumTiers();
end
Addon.API.GetMythicTierID = GetMythicTierID;


local ALL_SEASON_DUNGEONS;
local function GetSeasonDungeons()
	if (ALL_SEASON_DUNGEONS ~= nil) then
		return ALL_SEASON_DUNGEONS;
	end

	local mythicTierID = GetMythicTierID();
	if (not mythicTierID) then
		return {};
	end

	EJ_SelectTier(mythicTierID);
	EJ_SetDifficulty(DifficultyUtil.ID.DungeonChallenge);

	local mapTable = C_ChallengeMode.GetMapTable() or {};
	local sortedTable = {};

	for _, mapID in next, mapTable do
		local mapName, _, _, mapSmallImage = C_ChallengeMode.GetMapUIInfo(mapID);

		local instanceIndex = 1;
		local instanceID, _, _, _, bgTexture, _, instanceSmallImage = EJ_GetInstanceByIndex(instanceIndex, false);

		while (instanceID) do
			if (mapSmallImage == instanceSmallImage) then
				table.insert(sortedTable, {
					name = Translate[mapName],
					mapID = mapID,
					instanceID = instanceID,
					bgTexture = bgTexture
				});
				break;
			end

			instanceIndex = instanceIndex+1;
			instanceID, _, _, _, bgTexture, _, instanceSmallImage = EJ_GetInstanceByIndex(instanceIndex, false);
		end
	end

	table.sort(sortedTable, function(a, b)
		return a.mapID < b.mapID;
	end);

	ALL_SEASON_DUNGEONS = sortedTable;
	return sortedTable;
end
Addon.API.GetSeasonDungeons = GetSeasonDungeons;


local function CleanUpDatabase()
	local currentSeasonDB = KEYSTONE_LOOT_CHAR_DB.currSeasion;
	local currentSeason = C_MythicPlus.GetCurrentUIDisplaySeason();

	if (currentSeason ~= currentSeasonDB) then
		Addon.API.RemoveAllFavorites();

		KEYSTONE_LOOT_CHAR_DB.currSeasion = currentSeason;
	end
end
Addon.API.CleanUpDatabase = CleanUpDatabase;