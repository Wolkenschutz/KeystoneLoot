local AddonName, KeystoneLoot = ...;

local _raidList = {
	[12] = {
		{ --[[name = "Gewölbe der Inkarnationen",]] journalInstanceId = 1200, instanceId = 2522, bossList = {
			{ --[[name = "Eranog",]] npcId = 184972, bossId = 2480, bossTexture = 105614, lootTable = { [14] = { 195476, 195478, 195480, 195482, 194299, 195475, 195477, 195479, 195490 }, [16] = { 195476, 195478, 195480, 195482, 194299, 195475, 195477, 195479, 195490 }, [17] = { 195476, 195478, 195480, 195482, 194299, 195475, 195477, 195479, 195490 }, [15] = { 195476, 195478, 195480, 195482, 194299, 195475, 195477, 195479, 195490 } } },
			{ --[[name = "Terros",]] npcId = 190496, bossId = 2500, bossTexture = 106344, lootTable = { [14] = { 195502, 195504, 195497, 195499, 195501, 195503, 195498, 195500, 194303 }, [16] = { 195502, 195504, 195497, 195499, 195501, 195503, 195498, 195500, 194303 }, [17] = { 195502, 195504, 195497, 195499, 195501, 195503, 195498, 195500, 194303 }, [15] = { 195502, 195504, 195497, 195499, 195501, 195503, 195498, 195500, 194303 } } },
			{ --[[name = "Der Primalistenrat",]] npcId = 187771, bossId = 2486, bossTexture = 107599, lootTable = { [14] = { 195487, 195489, 195484, 195486, 195518, 194301, 195485, 194300, 195488 }, [16] = { 195487, 195489, 195484, 195486, 195518, 194301, 195485, 194300, 195488 }, [17] = { 195487, 195489, 195484, 195486, 195518, 194301, 195485, 194300, 195488 }, [15] = { 195487, 195489, 195484, 195486, 195518, 194301, 195485, 194300, 195488 } } },
			{ --[[name = "Sennarth, der kalte Atem",]] npcId = 187967, bossId = 2482, bossTexture = 106348, lootTable = { [14] = { 194304, 195506, 195510, 217328, 195508, 217329, 195505, 195507, 195509, 195511, 217331, 217330 }, [16] = { 194304, 195506, 195510, 217328, 195508, 217329, 195505, 195507, 195509, 195511, 217331, 217330 }, [17] = { 194304, 195506, 195510, 217328, 195508, 217329, 195505, 195507, 195509, 195511, 217331, 217330 }, [15] = { 194304, 195506, 195510, 217328, 195508, 217329, 195505, 195507, 195509, 195511, 217331, 217330 } } },
			{ --[[name = "Dathea, die Aufgestiegene",]] npcId = 189813, bossId = 2502, bossTexture = 107813, lootTable = { [14] = { 194302, 195491, 195493, 195495, 217322, 217320, 195492, 217321, 195494, 195496, 217323, 195481 }, [16] = { 194302, 195491, 195493, 195495, 217322, 217320, 195492, 217321, 195494, 195496, 217323, 195481 }, [17] = { 194302, 195491, 195493, 195495, 217322, 217320, 195492, 217321, 195494, 195496, 217323, 195481 }, [15] = { 194302, 195491, 195493, 195495, 217322, 217320, 195492, 217321, 195494, 195496, 217323, 195481 } } },
			{ --[[name = "Kurog Grimmtotem",]] npcId = 181378, bossId = 2491, bossTexture = 106792, lootTable = { [14] = { 195515, 217316, 195512, 217317, 195513, 195517, 217318, 195483, 217319, 194306, 195514, 195516, 194305 }, [16] = { 195515, 217316, 195512, 217317, 195513, 195517, 217318, 195483, 217319, 194306, 195514, 195516, 194305 }, [17] = { 195515, 217316, 195512, 217317, 195513, 195517, 217318, 195483, 217319, 194306, 195514, 195516, 194305 }, [15] = { 195515, 217316, 195512, 217317, 195513, 195517, 217318, 195483, 217319, 194306, 195514, 195516, 194305 } } },
			{ --[[name = "Bruthüterin Diurna",]] npcId = 190245, bossId = 2493, bossTexture = 106243, lootTable = { [14] = { 195523, 217332, 194307, 195520, 195524, 217333, 194308, 195521, 195525, 217334, 195522, 195526, 195519, 217335 }, [16] = { 195523, 217332, 194307, 195520, 195524, 217333, 194308, 195521, 195525, 217334, 195522, 195526, 195519, 217335 }, [17] = { 195523, 217332, 194307, 195520, 195524, 217333, 194308, 195521, 195525, 217334, 195522, 195526, 195519, 217335 }, [15] = { 195523, 217332, 194307, 195520, 195524, 217333, 194308, 195521, 195525, 217334, 195522, 195526, 195519, 217335 } } },
			{ --[[name = "Raszageth die Sturmfresserin",]] npcId = 189492, bossId = 2499, bossTexture = 103255, lootTable = { [14] = { 194310, 195527, 195531, 195528, 217325, 195529, 195533, 194309, 217408, 195530, 217327, 217324, 195532, 217326 }, [16] = { 194310, 195527, 195531, 195528, 217325, 195529, 195533, 194309, 217408, 195530, 217327, 217324, 195532, 217326 }, [17] = { 194310, 195527, 195531, 195528, 217325, 195529, 195533, 194309, 217408, 195530, 217327, 217324, 195532, 217326 }, [15] = { 194310, 195527, 195531, 195528, 217325, 195529, 195533, 194309, 217408, 195530, 217327, 217324, 195532, 217326 } } }
		} },
		{ --[[name = "Aberrus, Schmelztiegel der Schatten",]] journalInstanceId = 1208, instanceId = 2569, bossList = {
			{ --[[name = "Kazzara, die Höllengeschmiedete",]] npcId = 201261, bossId = 2522, bossTexture = 111505, lootTable = { [14] = { 202612, 202616, 202573, 202590, 202594, 202583, 202600, 202602, 202559, 202576, 202589, 202557 }, [16] = { 202612, 202616, 202573, 202590, 202594, 202583, 202600, 202602, 202559, 202576, 202589, 202557 }, [17] = { 202612, 202616, 202573, 202590, 202594, 202583, 202600, 202602, 202559, 202576, 202589, 202557 }, [15] = { 202612, 202616, 202573, 202590, 202594, 202583, 202600, 202602, 202559, 202576, 202589, 202557 } } },
			{ --[[name = "Die Verschmelzungskammer",]] npcId = { 201774, 201773}, bossId = 2529, bossTexture = 111850, lootTable = { [14] = { 202605, 202593, 202579, 202568, 202615, 202572, 202596, 202617, 202563, 202595, 202598 }, [16] = { 202605, 202593, 202579, 202568, 202615, 202572, 202596, 202617, 202563, 202595, 202598 }, [17] = { 202605, 202593, 202579, 202568, 202615, 202572, 202596, 202617, 202563, 202595, 202598 }, [15] = { 202605, 202593, 202579, 202568, 202615, 202572, 202596, 202617, 202563, 202595, 202598 } } },
			{ --[[name = "Die vergessenen Experimente",]] npcId = 200912, bossId = 2530, bossTexture = 111623, lootTable = { [14] = { 202588, 217321, 217322, 202566, 202582, 203729, 217320, 202652, 217323, 202571, 202575, 204318 }, [16] = { 202588, 217321, 217322, 202566, 202582, 203729, 217320, 202652, 217323, 202571, 202575, 204318 }, [17] = { 202588, 217321, 217322, 202566, 202582, 203729, 217320, 202652, 217323, 202571, 202575, 204318 }, [15] = { 202588, 217321, 217322, 202566, 202582, 203729, 217320, 202652, 217323, 202571, 202575, 204318 } } },
			{ --[[name = "Angriff der Zaqali",]] npcId = 199659, bossId = 2524, bossTexture = 111276, lootTable = { [14] = { 202597, 204279, 202618, 202607, 202613, 202574, 202586, 202604, 202591, 202578, 202580, 202577 }, [16] = { 202597, 204279, 202618, 202607, 202613, 202574, 202586, 202604, 202591, 202578, 202580, 202577 }, [17] = { 202597, 204279, 202618, 202607, 202613, 202574, 202586, 202604, 202591, 202578, 202580, 202577 }, [15] = { 202597, 204279, 202618, 202607, 202613, 202574, 202586, 202604, 202591, 202578, 202580, 202577 } } },
			{ --[[name = "Ältester Rashok",]] npcId = 201320, bossId = 2525, bossTexture = 112109, lootTable = { [14] = { 204319, 217328, 202592, 202569, 217329, 202655, 202659, 202614, 217331, 202603, 204466, 217330 }, [16] = { 204319, 217328, 202592, 202569, 217329, 202655, 202659, 202614, 217331, 202603, 204466, 217330 }, [17] = { 204319, 217328, 202592, 202569, 217329, 202655, 202659, 202614, 217331, 202603, 204466, 217330 }, [15] = { 204319, 217328, 202592, 202569, 217329, 202655, 202659, 202614, 217331, 202603, 204466, 217330 } } },
			{ --[[name = "Der aufmerksame Verwalter, Zskarn",]] npcId = 202637, bossId = 2532, bossTexture = 111477, lootTable = { [14] = { 217316, 204393, 204467, 204320, 217317, 204391, 202555, 217319, 204322, 217318, 202610, 204400 }, [16] = { 217316, 204393, 204467, 204320, 217317, 204391, 202555, 217319, 204322, 217318, 202610, 204400 }, [17] = { 217316, 204393, 204467, 204320, 217317, 204391, 202555, 217319, 204322, 217318, 202610, 204400 }, [15] = { 217316, 204393, 204467, 204320, 217317, 204391, 202555, 217319, 204322, 217318, 202610, 204400 } } },
			{ --[[name = "Magmorax",]] npcId = 201579, bossId = 2527, bossTexture = 111628, lootTable = { [14] = { 217327, 203996, 217324, 204394, 217326, 202560, 217325, 204396, 202570, 204395, 204397 }, [16] = { 217327, 203996, 217324, 204394, 217326, 202560, 217325, 204396, 202570, 204395, 204397 }, [17] = { 217327, 203996, 217324, 204394, 217326, 202560, 217325, 204396, 202570, 204395, 204397 }, [15] = { 217327, 203996, 217324, 204394, 217326, 202560, 217325, 204396, 202570, 204395, 204397 } } },
			{ --[[name = "Echo von Neltharion",]] npcId = 201668, bossId = 2523, bossTexture = 111794, lootTable = { [14] = { 204211, 217332, 204324, 204398, 217333, 204201, 202601, 217334, 204202, 204392, 203714, 202558, 202606, 217335 }, [16] = { 204211, 217332, 204324, 204398, 217333, 204201, 202601, 217334, 204202, 204392, 203714, 202558, 202606, 217335 }, [17] = { 204211, 217332, 204324, 204398, 217333, 204201, 202601, 217334, 204202, 204392, 203714, 202558, 202606, 217335 }, [15] = { 204211, 217332, 204324, 204398, 217333, 204201, 202601, 217334, 204202, 204392, 203714, 202558, 202606, 217335 } } },
			{ --[[name = "Schuppenkommandant Sarkareth",]] npcId = 201754, bossId = 2520, bossTexture = 111664, lootTable = { [14] = { 204177, 202599, 217408, 204390, 202584, 204424, 203963, 202585, 202587, 202564, 204399, 204465, 202565, 206955 }, [16] = { 204177, 202599, 217408, 204390, 204465, 204424, 203963, 202585, 202587, 202564, 205876, 204399, 202565, 202584 }, [17] = { 204177, 202599, 217408, 204390, 202584, 204424, 203963, 202585, 202587, 202564, 204399, 204465, 202565, 206955 }, [15] = { 204177, 202599, 217408, 204390, 202584, 204424, 203963, 202585, 202587, 202564, 204399, 204465, 202565, 206955 } } }
		} },
		{ --[[name = "Amirdrassil, Hoffnung des Traums",]] journalInstanceId = 1207, instanceId = 2549, bossList = {
			{ --[[name = "Knorrenwurzel",]] npcId = 209333, bossId = 2564, bossTexture = 113866, lootTable = { [14] = { 207142, 207144, 207133, 207120, 207797, 207169, 207126, 207160, 207117, 207794, 207153, 207800 }, [16] = { 207142, 207144, 207133, 207120, 207797, 207169, 207126, 207160, 207117, 207794, 207153, 207800 }, [17] = { 207142, 207144, 207133, 207120, 207797, 207169, 207126, 207160, 207117, 207794, 207153, 207800 }, [15] = { 207142, 207144, 207133, 207120, 207797, 207169, 207126, 207160, 207117, 207794, 207153, 207800 } } },
			{ --[[name = "Igira die Grausame",]] npcId = 200926, bossId = 2554, bossTexture = 112382, lootTable = { [14] = { 207140, 217320, 207118, 217321, 207165, 207150, 217322, 207162, 217323, 207783, 207787, 207131 }, [16] = { 207140, 217320, 207118, 217321, 207165, 207150, 217322, 207162, 217323, 207783, 207787, 207131 }, [17] = { 207140, 217320, 207118, 217321, 207165, 207150, 217322, 207162, 217323, 207783, 207787, 207131 }, [15] = { 207140, 217320, 207118, 217321, 207165, 207150, 217322, 207162, 217323, 207783, 207787, 207131 } } },
			{ --[[name = "Volcoross",]] npcId = 208478, bossId = 2557, bossTexture = 113942, lootTable = { [14] = { 207789, 207146, 207148, 207152, 210214, 207141, 207128, 207175, 207121, 207122, 207785, 207130 }, [16] = { 207789, 207146, 207148, 207152, 210214, 207141, 207128, 207175, 207121, 207122, 207785, 207130 }, [17] = { 207789, 207146, 207148, 207152, 210214, 207141, 207128, 207175, 207121, 207122, 207785, 207130 }, [15] = { 207789, 207146, 207148, 207152, 210214, 207141, 207128, 207175, 207121, 207122, 207785, 207130 } } },
			{ --[[name = "Larodar, Bewahrer der Flamme",]] npcId = 208445, bossId = 2553, bossTexture = 113588, lootTable = { [14] = { 209035, 207129, 207792, 207149, 217329, 217330, 207170, 207143, 207116, 217328, 207159, 217331, 207790 }, [16] = { 209035, 207129, 207792, 207149, 217329, 217330, 207170, 207143, 207116, 217328, 207159, 217331, 207790 }, [17] = { 209035, 207129, 207792, 207149, 217329, 217330, 207170, 207143, 207116, 217328, 207159, 217331, 207790 }, [15] = { 209035, 207129, 207792, 207149, 217329, 217330, 207170, 207143, 207116, 217328, 207159, 217331, 207790 } } },
			{ --[[name = "Rat der Träume",]] npcId = { 208363, 208365, 213390 }, bossId = 2555, bossTexture = 114021, lootTable = { [14] = { 207127, 210206, 207782, 207796, 207173, 210205, 207784, 207119, 207151, 207138, 207168, 207139 }, [16] = { 207127, 210206, 207782, 207796, 207173, 210205, 207784, 207119, 207151, 207138, 207168, 207139 }, [17] = { 207127, 210206, 207782, 207796, 207173, 210205, 207784, 207119, 207151, 207138, 207168, 207139 }, [15] = { 207127, 210206, 207782, 207796, 207173, 210205, 207784, 207119, 207151, 207138, 207168, 207139 } } },
			{ --[[name = "Nymue, Weberin des Kreises",]] npcId = 206172, bossId = 2556, bossTexture = 112829, lootTable = { [14] = { 217316, 217317, 210203, 217318, 208615, 207135, 208445, 207798, 217319, 207155, 208616, 207123 }, [16] = { 217316, 217317, 210203, 217318, 208615, 207135, 208445, 207798, 217319, 207155, 208616, 207123 }, [17] = { 217316, 217317, 210203, 217318, 208615, 207135, 208445, 207798, 217319, 207155, 208616, 207123 }, [15] = { 217316, 217317, 210203, 217318, 208615, 207135, 208445, 207798, 217319, 207155, 208616, 207123 } } },
			{ --[[name = "Glimmeron",]] npcId = 200927, bossId = 2563, bossTexture = 113988, lootTable = { [14] = { 210204, 207161, 217333, 217335, 207167, 207799, 207156, 207791, 217332, 217334, 207166 }, [16] = { 210204, 207161, 217333, 217335, 207167, 207799, 207156, 207791, 217332, 217334, 207166 }, [17] = { 210204, 207161, 217333, 217335, 207167, 207799, 207156, 207791, 217332, 217334, 207166 }, [15] = { 210204, 207161, 217333, 217335, 207167, 207799, 207156, 207791, 217332, 217334, 207166 } } },
			{ --[[name = "Tindral Raschweise, Seher der Flamme",]] npcId = 209090, bossId = 2565, bossTexture = 114456, lootTable = { [14] = { 207795, 217324, 207780, 207137, 207157, 207781, 207134, 217326, 207163, 207172, 217327, 217325 }, [16] = { 207795, 217324, 207780, 207137, 207157, 207781, 207134, 217326, 207163, 207172, 217327, 217325 }, [17] = { 207795, 217324, 207780, 207137, 207157, 207781, 207134, 217326, 207163, 207172, 217327, 217325 }, [15] = { 207795, 217324, 207780, 207137, 207157, 207781, 207134, 217326, 207163, 207172, 217327, 217325 } } },
			{ --[[name = "Fyrakk der Lodernde",]] npcId = 204931, bossId = 2519, bossTexture = 111452, lootTable = { [14] = { 206448, 207174, 210536, 217408, 207154, 207786, 207788, 207145, 207132, 207124, 207115, 207793, 207171, 208614 }, [16] = { 206448, 208614, 210536, 217408, 207124, 207154, 207786, 207788, 207145, 207132, 207115, 210061, 207793, 207171, 207174 }, [17] = { 206448, 207174, 210536, 217408, 207154, 207786, 207788, 207145, 207132, 207124, 207115, 207793, 207171, 208614 }, [15] = { 206448, 207174, 210536, 217408, 207154, 207786, 207788, 207145, 207132, 207124, 207115, 207793, 207171, 208614 } } }
		} }
	}
};

