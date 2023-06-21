local AddonName, Addon = ...;


local function UpdateLoot()
	local mythicTierID = Addon.API.GetMythicTierID();
	if (mythicTierID == nil) then
		return;
	end

	if (Addon.SELECTED_SLOT_ID == -1) then
		for _, InstanceFrame in next, Addon.GetInstanceFrames() do
			local instanceID = InstanceFrame.instanceID;
			local instanceFavorites = Addon.API.GetInstanceFavorites(instanceID);

			for i=1, 8 do
				local ItemFrame = Addon.GetItemFrame(i, InstanceFrame);
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
					ItemFrame.link = itemInfo.link;
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

	EJ_SetDifficulty(DifficultyUtil.ID.DungeonChallenge);
	EJ_SetLootFilter(Addon.SELECTED_CLASS_ID, Addon.SELECTED_SPEC_ID);

	C_EncounterJournal.SetSlotFilter(Addon.SELECTED_SLOT_ID);
	C_EncounterJournal.SetPreviewMythicPlusLevel(16); -- FIXME: ??? Kaputt seit Dragonflight. Alternative?

	EJ_SelectTier(mythicTierID);
	EJ_SetDifficulty(DifficultyUtil.ID.DungeonChallenge);

	local i = 1;
	local id = EJ_GetInstanceByIndex(i, false);

	while (id) do
		EJ_SelectInstance(id);

		local InstanceFrame = Addon.GetInstanceFrame(i);

		for i=1, 8 do
			local ItemFrame = Addon.GetItemFrame(i, InstanceFrame);
			local FavoriteStar = ItemFrame.FavoriteStar;

			local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i);
			if (itemInfo == nil) then
				ItemFrame:Hide();
				FavoriteStar:Hide();
			else
				local itemID = itemInfo.itemID;
				local db = Addon.API.GetFavorite(id, itemID);
				local isFavorite = db ~= nil;

				FavoriteStar:SetDesaturated(not isFavorite);
				FavoriteStar:SetShown(isFavorite);

				ItemFrame.isFavorite = isFavorite;
				ItemFrame.link = itemInfo.link;
				ItemFrame.itemID = itemID;
				ItemFrame.Icon:SetTexture(itemInfo.icon);
				ItemFrame:Show();
			end
		end

		local numLoot = EJ_GetNumLoot();

		InstanceFrame.Title:SetTextColor((numLoot == 0 and GRAY_FONT_COLOR or HIGHLIGHT_FONT_COLOR):GetRGB());
		InstanceFrame.Bg:SetDesaturated(numLoot == 0);
		InstanceFrame:SetAlpha(numLoot == 0 and 0.8 or 1);

		i = i+1;
		id = EJ_GetInstanceByIndex(i, false);
	end
end
Addon.API.UpdateLoot = UpdateLoot;