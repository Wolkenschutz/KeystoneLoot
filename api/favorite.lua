local AddonName, Addon = ...;


local function SetFavorite(instanceID, itemID, icon)
	KEYSTONE_LOOT_CHAR_DB[instanceID] = KEYSTONE_LOOT_CHAR_DB[instanceID] or {};
	KEYSTONE_LOOT_CHAR_DB[instanceID][itemID] = {
		icon = icon
	}
end
Addon.API.SetFavorite = SetFavorite;

local function RemoveFavorite(instanceID, itemID)
	if (KEYSTONE_LOOT_CHAR_DB[instanceID] and KEYSTONE_LOOT_CHAR_DB[instanceID][itemID]) then
		KEYSTONE_LOOT_CHAR_DB[instanceID][itemID] = nil;
	end
end
Addon.API.RemoveFavorite = RemoveFavorite;

local function RemoveAllFavorites()
	KEYSTONE_LOOT_CHAR_DB = {};
end
Addon.API.RemoveAllFavorites = RemoveAllFavorites;

local function GetFavorite(instanceID, itemID)
	return KEYSTONE_LOOT_CHAR_DB[instanceID] and KEYSTONE_LOOT_CHAR_DB[instanceID][itemID];
end
Addon.API.GetFavorite = GetFavorite;

local function GetInstanceFavorites(instanceID)
	return KEYSTONE_LOOT_CHAR_DB[instanceID];
end
Addon.API.GetInstanceFavorites = GetInstanceFavorites;