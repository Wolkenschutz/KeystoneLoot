local AddonName, Addon = ...;


Addon.SELECTED_SLOT_ID = -1;


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


local function SetFilter(self, slotID)
	Addon.SELECTED_SLOT_ID = slotID
	Addon.API.UpdateLoot();

	UIDropDownMenu_SetText(Addon.SELECTED_FILTER_BUTTON, slotID == -1 and FAVORITES or SLOT_NAME[slotID]);

	CloseDropDownMenus(1);
end

local function InitDropDownMenu(self, level)
	local SELECTED_SLOT_ID = Addon.SELECTED_SLOT_ID;

	local info = UIDropDownMenu_CreateInfo();
	info.text = FAVORITES;
	info.checked = SELECTED_SLOT_ID == -1;
	info.arg1 = -1;
	info.func = SetFilter;
	UIDropDownMenu_AddButton(info);

	UIDropDownMenu_AddSeparator();

	for _, id in ipairs(SortedFilterList) do
		info.text = SLOT_NAME[id];
		info.checked = SELECTED_SLOT_ID == id;
		info.arg1 = id;
		UIDropDownMenu_AddButton(info);
	end
end


local Filter = Addon.CreateFilterButton('slot', InitDropDownMenu);
Filter:SetPoint('TOP', 0, -35);
Filter:SetText(FAVORITES);