local AddonName, KeystoneLoot = ...;

local _raidList = {
	[14] = {
		{ --[[name = "Befreiung von Lorenhall",]] journalInstanceId = 1296, instanceId = 2769, bossList = {
			{ --[[name = "Strolch und die Gangzwinger",]] npcId = 0, bossId = 2639, lootTable = { [14] = {  }, [16] = {  }, [17] = {  }, [15] = {  } } },
			{ --[[name = "Kessel des Gemetzels",]] npcId = 0, bossId = 2640, lootTable = { [14] = {  }, [16] = {  }, [17] = {  }, [15] = {  } } },
			{ --[[name = "Rik Resonanz",]] npcId = 0, bossId = 2641, lootTable = { [14] = {  }, [16] = {  }, [17] = {  }, [15] = {  } } },
			{ --[[name = "Stix Kojenschrotter",]] npcId = 0, bossId = 2642, lootTable = { [14] = {  }, [16] = {  }, [17] = {  }, [15] = {  } } },
			{ --[[name = "Ritzelkrämer Lockenstock",]] npcId = 0, bossId = 2653, lootTable = { [14] = {  }, [16] = {  }, [17] = {  }, [15] = {  } } },
			{ --[[name = "Der Einarmige Bandit",]] npcId = 0, bossId = 2644, lootTable = { [14] = {  }, [16] = {  }, [17] = {  }, [15] = {  } } },
			{ --[[name = "Mug'Zee, Wachleitung",]] npcId = 0, bossId = 2645, lootTable = { [14] = {  }, [16] = {  }, [17] = {  }, [15] = {  } } },
			{ --[[name = "Chromkönig Gallywix",]] npcId = 0, bossId = 2646, lootTable = { [14] = {  }, [16] = {  }, [17] = {  }, [15] = {  } } },
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