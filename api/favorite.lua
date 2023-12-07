local AddonName, Addon = ...;


local function SetFavorite(mapID, itemID, icon)
	local classSlug = KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID..':'..KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID;

	if (KEYSTONE_LOOT_CHAR_DB[mapID] == nil) then
		KEYSTONE_LOOT_CHAR_DB[mapID] = {};
	end

	if (KEYSTONE_LOOT_CHAR_DB[mapID][classSlug] == nil) then
		KEYSTONE_LOOT_CHAR_DB[mapID][classSlug] = {};
	end

	KEYSTONE_LOOT_CHAR_DB[mapID][classSlug][itemID] = {
		icon = icon
	}
end
Addon.API.SetFavorite = SetFavorite;

local function RemoveFavorite(mapID, itemID)
	local classSlug = KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID..':'..KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID;

	if (KEYSTONE_LOOT_CHAR_DB[mapID] and KEYSTONE_LOOT_CHAR_DB[mapID][classSlug] and KEYSTONE_LOOT_CHAR_DB[mapID][classSlug][itemID]) then
		KEYSTONE_LOOT_CHAR_DB[mapID][classSlug][itemID] = nil;
	end
end
Addon.API.RemoveFavorite = RemoveFavorite;

local function RemoveAllFavorites()
	KEYSTONE_LOOT_CHAR_DB = {};
end
Addon.API.RemoveAllFavorites = RemoveAllFavorites;

local function GetFavorite(mapID, itemID)
	local classSlug = KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID..':'..KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID;

	if (KEYSTONE_LOOT_CHAR_DB[mapID] == nil or KEYSTONE_LOOT_CHAR_DB[mapID][classSlug] == nil) then
		return;
	end

	return KEYSTONE_LOOT_CHAR_DB[mapID][classSlug][itemID];
end
Addon.API.GetFavorite = GetFavorite;

local function GetFavorites(mapID)
	local classSlug = KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID..':'..KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID;

	return KEYSTONE_LOOT_CHAR_DB[mapID] and KEYSTONE_LOOT_CHAR_DB[mapID][classSlug];
end
Addon.API.GetFavorites = GetFavorites;