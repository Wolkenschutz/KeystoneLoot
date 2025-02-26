local AddonName, KeystoneLoot = ...;

local _dungeonList = {
	[14] = {
		{ --[[name = "Operation: Schleuse",]] challengeModeId = 525, teleportSpellId = 1216786, bgTexture = 6422412, lootTable = {  } },
		{ --[[name = "Metbrauerei Glutbräu",]] challengeModeId = 506, teleportSpellId = 445440, bgTexture = 5912547, lootTable = {  } },
		{ --[[name = "Die Brutstätte",]] challengeModeId = 500, teleportSpellId = 445443, bgTexture = 5912553, lootTable = {  } },
		{ --[[name = "Dunkelflammenspalt",]] challengeModeId = 504, teleportSpellId = 445441, bgTexture = 5912549, lootTable = {  } },
		{ --[[name = "Priorat der Heiligen Flamme",]] challengeModeId = 499, teleportSpellId = 445444, bgTexture = 5912551, lootTable = {  } },
		{ --[[name = "Das RIESENFLÖZ!!",]] challengeModeId = 247, teleportSpellId = (UnitFactionGroup("player") == "Alliance" and 467553 or 467555), bgTexture = 2178274, lootTable = {  } },
		{ --[[name = "Mechagon - Werkstatt,]] challengeModeId = 370, teleportSpellId = 373274, bgTexture = 3025325, lootTable = {  } },
		{ --[[name = "Theater der Schmerzen",]] challengeModeId = 382, teleportSpellId = 354467, bgTexture = 3759914, lootTable = {  } },
	}
};

function KeystoneLoot:GetDungeonList()
	return _dungeonList[self:GetSeasonId()] or {};
end

function KeystoneLoot:GetDungeonItemList(challengeModeId)
	local slotId = KeystoneLootCharDB.selectedSlotId;
	local classId = KeystoneLootCharDB.selectedClassId;
	local specId = KeystoneLootCharDB.selectedSpecId;
	local _itemList = {};

	for _, dungeonInfo in next, self:GetDungeonList() do
		if (dungeonInfo.challengeModeId == challengeModeId) then
			for _, itemId in next, dungeonInfo.lootTable do
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

	return _itemList;
end

function KeystoneLoot:HasDungeonSlotItems(slotId)
	local classId = KeystoneLootCharDB.selectedClassId;
	local specId = KeystoneLootCharDB.selectedSpecId;

	for _, dungeonInfo in next, self:GetDungeonList() do
		for _, itemId in next, dungeonInfo.lootTable do
			local itemInfo = self:GetItemInfo(itemId);
			if (itemInfo and itemInfo.classes[classId] and itemInfo.slotId == slotId) then
				for _, itemSpecId in next, itemInfo.classes[classId] do
					if (itemSpecId == specId) then
						return true;
					end
				end
			end
		end
	end

	return false;
end


local _keystoneItemLevel = {
	[14] = {
		[2] = { endOfRun = { level = 639, text = 'Champion' }, greatVault = { level = 649, text = 'Hero' } },
		[3] = { endOfRun = { level = 639, text = 'Champion' }, greatVault = { level = 649, text = 'Hero' } },
		[4] = { endOfRun = { level = 642, text = 'Champion' }, greatVault = { level = 652, text = 'Hero' } },
		[5] = { endOfRun = { level = 645, text = 'Champion' }, greatVault = { level = 652, text = 'Hero' } },
		[6] = { endOfRun = { level = 649, text = 'Hero' }, greatVault = { level = 655, text = 'Hero' } },
		[7] = { endOfRun = { level = 649, text = 'Hero' }, greatVault = { level = 658, text = 'Hero' } },
		[8] = { endOfRun = { level = 652, text = 'Hero' }, greatVault = { level = 658, text = 'Hero' } },
		[9] = { endOfRun = { level = 652, text = 'Hero' }, greatVault = { level = 658, text = 'Hero' } },
		[10] = { endOfRun = { level = 655, text = 'Hero' }, greatVault = { level = 662, text = 'Myth' } }
	}
};

function KeystoneLoot:GetKeystoneItemLevels(keystoneLevel)
	keystoneLevel = tonumber(keystoneLevel) or 0;
	if (keystoneLevel > 10) then
		keystoneLevel = 10;
	end

	return _keystoneItemLevel[self:GetSeasonId()][keystoneLevel];
end


local _itemlevels = {
	[14] = {
		{ id = 'champion', text = 'Champion', entries = {
			{ itemLevel = 636, bonusId = 11977, text = ITEM_GOOD_COLOR_CODE..'636|r | +0' },
			{ itemLevel = 639, bonusId = 11978, text = ITEM_GOOD_COLOR_CODE..'639|r | +2 +3' },
			{ itemLevel = 642, bonusId = 11979, text = ITEM_GOOD_COLOR_CODE..'642|r | +4' },
			{ itemLevel = 645, bonusId = 11980, text = ITEM_GOOD_COLOR_CODE..'645|r | +5' },
			{ itemLevel = 649, bonusId = 11981, text = ITEM_SUPERIOR_COLOR_CODE..'649|r | '..ITEM_UPGRADE },
			{ itemLevel = 652, bonusId = 11982, text = ITEM_SUPERIOR_COLOR_CODE..'652|r | '..ITEM_UPGRADE },
			{ itemLevel = 655, bonusId = 11983, text = ITEM_SUPERIOR_COLOR_CODE..'655|r | '..ITEM_UPGRADE },
			{ itemLevel = 658, bonusId = 11984, text = ITEM_SUPERIOR_COLOR_CODE..'658|r | '..ITEM_UPGRADE }
		} },
		{ id = 'hero', text = 'Hero', entries = {
			{ itemLevel = 649, bonusId = 11985, text = ITEM_SUPERIOR_COLOR_CODE..'649|r | +6 +7' },
			{ itemLevel = 652, bonusId = 11986, text = ITEM_SUPERIOR_COLOR_CODE..'652|r | +8 +9' },
			{ itemLevel = 655, bonusId = 11987, text = ITEM_SUPERIOR_COLOR_CODE..'655|r | +10' },
			{ itemLevel = 658, bonusId = 11988, text = ITEM_SUPERIOR_COLOR_CODE..'658|r | '..ITEM_UPGRADE },
			{ itemLevel = 662, bonusId = 11989, text = ITEM_EPIC_COLOR_CODE..'662|r | '..ITEM_UPGRADE },
			{ itemLevel = 665, bonusId = 11990, text = ITEM_EPIC_COLOR_CODE..'665|r | '..ITEM_UPGRADE }
		} },
		{ id = 'myth', text = 'Great Vault', entries = {
			{ itemLevel = 662, bonusId = 11991, text = ITEM_EPIC_COLOR_CODE..'662|r | +10' },
			{ itemLevel = 665, bonusId = 11992, text = ITEM_EPIC_COLOR_CODE..'665|r | '..ITEM_UPGRADE },
			{ itemLevel = 668, bonusId = 11993, text = ITEM_EPIC_COLOR_CODE..'668|r | '..ITEM_UPGRADE },
			{ itemLevel = 672, bonusId = 11994, text = ITEM_EPIC_COLOR_CODE..'672|r | '..ITEM_UPGRADE },
			{ itemLevel = 675, bonusId = 11995, text = ITEM_LEGENDARY_COLOR_CODE..'675|r | '..ITEM_UPGRADE },
			{ itemLevel = 678, bonusId = 11996, text = ITEM_LEGENDARY_COLOR_CODE..'678|r | '..ITEM_UPGRADE }
		} }
	}
};

function KeystoneLoot:GetDungeonItemLevels()
	return _itemlevels[self:GetSeasonId()] or {};
end