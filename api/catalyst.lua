local AddonName, Addon = ...;


local ITEMS_TO_CHANGE = {
    [Enum.ItemSlotFilterType.Head] = {
        { itemID = 202443, icon = 5077280 },
        { itemID = 202452, icon = 4869739 },
        { itemID = 202479, icon = 5006793 },
        { itemID = 202497, icon = 4896760 },
        { itemID = 202542, icon = 5007845 },
        { itemID = 202461, icon = 5094755 },
        { itemID = 202470, icon = 4733789 },
        { itemID = 202551, icon = 4751703 },
        { itemID = 202533, icon = 4876760 },
        { itemID = 202506, icon = 4890976 },
        { itemID = 202515, icon = 4962453 },
        { itemID = 202524, icon = 4956646 },
        { itemID = 202488, icon = 4885972 }
    },
    [Enum.ItemSlotFilterType.Shoulder] = {
        { itemID = 202441, icon = 5077282 },
        { itemID = 202450, icon = 4869742 },
        { itemID = 202477, icon = 5006795 },
        { itemID = 202495, icon = 4896762 },
        { itemID = 202540, icon = 5007851 },
        { itemID = 202459, icon = 5094757 },
        { itemID = 202468, icon = 4733791 },
        { itemID = 202549, icon = 4751524 },
        { itemID = 202531, icon = 4876762 },
        { itemID = 202504, icon = 4890978 },
        { itemID = 202513, icon = 4962804 },
        { itemID = 202522, icon = 4956648 },
        { itemID = 202486, icon = 4885974 }
    },
    [Enum.ItemSlotFilterType.Chest] = {
        { itemID = 202446, icon = 5077278 },
        { itemID = 202455, icon = 4869737 },
        { itemID = 202482, icon = 5006791 },
        { itemID = 202500, icon = 4896758 },
        { itemID = 202545, icon = 5007843 },
        { itemID = 202464, icon = 5094753 },
        { itemID = 202473, icon = 4733787 },
        { itemID = 202554, icon = 4751901 },
        { itemID = 202536, icon = 4876758 },
        { itemID = 202509, icon = 4890974 },
        { itemID = 202518, icon = 4962068 },
        { itemID = 202527, icon = 4956644 },
        { itemID = 202491, icon = 4885970 }
    },
    [Enum.ItemSlotFilterType.Hand] = {
        { itemID = 202444, icon = 5077279 },
        { itemID = 202453, icon = 4869738 },
        { itemID = 202480, icon = 5006792 },
        { itemID = 202498, icon = 4896759 },
        { itemID = 202543, icon = 5007844 },
        { itemID = 202462, icon = 5094754 },
        { itemID = 202471, icon = 4733788 },
        { itemID = 202552, icon = 4751902 },
        { itemID = 202534, icon = 4876759 },
        { itemID = 202507, icon = 4890975 },
        { itemID = 202516, icon = 4962268 },
        { itemID = 202525, icon = 4956645 },
        { itemID = 202489, icon = 4885971 }
    },
    [Enum.ItemSlotFilterType.Legs] = {
        { itemID = 202442, icon = 5077281 },
        { itemID = 202451, icon = 4869740 },
        { itemID = 202478, icon = 5006794 },
        { itemID = 202496, icon = 4896761 },
        { itemID = 202541, icon = 5007846 },
        { itemID = 202460, icon = 5094756 },
        { itemID = 202469, icon = 4733790 },
        { itemID = 202550, icon = 4751903 },
        { itemID = 202532, icon = 4876761 },
        { itemID = 202505, icon = 4890977 },
        { itemID = 202514, icon = 4962626 },
        { itemID = 202523, icon = 4956647 },
        { itemID = 202487, icon = 4885973 }
    },
    [Enum.ItemSlotFilterType.Cloak] = {
        { itemID = 202438, icon = 5077277 },
        { itemID = 202447, icon = 4869736 },
        { itemID = 202474, icon = 5006790 },
        { itemID = 202492, icon = 4896757 },
        { itemID = 200332, icon = 4534052 },
        { itemID = 202456, icon = 5094752 },
        { itemID = 202465, icon = 4733786 },
        { itemID = 200323, icon = 4392922 },
        { itemID = 202528, icon = 4876757 },
        { itemID = 202501, icon = 4890973 },
        { itemID = 202510, icon = 4962009 },
        { itemID = 202519, icon = 4956643 },
        { itemID = 202483, icon = 4885969 }
    },
    [Enum.ItemSlotFilterType.Wrist] = {
        { itemID = 202439, icon = 5077276 },
        { itemID = 202448, icon = 4869735 },
        { itemID = 202475, icon = 5006789 },
        { itemID = 202493, icon = 4896756 },
        { itemID = 202538, icon = 5007825 },
        { itemID = 202457, icon = 5094751 },
        { itemID = 202466, icon = 4733785 },
        { itemID = 202547, icon = 4751899 },
        { itemID = 202529, icon = 4876756 },
        { itemID = 202502, icon = 5054667 },
        { itemID = 202511, icon = 4956907 },
        { itemID = 202520, icon = 4956642 },
        { itemID = 202484, icon = 4885968 }
    },
    [Enum.ItemSlotFilterType.Waist] = {
        { itemID = 202440, icon = 5077274 },
        { itemID = 202449, icon = 4869733 },
        { itemID = 202476, icon = 5006787 },
        { itemID = 202494, icon = 4896754 },
        { itemID = 202539, icon = 5007823 },
        { itemID = 202458, icon = 5094749 },
        { itemID = 202467, icon = 4733783 },
        { itemID = 202548, icon = 4751495 },
        { itemID = 202530, icon = 4876754 },
        { itemID = 202503, icon = 4890971 },
        { itemID = 202512, icon = 4956905 },
        { itemID = 202521, icon = 4956640 },
        { itemID = 202485, icon = 4885966 }
    },
    [Enum.ItemSlotFilterType.Feet] = {
        { itemID = 202445, icon = 5077275 },
        { itemID = 202454, icon = 4869736 },
        { itemID = 202481, icon = 5006788 },
        { itemID = 202499, icon = 4896755 },
        { itemID = 202544, icon = 5007824 },
        { itemID = 202463, icon = 5094750 },
        { itemID = 202472, icon = 4733784 },
        { itemID = 202553, icon = 5149796 },
        { itemID = 202535, icon = 4876755 },
        { itemID = 202508, icon = 4890972 },
        { itemID = 202517, icon = 4956906 },
        { itemID = 202526, icon = 4956641 },
        { itemID = 202490, icon = 4885967 }
    }
};


