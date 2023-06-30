local AddonName, Addon = ...;


Addon.SELECTED_ITEMLEVEL = 402;


local ITEMLEVEL_NAME = {
	[402] = '402 (+2)',
	[405] = '405 (+3 +4)',
	[408] = '408 (+5 +6)',
	[411] = '411 (+7 +8)',
	[415] = '415 (+9 +10)',
	[418] = '418 (+11 +12)',
	[421] = '421 (+13 +14)',
	[424] = '424 (+15 +16)',
	[428] = '428 (+17 +18)',
	[431] = '431 (+19 +20)',
	[434] = '434 (Vault)',
	[437] = '437 (Vault)',
	[441] = '441 (Vault)',
	[444] = '444 (Vault)',
	[447] = '447 (Vault)'
};

local SortedFilterList = {};
for itemLevel in next, ITEMLEVEL_NAME do
	table.insert(SortedFilterList, itemLevel);
end
table.sort(SortedFilterList);


local function SetFilter(self, itemLevel)
	Addon.SELECTED_ITEMLEVEL = itemLevel

	UIDropDownMenu_SetText(Addon.SELECTED_FILTER_BUTTON, ITEMLEVEL_NAME[itemLevel]);

	CloseDropDownMenus(1);
end

local function InitDropDownMenu(self, level)
	local SELECTED_ITEMLEVEL = Addon.SELECTED_ITEMLEVEL;

	local info = UIDropDownMenu_CreateInfo();
	info.func = SetFilter;

	for _, itemLevel in ipairs(SortedFilterList) do
		info.text = ITEMLEVEL_NAME[itemLevel];
		info.checked = SELECTED_ITEMLEVEL == itemLevel;
		info.arg1 = itemLevel;
		UIDropDownMenu_AddButton(info);
	end
end


local Filter = Addon.CreateFilterButton('itemLevel', InitDropDownMenu);
Filter:SetPoint('TOP', 120, -35);
Filter:SetText(ITEMLEVEL_NAME[Addon.SELECTED_ITEMLEVEL]);