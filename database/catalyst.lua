local AddonName , KeystoneLoot = ...;

local _items = {
	[11] = {
		[207207] = { classId = 7, icon = 4952862, slotId = 2 },
		[207223] = { classId = 13, icon = 5357696, slotId = 5 },
		[207239] = { classId = 4, icon = 5349808, slotId = 4 },
		[207255] = { classId = 11, icon = 5343024, slotId = 6 },
		[207271] = { classId = 9, icon = 5202183, slotId = 8 },
		[207287] = { classId = 8, icon = 5167087, slotId = 7 },
		[207176] = { classId = 1, icon = 5330048, slotId = 3 },
		[207192] = { classId = 2, icon = 5142412, slotId = 6 },
		[207208] = { classId = 7, icon = 4952861, slotId = 8 },
		[207224] = { classId = 13, icon = 5357694, slotId = 7 },
		[207240] = { classId = 10, icon = 5210374, slotId = 3 },
		[207256] = { classId = 11, icon = 5343020, slotId = 9 },
		[207272] = { classId = 9, icon = 5202182, slotId = 0 },
		[207288] = { classId = 8, icon = 5167095, slotId = 2 },
		[207177] = { classId = 1, icon = 5330047, slotId = 5 },
		[207193] = { classId = 2, icon = 5142404, slotId = 9 },
		[207209] = { classId = 7, icon = 4952860, slotId = 0 },
		[207225] = { classId = 13, icon = 5357704, slotId = 2 },
		[207241] = { classId = 10, icon = 5210373, slotId = 5 },
		[207257] = { classId = 11, icon = 5343023, slotId = 4 },
		[207273] = { classId = 9, icon = 5202181, slotId = 6 },
		[207289] = { classId = 8, icon = 5167094, slotId = 8 },
		[207194] = { classId = 2, icon = 5142409, slotId = 4 },
		[207210] = { classId = 7, icon = 4952859, slotId = 6 },
		[207226] = { classId = 13, icon = 5357702, slotId = 8 },
		[207242] = { classId = 10, icon = 5210371, slotId = 7 },
		[207258] = { classId = 12, icon = 5153465, slotId = 3 },
		[207274] = { classId = 9, icon = 5202177, slotId = 9 },
		[207290] = { classId = 8, icon = 5167093, slotId = 0 },
		[207179] = { classId = 1, icon = 5330045, slotId = 7 },
		[207195] = { classId = 6, icon = 5343235, slotId = 3 },
		[207211] = { classId = 7, icon = 4952855, slotId = 9 },
		[207227] = { classId = 13, icon = 5357701, slotId = 0 },
		[207243] = { classId = 10, icon = 5210383, slotId = 2 },
		[207259] = { classId = 12, icon = 5153464, slotId = 5 },
		[207275] = { classId = 9, icon = 5202180, slotId = 4 },
		[207291] = { classId = 8, icon = 5167092, slotId = 6 },
		[207180] = { classId = 1, icon = 5330053, slotId = 2 },
		[207196] = { classId = 6, icon = 5343234, slotId = 5 },
		[207212] = { classId = 7, icon = 4952858, slotId = 4 },
		[207228] = { classId = 13, icon = 5357700, slotId = 6 },
		[207244] = { classId = 10, icon = 5210378, slotId = 8 },
		[207260] = { classId = 12, icon = 5153462, slotId = 7 },
		[207276] = { classId = 5, icon = 5279080, slotId = 3 },
		[207292] = { classId = 8, icon = 5167088, slotId = 9 },
		[207181] = { classId = 1, icon = 5330052, slotId = 8 },
		[207197] = { classId = 6, icon = 5343232, slotId = 7 },
		[207213] = { classId = 3, icon = 5226492, slotId = 3 },
		[207229] = { classId = 13, icon = 5357695, slotId = 9 },
		[207245] = { classId = 10, icon = 5210377, slotId = 0 },
		[207261] = { classId = 12, icon = 5153470, slotId = 2 },
		[207277] = { classId = 5, icon = 5279079, slotId = 5 },
		[207293] = { classId = 8, icon = 5167091, slotId = 4 },
		[207182] = { classId = 1, icon = 5330051, slotId = 0 },
		[207198] = { classId = 6, icon = 5343240, slotId = 2 },
		[207214] = { classId = 3, icon = 5226491, slotId = 5 },
		[207230] = { classId = 13, icon = 5357699, slotId = 4 },
		[207246] = { classId = 10, icon = 5210376, slotId = 6 },
		[207262] = { classId = 12, icon = 5153469, slotId = 8 },
		[207278] = { classId = 5, icon = 5279077, slotId = 7 },
		[207183] = { classId = 1, icon = 5330050, slotId = 6 },
		[207199] = { classId = 6, icon = 5343239, slotId = 8 },
		[207215] = { classId = 3, icon = 5226473, slotId = 7 },
		[207231] = { classId = 4, icon = 5349807, slotId = 3 },
		[207247] = { classId = 10, icon = 5210372, slotId = 9 },
		[207263] = { classId = 12, icon = 5153468, slotId = 0 },
		[207279] = { classId = 5, icon = 5309927, slotId = 2 },
		[207184] = { classId = 1, icon = 5330046, slotId = 9 },
		[207200] = { classId = 6, icon = 5343238, slotId = 0 },
		[207216] = { classId = 3, icon = 5226497, slotId = 2 },
		[207232] = { classId = 4, icon = 5349806, slotId = 5 },
		[207248] = { classId = 10, icon = 5210375, slotId = 4 },
		[207264] = { classId = 12, icon = 5153467, slotId = 6 },
		[207280] = { classId = 5, icon = 5279083, slotId = 8 },
		[207185] = { classId = 1, icon = 5330049, slotId = 4 },
		[207201] = { classId = 6, icon = 5343237, slotId = 6 },
		[207217] = { classId = 3, icon = 5226496, slotId = 8 },
		[207233] = { classId = 4, icon = 5349804, slotId = 7 },
		[207249] = { classId = 11, icon = 5343022, slotId = 3 },
		[207265] = { classId = 12, icon = 5153463, slotId = 9 },
		[207281] = { classId = 5, icon = 5279082, slotId = 0 },
		[207186] = { classId = 2, icon = 5142406, slotId = 3 },
		[207202] = { classId = 6, icon = 5343233, slotId = 9 },
		[207218] = { classId = 3, icon = 5226495, slotId = 0 },
		[207234] = { classId = 4, icon = 5349812, slotId = 2 },
		[207250] = { classId = 11, icon = 5343021, slotId = 5 },
		[207266] = { classId = 12, icon = 5153466, slotId = 4 },
		[207282] = { classId = 5, icon = 5279081, slotId = 6 },
		[207187] = { classId = 2, icon = 5142405, slotId = 5 },
		[207203] = { classId = 6, icon = 5343236, slotId = 4 },
		[207219] = { classId = 3, icon = 5226494, slotId = 6 },
		[207235] = { classId = 4, icon = 5349811, slotId = 8 },
		[207251] = { classId = 11, icon = 5343019, slotId = 7 },
		[207267] = { classId = 9, icon = 5202179, slotId = 3 },
		[207283] = { classId = 5, icon = 5279078, slotId = 9 },
		[207188] = { classId = 2, icon = 5142403, slotId = 7 },
		[207204] = { classId = 7, icon = 4952857, slotId = 3 },
		[207220] = { classId = 3, icon = 5226490, slotId = 9 },
		[207236] = { classId = 4, icon = 5349810, slotId = 0 },
		[207252] = { classId = 11, icon = 5343028, slotId = 2 },
		[207268] = { classId = 9, icon = 5202178, slotId = 5 },
		[207284] = { classId = 5, icon = 5279084, slotId = 4 },
		[207189] = { classId = 2, icon = 5142420, slotId = 2 },
		[207205] = { classId = 7, icon = 4952856, slotId = 5 },
		[207221] = { classId = 3, icon = 5226493, slotId = 4 },
		[207237] = { classId = 4, icon = 5349809, slotId = 6 },
		[207253] = { classId = 11, icon = 5343026, slotId = 8 },
		[207269] = { classId = 9, icon = 5202176, slotId = 7 },
		[207285] = { classId = 8, icon = 5167090, slotId = 3 },
		[207190] = { classId = 2, icon = 5142419, slotId = 8 },
		[207206] = { classId = 7, icon = 4952854, slotId = 7 },
		[207222] = { classId = 13, icon = 5357697, slotId = 3 },
		[207238] = { classId = 4, icon = 5349805, slotId = 9 },
		[207254] = { classId = 11, icon = 5343025, slotId = 0 },
		[207270] = { classId = 9, icon = 5202184, slotId = 2 },
		[207286] = { classId = 8, icon = 5167089, slotId = 5 },
		[207191] = { classId = 2, icon = 5142417, slotId = 0 }
	}
};

local function GetCatalystItems()
	local seasonItems = _items[KeystoneLoot:GetSeasonId()];

	if (seasonItems) then
		return seasonItems;
	end
end

function KeystoneLoot:GetCatalystItemList(classId, slotId)
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

