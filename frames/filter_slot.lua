local AddonName, Addon = ...;


Addon.SELECTED_SLOT_ID = -1;


local SlotFilterToSlotName = {
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

-- NOTE: Obere Liste wird komplett durcheinandergewürfelt...?
local SortedFilterList = {};
for id in next, SlotFilterToSlotName do
	table.insert(SortedFilterList, id);
end
table.sort(SortedFilterList);


local function SetSlotFilter(self, slotID)
	Addon.SELECTED_SLOT_ID = slotID
	Addon.API.UpdateLoot();

	UIDropDownMenu_SetText(Addon.SELECTED_FILTER_BUTTON, slotID == -1 and FAVORITES or SlotFilterToSlotName[slotID]);

	CloseDropDownMenus(1);
end

local function InitSlotDropDownMenu(self, level)
	local SELECTED_SLOT_ID = Addon.SELECTED_SLOT_ID;

	local info = UIDropDownMenu_CreateInfo();
	info.text = FAVORITES;
	info.checked = SELECTED_SLOT_ID == -1;
	info.arg1 = -1;
	info.func = SetSlotFilter;
	UIDropDownMenu_AddButton(info);

	for _, id in ipairs(SortedFilterList) do
		info.text = SlotFilterToSlotName[id];
		info.checked = SELECTED_SLOT_ID == id;
		info.arg1 = id;
		UIDropDownMenu_AddButton(info);
	end
end


local SlotFilter = Addon.CreateFilterButton('slot', InitSlotDropDownMenu);
SlotFilter:SetPoint('TOP', 65, -35);
SlotFilter:SetText(FAVORITES);