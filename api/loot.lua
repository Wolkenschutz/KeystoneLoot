local AddonName, Addon = ...;


local function UpdateLoot()
	local mythicTierID = Addon.API.GetMythicTierID();
	if (not mythicTierID) then
		return;
	end

	Addon.API.UpdateCatalystLoot();

	if (Addon.SELECTED_SLOT_ID == -1) then
		for _, InstanceFrame in next, Addon.GetInstanceFrames() do
			local numLoot = 0;
			local instanceFavorites = Addon.API.GetFavorites(InstanceFrame.mapID);

			if (instanceFavorites ~= nil) then
				for itemID, itemInfo in next, instanceFavorites do
					numLoot = numLoot + 1;

					if (numLoot > 8) then
						break;
					end

					local ItemFrame = Addon.GetItemFrame(numLoot, InstanceFrame);
					local FavoriteStar = ItemFrame.FavoriteStar;

					FavoriteStar:SetDesaturated(false);
					FavoriteStar:Show();

					ItemFrame.isFavorite = true;
					ItemFrame.link = 'item:'..itemID;
					ItemFrame.itemID = itemID;
					ItemFrame.Icon:SetTexture(itemInfo.icon);
					ItemFrame:Show();
				end
			end

			for index=(numLoot + 1), 8 do
				local ItemFrame = Addon.GetItemFrame(index, InstanceFrame);
				ItemFrame:Hide();
			end

			InstanceFrame.Title:SetTextColor((numLoot == 0 and GRAY_FONT_COLOR or HIGHLIGHT_FONT_COLOR):GetRGB());
			InstanceFrame.Bg:SetDesaturated(numLoot == 0);
			InstanceFrame:SetAlpha(numLoot == 0 and 0.8 or 1);
		end
		return;
	end

	EJ_ClearSearch();

	EJ_SelectTier(mythicTierID);
	EJ_SetDifficulty(DifficultyUtil.ID.DungeonChallenge);

	EJ_SetLootFilter(Addon.SELECTED_CLASS_ID, Addon.SELECTED_SPEC_ID);
	C_EncounterJournal.SetSlotFilter(Addon.SELECTED_SLOT_ID);

	for _, InstanceFrame in next, Addon.GetInstanceFrames() do
		local instanceID = InstanceFrame.instanceID;
		local mapID = InstanceFrame.mapID;

		EJ_SelectInstance(instanceID);

		local numLoot = 0;
		local itemFrameIndex = 1;
		local lootIndex = 1;

		local itemInfo = C_EncounterJournal.GetLootInfoByIndex(lootIndex);
		while (itemInfo and itemFrameIndex <= 8) do
			local encounterID = itemInfo.encounterID;
			local itemSkip = false;

			if (
				(mapID == 463 and (encounterID == 2526 or encounterID == 2536 or encounterID == 2534 or encounterID == 2538)) or -- Fall brauch keine Items aus Rise
				(mapID == 464 and (encounterID == 2521 or encounterID == 2528 or encounterID == 2535 or encounterID == 2537)) -- Rise brauch keine Items aus Fall
			) then
				itemSkip = true;
			end

			if (not itemSkip) then
				local ItemFrame = Addon.GetItemFrame(itemFrameIndex, InstanceFrame);
				local FavoriteStar = ItemFrame.FavoriteStar;

				local itemID = itemInfo.itemID;
				local favoriteItem = Addon.API.GetFavorite(mapID, itemID);
				local isFavorite = favoriteItem ~= nil;

				FavoriteStar:SetDesaturated(not isFavorite);
				FavoriteStar:SetShown(isFavorite);

				ItemFrame.isFavorite = isFavorite;
				ItemFrame.link = 'item:'..itemID;
				ItemFrame.itemID = itemID;
				ItemFrame.Icon:SetTexture(itemInfo.icon);
				ItemFrame:Show();

				itemFrameIndex = itemFrameIndex + 1;
				numLoot = numLoot + 1;
			end

			lootIndex = lootIndex + 1;
			itemInfo = C_EncounterJournal.GetLootInfoByIndex(lootIndex);
		end

		for index=itemFrameIndex, 8 do
			local ItemFrame = Addon.GetItemFrame(index, InstanceFrame);
			ItemFrame:Hide();
		end

		InstanceFrame.Title:SetTextColor((numLoot == 0 and GRAY_FONT_COLOR or HIGHLIGHT_FONT_COLOR):GetRGB());
		InstanceFrame.Bg:SetDesaturated(numLoot == 0);
		InstanceFrame:SetAlpha(numLoot == 0 and 0.8 or 1);
	end
end
Addon.API.UpdateLoot = UpdateLoot;