function KeystoneLoot:GetRaidList()
	local raidList = _raidList[self:GetSeasonId()];

	if (raidList) then
		return raidList;
	end
end

function KeystoneLoot:GetRaidBossItemList(bossId)
	local slotId = KeystoneLootCharDB.selectedSlotId;
	local classId = KeystoneLootCharDB.selectedClassId;
	local specId = KeystoneLootCharDB.selectedSpecId;
	local difficultyId = KeystoneLoot:GetRaidDifficultyId();
	local _itemList = {};

	for _, raidInfo in next, self:GetRaidList() or {} do
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

	for _, raidInfo in next, self:GetRaidList() or {} do
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
	[12] = {
		{ id = 'veteran', text = 'Raid Finder', difficultyId = DifficultyUtil.ID.PrimaryRaidLFR, entries = {
			{ itemLevel = 480, bonusId = 10305, text = ITEM_POOR_COLOR_CODE..'480|r | '..BOSS..' 1-4' },
			{ itemLevel = 483, bonusId = 10306, text = ITEM_POOR_COLOR_CODE..'483|r | '..ITEM_UPGRADE },
			{ itemLevel = 486, bonusId = 10307, text = ITEM_POOR_COLOR_CODE..'486|r | '..BOSS..' 5-6' },
			{ itemLevel = 489, bonusId = 10308, text = ITEM_POOR_COLOR_CODE..'489|r | '..BOSS..' 7-8' },
			{ itemLevel = 493, bonusId = 10309, text = ITEM_GOOD_COLOR_CODE..'493|r | '..ITEM_UPGRADE },
			{ itemLevel = 496, bonusId = 10310, text = ITEM_GOOD_COLOR_CODE..'496|r | '..ITEM_UPGRADE },
			{ itemLevel = 499, bonusId = 10311, text = ITEM_GOOD_COLOR_CODE..'499|r | '..ITEM_UPGRADE },
			{ itemLevel = 502, bonusId = 10312, text = ITEM_GOOD_COLOR_CODE..'502|r | '..ITEM_UPGRADE }
		} },
		{ id = 'champion', text = 'Normal', difficultyId = DifficultyUtil.ID.PrimaryRaidNormal, entries = {
			{ itemLevel = 493, bonusId = 10313, text = ITEM_GOOD_COLOR_CODE..'493|r | '..BOSS..' 1-4' },
			{ itemLevel = 496, bonusId = 10314, text = ITEM_GOOD_COLOR_CODE..'496|r | '..ITEM_UPGRADE },
			{ itemLevel = 499, bonusId = 10315, text = ITEM_GOOD_COLOR_CODE..'499|r | '..BOSS..' 5-6' },
			{ itemLevel = 502, bonusId = 10316, text = ITEM_GOOD_COLOR_CODE..'502|r | '..BOSS..' 7-8' },
			{ itemLevel = 506, bonusId = 10317, text = ITEM_SUPERIOR_COLOR_CODE..'506|r | '..ITEM_UPGRADE },
			{ itemLevel = 509, bonusId = 10318, text = ITEM_SUPERIOR_COLOR_CODE..'509|r | '..ITEM_UPGRADE },
			{ itemLevel = 512, bonusId = 10319, text = ITEM_SUPERIOR_COLOR_CODE..'512|r | '..ITEM_UPGRADE },
			{ itemLevel = 515, bonusId = 10320, text = ITEM_SUPERIOR_COLOR_CODE..'515|r | '..ITEM_UPGRADE }
		} },
		{ id = 'hero', text = 'Heroic', difficultyId = DifficultyUtil.ID.PrimaryRaidHeroic, entries = {
			{ itemLevel = 506, bonusId = 10329, text = ITEM_SUPERIOR_COLOR_CODE..'506|r | '..BOSS..' 1-4' },
			{ itemLevel = 509, bonusId = 10330, text = ITEM_SUPERIOR_COLOR_CODE..'509|r | '..ITEM_UPGRADE },
			{ itemLevel = 512, bonusId = 10331, text = ITEM_SUPERIOR_COLOR_CODE..'512|r | '..BOSS..' 5-7' },
			{ itemLevel = 515, bonusId = 10332, text = ITEM_SUPERIOR_COLOR_CODE..'515|r | '..BOSS..' 7-8' },
			{ itemLevel = 519, bonusId = 10333, text = ITEM_EPIC_COLOR_CODE..'519|r | '..ITEM_UPGRADE },
			{ itemLevel = 522, bonusId = 10334, text = ITEM_EPIC_COLOR_CODE..'522|r | '..ITEM_UPGRADE }
		} },
		{ id = 'myth', text = 'Mythic', difficultyId = DifficultyUtil.ID.PrimaryRaidMythic, entries = {
			{ itemLevel = 519, bonusId = 10335, text = ITEM_EPIC_COLOR_CODE..'519|r | '..BOSS..' 1-4' },
			{ itemLevel = 522, bonusId = 10336, text = ITEM_EPIC_COLOR_CODE..'522|r | '..ITEM_UPGRADE },
			{ itemLevel = 525, bonusId = 10337, text = ITEM_LEGENDARY_COLOR_CODE..'525|r | '..BOSS..' 5-7' },
			{ itemLevel = 528, bonusId = 10338, text = ITEM_LEGENDARY_COLOR_CODE..'528|r | '..BOSS..' 7-8' }
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
	for _, raidInfo in next, self:GetRaidList() or {} do
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