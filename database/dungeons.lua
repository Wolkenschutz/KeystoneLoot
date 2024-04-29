local AddonName, KeystoneLoot = ...;

local _dungeonList = {
	-- [11] = {
	-- 	{ --[[name = "Der Immergrüne Flor",]] challengeModeId = 168, teleportSpellId = 159901, bgTexture = 1060547, lootTable = { 109807, 119173, 119175, 109939, 109848, 119181, 110009, 109984, 109986, 110019, 109866, 119176, 109841, 119174, 109876, 109824, 110004, 109948, 109886, 109979, 109795, 110014, 109937, 109815, 109999 } },
	-- 	{ --[[name = "Das Finsterherzdickicht",]] challengeModeId = 198, teleportSpellId = 424163, bgTexture = 1411855, lootTable = { 137301, 137305, 137309, 134461, 211473, 137306, 134520, 134462, 137322, 137319, 137311, 137315, 134405, 134429, 134423, 137300, 137304, 134487, 137312, 134464, 137320, 134531, 137310 } },
	-- 	{ --[[name = "Die Rabenwehr",]] challengeModeId = 199, teleportSpellId = 424153, bgTexture = 1411853, lootTable = { 136716, 134519, 136724, 136976, 134419, 134431, 211470, 139244, 211513, 136714, 139240, 134490, 134426, 136978, 139245, 134451, 139242, 136715, 134440, 134528, 134483, 134499, 139246, 136977 } },
	-- 	{ --[[name = "Atal'Dazar",]] challengeModeId = 244, teleportSpellId = 424187, bgTexture = 1778892, lootTable = { 158319, 160214, 211403, 158308, 159610, 160269, 158320, 158323, 158321, 211404, 155861, 158712, 158375, 155868, 160212, 158348, 159445, 211405, 158306, 158713, 211401, 155869, 158322, 211402, 159632, 158303, 158711, 159458, 158309 } },
	-- 	{ --[[name = "Das Kronsteiganwesen",]] challengeModeId = 248, teleportSpellId = 424167, bgTexture = 2178278, lootTable = { 159404, 159660, 158362, 159397, 159669, 159133, 159347, 159630, 162548, 159452, 159456, 159285, 159340, 159282, 159262, 159631, 159294, 159662, 159457, 159616, 159403, 159345, 159659, 159661, 159450, 159341, 159272, 159399 } },
	-- 	{ --[[name = "Thron der Gezeiten",]] challengeModeId = 456, teleportSpellId = 424142, bgTexture = 522362, lootTable = { 133360, 133368, 133186, 133190, 133198, 133202, 133179, 133187, 133191, 133195, 133358, 133180, 133184, 133192, 133196, 133200, 133359, 133367, 133185, 133189, 133182, 133197, 133201, 133181 } },
	-- 	{ --[[name = "Dämmerung des Ewigen: Galakronds Sturz",]] challengeModeId = 463, teleportSpellId = 424197, bgTexture = 5221768, lootTable = { 207923, 207528, 207912, 207920, 207897, 207991, 207983, 207996, 207851, 207828, 207921, 207898, 207836, 207995, 207999, 207817, 207819, 208321, 207820, 207838, 207992, 207903, 207566, 207911, 207858 } },
	-- 	{ --[[name = "Dämmerung des Ewigen: Murozonds Erhebung",]] challengeModeId = 464, teleportSpellId = 424197, bgTexture = 5221768, lootTable = { 207884, 207950, 207927, 207873, 207939, 207978, 207951, 207552, 207928, 207994, 207936, 207878, 207824, 207579, 207987, 207867, 207997, 208216, 207862, 208193, 208000, 207581, 208391, 207874, 207986, 207876, 207946, 207945 } }
	-- },
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


local _itemlevels = {
	[11] = {
		{ id = 'veteran', text = 'Veteran', entries = {
			{ itemLevel = 441, bonusId = 9552, text = ITEM_POOR_COLOR_CODE..'441|r | +2' },
			{ itemLevel = 444, bonusId = 9553, text = ITEM_POOR_COLOR_CODE..'444|r | +3 +4' },
			{ itemLevel = 447, bonusId = 9554, text = ITEM_POOR_COLOR_CODE..'447|r | +5 +6' },
			{ itemLevel = 450, bonusId = 9555, text = ITEM_POOR_COLOR_CODE..'450|r | +7 +8' },
			{ itemLevel = 454, bonusId = 9556, text = ITEM_GOOD_COLOR_CODE..'454|r | '..ITEM_UPGRADE },
			{ itemLevel = 457, bonusId = 9557, text = ITEM_GOOD_COLOR_CODE..'457|r | '..ITEM_UPGRADE },
			{ itemLevel = 460, bonusId = 9558, text = ITEM_GOOD_COLOR_CODE..'460|r | '..ITEM_UPGRADE },
			{ itemLevel = 463, bonusId = 9559, text = ITEM_GOOD_COLOR_CODE..'463|r | '..ITEM_UPGRADE }
		} },
		{ id = 'champion', text = 'Champion', entries = {
			{ itemLevel = 454, bonusId = 9560, text = ITEM_GOOD_COLOR_CODE..'454|r | +9 +10' },
			{ itemLevel = 457, bonusId = 9561, text = ITEM_GOOD_COLOR_CODE..'457|r | +11 +12' },
			{ itemLevel = 460, bonusId = 9562, text = ITEM_GOOD_COLOR_CODE..'460|r | +13 +14' },
			{ itemLevel = 463, bonusId = 9563, text = ITEM_GOOD_COLOR_CODE..'463|r | +15 +16' },
			{ itemLevel = 467, bonusId = 9564, text = ITEM_SUPERIOR_COLOR_CODE..'467|r | '..ITEM_UPGRADE },
			{ itemLevel = 470, bonusId = 9565, text = ITEM_SUPERIOR_COLOR_CODE..'470|r | '..ITEM_UPGRADE },
			{ itemLevel = 473, bonusId = 9566, text = ITEM_SUPERIOR_COLOR_CODE..'473|r | '..ITEM_UPGRADE },
			{ itemLevel = 476, bonusId = 9567, text = ITEM_SUPERIOR_COLOR_CODE..'476|r | '..ITEM_UPGRADE }
		} },
		{ id = 'hero', text = 'Hero', entries = {
			{ itemLevel = 467, bonusId = 9568, text = ITEM_SUPERIOR_COLOR_CODE..'467|r | +17 +18' },
			{ itemLevel = 470, bonusId = 9569, text = ITEM_SUPERIOR_COLOR_CODE..'470|r | +19 +20' },
			{ itemLevel = 473, bonusId = 9570, text = ITEM_SUPERIOR_COLOR_CODE..'473|r | '..ITEM_UPGRADE },
			{ itemLevel = 476, bonusId = 9571, text = ITEM_SUPERIOR_COLOR_CODE..'476|r | '..ITEM_UPGRADE },
			{ itemLevel = 480, bonusId = 9572, text = ITEM_EPIC_COLOR_CODE..'480|r | '..ITEM_UPGRADE },
			{ itemLevel = 483, bonusId = 9581, text = ITEM_EPIC_COLOR_CODE..'483|r | '..ITEM_UPGRADE }
		} },
		{ id = 'myth', text = 'Great Vault', entries = {
			{ itemLevel = 480, bonusId = 9573, text = ITEM_EPIC_COLOR_CODE..'480|r | +18 +19' },
			{ itemLevel = 483, bonusId = 9574, text = ITEM_EPIC_COLOR_CODE..'483|r | +20' },
			{ itemLevel = 486, bonusId = 9575, text = ITEM_LEGENDARY_COLOR_CODE..'486|r | '..ITEM_UPGRADE },
			{ itemLevel = 489, bonusId = 9576, text = ITEM_LEGENDARY_COLOR_CODE..'489|r | '..ITEM_UPGRADE }
		} }
	},
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