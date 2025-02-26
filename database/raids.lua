local AddonName, KeystoneLoot = ...;

local _raidList = {
	[13] = {
		{ --[[name = "Palast der Nerub'ar",]] journalInstanceId = 1273, instanceId = 2657, bossList = {
			{ --[[name = "Ulgrax der Verschlinger",]] npcId = 215657, bossId = 2607, lootTable = { [14] = { 212424, 212426, 212428, 219915, 212419, 212423, 212425, 212442, 212409, 212386, 212388, 212446, 212431 }, [16] = { 212424, 212426, 212428, 219915, 212419, 212423, 212425, 212442, 212409, 212386, 212388, 212446, 212431 }, [17] = { 212424, 212426, 212428, 219915, 212419, 212423, 212425, 212442, 212409, 212386, 212388, 212446, 212431 }, [15] = { 212424, 212426, 212428, 219915, 212419, 212423, 212425, 212442, 212409, 212386, 212388, 212446, 212431 } } },
			{ --[[name = "Der blutgebundene Schrecken",]] npcId = 214502, bossId = 2611, lootTable = { [14] = { 212422, 212439, 212430, 219917, 212404, 212421, 212438, 212395, 212414, 212451, 212417, 225590, 212447 }, [16] = { 212422, 212439, 212430, 219917, 212404, 212421, 212438, 212395, 212414, 212451, 212417, 225590, 212447 }, [17] = { 212422, 212439, 212430, 219917, 212404, 212421, 212438, 212395, 212414, 212451, 212417, 225590, 212447 }, [15] = { 212422, 212439, 212430, 219917, 212404, 212421, 212438, 212395, 212414, 212451, 212417, 225590, 212447 } } },
			{ --[[name = "Sikran, Hauptmann der Sureki",]] npcId = 214503, bossId = 2599, lootTable = { [14] = { 212392, 225577, 212413, 212415, 223097, 212449, 225621, 225619, 212445, 212427, 212399, 212416, 225618, 212405, 225620 }, [16] = { 212392, 225577, 212413, 212415, 223097, 212449, 225621, 225619, 212445, 212427, 212399, 212416, 225618, 212405, 225620 }, [17] = { 212392, 225577, 212413, 212415, 223097, 212449, 225621, 225619, 212445, 212427, 212399, 212416, 225618, 212405, 225620 }, [15] = { 212392, 225577, 212413, 212415, 223097, 212449, 225621, 225619, 212445, 212427, 212399, 212416, 225618, 212405, 225620 } } },
			{ --[[name = "Rasha'nan",]] npcId = 214504, bossId = 2609, lootTable = { [14] = { 212437, 225583, 225630, 225632, 225574, 212391, 212453, 212440, 212398, 225631, 225586, 212448, 224435, 225633 }, [16] = { 212437, 225583, 225630, 225632, 225574, 212391, 212453, 212440, 212398, 225631, 225586, 212448, 224435, 225633 }, [17] = { 212437, 225583, 225630, 225632, 225574, 212391, 212453, 212440, 212398, 225631, 225586, 212448, 224435, 225633 }, [15] = { 212437, 225583, 225630, 225632, 225574, 212391, 212453, 212440, 212398, 225631, 225586, 212448, 224435, 225633 } } },
			{ --[[name = "Brutverderber Ovi'nax",]] npcId = 214506, bossId = 2612, lootTable = { [14] = { 212452, 225588, 220305, 225617, 212389, 225576, 212387, 225580, 225582, 225614, 225616, 212418, 226190, 225615 }, [16] = { 212452, 225588, 220305, 225617, 212389, 225576, 212387, 225580, 225582, 225614, 225616, 212418, 226190, 225615 }, [17] = { 212452, 225588, 220305, 225617, 212389, 225576, 212387, 225580, 225582, 225614, 225616, 212418, 226190, 225615 }, [15] = { 212452, 225588, 220305, 225617, 212389, 225576, 212387, 225580, 225582, 225614, 225616, 212418, 226190, 225615 } } },
			{ --[[name = "Nexusprinzessin Ky'veza",]] npcId = 217748, bossId = 2601, lootTable = { [14] = { 219877, 225581, 223048, 212400, 225589, 225591, 225626, 212441, 225627, 225629, 225636, 212456, 225628, 221023 }, [16] = { 219877, 225581, 223048, 212400, 225589, 225591, 225626, 212441, 225627, 225629, 225636, 212456, 225628, 221023 }, [17] = { 219877, 225581, 223048, 212400, 225589, 225591, 225626, 212441, 225627, 225629, 225636, 212456, 225628, 221023 }, [15] = { 219877, 225581, 223048, 212400, 225589, 225591, 225626, 212441, 225627, 225629, 225636, 212456, 225628, 221023 } } },
			{ --[[name = "Der Seidenhof",]] npcId = { 217491, 217489 }, bossId = 2608, lootTable = { [14] = { 212407, 225624, 212443, 220202, 225622, 225584, 225623, 225625, 212397, 223094, 212432, 212429, 225575, 212450 }, [16] = { 212407, 225624, 212443, 220202, 225622, 225584, 225623, 225625, 212397, 223094, 212432, 212429, 225575, 212450 }, [17] = { 212407, 225624, 212443, 220202, 225622, 225584, 225623, 225625, 212397, 223094, 212432, 212429, 225575, 212450 }, [15] = { 212407, 225624, 212443, 220202, 225622, 225584, 225623, 225625, 212397, 223094, 212432, 212429, 225575, 212450 } } },
			{ --[[name = "Königin Ansurek",]] npcId = 218370, bossId = 2602, lootTable = { [14] = { 212394, 212454, 212434, 223144, 225585, 225587, 225634, 212436, 225578, 225579, 212435, 212444, 212401, 212433, 212420, 224147 }, [16] = { 225585, 223144, 225578, 212454, 212435, 225587, 212420, 225634, 212401, 212436, 212444, 212434, 212394, 224147, 212433, 225579, 224151 }, [17] = { 212394, 212454, 212434, 223144, 225585, 225587, 225634, 212436, 225578, 225579, 212435, 212444, 212401, 212433, 212420, 224147 }, [15] = { 212394, 212454, 212434, 223144, 225585, 225587, 225634, 212436, 225578, 225579, 212435, 212444, 212401, 212433, 212420, 224147 } } }
		} }
	}
};

