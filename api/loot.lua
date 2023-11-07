local AddonName, Addon = ...;


local function UpdateLoot()
	local mythicTierID = Addon.API.GetMythicTierID();
	if (not mythicTierID) then
		return;
	end

	Addon.API.UpdateCatalystLoot();

	if (Addon.SELECTED_SLOT_ID == -1) then
		for _, InstanceFrame in next, Addon.GetInstanceFrames() do
			local instanceID = InstanceFrame.instanceID;
			local instanceFavorites = Addon.API.GetInstanceFavorites(instanceID);

			for itemIndex=1, 8 do
				local ItemFrame = Addon.GetItemFrame(itemIndex, InstanceFrame);
				local FavoriteStar = ItemFrame.FavoriteStar;

				ItemFrame:Hide();
				FavoriteStar:Hide();
			end

			local numLoot = 0;
			if (instanceFavorites ~= nil) then
				for itemID, itemInfo in next, instanceFavorites do
					numLoot = numLoot + 1;

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

	local instanceIndex = 1;
	local instanceID = EJ_GetInstanceByIndex(instanceIndex, false);

	while (instanceID) do
		EJ_SelectInstance(instanceID);

		local InstanceFrame = Addon.GetInstanceFrame(instanceIndex);

		for itemIndex=1, 8 do
			local ItemFrame = Addon.GetItemFrame(itemIndex, InstanceFrame);

			local itemInfo = C_EncounterJournal.GetLootInfoByIndex(itemIndex);
			if (itemInfo == nil) then
				ItemFrame:Hide();
			else
				local FavoriteStar = ItemFrame.FavoriteStar;

				local itemID = itemInfo.itemID;
				local favoriteItem = Addon.API.GetFavorite(instanceID, itemID);
				local isFavorite = favoriteItem ~= nil;

				FavoriteStar:SetDesaturated(not isFavorite);
				FavoriteStar:SetShown(isFavorite);

				ItemFrame.isFavorite = isFavorite;
				ItemFrame.link = 'item:'..itemID;
				ItemFrame.itemID = itemID;
				ItemFrame.Icon:SetTexture(itemInfo.icon);
				ItemFrame:Show();
			end
		end

		local numLoot = EJ_GetNumLoot();

		InstanceFrame.Title:SetTextColor((numLoot == 0 and GRAY_FONT_COLOR or HIGHLIGHT_FONT_COLOR):GetRGB());
		InstanceFrame.Bg:SetDesaturated(numLoot == 0);
		InstanceFrame:SetAlpha(numLoot == 0 and 0.8 or 1);

		instanceIndex = instanceIndex+1;
		instanceID = EJ_GetInstanceByIndex(instanceIndex, false);
	end
end
Addon.API.UpdateLoot = UpdateLoot;