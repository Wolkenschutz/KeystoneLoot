local AddonName, Addon = ...;
Addon.API = {};


local function GetMythicTierID()
	return C_MythicPlus.IsMythicPlusActive() and EJ_GetNumTiers();
end
Addon.API.GetMythicTierID = GetMythicTierID;

local function CleanUpDatabase()
	local currentSeasonDB = KEYSTONE_LOOT_CHAR_DB.currSeasion;
	local currentSeason = C_MythicPlus.GetCurrentUIDisplaySeason();

	if (currentSeason ~= currentSeasonDB) then
		Addon.API.RemoveAllFavorites();

		KEYSTONE_LOOT_CHAR_DB.currSeasion = currentSeason;
	end
end
Addon.API.CleanUpDatabase = CleanUpDatabase;