function KeystoneLoot:GetRaidList()
	return _raidList[self:GetSeasonId()] or {};
end

function KeystoneLoot:GetRaidBossItemList(bossId)
	local slotId = KeystoneLootCharDB.selectedSlotId;
	local classId = KeystoneLootCharDB.selectedClassId;
	local specId = KeystoneLootCharDB.selectedSpecId;
	local difficultyId = KeystoneLoot:GetRaidDifficultyId();
	local _itemList = {};

	for _, raidInfo in next, self:GetRaidList() do
		for _, bossInfo in next, raidInfo.bossList do
			if (bossInfo.bossId == bossId) then
				for _, itemId in next, bossInfo.lootTable[difficultyId] or {} do
					local itemInfo = self:GetItemInfo(itemId);

					if (itemInfo and itemInfo.classes[classId] and itemInfo.slotId == slotId) then
						for _, itemSpecId in next, itemInfo.classes[classId] do
							if (itemSpecId == specId) then
								table.insert(_itemList, {
									itemId = itemId,
									icon = itemInfo.icon
								});
							end
						end
					end
				end
				break;
			end
		end
	end

	return _itemList;
end

function KeystoneLoot:HasRaidSlotItems(journalInstanceId, slotId)
	local selectedClassId = KeystoneLootCharDB.selectedClassId;
	local selectedSpecId = KeystoneLootCharDB.selectedSpecId;
	local difficultyId = KeystoneLoot:GetRaidDifficultyId();

	for _, raidInfo in next, self:GetRaidList() do
		if (raidInfo.journalInstanceId == journalInstanceId) then
			for _, bossInfo in next, raidInfo.bossList do
				for _, itemId in next, bossInfo.lootTable[difficultyId] or {} do
					local itemInfo = self:GetItemInfo(itemId);
					if (itemInfo and itemInfo.classes[selectedClassId] and itemInfo.slotId == slotId) then
						for _, itemSpecId in next, itemInfo.classes[selectedClassId] do
							if (itemSpecId == selectedSpecId) then
								return true;
							end
						end
					end
				end
			end
			break;
		end
	end

	return false;
end


