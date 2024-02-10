local AddonName, Addon = ...;


local Database = {};
Addon.Database = Database;

local dbVersion = 1;
local dbCharacterVersion = 1;


function Database:GetFavorite(mapID, specID, itemID)
	if (KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID] == nil or KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID][specID] == nil) then
		return;
	end

	return KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID][specID][itemID];
end

function Database:SetFavorite(mapID, specID, itemID, icon)
	if (KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID] == nil) then
		KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID] = {};
	end

	if (KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID][specID] == nil) then
		KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID][specID] = {};
	end

	KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID][specID][itemID] = {
		icon = icon
	};
end

function Database:RemoveFavorite(mapID, specID, itemID)
	if (
		KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID] and
		KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID][specID] and
		KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID][specID][itemID]
	) then
		KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID][specID][itemID] = nil;
	end
end

function Database:GetFavorites(mapID, specID)
	return KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID] and KEYSTONELOOT_CHAR_DB.favoriteLoot[mapID][specID];
end

-- TODO: Bei allem: Dungeon und Raid getrennt?
-- Class und Slot kann eigentlich synct sein?
-- Wie Itemlevel machen? Raid hat kein +X
-- Zukunft: Fated Raid
function Database:GetSelectedClass()
	local defaultClassID, defaultSpecID = Addon.Filter:GetButton('Class'):GetDefaultValue();
	return KEYSTONELOOT_CHAR_DB and KEYSTONELOOT_CHAR_DB.selectedClassID or defaultClassID, KEYSTONELOOT_CHAR_DB and KEYSTONELOOT_CHAR_DB.selectedSpecID or defaultSpecID;
end

function Database:SetSelectedClass(classID, specID)
	KEYSTONELOOT_CHAR_DB.selectedClassID = classID;
	KEYSTONELOOT_CHAR_DB.selectedSpecID = specID;
end

function Database:GetSelectedSlot()
	return KEYSTONELOOT_CHAR_DB and KEYSTONELOOT_CHAR_DB.selectedSlotID or Addon.Filter:GetButton('Slot'):GetDefaultValue();
end

function Database:SetSelectedSlot(slotID)
	KEYSTONELOOT_CHAR_DB.selectedSlotID = slotID;
end

function Database:GetSelectedItemLevel()
	local defaultCategory, defaultRank = Addon.Filter:GetButton('ItemLevel'):GetDefaultValue();
	return KEYSTONELOOT_CHAR_DB and KEYSTONELOOT_CHAR_DB.selectedItemLevelCategory or defaultCategory, KEYSTONELOOT_CHAR_DB and KEYSTONELOOT_CHAR_DB.selectedItemLevelRank or defaultRank;
end

function Database:SetSelectedItemLevel(category, rank)
	if (category ~= nil) then
		KEYSTONELOOT_CHAR_DB.selectedItemLevelCategory = category;
	end

	if (rank ~= nil) then
		KEYSTONELOOT_CHAR_DB.selectedItemLevelRank = rank;
	end
end

function Database:GetMinimapPosition()
	return KEYSTONELOOT_DB and KEYSTONELOOT_DB.minimapButtonPosition or 195;
end

function Database:SetMinimapPosition(position)
	KEYSTONELOOT_DB.minimapButtonPosition = position;
end

function Database:IsMinimapEnabled()
	return KEYSTONELOOT_DB and KEYSTONELOOT_DB.minimapButtonEnabled;
end

function Database:SetMinimapEnabled(isEnabled)
	KEYSTONELOOT_DB.minimapButtonEnabled = isEnabled;
end

function Database:IsReminderEnabled()
	return KEYSTONELOOT_DB and KEYSTONELOOT_DB.lootReminderEnabled;
end

function Database:SetReminderEnabled(isEnabled)
	KEYSTONELOOT_DB.lootReminderEnabled = isEnabled;
end


