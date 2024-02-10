local AddonName, Addon = ...;


local Util = {};
Addon.Util = Util;


function Util:TableCount(table)
	local count = 0;

	for _ in pairs(table) do
		count = count + 1;
	end

	return count;
end

function Util:GetSelectedLootSpecialization()
	local lootSpecID = GetLootSpecialization();
	if (lootSpecID == 0) then
		lootSpecID = GetSpecializationInfo(GetSpecialization());
	end

	return lootSpecID;
end