local _itemlevels = {
	[14] = {
		{ id = 'veteran', text = 'Raid Finder', difficultyId = DifficultyUtil.ID.PrimaryRaidLFR, entries = {
			{ itemLevel = 623, bonusId = 11969, text = ITEM_POOR_COLOR_CODE..'623|r | '..BOSS..' 1-2' },
			{ itemLevel = 626, bonusId = 11970, text = ITEM_POOR_COLOR_CODE..'587|r | '..BOSS..' 3-4' },
			{ itemLevel = 629, bonusId = 11971, text = ITEM_POOR_COLOR_CODE..'629|r | '..BOSS..' 5-6' },
			{ itemLevel = 632, bonusId = 11972, text = ITEM_POOR_COLOR_CODE..'632|r | '..BOSS..' 7-8' },
			{ itemLevel = 636, bonusId = 11973, text = ITEM_GOOD_COLOR_CODE..'636|r | '..ITEM_UPGRADE },
			{ itemLevel = 639, bonusId = 11974, text = ITEM_GOOD_COLOR_CODE..'639|r | '..ITEM_UPGRADE },
			{ itemLevel = 642, bonusId = 11975, text = ITEM_GOOD_COLOR_CODE..'642|r | '..ITEM_UPGRADE },
			{ itemLevel = 645, bonusId = 11976, text = ITEM_GOOD_COLOR_CODE..'645|r | '..ITEM_UPGRADE }
		} },
		{ id = 'champion', text = 'Normal', difficultyId = DifficultyUtil.ID.PrimaryRaidNormal, entries = {
			{ itemLevel = 636, bonusId = 11977, text = ITEM_GOOD_COLOR_CODE..'636|r | '..BOSS..' 1-2' },
			{ itemLevel = 639, bonusId = 11978, text = ITEM_GOOD_COLOR_CODE..'639|r | '..BOSS..' 3-4' },
			{ itemLevel = 642, bonusId = 11979, text = ITEM_GOOD_COLOR_CODE..'642|r | '..BOSS..' 5-6' },
			{ itemLevel = 645, bonusId = 11980, text = ITEM_GOOD_COLOR_CODE..'645|r | '..BOSS..' 7-8' },
			{ itemLevel = 649, bonusId = 11981, text = ITEM_SUPERIOR_COLOR_CODE..'649|r | '..ITEM_UPGRADE },
			{ itemLevel = 652, bonusId = 11982, text = ITEM_SUPERIOR_COLOR_CODE..'652|r | '..ITEM_UPGRADE },
			{ itemLevel = 655, bonusId = 11983, text = ITEM_SUPERIOR_COLOR_CODE..'655|r | '..ITEM_UPGRADE },
			{ itemLevel = 658, bonusId = 11984, text = ITEM_SUPERIOR_COLOR_CODE..'658|r | '..ITEM_UPGRADE }
		} },
		{ id = 'hero', text = 'Heroic', difficultyId = DifficultyUtil.ID.PrimaryRaidHeroic, entries = {
			{ itemLevel = 649, bonusId = 11985, text = ITEM_SUPERIOR_COLOR_CODE..'649|r | '..BOSS..' 1-2' },
			{ itemLevel = 652, bonusId = 11986, text = ITEM_SUPERIOR_COLOR_CODE..'652|r | '..BOSS..' 3-4' },
			{ itemLevel = 655, bonusId = 11987, text = ITEM_SUPERIOR_COLOR_CODE..'655|r | '..BOSS..' 5-6' },
			{ itemLevel = 658, bonusId = 11988, text = ITEM_SUPERIOR_COLOR_CODE..'658|r | '..BOSS..' 7-8' },
			{ itemLevel = 662, bonusId = 11989, text = ITEM_EPIC_COLOR_CODE..'662|r | '..ITEM_UPGRADE },
			{ itemLevel = 665, bonusId = 11990, text = ITEM_EPIC_COLOR_CODE..'665|r | '..ITEM_UPGRADE }
		} },
		{ id = 'myth', text = 'Mythic', difficultyId = DifficultyUtil.ID.PrimaryRaidMythic, entries = {
			{ itemLevel = 662, bonusId = 11991, text = ITEM_EPIC_COLOR_CODE..'662|r | '..BOSS..' 1-2' },
			{ itemLevel = 665, bonusId = 11992, text = ITEM_EPIC_COLOR_CODE..'665|r | '..BOSS..' 3-4' },
			{ itemLevel = 668, bonusId = 11993, text = ITEM_EPIC_COLOR_CODE..'668|r | '..BOSS..' 5-6' },
			{ itemLevel = 672, bonusId = 11994, text = ITEM_EPIC_COLOR_CODE..'672|r | '..BOSS..' 7-8' },
			{ itemLevel = 675, bonusId = 11995, text = ITEM_LEGENDARY_COLOR_CODE..'675|r | '..ITEM_UPGRADE },
			{ itemLevel = 678, bonusId = 11996, text = ITEM_LEGENDARY_COLOR_CODE..'678|r | '..ITEM_UPGRADE }
		} }
	}
};

function KeystoneLoot:GetRaidItemLevels()
	return _itemlevels[self:GetSeasonId()] or {};
end


function KeystoneLoot:GetRaidDifficultyId()
	local selectedCategoryId = ('-'):split(KeystoneLootCharDB.selectedRaidItemLevel);
	local _itemLevels = self:GetRaidItemLevels();

	if (#_itemLevels > 0 and selectedCategoryId == '0') then
		selectedCategoryId = _itemLevels[1].id;
	end

	for index, category in next, _itemLevels do
		if (selectedCategoryId == category.id) then
			return category.difficultyId;
		end
	end

	return 0;
end

function KeystoneLoot:GetRaidBossId(npcId)
	for _, raidInfo in next, self:GetRaidList() do
		for _, bossInfo in next, raidInfo.bossList do
			local npcIds = bossInfo.npcId;
			if (type(npcIds) ~= 'table') then
				npcIds = { npcIds };
			end

			for _, id in next, npcIds do
				if (id == npcId) then
					return bossInfo.bossId;
				end
			end
		end
	end

	return 0;
end