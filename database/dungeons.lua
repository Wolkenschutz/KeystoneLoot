local AddonName, KeystoneLoot = ...;

local _dungeonList = {
	[12] = {
		{ --[[name = "Rubinlebensbecken",]] challengeModeId = 399, teleportSpellId = 393256, bgTexture = 4742927, lootTable = { 193748, 193752, 193756, 193764, 193753, 193757, 193761, 193765, 193750, 193754, 193758, 193762, 193766, 193751, 193755, 193728, 193763, 193767, 193691, 193759 } },
		{ --[[name = "Angriff der Nokhud",]] challengeModeId = 400, teleportSpellId = 393262, bgTexture = 4742924, lootTable = { 193686, 193690, 193694, 193698, 193679, 193683, 193687, 193695, 193699, 193676, 193680, 193684, 193688, 212757, 193696, 193700, 193677, 193681, 193685, 193693, 193697, 193678, 193692 } },
		{ --[[name = "Azurblaues Gewölbe",]] challengeModeId = 401, teleportSpellId = 393279, bgTexture = 4742829, lootTable = { 193632, 193636, 193644, 193648, 193629, 193633, 193637, 193641, 193645, 193649, 193630, 193634, 193638, 193642, 193646, 193650, 193631, 193635, 212684, 193643, 193647, 193651, 212685 } },
		{ --[[name = "Akademie von Algeth'ar",]] challengeModeId = 402, teleportSpellId = 393273, bgTexture = 4742929, lootTable = { 193717, 193721, 193706, 193710, 193714, 193718, 193722, 193703, 193707, 193711, 193715, 193719, 193723, 193704, 193708, 193712, 193716, 193720, 193701, 193705, 193709, 193713 } },
		{ --[[name = "Uldaman: Vermächtnis von Tyr",]] challengeModeId = 403, teleportSpellId = 393222, bgTexture = 4742930, lootTable = { 193810, 193814, 193818, 193791, 193795, 193799, 193803, 193807, 193811, 193815, 193819, 193668, 193796, 193800, 193804, 193808, 193812, 193816, 193820, 193797, 193801, 193809, 193813, 193817, 193794, 193792, 193802, 193806, 212756 } },
		{ --[[name = "Neltharus",]] challengeModeId = 404, teleportSpellId = 393276, bgTexture = 4742928, lootTable = { 193779, 193783, 193787, 193768, 193772, 193776, 193780, 193784, 193788, 193769, 193773, 193777, 193781, 193785, 193727, 193778, 193782, 193786, 193790, 193771, 193775, 193789 } },
		{ --[[name = "Brackenfellhöhle",]] challengeModeId = 405, teleportSpellId = 393267, bgTexture = 4742923, lootTable = { 193655, 193663, 193667, 193671, 193675, 193652, 193656, 193660, 193664, 193672, 193653, 193657, 193661, 193665, 193669, 193673, 193654, 193658, 193662, 193666, 193670, 193674, 193793 } },
		{ --[[name = "Hallen der Infusion",]] challengeModeId = 406, teleportSpellId = 393283, bgTexture = 4742926, lootTable = { 193725, 193760, 193733, 193741, 193745, 193726, 193730, 193734, 193738, 193742, 193746, 193731, 193735, 193770, 193743, 193747, 193724, 193739, 193729, 212683, 193740, 193744, 212682 } }
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
	[13] = {
		[2] = { endOfRun = { level = 597, text = 'Champion' }, greatVault = { level = 606, text = 'Champion' } },
		[3] = { endOfRun = { level = 597, text = 'Champion' }, greatVault = { level = 610, text = 'Hero' } },
		[4] = { endOfRun = { level = 600, text = 'Champion' }, greatVault = { level = 610, text = 'Hero' } },
		[5] = { endOfRun = { level = 603, text = 'Champion' }, greatVault = { level = 613, text = 'Hero' } },
		[6] = { endOfRun = { level = 606, text = 'Champion' }, greatVault = { level = 613, text = 'Hero' } },
		[7] = { endOfRun = { level = 610, text = 'Hero' }, greatVault = { level = 616, text = 'Hero' } },
		[8] = { endOfRun = { level = 610, text = 'Hero' }, greatVault = { level = 619, text = 'Hero' } },
		[9] = { endOfRun = { level = 613, text = 'Hero' }, greatVault = { level = 619, text = 'Hero' } },
		[10] = { endOfRun = { level = 613, text = 'Hero' }, greatVault = { level = 623, text = 'Myth' } }
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
	[13] = {
		{ id = 'champion', text = 'Champion', entries = {
			{ itemLevel = 597, bonusId = 10313, text = ITEM_GOOD_COLOR_CODE..'597|r | +2 +3' },
			{ itemLevel = 600, bonusId = 10314, text = ITEM_GOOD_COLOR_CODE..'600|r | +4' },
			{ itemLevel = 603, bonusId = 10315, text = ITEM_GOOD_COLOR_CODE..'603|r | +5' },
			{ itemLevel = 606, bonusId = 10316, text = ITEM_GOOD_COLOR_CODE..'606|r | +6' },
			{ itemLevel = 610, bonusId = 10317, text = ITEM_SUPERIOR_COLOR_CODE..'610|r | '..ITEM_UPGRADE },
			{ itemLevel = 613, bonusId = 10318, text = ITEM_SUPERIOR_COLOR_CODE..'613|r | '..ITEM_UPGRADE },
			{ itemLevel = 616, bonusId = 10319, text = ITEM_SUPERIOR_COLOR_CODE..'616|r | '..ITEM_UPGRADE },
			{ itemLevel = 619, bonusId = 10320, text = ITEM_SUPERIOR_COLOR_CODE..'619|r | '..ITEM_UPGRADE }
		} },
		{ id = 'hero', text = 'Hero', entries = {
			{ itemLevel = 610, bonusId = 10329, text = ITEM_SUPERIOR_COLOR_CODE..'610|r | +7 +8' },
			{ itemLevel = 613, bonusId = 10330, text = ITEM_SUPERIOR_COLOR_CODE..'613|r | +9 +10' },
			{ itemLevel = 616, bonusId = 10331, text = ITEM_SUPERIOR_COLOR_CODE..'616|r | '..ITEM_UPGRADE },
			{ itemLevel = 619, bonusId = 10332, text = ITEM_SUPERIOR_COLOR_CODE..'619|r | '..ITEM_UPGRADE },
			{ itemLevel = 623, bonusId = 10333, text = ITEM_EPIC_COLOR_CODE..'623|r | '..ITEM_UPGRADE },
			{ itemLevel = 626, bonusId = 10334, text = ITEM_EPIC_COLOR_CODE..'626|r | '..ITEM_UPGRADE }
		} },
		{ id = 'myth', text = 'Great Vault', entries = {
			{ itemLevel = 623, bonusId = 10335, text = ITEM_EPIC_COLOR_CODE..'623|r | +10' },
			{ itemLevel = 626, bonusId = 10336, text = ITEM_EPIC_COLOR_CODE..'626|r | '..ITEM_UPGRADE },
			{ itemLevel = 629, bonusId = 10337, text = ITEM_EPIC_COLOR_CODE..'629|r | '..ITEM_UPGRADE },
			{ itemLevel = 632, bonusId = 10338, text = ITEM_EPIC_COLOR_CODE..'632|r | '..ITEM_UPGRADE },
			{ itemLevel = 636, bonusId = 10339, text = ITEM_LEGENDARY_COLOR_CODE..'636|r | '..ITEM_UPGRADE },
			{ itemLevel = 639, bonusId = 10340, text = ITEM_LEGENDARY_COLOR_CODE..'639|r | '..ITEM_UPGRADE }
		} }
	}
};

function KeystoneLoot:GetDungeonItemLevels()
	return _itemlevels[self:GetSeasonId()] or {};
end