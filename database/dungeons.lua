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
	local dungeonList = _dungeonList[self:GetSeasonId()];

	if (dungeonList) then
		return dungeonList;
	end
end

function KeystoneLoot:GetDungeonItemList(challengeModeId)
	local slotId = KeystoneLootCharDB.selectedSlotId;
	local classId = KeystoneLootCharDB.selectedClassId;
	local specId = KeystoneLootCharDB.selectedSpecId;
	local _itemList = {};

	for _, dungeonInfo in next, self:GetDungeonList() or {} do
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

	for _, dungeonInfo in next, self:GetDungeonList() or {} do
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
	[12] = {
		[2] = { endOfRun = { level = 496, text = 'Champion' }, greatVault = { level = 509, text = 'Hero' } },
		[3] = { endOfRun = { level = 499, text = 'Champion' }, greatVault = { level = 509, text = 'Hero' } },
		[4] = { endOfRun = { level = 499, text = 'Champion' }, greatVault = { level = 512, text = 'Hero' } },
		[5] = { endOfRun = { level = 502, text = 'Champion' }, greatVault = { level = 512, text = 'Hero' } },
		[6] = { endOfRun = { level = 502, text = 'Champion' }, greatVault = { level = 515, text = 'Hero' } },
		[7] = { endOfRun = { level = 506, text = 'Hero' }, greatVault = { level = 515, text = 'Hero' } },
		[8] = { endOfRun = { level = 506, text = 'Hero' }, greatVault = { level = 519, text = 'Myth' } },
		[9] = { endOfRun = { level = 509, text = 'Hero' }, greatVault = { level = 519, text = 'Myth' } },
		[10] = { endOfRun = { level = 509, text = 'Hero' }, greatVault = { level = 522, text = 'Myth' } }
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
	-- [11] = {
	-- 	{ id = 'veteran', text = 'Veteran', entries = {
	-- 		{ itemLevel = 441, bonusId = 9552, text = ITEM_POOR_COLOR_CODE..'441|r | +2' },
	-- 		{ itemLevel = 444, bonusId = 9553, text = ITEM_POOR_COLOR_CODE..'444|r | +3 +4' },
	-- 		{ itemLevel = 447, bonusId = 9554, text = ITEM_POOR_COLOR_CODE..'447|r | +5 +6' },
	-- 		{ itemLevel = 450, bonusId = 9555, text = ITEM_POOR_COLOR_CODE..'450|r | +7 +8' },
	-- 		{ itemLevel = 454, bonusId = 9556, text = ITEM_GOOD_COLOR_CODE..'454|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 457, bonusId = 9557, text = ITEM_GOOD_COLOR_CODE..'457|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 460, bonusId = 9558, text = ITEM_GOOD_COLOR_CODE..'460|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 463, bonusId = 9559, text = ITEM_GOOD_COLOR_CODE..'463|r | '..ITEM_UPGRADE }
	-- 	} },
	-- 	{ id = 'champion', text = 'Champion', entries = {
	-- 		{ itemLevel = 454, bonusId = 9560, text = ITEM_GOOD_COLOR_CODE..'454|r | +9 +10' },
	-- 		{ itemLevel = 457, bonusId = 9561, text = ITEM_GOOD_COLOR_CODE..'457|r | +11 +12' },
	-- 		{ itemLevel = 460, bonusId = 9562, text = ITEM_GOOD_COLOR_CODE..'460|r | +13 +14' },
	-- 		{ itemLevel = 463, bonusId = 9563, text = ITEM_GOOD_COLOR_CODE..'463|r | +15 +16' },
	-- 		{ itemLevel = 467, bonusId = 9564, text = ITEM_SUPERIOR_COLOR_CODE..'467|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 470, bonusId = 9565, text = ITEM_SUPERIOR_COLOR_CODE..'470|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 473, bonusId = 9566, text = ITEM_SUPERIOR_COLOR_CODE..'473|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 476, bonusId = 9567, text = ITEM_SUPERIOR_COLOR_CODE..'476|r | '..ITEM_UPGRADE }
	-- 	} },
	-- 	{ id = 'hero', text = 'Hero', entries = {
	-- 		{ itemLevel = 467, bonusId = 9568, text = ITEM_SUPERIOR_COLOR_CODE..'467|r | +17 +18' },
	-- 		{ itemLevel = 470, bonusId = 9569, text = ITEM_SUPERIOR_COLOR_CODE..'470|r | +19 +20' },
	-- 		{ itemLevel = 473, bonusId = 9570, text = ITEM_SUPERIOR_COLOR_CODE..'473|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 476, bonusId = 9571, text = ITEM_SUPERIOR_COLOR_CODE..'476|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 480, bonusId = 9572, text = ITEM_EPIC_COLOR_CODE..'480|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 483, bonusId = 9581, text = ITEM_EPIC_COLOR_CODE..'483|r | '..ITEM_UPGRADE }
	-- 	} },
	-- 	{ id = 'myth', text = 'Great Vault', entries = {
	-- 		{ itemLevel = 480, bonusId = 9573, text = ITEM_EPIC_COLOR_CODE..'480|r | +18 +19' },
	-- 		{ itemLevel = 483, bonusId = 9574, text = ITEM_EPIC_COLOR_CODE..'483|r | +20' },
	-- 		{ itemLevel = 486, bonusId = 9575, text = ITEM_LEGENDARY_COLOR_CODE..'486|r | '..ITEM_UPGRADE },
	-- 		{ itemLevel = 489, bonusId = 9576, text = ITEM_LEGENDARY_COLOR_CODE..'489|r | '..ITEM_UPGRADE }
	-- 	} }
	-- },
	[12] = {
		{ id = 'champion', text = 'Champion', entries = {
			{ itemLevel = 493, bonusId = 10313, text = ITEM_GOOD_COLOR_CODE..'493|r | +0' },
			{ itemLevel = 496, bonusId = 10314, text = ITEM_GOOD_COLOR_CODE..'496|r | +2' },
			{ itemLevel = 499, bonusId = 10315, text = ITEM_GOOD_COLOR_CODE..'499|r | +3 +4' },
			{ itemLevel = 502, bonusId = 10316, text = ITEM_GOOD_COLOR_CODE..'502|r | +5 +6' },
			{ itemLevel = 506, bonusId = 10317, text = ITEM_SUPERIOR_COLOR_CODE..'506|r | '..ITEM_UPGRADE },
			{ itemLevel = 509, bonusId = 10318, text = ITEM_SUPERIOR_COLOR_CODE..'509|r | '..ITEM_UPGRADE },
			{ itemLevel = 512, bonusId = 10319, text = ITEM_SUPERIOR_COLOR_CODE..'512|r | '..ITEM_UPGRADE },
			{ itemLevel = 515, bonusId = 10320, text = ITEM_SUPERIOR_COLOR_CODE..'515|r | '..ITEM_UPGRADE }
		} },
		{ id = 'hero', text = 'Hero', entries = {
			{ itemLevel = 506, bonusId = 10329, text = ITEM_SUPERIOR_COLOR_CODE..'506|r | +7 +8' },
			{ itemLevel = 509, bonusId = 10330, text = ITEM_SUPERIOR_COLOR_CODE..'509|r | +9 +10' },
			{ itemLevel = 512, bonusId = 10331, text = ITEM_SUPERIOR_COLOR_CODE..'512|r | '..ITEM_UPGRADE },
			{ itemLevel = 515, bonusId = 10332, text = ITEM_SUPERIOR_COLOR_CODE..'515|r | '..ITEM_UPGRADE },
			{ itemLevel = 519, bonusId = 10333, text = ITEM_EPIC_COLOR_CODE..'519|r | '..ITEM_UPGRADE },
			{ itemLevel = 522, bonusId = 10334, text = ITEM_EPIC_COLOR_CODE..'522|r | '..ITEM_UPGRADE }
		} },
		{ id = 'myth', text = 'Great Vault', entries = {
			{ itemLevel = 519, bonusId = 10335, text = ITEM_EPIC_COLOR_CODE..'519|r | +8 +9' },
			{ itemLevel = 522, bonusId = 10336, text = ITEM_EPIC_COLOR_CODE..'522|r | +10' },
			{ itemLevel = 525, bonusId = 10337, text = ITEM_LEGENDARY_COLOR_CODE..'525|r | '..ITEM_UPGRADE },
			{ itemLevel = 528, bonusId = 10338, text = ITEM_LEGENDARY_COLOR_CODE..'528|r | '..ITEM_UPGRADE }
		} }
	}
};

function KeystoneLoot:GetDungeonItemLevels()
	return _itemlevels[self:GetSeasonId()] or {};
end