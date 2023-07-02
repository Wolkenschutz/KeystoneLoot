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
	[434] = '434 ('..RATED_PVP_WEEKLY_VAULT..' +12 +13)',
	[437] = '437 ('..RATED_PVP_WEEKLY_VAULT..' +14 +15)',
	[441] = '441 ('..RATED_PVP_WEEKLY_VAULT..' +16 +17)',
	[444] = '444 ('..RATED_PVP_WEEKLY_VAULT..' +18 +19)',
	[447] = '447 ('..RATED_PVP_WEEKLY_VAULT..' +20)'
};

local SortedFilterList = {};
for itemLevel in next, ITEMLEVEL_NAME do
	table.insert(SortedFilterList, itemLevel);
end
table.sort(SortedFilterList);


local function SetFilter(itemLevel)
	Addon.SELECTED_ITEMLEVEL = itemLevel

	Addon.API.SetDropDownMenuText(ITEMLEVEL_NAME[itemLevel]);
end

local function InitDropDownMenu()
	local SELECTED_ITEMLEVEL = Addon.SELECTED_ITEMLEVEL;
	local list = {};

	for _, itemLevel in ipairs(SortedFilterList) do
		local info = {};
		info.text = ITEMLEVEL_NAME[itemLevel];
		info.checked = SELECTED_ITEMLEVEL == itemLevel;
		info.disabled = info.checked;
		info.args = itemLevel;
		info.func = SetFilter;
		table.insert(list, info);
	end

	return list;
end


local Filter = Addon.CreateFilterButton('itemLevel', InitDropDownMenu);
Filter:SetPoint('TOP', 120, -35);
Filter:SetText(ITEMLEVEL_NAME[Addon.SELECTED_ITEMLEVEL]);