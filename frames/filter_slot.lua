local AddonName, Addon = ...;




local SLOT_NAME = {
	[Enum.ItemSlotFilterType.Head] = INVTYPE_HEAD,
	[Enum.ItemSlotFilterType.Neck] = INVTYPE_NECK,
	[Enum.ItemSlotFilterType.Shoulder] = INVTYPE_SHOULDER,
	[Enum.ItemSlotFilterType.Cloak] = INVTYPE_CLOAK,
	[Enum.ItemSlotFilterType.Chest] = INVTYPE_CHEST,
	[Enum.ItemSlotFilterType.Wrist] = INVTYPE_WRIST,
	[Enum.ItemSlotFilterType.Hand] = INVTYPE_HAND,
	[Enum.ItemSlotFilterType.Waist] = INVTYPE_WAIST,
	[Enum.ItemSlotFilterType.Legs] = INVTYPE_LEGS,
	[Enum.ItemSlotFilterType.Feet] = INVTYPE_FEET,
	[Enum.ItemSlotFilterType.MainHand] = INVTYPE_WEAPONMAINHAND,
	[Enum.ItemSlotFilterType.OffHand] = INVTYPE_WEAPONOFFHAND,
	[Enum.ItemSlotFilterType.Finger] = INVTYPE_FINGER,
	[Enum.ItemSlotFilterType.Trinket] = INVTYPE_TRINKET,
	[Enum.ItemSlotFilterType.Other] = EJ_LOOT_SLOT_FILTER_OTHER
}

local SortedFilterList = {};
for id in next, SLOT_NAME do
	table.insert(SortedFilterList, id);
end
table.sort(SortedFilterList);


local function SetFilterText(self)
	local SELECTED_SLOT_ID = KEYSTONE_LOOT_CHAR_DB.SELECTED_SLOT_ID;

	local text = SELECTED_SLOT_ID == -1 and FAVORITES or SLOT_NAME[SELECTED_SLOT_ID];

	if (self == nil) then
		Addon.API.SetDropDownMenuText(text);
	else
		self.Text:SetText(text);
	end
	
end

local function SetFilter(slotID)
	KEYSTONE_LOOT_CHAR_DB.SELECTED_SLOT_ID = slotID;

	Addon.API.UpdateLoot();

	SetFilterText();
end

local function InitFunction(self)
	if (KEYSTONE_LOOT_CHAR_DB.SELECTED_SLOT_ID == nil) then
		KEYSTONE_LOOT_CHAR_DB.SELECTED_SLOT_ID = -1;
	end

	SetFilterText(self);
end

local function ListFunction()
	local SELECTED_SLOT_ID = KEYSTONE_LOOT_CHAR_DB.SELECTED_SLOT_ID;
	local list = {};

	local info = {};
	info.text = FAVORITES;
	info.checked = SELECTED_SLOT_ID == -1;
	info.disabled = info.checked;
	info.args = -1;
	info.func = SetFilter;
	table.insert(list, info);

	local info = {};
	info.divider = true;
	table.insert(list, info);

	for _, id in ipairs(SortedFilterList) do
		local info = {};
		info.text = SLOT_NAME[id];
		info.checked = SELECTED_SLOT_ID == id;
		info.disabled = info.checked;
		info.args = id;
		info.func = SetFilter;
		table.insert(list, info);
	end

	return list;
end


local Filter = Addon.CreateFilterButton('slot', ListFunction, InitFunction);
Filter:SetPoint('TOP', 0, -35);