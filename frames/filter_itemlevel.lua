local AddonName, Addon = ...;


local Translate = Addon.API.Translate;

local DEFAULT_CATEGORY = 'veteran';
local DEFAULT_RANK = 1;

local DROPDOWN_CATEGORIES = {
	{ category = 'veteran', text = Translate['Veteran'] },
	{ category = 'champion', text = Translate['Champion'] },
	{ category = 'hero', text = Translate['Hero'] },
	{ category = 'vault', text = Translate['Great Vault'] }
};

local DROPDOWN_CATEGORY_RANKS = {
	veteran = {
		{ itemLevel = 441, bonusID = 'veteran-1', text = ITEM_POOR_COLOR_CODE..'441|r | +2' },
		{ itemLevel = 444, bonusID = 'veteran-2', text = ITEM_POOR_COLOR_CODE..'444|r | +3 +4' },
		{ itemLevel = 447, bonusID = 'veteran-3', text = ITEM_POOR_COLOR_CODE..'447|r | +5 +6' },
		{ itemLevel = 450, bonusID = 'veteran-4', text = ITEM_POOR_COLOR_CODE..'450|r | +7 +8' },
		{ itemLevel = 454, bonusID = 'veteran-5', text = ITEM_GOOD_COLOR_CODE..'454|r | '..ITEM_UPGRADE },
		{ itemLevel = 457, bonusID = 'veteran-6', text = ITEM_GOOD_COLOR_CODE..'457|r | '..ITEM_UPGRADE },
		{ itemLevel = 460, bonusID = 'veteran-7', text = ITEM_GOOD_COLOR_CODE..'460|r | '..ITEM_UPGRADE },
		{ itemLevel = 463, bonusID = 'veteran-8', text = ITEM_GOOD_COLOR_CODE..'463|r | '..ITEM_UPGRADE }
	},
	champion = {
		{ itemLevel = 454, bonusID = 'champion-1', text = ITEM_GOOD_COLOR_CODE..'454|r | +9 +10' },
		{ itemLevel = 457, bonusID = 'champion-2', text = ITEM_GOOD_COLOR_CODE..'457|r | +11 +12' },
		{ itemLevel = 460, bonusID = 'champion-3', text = ITEM_GOOD_COLOR_CODE..'460|r | +13 +14' },
		{ itemLevel = 463, bonusID = 'champion-4', text = ITEM_GOOD_COLOR_CODE..'463|r | +15 +16' },
		{ itemLevel = 467, bonusID = 'champion-5', text = ITEM_SUPERIOR_COLOR_CODE..'467|r | '..ITEM_UPGRADE },
		{ itemLevel = 470, bonusID = 'champion-6', text = ITEM_SUPERIOR_COLOR_CODE..'470|r | '..ITEM_UPGRADE },
		{ itemLevel = 473, bonusID = 'champion-7', text = ITEM_SUPERIOR_COLOR_CODE..'473|r | '..ITEM_UPGRADE },
		{ itemLevel = 476, bonusID = 'champion-8', text = ITEM_SUPERIOR_COLOR_CODE..'476|r | '..ITEM_UPGRADE }
	},
	hero = {
		{ itemLevel = 467, bonusID = 'hero-1', text = ITEM_SUPERIOR_COLOR_CODE..'467|r | +17 +18' },
		{ itemLevel = 470, bonusID = 'hero-2', text = ITEM_SUPERIOR_COLOR_CODE..'470|r | +19 +20' },
		{ itemLevel = 473, bonusID = 'hero-3', text = ITEM_SUPERIOR_COLOR_CODE..'473|r | '..ITEM_UPGRADE },
		{ itemLevel = 476, bonusID = 'hero-4', text = ITEM_SUPERIOR_COLOR_CODE..'476|r | '..ITEM_UPGRADE },
		{ itemLevel = 480, bonusID = 'hero-5', text = ITEM_EPIC_COLOR_CODE..'480|r | '..ITEM_UPGRADE },
		{ itemLevel = 483, bonusID = 'hero-6', text = ITEM_EPIC_COLOR_CODE..'483|r | '..ITEM_UPGRADE }
	},
	vault = {
		{ itemLevel = 480, bonusID = 'myth-1', text = ITEM_EPIC_COLOR_CODE..'480|r | +18 +19' },
		{ itemLevel = 483, bonusID = 'myth-2', text = ITEM_EPIC_COLOR_CODE..'483|r | +20 | '..ITEM_UPGRADE },
		{ itemLevel = 486, bonusID = 'myth-3', text = ITEM_LEGENDARY_COLOR_CODE..'486|r | '..ITEM_UPGRADE },
		{ itemLevel = 489, bonusID = 'myth-4', text = ITEM_LEGENDARY_COLOR_CODE..'489|r | '..ITEM_UPGRADE }
	}
};


local function SetFilterText(self)
	local info = DROPDOWN_CATEGORY_RANKS[KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_CATEGORY];
	if (info == nil) then
		KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_CATEGORY = DEFAULT_CATEGORY;
		SetFilterText(self);
		return;
	end

	info = info[KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_RANK];
	if (info == nil) then
		KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_RANK = DEFAULT_RANK;
		SetFilterText(self);
		return;
	end

	Addon.SELECTED_ITEMLEVEL = info.itemLevel;
	Addon.SELECTED_ITEMLEVEL_BONUSID = info.bonusID;

	local text = info.text;

	if (self == nil) then
		Addon.API.SetDropDownMenuText(text);
	else
		self.Text:SetText(text);
	end
	
end

local function SetFilter(category, index)
	KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_CATEGORY = category;
	KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_RANK = index;

	SetFilterText();
end

local function InitFunction(self)
	if (KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_CATEGORY == nil) then
		KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_CATEGORY = DEFAULT_CATEGORY;
	end

	if (KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_RANK == nil) then
		KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_RANK = DEFAULT_RANK;
	end

	SetFilterText(self);
end

local function ListFunction()
	local SELECTED_ITEMLEVEL_CATEGORY = KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_CATEGORY;
	local SELECTED_ITEMLEVEL_RANK = KEYSTONE_LOOT_CHAR_DB.SELECTED_ITEMLEVEL_RANK;
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


local Filter = Addon.CreateFilterButton('itemLevel', ListFunction, InitFunction);
Filter:SetPoint('TOP', 120, -35);

Addon.Frames.FilterItemLevelButton = Filter;