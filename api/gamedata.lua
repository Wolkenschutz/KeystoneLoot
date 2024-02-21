local AddonName, Addon = ...;


local GameData = {};
Addon.GameData = GameData;

local _dungeonData = {};


function GameData:LoadDungeonData(classID)
	if (not C_MythicPlus.IsMythicPlusActive()) then
		return false;
	end

	EJ_ClearSearch();
	EJ_SelectTier(EJ_GetNumTiers());
	EJ_SetDifficulty(DifficultyUtil.ID.DungeonChallenge);

	local mapTable = C_ChallengeMode.GetMapTable() or {};

	for _, mapID in next, mapTable do
		local instanceIndex = 1;
		local instanceID, _, _, _, bgTexture, _, instanceSmallImage = EJ_GetInstanceByIndex(instanceIndex, false);
		local mapName, _, _, mapSmallImage = C_ChallengeMode.GetMapUIInfo(mapID);

		while (instanceID) do
			if (mapSmallImage == instanceSmallImage) then
				EJ_SelectInstance(instanceID);

				if (_dungeonData[mapID] == nil) then
					_dungeonData[mapID] = {
						name = mapName,
						bgTexture = bgTexture,
						lootTable = {}
					};
				end

				for specIndex=1, GetNumSpecializationsForClassID(classID) do
					local specID = GetSpecializationInfoForClassID(classID, specIndex);

					EJ_SetLootFilter(classID, specID);

					for slotID=0, 14 do -- Enum.ItemSlotFilterType
						C_EncounterJournal.SetSlotFilter(slotID);

						local lootIndex = 1
						local itemInfo = C_EncounterJournal.GetLootInfoByIndex(lootIndex);

						while (itemInfo and itemInfo.name) do
							local encounterID = itemInfo.encounterID;
							local itemID = itemInfo.itemID;
							local skipItem = false;

							if ( -- Megadungeon teilen...
								(mapID == 463 and (encounterID == 2526 or encounterID == 2536 or encounterID == 2533 or encounterID == 2534 or encounterID == 2538)) or -- Fall brauch keine Items aus Rise
								(mapID == 464 and (encounterID == 2521 or encounterID == 2528 or encounterID == 2535 or encounterID == 2537)) -- Rise brauch keine Items aus Fall
							) then
								skipItem = true;
							end

							if (not skipItem) then
								if (_dungeonData[mapID].lootTable[itemID] == nil) then
									_dungeonData[mapID].lootTable[itemID] = {
										icon = itemInfo.icon,
										slotID = slotID,
										classes = {}
									};
								end

								if (_dungeonData[mapID].lootTable[itemID].classes[classID] == nil) then
									_dungeonData[mapID].lootTable[itemID].classes[classID] = {};
								end

								_dungeonData[mapID].lootTable[itemID].classes[classID][specID] = true;
							end

							lootIndex = lootIndex + 1;
							itemInfo = C_EncounterJournal.GetLootInfoByIndex(lootIndex);
						end
					end
				end

				break;
			end

			instanceIndex = instanceIndex+1;
			instanceID, _, _, _, bgTexture, _, instanceSmallImage = EJ_GetInstanceByIndex(instanceIndex, false);
		end
	end

	return true;
end

function GameData:HasSlotItems(slotID, classID, specID)
	for mapID, dungeonInfo in pairs(_dungeonData) do
		for itemID, itemInfo in pairs(dungeonInfo.lootTable) do
			if (itemInfo.classes[classID] and itemInfo.classes[classID][specID] and itemInfo.slotID == slotID) then
				return true;
			end
		end
	end

	return false;
end

function GameData:GetDungeonList()
	local _dungeonList = {};

	for mapID, dungeonInfo in pairs(_dungeonData) do
		table.insert(_dungeonList, {
			mapID = mapID,
			name = dungeonInfo.name,
			bgTexture = dungeonInfo.bgTexture
		});
	end

	table.sort(_dungeonList, function(a, b)
		return a.mapID < b.mapID;
	end);

	return _dungeonList;
end

function GameData:GetLootTable(mapID, slotID, classID, specID)
	local _lootTable = {};

	if (slotID == -1) then
		local _favoritesList;

		if (Addon.Database:IsFavoritesShowAllSpecs()) then
			_favoritesList = Addon.Database:GetFavoritesForMapID(mapID);
		else
			_favoritesList = Addon.Database:GetFavorites(mapID, specID);
		end

		for itemID, itemInfo in next, _favoritesList or {} do
			table.insert(_lootTable, {
				specID = itemInfo.specID,
				itemID = itemID,
				icon = itemInfo.icon
			});
		end

		return _lootTable;
	end

	for itemID, itemInfo in next, _dungeonData[mapID].lootTable do
		if (itemInfo.classes[classID] and itemInfo.classes[classID][specID] and itemInfo.slotID == slotID) then
			table.insert(_lootTable, {
				itemID = itemID,
				icon = itemInfo.icon
			});
		end
	end

	return _lootTable;
end

function GameData:GetReminderLootTable(mapID)
	local _, _, classID = UnitClass('player');
	local _lootTable = {};

	for itemID, itemInfo in pairs(_dungeonData[mapID] and _dungeonData[mapID].lootTable or {}) do
		if (itemInfo.classes[classID]) then
			table.insert(_lootTable, {
				itemID = itemID,
				icon = itemInfo.icon,
				specIDs = itemInfo.classes[classID]
			});
		end
	end

	return _lootTable;
end