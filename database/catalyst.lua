local AddonName, KeystoneLoot = ...;

local _items = {
	[12] = {
		[217240] = { classId = 7, icon = 4952862, slotId = 2 },
		[200367] = { classId = 10, icon = 4510277, slotId = 5 },
		[202445] = { classId = 1, icon = 5077275, slotId = 9 },
		[207287] = { classId = 8, icon = 5167087, slotId = 7 },
		[217209] = { classId = 4, icon = 4896761, slotId = 8 },
		[217225] = { classId = 6, icon = 5343240, slotId = 2 },
		[200366] = { classId = 10, icon = 4510269, slotId = 7 },
		[217178] = { classId = 13, icon = 4567907, slotId = 0 },
		[217194] = { classId = 11, icon = 4962626, slotId = 8 },
		[217210] = { classId = 4, icon = 4896762, slotId = 2 },
		[202494] = { classId = 4, icon = 4896754, slotId = 7 },
		[202510] = { classId = 11, icon = 4962009, slotId = 3 },
		[217179] = { classId = 13, icon = 4567908, slotId = 8 },
		[217195] = { classId = 11, icon = 4962804, slotId = 2 },
		[217211] = { classId = 9, icon = 4876759, slotId = 6 },
		[217227] = { classId = 12, icon = 5153467, slotId = 6 },
		[202511] = { classId = 11, icon = 4956907, slotId = 5 },
		[200384] = { classId = 13, icon = 4567901, slotId = 7 },
		[207258] = { classId = 12, icon = 5153465, slotId = 3 },
		[217180] = { classId = 13, icon = 4567909, slotId = 2 },
		[217196] = { classId = 2, icon = 4869737, slotId = 4 },
		[217212] = { classId = 9, icon = 4876760, slotId = 0 },
		[217228] = { classId = 12, icon = 5153468, slotId = 0 },
		[202512] = { classId = 11, icon = 4956905, slotId = 7 },
		[202528] = { classId = 9, icon = 4876757, slotId = 3 },
		[202544] = { classId = 5, icon = 5007824, slotId = 9 },
		[207259] = { classId = 12, icon = 5153464, slotId = 5 },
		[202449] = { classId = 2, icon = 4869733, slotId = 7 },
		[217197] = { classId = 2, icon = 4869738, slotId = 6 },
		[217213] = { classId = 9, icon = 4876761, slotId = 8 },
		[217229] = { classId = 12, icon = 5153469, slotId = 8 },
		[202529] = { classId = 9, icon = 4876756, slotId = 5 },
		[207260] = { classId = 12, icon = 5153462, slotId = 7 },
		[217182] = { classId = 3, icon = 4522318, slotId = 6 },
		[217198] = { classId = 2, icon = 4869739, slotId = 0 },
		[217214] = { classId = 9, icon = 4876762, slotId = 2 },
		[217230] = { classId = 12, icon = 5153470, slotId = 2 },
		[217177] = { classId = 13, icon = 4567906, slotId = 6 },
		[202530] = { classId = 9, icon = 4876754, slotId = 7 },
		[217192] = { classId = 11, icon = 4962268, slotId = 6 },
		[200385] = { classId = 13, icon = 4567903, slotId = 5 },
		[217183] = { classId = 3, icon = 4522319, slotId = 0 },
		[217199] = { classId = 2, icon = 4869740, slotId = 8 },
		[217231] = { classId = 8, icon = 5167092, slotId = 6 },
		[202499] = { classId = 4, icon = 4896755, slotId = 9 },
		[217237] = { classId = 7, icon = 4952859, slotId = 6 },
		[207211] = { classId = 7, icon = 4952855, slotId = 9 },
		[200388] = { classId = 3, icon = 4522314, slotId = 9 },
		[207285] = { classId = 8, icon = 5167090, slotId = 3 },
		[217184] = { classId = 3, icon = 4522320, slotId = 8 },
		[217200] = { classId = 2, icon = 4869742, slotId = 2 },
		[217216] = { classId = 1, icon = 5077278, slotId = 4 },
		[217232] = { classId = 8, icon = 5167093, slotId = 0 },
		[217193] = { classId = 11, icon = 4962453, slotId = 0 },
		[202538] = { classId = 5, icon = 5007825, slotId = 5 },
		[200386] = { classId = 13, icon = 4567904, slotId = 3 },
		[200368] = { classId = 10, icon = 4510270, slotId = 3 },
		[217185] = { classId = 3, icon = 4522321, slotId = 2 },
		[217201] = { classId = 5, icon = 5007844, slotId = 6 },
		[217217] = { classId = 1, icon = 5077279, slotId = 6 },
		[217233] = { classId = 8, icon = 5167094, slotId = 8 },
		[202517] = { classId = 11, icon = 4956906, slotId = 9 },
		[207195] = { classId = 6, icon = 5343235, slotId = 3 },
		[202448] = { classId = 2, icon = 4869735, slotId = 5 },
		[202438] = { classId = 1, icon = 5077277, slotId = 3 },
		[217186] = { classId = 10, icon = 4510278, slotId = 4 },
		[217202] = { classId = 5, icon = 5007845, slotId = 0 },
		[217218] = { classId = 1, icon = 5077280, slotId = 0 },
		[217234] = { classId = 8, icon = 5167095, slotId = 2 },
		[202492] = { classId = 4, icon = 4896757, slotId = 3 },
		[207202] = { classId = 6, icon = 5343233, slotId = 9 },
		[202447] = { classId = 2, icon = 4869736, slotId = 3 },
		[207265] = { classId = 12, icon = 5153463, slotId = 9 },
		[217187] = { classId = 10, icon = 4510279, slotId = 6 },
		[217203] = { classId = 5, icon = 5007846, slotId = 8 },
		[217219] = { classId = 1, icon = 5077281, slotId = 8 },
		[217235] = { classId = 8, icon = 5167091, slotId = 4 },
		[200361] = { classId = 10, icon = 4510268, slotId = 9 },
		[202535] = { classId = 9, icon = 4876755, slotId = 9 },
		[217239] = { classId = 7, icon = 4952861, slotId = 8 },
		[202440] = { classId = 1, icon = 5077274, slotId = 7 },
		[217188] = { classId = 10, icon = 4510280, slotId = 0 },
		[217204] = { classId = 5, icon = 5007851, slotId = 2 },
		[217220] = { classId = 1, icon = 5077282, slotId = 2 },
		[217236] = { classId = 7, icon = 4952858, slotId = 4 },
		[207205] = { classId = 7, icon = 4952856, slotId = 5 },
		[202536] = { classId = 9, icon = 4876758, slotId = 4 },
		[200393] = { classId = 3, icon = 4522313, slotId = 7 },
		[207196] = { classId = 6, icon = 5343234, slotId = 5 },
		[217189] = { classId = 10, icon = 4510274, slotId = 8 },
		[217205] = { classId = 5, icon = 5007843, slotId = 4 },
		[217221] = { classId = 6, icon = 5343236, slotId = 4 },
		[207204] = { classId = 7, icon = 4952857, slotId = 3 },
		[202493] = { classId = 4, icon = 4896756, slotId = 5 },
		[202537] = { classId = 5, icon = 5007842, slotId = 3 },
		[200394] = { classId = 3, icon = 4522315, slotId = 5 },
		[202439] = { classId = 1, icon = 5077276, slotId = 5 },
		[217190] = { classId = 10, icon = 4510275, slotId = 2 },
		[217206] = { classId = 4, icon = 4896758, slotId = 4 },
		[217222] = { classId = 6, icon = 5343237, slotId = 6 },
		[217238] = { classId = 7, icon = 4952860, slotId = 0 },
		[207292] = { classId = 8, icon = 5167088, slotId = 9 },
		[200379] = { classId = 13, icon = 4567902, slotId = 9 },
		[200395] = { classId = 3, icon = 4522316, slotId = 3 },
		[202454] = { classId = 2, icon = 4869734, slotId = 9 },
		[217191] = { classId = 11, icon = 4962068, slotId = 4 },
		[217207] = { classId = 4, icon = 4896759, slotId = 6 },
		[217223] = { classId = 6, icon = 5343238, slotId = 0 },
		[207206] = { classId = 7, icon = 4952854, slotId = 7 },
		[207197] = { classId = 6, icon = 5343232, slotId = 7 },
		[202539] = { classId = 5, icon = 5007823, slotId = 7 },
		[217226] = { classId = 12, icon = 5153466, slotId = 4 },
		[217176] = { classId = 13, icon = 4567905, slotId = 4 },
		[207286] = { classId = 8, icon = 5167089, slotId = 5 },
		[217208] = { classId = 4, icon = 4896760, slotId = 0 },
		[217224] = { classId = 6, icon = 5343239, slotId = 8 },
		[217181] = { classId = 3, icon = 4522317, slotId = 4 }
	}
};

local function GetCatalystItems()
	local seasonItems = _items[KeystoneLoot:GetSeasonId()];

	if (seasonItems) then
		return seasonItems;
	end
end

function KeystoneLoot:GetCatalystItemList()
	local classId = KeystoneLootCharDB.selectedClassId;
	local slotId = KeystoneLootCharDB.selectedSlotId;
	local _itemList = {};

	for itemId, itemInfo in next, GetCatalystItems() or {} do
		if (itemInfo.classId == classId and itemInfo.slotId == slotId) then
			table.insert(_itemList, {
				itemId = itemId,
				icon = itemInfo.icon
			});
		end
	end

	return _itemList;
end

