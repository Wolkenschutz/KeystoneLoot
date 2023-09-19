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

if (Addon.API.GetTocVersion() >= 100200) then
    ITEMS_TO_CHANGE = {
        [Enum.ItemSlotFilterType.Head] = {
            { itemID = 207182, icon = 5330051 },
            { itemID = 207191, icon = 5142417 },
            { itemID = 207218, icon = 5226495 },
            { itemID = 207236, icon = 5349810 },
            { itemID = 207281, icon = 5279082 },
            { itemID = 207200, icon = 5343238 },
            { itemID = 207209, icon = 4952860 },
            { itemID = 207290, icon = 5167093 },
            { itemID = 207272, icon = 5202182 },
            { itemID = 207245, icon = 5210377 },
            { itemID = 207254, icon = 5343025 },
            { itemID = 207263, icon = 5153468 },
            { itemID = 207227, icon = 5357701 }
        },
        [Enum.ItemSlotFilterType.Shoulder] = {
            { itemID = 207180, icon = 5330053 },
            { itemID = 207189, icon = 5142420 },
            { itemID = 207216, icon = 5226497 },
            { itemID = 207234, icon = 5349812 },
            { itemID = 207279, icon = 5309927 },
            { itemID = 207198, icon = 5343240 },
            { itemID = 207207, icon = 4952862 },
            { itemID = 207288, icon = 5167095 },
            { itemID = 207270, icon = 5202184 },
            { itemID = 207243, icon = 5210383 },
            { itemID = 207252, icon = 5343028 },
            { itemID = 207261, icon = 5153470 },
            { itemID = 207225, icon = 5357704 }
        },
        [Enum.ItemSlotFilterType.Chest] = {
            { itemID = 207185, icon = 5330049 },
            { itemID = 207194, icon = 5142409 },
            { itemID = 207221, icon = 5226493 },
            { itemID = 207239, icon = 5349808 },
            { itemID = 207284, icon = 5279084 },
            { itemID = 207203, icon = 5343236 },
            { itemID = 207212, icon = 4952858 },
            { itemID = 207293, icon = 5167091 },
            { itemID = 207275, icon = 5202180 },
            { itemID = 207248, icon = 5210375 },
            { itemID = 207257, icon = 5343023 },
            { itemID = 207266, icon = 5153466 },
            { itemID = 207230, icon = 5357699 }
        },
        [Enum.ItemSlotFilterType.Hand] = {
            { itemID = 207183, icon = 5330050 },
            { itemID = 207192, icon = 5142412 },
            { itemID = 207219, icon = 5226494 },
            { itemID = 207237, icon = 5349809 },
            { itemID = 207282, icon = 5279081 },
            { itemID = 207201, icon = 5343237 },
            { itemID = 207210, icon = 4952859 },
            { itemID = 207291, icon = 5167092 },
            { itemID = 207273, icon = 5202181 },
            { itemID = 207246, icon = 5210376 },
            { itemID = 207255, icon = 5343024 },
            { itemID = 207264, icon = 5153467 },
            { itemID = 207228, icon = 5357700 }
        },
        [Enum.ItemSlotFilterType.Legs] = {
            { itemID = 207181, icon = 5330052 },
            { itemID = 207190, icon = 5142419 },
            { itemID = 207217, icon = 5226496 },
            { itemID = 207235, icon = 5349811 },
            { itemID = 207280, icon = 5279083 },
            { itemID = 207199, icon = 5343239 },
            { itemID = 207208, icon = 4952861 },
            { itemID = 207289, icon = 5167094 },
            { itemID = 207271, icon = 5202183 },
            { itemID = 207244, icon = 5210378 },
            { itemID = 207253, icon = 5343026 },
            { itemID = 207262, icon = 5153469 },
            { itemID = 207226, icon = 5357702 }
        },
        [Enum.ItemSlotFilterType.Cloak] = {
            { itemID = 207176, icon = 5330048 },
            { itemID = 207186, icon = 5142406 },
            { itemID = 207213, icon = 5226492 },
            { itemID = 207231, icon = 5349807 },
            { itemID = 207276, icon = 5279080 },
            { itemID = 207195, icon = 5343235 },
            { itemID = 207204, icon = 4952857 },
            { itemID = 207285, icon = 5167090 },
            { itemID = 207267, icon = 5202179 },
            { itemID = 207240, icon = 5210374 },
            { itemID = 207249, icon = 5343022 },
            { itemID = 207258, icon = 5153465 },
            { itemID = 207222, icon = 5357697 }
        },
        [Enum.ItemSlotFilterType.Wrist] = {
            { itemID = 207177, icon = 5330047 },
            { itemID = 207187, icon = 5142405 },
            { itemID = 207214, icon = 5226491 },
            { itemID = 207232, icon = 5349806 },
            { itemID = 207277, icon = 5279079 },
            { itemID = 207196, icon = 5343234 },
            { itemID = 207205, icon = 4952856 },
            { itemID = 207286, icon = 5167089 },
            { itemID = 207268, icon = 5202178 },
            { itemID = 207241, icon = 5210373 },
            { itemID = 207250, icon = 5343021 },
            { itemID = 207259, icon = 5153464 },
            { itemID = 207223, icon = 5357696 }
        },
        [Enum.ItemSlotFilterType.Waist] = {
            { itemID = 207179, icon = 5330045 },
            { itemID = 207188, icon = 5142403 },
            { itemID = 207215, icon = 5226473 },
            { itemID = 207233, icon = 5349804 },
            { itemID = 207278, icon = 5279077 },
            { itemID = 207197, icon = 5343232 },
            { itemID = 207206, icon = 4952854 },
            { itemID = 207287, icon = 5167087 },
            { itemID = 207269, icon = 5202176 },
            { itemID = 207242, icon = 5210371 },
            { itemID = 207251, icon = 5343019 },
            { itemID = 207260, icon = 5153462 },
            { itemID = 207224, icon = 5357694 }
        },
        [Enum.ItemSlotFilterType.Feet] = {
            { itemID = 207184, icon = 5330046 },
            { itemID = 207193, icon = 5142404 },
            { itemID = 207220, icon = 5226490 },
            { itemID = 207238, icon = 5349805 },
            { itemID = 207283, icon = 5279078 },
            { itemID = 207202, icon = 5343233 },
            { itemID = 207211, icon = 4952855 },
            { itemID = 207292, icon = 5167088 },
            { itemID = 207274, icon = 5202177 },
            { itemID = 207247, icon = 5210372 },
            { itemID = 207256, icon = 5343020 },
            { itemID = 207265, icon = 5153463 },
            { itemID = 207229, icon = 5357695 }
        }
    };
end


local function GetCatalystItem(slotType)
	return ITEMS_TO_CHANGE[slotType] and ITEMS_TO_CHANGE[slotType][Addon.SELECTED_CLASS_ID];
end
Addon.API.GetCatalystItem = GetCatalystItem;

local function UpdateCatalystLoot()
	local CatalystPopout = Addon.Frames.CatalystPopout;

	if (Addon.API.GetTocVersion() >= 100300) then
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