function Database:CheckDB()
	if (KEYSTONELOOT_DB == nil or KEYSTONELOOT_DB.dbVersion == nil) then
		KEYSTONELOOT_DB = {
			dbVersion = 0
		};
	end

	if (dbVersion > KEYSTONELOOT_DB.dbVersion) then
		if (KEYSTONELOOT_DB.dbVersion == 0) then
			KEYSTONELOOT_DB.minimapButtonPosition = KEYSTONE_LOOT_DB and KEYSTONE_LOOT_DB.minimapButtonPosition;
			if (KEYSTONE_LOOT_DB and KEYSTONE_LOOT_DB.minimapButtonEnabled ~= nil) then
				KEYSTONELOOT_DB.minimapButtonEnabled = KEYSTONE_LOOT_DB.minimapButtonEnabled;
			else
				KEYSTONELOOT_DB.minimapButtonEnabled = true;
			end
			if (KEYSTONE_LOOT_DB and KEYSTONE_LOOT_DB.lootReminderEnabled ~= nil) then
				KEYSTONELOOT_DB.lootReminderEnabled = KEYSTONE_LOOT_DB.lootReminderEnabled;
			else
				KEYSTONELOOT_DB.lootReminderEnabled = true;
			end

			KEYSTONE_LOOT_DB = nil;
		end

		KEYSTONELOOT_DB.dbVersion = KEYSTONELOOT_DB.dbVersion + 1;
		self:CheckDB();
	end
end

function Database:CheckCharacterDB()
	if (KEYSTONELOOT_CHAR_DB == nil or KEYSTONELOOT_CHAR_DB.dbVersion == nil) then
		KEYSTONELOOT_CHAR_DB = {
			dbVersion = 0
		};
	end

	if (dbCharacterVersion > KEYSTONELOOT_CHAR_DB.dbVersion) then
		if (KEYSTONELOOT_CHAR_DB.dbVersion == 0) then
			KEYSTONELOOT_CHAR_DB.currentSeason = KEYSTONE_LOOT_CHAR_DB and KEYSTONE_LOOT_CHAR_DB.currSeasion or C_MythicPlus.GetCurrentUIDisplaySeason() or -1;

			KEYSTONELOOT_CHAR_DB.selectedClassID = KEYSTONE_LOOT_CHAR_DB and KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID;
			KEYSTONELOOT_CHAR_DB.selectedSpecID = KEYSTONE_LOOT_CHAR_DB and KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID;
			KEYSTONELOOT_CHAR_DB.selectedSlotID = KEYSTONE_LOOT_CHAR_DB and KEYSTONE_LOOT_CHAR_DB.SELECTED_SLOT_ID;
			KEYSTONELOOT_CHAR_DB.selectedItemLevelCategory = KEYSTONE_LOOT_CHAR_DB and KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_CATEGORY;
			KEYSTONELOOT_CHAR_DB.selectedItemLevelRank = KEYSTONE_LOOT_CHAR_DB and KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_RANK;

			KEYSTONELOOT_CHAR_DB.favoriteLoot = {};
			for key, value in pairs(KEYSTONE_LOOT_CHAR_DB or {}) do
				if (type(key) == 'number' or key == 'catalyst') then
					KEYSTONELOOT_CHAR_DB.favoriteLoot[key] = {};

					for classInfo, itemTable in pairs(value) do
						local _, specID = (':'):split(classInfo);

						KEYSTONELOOT_CHAR_DB.favoriteLoot[key][tonumber(specID)] = itemTable;
					end
				end
			end

			KEYSTONE_LOOT_CHAR_DB = nil;
		end

		KEYSTONELOOT_CHAR_DB.dbVersion = KEYSTONELOOT_CHAR_DB.dbVersion + 1;
		self:CheckCharacterDB();
	end

	self:RemoveOldSeason();
end

function Database:RemoveOldSeason()
	local currentSeasonDB = KEYSTONELOOT_CHAR_DB.currentSeason;
	local currentSeason = C_MythicPlus.GetCurrentUIDisplaySeason();

	if (currentSeason and currentSeasonDB and currentSeason ~= currentSeasonDB) then
		wipe(KEYSTONELOOT_CHAR_DB.favoriteLoot);

		KEYSTONELOOT_CHAR_DB.currentSeason = currentSeason;
	end
end