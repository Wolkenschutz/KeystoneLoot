local AddonName, Addon = ...;


local CreateFilterButton = Addon.CreateFilterButton;

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


local function SetSlotFilter(self, slotID)
	Addon.SELECTED_SLOT_ID = slotID
	UIDropDownMenu_SetText(Addon.SELECTED_FILTER_BUTTON, slotID == -1 and FAVORITES or SlotFilterToSlotName[slotID]);

	Addon.API.UpdateInstances();

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

	for filter, name in next, SlotFilterToSlotName do
		info.text = name;
		info.checked = SELECTED_SLOT_ID == filter;
		info.arg1 = filter;
		UIDropDownMenu_AddButton(info);
	end
end


local SlotFilter = CreateFilterButton('slot', InitSlotDropDownMenu);
Addon.Frames.Filter.Slot = SlotFilter;

SlotFilter:SetPoint('TOP', 55, -35);
SlotFilter:SetText(FAVORITES);