local function GetCatalystItem(slotType)
	return ITEMS_TO_CHANGE[slotType] and ITEMS_TO_CHANGE[slotType][Addon.SELECTED_CLASS_ID];
end
Addon.API.GetCatalystItem = GetCatalystItem;

local function UpdateCatalystLoot()
	local CatalystPopout = Addon.Frames.CatalystPopout;

	if (Addon.API.GetTocVersion() >= 100200) then
		CatalystPopout:Hide();
		return;
	end

	local numIcons = 0;
	local ITEM_LIST = {};

	if (Addon.SELECTED_SLOT_ID == -1) then
		ITEM_LIST = Addon.API.GetInstanceFavorites(CatalystPopout.instanceID) or {};
	elseif (ITEMS_TO_CHANGE[Addon.SELECTED_SLOT_ID] ~= nil) then
		local itemInfo = ITEMS_TO_CHANGE[Addon.SELECTED_SLOT_ID][Addon.SELECTED_CLASS_ID];

		ITEM_LIST = {
			[itemInfo.itemID] = { icon = itemInfo.icon }
		};
	end

	for itemID, itemInfo in next, ITEM_LIST do
		numIcons = numIcons + 1;

		local ItemFrame = Addon.GetCatalystItemFrame(numIcons);
		local FavoriteStar = ItemFrame.FavoriteStar;

		local favoriteItem = Addon.API.GetFavorite(CatalystPopout.instanceID, itemID);
		local isFavorite = favoriteItem ~= nil;

		FavoriteStar:SetDesaturated(not isFavorite);
		FavoriteStar:SetShown(isFavorite);

		ItemFrame.isFavorite = isFavorite;
		ItemFrame.link = 'item:'..itemID;
		ItemFrame.itemID = itemID;

		ItemFrame.Icon:SetTexture(itemInfo.icon);

		ItemFrame:Show();
	end

	for i=(numIcons + 1), #Addon.GetCatalystItemFrames() do
		local ItemFrame = Addon.GetCatalystItemFrame(i);
		ItemFrame:Hide();
	end


	CatalystPopout:SetHeight(104 + (numIcons * 40));
	CatalystPopout:SetShown(numIcons ~= 0);
end
Addon.API.UpdateCatalystLoot = UpdateCatalystLoot;