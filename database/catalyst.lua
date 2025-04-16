local AddonName, KeystoneLoot = ...;

local _items = {
	[14] = {
		[229305] = { classId = 11, icon = 6078433, slotId = 2 },
		[229321] = { classId = 9, icon = 5766968, slotId = 5 },
		[229337] = { classId = 5, icon = 6055037, slotId = 4 },
		[229242] = { classId = 2, icon = 5753671, slotId = 2 },
		[229258] = { classId = 7, icon = 6236790, slotId = 5 },
		[229274] = { classId = 3, icon = 6161323, slotId = 4 },
		[229290] = { classId = 4, icon = 5659976, slotId = 6 },
		[229306] = { classId = 11, icon = 6078431, slotId = 8 },
		[229322] = { classId = 9, icon = 5766966, slotId = 7 },
		[229338] = { classId = 8, icon = 5889418, slotId = 3 },
		[229243] = { classId = 2, icon = 5753670, slotId = 8 },
		[229259] = { classId = 7, icon = 6236791, slotId = 7 },
		[229275] = { classId = 13, icon = 6330308, slotId = 3 },
		[229291] = { classId = 4, icon = 5659972, slotId = 9 },
		[229307] = { classId = 11, icon = 6078430, slotId = 0 },
		[229323] = { classId = 9, icon = 5766974, slotId = 2 },
		[229339] = { classId = 8, icon = 5889417, slotId = 5 },
		[229244] = { classId = 2, icon = 5753669, slotId = 0 },
		[229260] = { classId = 7, icon = 6236797, slotId = 2 },
		[229276] = { classId = 13, icon = 6330307, slotId = 5 },
		[229292] = { classId = 4, icon = 5659975, slotId = 4 },
		[229308] = { classId = 11, icon = 6078429, slotId = 6 },
		[229324] = { classId = 9, icon = 5766972, slotId = 8 },
		[229340] = { classId = 8, icon = 5889415, slotId = 7 },
		[229245] = { classId = 2, icon = 5753668, slotId = 6 },
		[229261] = { classId = 7, icon = 6236796, slotId = 8 },
		[229277] = { classId = 13, icon = 6330304, slotId = 7 },
		[229293] = { classId = 10, icon = 5740524, slotId = 3 },
		[229309] = { classId = 11, icon = 6078426, slotId = 9 },
		[229325] = { classId = 9, icon = 5766971, slotId = 0 },
		[229341] = { classId = 8, icon = 5889423, slotId = 2 },
		[229230] = { classId = 1, icon = 6044630, slotId = 3 },
		[229246] = { classId = 2, icon = 5753664, slotId = 9 },
		[229262] = { classId = 7, icon = 6236795, slotId = 0 },
		[229278] = { classId = 13, icon = 6330315, slotId = 2 },
		[229294] = { classId = 10, icon = 5740523, slotId = 5 },
		[229310] = { classId = 11, icon = 6078432, slotId = 4 },
		[229326] = { classId = 9, icon = 5766970, slotId = 6 },
		[229342] = { classId = 8, icon = 5889421, slotId = 8 },
		[229231] = { classId = 1, icon = 6044629, slotId = 5 },
		[229247] = { classId = 2, icon = 5753667, slotId = 4 },
		[229263] = { classId = 7, icon = 6236794, slotId = 6 },
		[229279] = { classId = 13, icon = 6330314, slotId = 8 },
		[229295] = { classId = 10, icon = 5740521, slotId = 7 },
		[229311] = { classId = 12, icon = 6009144, slotId = 3 },
		[229327] = { classId = 9, icon = 5766967, slotId = 9 },
		[229343] = { classId = 8, icon = 5889420, slotId = 0 },
		[229248] = { classId = 6, icon = 5833840, slotId = 3 },
		[229264] = { classId = 7, icon = 6236789, slotId = 9 },
		[229280] = { classId = 13, icon = 6330313, slotId = 0 },
		[229296] = { classId = 10, icon = 5740529, slotId = 2 },
		[229312] = { classId = 12, icon = 6009143, slotId = 5 },
		[229328] = { classId = 9, icon = 6022396, slotId = 4 },
		[229344] = { classId = 8, icon = 5889419, slotId = 6 },
		[229233] = { classId = 1, icon = 6044639, slotId = 2 },
		[229249] = { classId = 6, icon = 5833839, slotId = 5 },
		[229265] = { classId = 7, icon = 6236793, slotId = 4 },
		[229281] = { classId = 13, icon = 6330311, slotId = 6 },
		[229297] = { classId = 10, icon = 5740528, slotId = 8 },
		[229313] = { classId = 12, icon = 6009141, slotId = 7 },
		[229329] = { classId = 5, icon = 6055036, slotId = 3 },
		[229345] = { classId = 8, icon = 5889416, slotId = 9 },
		[229234] = { classId = 1, icon = 6044636, slotId = 8 },
		[229250] = { classId = 6, icon = 5833837, slotId = 7 },
		[229266] = { classId = 3, icon = 6161322, slotId = 3 },
		[229282] = { classId = 13, icon = 6330305, slotId = 9 },
		[229298] = { classId = 10, icon = 5740527, slotId = 0 },
		[229314] = { classId = 12, icon = 6009140, slotId = 2 },
		[229330] = { classId = 5, icon = 6055035, slotId = 5 },
		[229346] = { classId = 8, icon = 5889422, slotId = 4 },
		[229235] = { classId = 1, icon = 6044635, slotId = 0 },
		[229251] = { classId = 6, icon = 5833861, slotId = 2 },
		[229267] = { classId = 3, icon = 6161321, slotId = 5 },
		[229283] = { classId = 13, icon = 6330309, slotId = 4 },
		[229299] = { classId = 10, icon = 5740526, slotId = 6 },
		[229315] = { classId = 12, icon = 6009148, slotId = 8 },
		[229331] = { classId = 5, icon = 6055033, slotId = 7 },
		[229236] = { classId = 1, icon = 6044633, slotId = 6 },
		[229252] = { classId = 6, icon = 5833860, slotId = 8 },
		[229268] = { classId = 3, icon = 6161319, slotId = 7 },
		[229284] = { classId = 4, icon = 5659974, slotId = 3 },
		[229300] = { classId = 10, icon = 5740522, slotId = 9 },
		[229316] = { classId = 12, icon = 6009147, slotId = 0 },
		[229332] = { classId = 5, icon = 6055041, slotId = 2 },
		[229237] = { classId = 1, icon = 6044627, slotId = 9 },
		[229253] = { classId = 6, icon = 5833847, slotId = 0 },
		[229269] = { classId = 3, icon = 6161327, slotId = 2 },
		[229285] = { classId = 4, icon = 5659973, slotId = 5 },
		[229301] = { classId = 10, icon = 5740525, slotId = 4 },
		[229317] = { classId = 12, icon = 6009146, slotId = 6 },
		[229333] = { classId = 5, icon = 6055040, slotId = 8 },
		[229238] = { classId = 1, icon = 6044632, slotId = 4 },
		[229254] = { classId = 6, icon = 5833846, slotId = 6 },
		[229270] = { classId = 3, icon = 6161326, slotId = 8 },
		[229286] = { classId = 4, icon = 5659971, slotId = 7 },
		[229302] = { classId = 11, icon = 6078428, slotId = 3 },
		[229318] = { classId = 12, icon = 6009142, slotId = 9 },
		[229334] = { classId = 5, icon = 6055039, slotId = 0 },
		[229239] = { classId = 2, icon = 5753666, slotId = 3 },
		[229255] = { classId = 6, icon = 5833838, slotId = 9 },
		[229271] = { classId = 3, icon = 6161325, slotId = 0 },
		[229287] = { classId = 4, icon = 5659979, slotId = 2 },
		[229303] = { classId = 11, icon = 6078427, slotId = 5 },
		[229319] = { classId = 12, icon = 6009145, slotId = 4 },
		[229335] = { classId = 5, icon = 6055038, slotId = 6 },
		[229240] = { classId = 2, icon = 5753665, slotId = 5 },
		[229256] = { classId = 6, icon = 5833841, slotId = 4 },
		[229272] = { classId = 3, icon = 6161324, slotId = 6 },
		[229288] = { classId = 4, icon = 5659978, slotId = 8 },
		[229304] = { classId = 11, icon = 6078425, slotId = 7 },
		[229320] = { classId = 9, icon = 5766969, slotId = 3 },
		[229336] = { classId = 5, icon = 6055034, slotId = 9 },
		[229241] = { classId = 2, icon = 5753663, slotId = 7 },
		[229257] = { classId = 7, icon = 6236792, slotId = 3 },
		[229273] = { classId = 3, icon = 6161320, slotId = 9 },
		[229289] = { classId = 4, icon = 5659977, slotId = 0 },
	}
};

function KeystoneLoot:GetCatalystItems()
	return _items[KeystoneLoot:GetSeasonId()] or {};
end

function KeystoneLoot:GetCatalystItemList()
	local classId = KeystoneLootCharDB.selectedClassId;
	local slotId = KeystoneLootCharDB.selectedSlotId;
	local _itemList = {};

	for itemId, itemInfo in next, self:GetCatalystItems() do
		if (itemInfo.classId == classId and itemInfo.slotId == slotId) then
			table.insert(_itemList, {
				itemId = itemId,
				icon = itemInfo.icon
			});
		end
	end

	return _itemList;
end
