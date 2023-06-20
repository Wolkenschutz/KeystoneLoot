local AddonName, Addon = ...;
Addon.API = {};


local MYTHIC_TIER_ID;


local function GetMythicTierID()
    if (MYTHIC_TIER_ID) then
        return MYTHIC_TIER_ID;
    end

	for i=1, EJ_GetNumTiers() do
		if (CHALLENGES == (EJ_GetTierInfo(i))) then
			MYTHIC_TIER_ID = i;
			return i;
		end
	end
end
Addon.API.GetMythicTierID = GetMythicTierID;