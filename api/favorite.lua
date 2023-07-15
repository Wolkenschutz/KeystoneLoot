local AddonName, Addon = ...;


local function SetFavorite(instanceID, itemID, icon)
	local classSlug = Addon.SELECTED_CLASS_ID..':'..Addon.SELECTED_SPEC_ID;

	if (KEYSTONE_LOOT_CHAR_DB[instanceID] == nil) then
		KEYSTONE_LOOT_CHAR_DB[instanceID] = {};
	end

	if (KEYSTONE_LOOT_CHAR_DB[instanceID][classSlug] == nil) then
		KEYSTONE_LOOT_CHAR_DB[instanceID][classSlug] = {};
	end

	KEYSTONE_LOOT_CHAR_DB[instanceID][classSlug][itemID] = {
		icon = icon
	}
end
Addon.API.SetFavorite = SetFavorite;

local function RemoveFavorite(instanceID, itemID)
	local classSlug = Addon.SELECTED_CLASS_ID..':'..Addon.SELECTED_SPEC_ID;

	if (KEYSTONE_LOOT_CHAR_DB[instanceID] and KEYSTONE_LOOT_CHAR_DB[instanceID][classSlug] and KEYSTONE_LOOT_CHAR_DB[instanceID][classSlug][itemID]) then
		KEYSTONE_LOOT_CHAR_DB[instanceID][classSlug][itemID] = nil;
	end
end
Addon.API.RemoveFavorite = RemoveFavorite;

local function RemoveAllFavorites()
	KEYSTONE_LOOT_CHAR_DB = {};
end
Addon.API.RemoveAllFavorites = RemoveAllFavorites;

local function GetFavorite(instanceID, itemID)
	local classSlug = Addon.SELECTED_CLASS_ID..':'..Addon.SELECTED_SPEC_ID;

	if (KEYSTONE_LOOT_CHAR_DB[instanceID] == nil or KEYSTONE_LOOT_CHAR_DB[instanceID][classSlug] == nil) then
		return;
	end

	return KEYSTONE_LOOT_CHAR_DB[instanceID][classSlug][itemID];
end
Addon.API.GetFavorite = GetFavorite;

local function GetInstanceFavorites(instanceID)
	local classSlug = Addon.SELECTED_CLASS_ID..':'..Addon.SELECTED_SPEC_ID;

	return KEYSTONE_LOOT_CHAR_DB[instanceID] and KEYSTONE_LOOT_CHAR_DB[instanceID][classSlug];
end
Addon.API.GetInstanceFavorites = GetInstanceFavorites;