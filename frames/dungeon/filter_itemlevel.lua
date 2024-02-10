local AddonName, Addon = ...;


local Translate = Addon.Translate;

local _defaultCategory = 'veteran';
local _defaultRank = 1;

local _categories = {
	{ category = 'veteran', text = Translate['Veteran'] },
	{ category = 'champion', text = Translate['Champion'] },
	{ category = 'hero', text = Translate['Hero'] },
	{ category = 'vault', text = Translate['Great Vault'] }
};

local _categoryRank = {
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


local Filter = Addon.Filter:CreateButton(Addon.Overview:GetTab('Dungeon'), 'ItemLevel');
Filter:SetPoint('TOP', 120, -35);

local function SetFilterText()
	local selectedCategory, selectedRank = Addon.Database:GetSelectedItemLevel();

	local info = _categoryRank[selectedCategory];
	if (info == nil) then
		Addon.Database:SetSelectedItemLevel(_defaultCategory, nil);
		SetFilterText();
		return;
	end

	info = info[selectedRank];
	if (info == nil) then
		Addon.Database:SetSelectedItemLevel(nil, _defaultRank);
		SetFilterText();
		return;
	end

	Addon.UpgradeItem:SetItemLevel(info.itemLevel);
	Addon.UpgradeItem:SetUpgradeID(info.bonusID);

	local text = info.text;

	Addon.DropDownMenu:SetText(text);
end

local function SetFilter(category, index)
	Addon.Database:SetSelectedItemLevel(category, index);

	SetFilterText();
end

function Filter:GetDefaultValue()
	return _defaultCategory, _defaultRank;
end

function Filter:Init()
	SetFilterText();
end

function Filter:List()
	local selectedCategory, selectedRank = Addon.Database:GetSelectedItemLevel();
	local _list = {};

	local numMenuList = #_categories;
	for indexCategory, entry in ipairs(_categories) do
		local isSelectedCategory = selectedCategory == entry.category;

		if (isSelectedCategory and indexCategory ~= 1) then
			local info = {};
			info.divider = true;
			table.insert(_list, info);
		end

		local info = {};
		info.text = entry.text..(isSelectedCategory and '' or ' ...');
		info.checked = isSelectedCategory;
		info.notCheckable = isSelectedCategory;
		info.disabled = isSelectedCategory;
		info.args = { entry.category, 1 };
		info.func = SetFilter;
		info.keepShownOnClick = true;
		table.insert(_list, info);

		if (isSelectedCategory) then
			for indexRank, data in ipairs(_categoryRank[entry.category]) do
				local info = {};
				info.leftPadding = 10;
				info.text = data.text;
				info.checked = isSelectedCategory and selectedRank == indexRank;
				info.disabled = info.checked;
				info.args = { entry.category, indexRank };
				info.func = SetFilter;
				table.insert(_list, info);
			end

			if (indexCategory ~= numMenuList) then
				local info = {};
				info.divider = true;
				table.insert(_list, info);
			end
		end

	end

	return _list;
end