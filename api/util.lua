local AddonName, Addon = ...;
Addon.API = {};


local MYTHIC_TIER_ID;


local function GetMythicTierID()
	return 11;
end
Addon.API.GetMythicTierID = GetMythicTierID;