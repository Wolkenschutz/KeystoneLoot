local AddonName, Addon = ...;


local function UpdateLoot()
	local mythicTierID = Addon.API.GetMythicTierID();
	if (mythicTierID == nil) then
		return;
	end

	if (Addon.SELECTED_SLOT_ID == -1) then
		print('STOP! Fav selected');
		-- DB werden icon, link, instanceID, classID und specID gespeichert. DB durchschauen und bei den Instanzen setzen.
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
			local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i);

			if (itemInfo == nil) then
				ItemFrame:Hide();
			else
				ItemFrame.link = itemInfo.link;
				ItemFrame.Icon:SetTexture(itemInfo.icon);
				ItemFrame:Show();
			end
		end

		local numLoot = EJ_GetNumLoot();

		InstanceFrame.Title:SetTextColor((numLoot == 0 and GRAY_FONT_COLOR or NORMAL_FONT_COLOR):GetRGB());
		InstanceFrame.Bg:SetDesaturated(numLoot == 0);
		InstanceFrame:SetAlpha(numLoot == 0 and 0.8 or 1);

		i = i+1;
		id = EJ_GetInstanceByIndex(i, false);
	end
end
Addon.API.UpdateLoot = UpdateLoot;