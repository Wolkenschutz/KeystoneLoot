local AddonName, Addon = ...;


local slotList = {
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

local sortedSlotList = {};
for id in next, slotList do
	table.insert(sortedSlotList, id);
end
table.sort(sortedSlotList);


local Filter = Addon.Filter:CreateButton(Addon.Overview:GetTab('Dungeon'), 'Slot');
Filter:SetPoint('TOP', 0, -35);

local function SetFilterText()
	local selectedSlotID = Addon.Database:GetSelectedSlot();
	local text = selectedSlotID == -1 and FAVORITES or slotList[selectedSlotID];

	Addon.DropDownMenu:SetText(text);
end

local function SetFilter(slotID)
	Addon.Database:SetSelectedSlot(slotID);
	Addon.Overview:GetTab('Dungeon'):Update();

	SetFilterText();
end

function Filter:GetDefaultValue()
	return -1;
end

function Filter:Init()
	SetFilterText();
end

function Filter:List()
	local selectedSlotID = Addon.Database:GetSelectedSlot();
	local selectedClassID, selectedSpecID = Addon.Database:GetSelectedClass();
	local _list = {};

	local info = {};
	info.text = FAVORITES;
	info.checked = selectedSlotID == -1;
	info.disabled = info.checked;
	info.args = -1;
	info.func = SetFilter;
	table.insert(_list, info);

	local info = {};
	info.divider = true;
	table.insert(_list, info);

	for _, id in ipairs(sortedSlotList) do
		local hasSlotItems = Addon.GameData:HasSlotItems(id, selectedClassID, selectedSpecID);
		local info = {};
		info.text = slotList[id];
		info.hasGrayColor = not hasSlotItems;
		info.checked = selectedSlotID == id;
		info.disabled = info.hasGrayColor or info.checked;
		info.args = id;
		info.func = SetFilter;
		table.insert(_list, info);
	end

	return _list;
end