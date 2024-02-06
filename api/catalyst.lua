local AddonName, Addon = ...;


local Catalyst = {};
Addon.Catalyst = Catalyst;

local _catalystItemList = {
	[3] = {
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
	}
};


local function CreateItemFrame(index)
	local CatalystPopout = Addon.Frames.CatalystPopout;
	local ItemFrame = Addon.DungeonItem:GetFrame(index, CatalystPopout);

	ItemFrame:ClearAllPoints();

	if (index == 1) then
		ItemFrame:SetPoint('TOP', 0, -90);
	else
		ItemFrame:SetPoint('TOP', CatalystPopout.ItemFrames[index - 1], 'BOTTOM', 0, -8);
	end

	return ItemFrame;
end

local function GetItemFrames()
	return Addon.Frames.CatalystPopout.ItemFrames;
end

local function GetItemFrame(index)
	return GetItemFrames()[index] or CreateItemFrame(index);
end

function Catalyst:Update()
	local CatalystPopout = Addon.Frames.CatalystPopout;

	local currentSeason = C_MythicPlus.GetCurrentUIDisplaySeason();
	local catalystItemList = _catalystItemList[currentSeason];
	if (catalystItemList == nil) then
		CatalystPopout:Hide();
		return;
	end

	local classID, specID = Addon.Database:GetSelectedClass();
	local slotID = Addon.Database:GetSelectedSlot();
	local mapID = CatalystPopout.mapID;
	local numItems = 0;
	local _itemList = {};

	if (slotID == -1) then
		_itemList = Addon.Database:GetFavorites(mapID, specID) or {};
	elseif (catalystItemList[slotID] ~= nil) then
		local itemInfo = catalystItemList[slotID][classID];

		_itemList = {
			[itemInfo.itemID] = { icon = itemInfo.icon }
		};
	end

	for itemID, itemInfo in next, _itemList do
		numItems = numItems + 1;

		local Frame = GetItemFrame(numItems);
		local FavoriteStar = Frame.FavoriteStar;

		local isFavoriteItem = Addon.Database:GetFavorite(mapID, specID, itemID) ~= nil;

		FavoriteStar:SetDesaturated(not isFavoriteItem);
		FavoriteStar:SetShown(isFavoriteItem);

		Frame.isFavorite = isFavoriteItem;
		Frame.itemID = itemID;
		Frame.Icon:SetTexture(itemInfo.icon);
		Frame:Show();
	end

	for i=(numItems + 1), #GetItemFrames() do
		local Frame = GetItemFrame(i);
		Frame:Hide();
	end


	CatalystPopout:SetHeight(104 + (numItems * 40));
	CatalystPopout:SetShown(numItems ~= 0);
end