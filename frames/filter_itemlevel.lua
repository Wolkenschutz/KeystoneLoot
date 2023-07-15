local AddonName, Addon = ...;


local Translate = Addon.API.Translate;

local SELECTED_ITEMLEVEL_CATEGORY = 'veteran';
local SELECTED_ITEMLEVEL_RANK = 1;

Addon.SELECTED_ITEMLEVEL = 402;
Addon.SELECTED_ITEMLEVEL_BONUSID = 'veteran-1';

local DROPDOWN_CATEGORIES = {
	{ category = 'veteran', text = Translate['Veteran'] },
	{ category = 'champion', text = Translate['Champion'] },
	{ category = 'hero', text = Translate['Hero'] },
	{ category = 'vault', text = Translate['Great Vault'] }
};

local DROPDOWN_CATEGORY_RANKS = {
	veteran = {
		{ itemLevel = 402, bonusID = 'veteran-1', text = ITEM_POOR_COLOR_CODE..'402|r | +2' },
		{ itemLevel = 405, bonusID = 'veteran-2', text = ITEM_POOR_COLOR_CODE..'405|r | +3 +4' },
		{ itemLevel = 408, bonusID = 'veteran-3', text = ITEM_POOR_COLOR_CODE..'408|r | +5 +6' },
		{ itemLevel = 411, bonusID = 'veteran-4', text = ITEM_POOR_COLOR_CODE..'411|r | +7 +8' },
		{ itemLevel = 415, bonusID = 'veteran-5', text = ITEM_GOOD_COLOR_CODE..'415|r | '..ITEM_UPGRADE },
		{ itemLevel = 418, bonusID = 'veteran-6', text = ITEM_GOOD_COLOR_CODE..'418|r | '..ITEM_UPGRADE },
		{ itemLevel = 421, bonusID = 'veteran-7', text = ITEM_GOOD_COLOR_CODE..'421|r | '..ITEM_UPGRADE },
		{ itemLevel = 424, bonusID = 'veteran-8', text = ITEM_GOOD_COLOR_CODE..'424|r | '..ITEM_UPGRADE }
	},
	champion = {
		{ itemLevel = 415, bonusID = 'champion-1', text = ITEM_GOOD_COLOR_CODE..'415|r | +9 +10' },
		{ itemLevel = 418, bonusID = 'champion-2', text = ITEM_GOOD_COLOR_CODE..'418|r | +11 +12' },
		{ itemLevel = 421, bonusID = 'champion-3', text = ITEM_GOOD_COLOR_CODE..'421|r | +13 +14' },
		{ itemLevel = 424, bonusID = 'champion-4', text = ITEM_GOOD_COLOR_CODE..'424|r | +15 +16' },
		{ itemLevel = 428, bonusID = 'champion-5', text = ITEM_SUPERIOR_COLOR_CODE..'428|r | '..ITEM_UPGRADE },
		{ itemLevel = 431, bonusID = 'champion-6', text = ITEM_SUPERIOR_COLOR_CODE..'431|r | '..ITEM_UPGRADE },
		{ itemLevel = 434, bonusID = 'champion-7', text = ITEM_SUPERIOR_COLOR_CODE..'434|r | '..ITEM_UPGRADE },
		{ itemLevel = 437, bonusID = 'champion-8', text = ITEM_SUPERIOR_COLOR_CODE..'437|r | '..ITEM_UPGRADE }
	},
	hero = {
		{ itemLevel = 428, bonusID = 'hero-1', text = ITEM_SUPERIOR_COLOR_CODE..'428|r | +17 +18' },
		{ itemLevel = 431, bonusID = 'hero-2', text = ITEM_SUPERIOR_COLOR_CODE..'431|r | +19 +20' },
		{ itemLevel = 434, bonusID = 'hero-3', text = ITEM_SUPERIOR_COLOR_CODE..'434|r | '..ITEM_UPGRADE },
		{ itemLevel = 437, bonusID = 'hero-4', text = ITEM_SUPERIOR_COLOR_CODE..'437|r | '..ITEM_UPGRADE },
		{ itemLevel = 441, bonusID = 'hero-5', text = ITEM_EPIC_COLOR_CODE..'441|r | '..ITEM_UPGRADE }
	},
	vault = {
		{ itemLevel = 441, bonusID = 'myth-1', text = ITEM_EPIC_COLOR_CODE..'441|r | +16 +17' },
		{ itemLevel = 444, bonusID = 'myth-2', text = ITEM_EPIC_COLOR_CODE..'444|r | +18 +19 | '..ITEM_UPGRADE },
		{ itemLevel = 447, bonusID = 'myth-3', text = ITEM_LEGENDARY_COLOR_CODE..'447|r | +20 | '..ITEM_UPGRADE }
	}
};


local function SetFilter(category, index)
	local info = DROPDOWN_CATEGORY_RANKS[category][index];

	Addon.SELECTED_ITEMLEVEL = info.itemLevel;
	Addon.SELECTED_ITEMLEVEL_BONUSID = info.bonusID;

	SELECTED_ITEMLEVEL_CATEGORY = category;
	SELECTED_ITEMLEVEL_RANK = index;

	Addon.API.SetDropDownMenuText(info.text);
end

local function InitDropDownMenu()
	local list = {};

	local numMenuList = #DROPDOWN_CATEGORIES;
	for index, entry in ipairs(DROPDOWN_CATEGORIES) do
		local isSelectedCategory = SELECTED_ITEMLEVEL_CATEGORY == entry.category;
		if (isSelectedCategory and index ~= 1) then
			local info = {};
			info.divider = true;
			table.insert(list, info);
		end

		local info = {};
		info.text = entry.text..(isSelectedCategory and '' or ' ...');
		info.checked = isSelectedCategory;
		info.notCheckable = isSelectedCategory;
		info.disabled = isSelectedCategory;
		info.args = { entry.category, 1 };
		info.func = SetFilter;
		info.keepShownOnClick = true;
		table.insert(list, info);

		if (isSelectedCategory) then
			for index, data in ipairs(DROPDOWN_CATEGORY_RANKS[entry.category]) do
				local info = {};
				info.leftPadding = 10;
				info.text = data.text;
				info.checked = isSelectedCategory and SELECTED_ITEMLEVEL_RANK == index;
				info.disabled = info.checked;
				info.args = { entry.category, index };
				info.func = SetFilter;
				table.insert(list, info);
			end
			
			if (index ~= numMenuList) then
				local info = {};
				info.divider = true;
				table.insert(list, info);
			end
		end

	end

	return list;
end


local Filter = Addon.CreateFilterButton('itemLevel', InitDropDownMenu);
Filter:SetPoint('TOP', 120, -35);
Filter:SetText(DROPDOWN_CATEGORY_RANKS[SELECTED_ITEMLEVEL_CATEGORY][SELECTED_ITEMLEVEL_RANK].text);