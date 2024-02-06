local AddonName, Addon = ...;


local LootReminder = {};
Addon.LootReminder = LootReminder;

local _reminderData = {};
function LootReminder:Update()
	wipe(_reminderData);

	local mapID = C_ChallengeMode.GetActiveChallengeMapID();
	local lootTable = Addon.GameData:GetReminderLootTable(mapID);
	local numSpecs = GetNumSpecializations();

	for i=1, numSpecs do
		local specID = GetSpecializationInfo(i);

		local favoriteItems = Addon.Database:GetFavorites(mapID, specID);
		if (favoriteItems and Addon.Util:TableCount(favoriteItems) > 0) then
			local _itemList = {};

			for itemID, itemInfo in next, favoriteItems do
				for _, value in next, lootTable do
					if (itemID == value.itemID and Addon.Util:TableCount(value.specIDs) ~= numSpecs) then
						_itemList[itemID] = {
							icon = itemInfo.icon
						};
						break;
					end
				end
			end

			if (Addon.Util:TableCount(_itemList) > 0) then
				table.insert(_reminderData, {
					specID = specID,
					mapID = mapID,
					favoriteItems = _itemList
				});
			end
		end
	end


	local lootSpecID = Addon.Util:GetSelectedLootSpecialization();
	if (#_reminderData == 0 or (#_reminderData == 1 and _reminderData[1].specID == lootSpecID)) then
		return;
	end

	Addon.Specialization:SetData(_reminderData)
end