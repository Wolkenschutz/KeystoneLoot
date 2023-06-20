local AddonName, Addon = ...;


local GetMythicTierID = Addon.API.GetMythicTierID


local function UpdateInstances()
	if (Addon.SELECTED_SLOT_ID == -1) then
		print('STOP! Fav selected');
		return;
	end

	local mythicTierID = GetMythicTierID();
	if (mythicTierID == nil) then
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
	local id, name, _, _, buttonImage = EJ_GetInstanceByIndex(i, false);

	while (name) do
		EJ_SelectInstance(id);

		local InstanceFrame = Addon.GetInstanceFrame(i);

		InstanceFrame.Title:SetText(name);
		InstanceFrame.Bg:SetTexture(buttonImage);

		local numHide = 1;

		for i=1, 8 do
			local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i);
			if (itemInfo == nil) then
				break;
			end

			local ItemFrame = Addon.GetItemFrame(i, InstanceFrame);
			ItemFrame.link = itemInfo.link;
			ItemFrame.Icon:SetTexture(itemInfo.icon);
			ItemFrame:Show();

			numHide = i + 1;
		end

		for i=numHide, 8 do
			local ItemFrame = Addon.GetItemFrame(i, InstanceFrame);
			ItemFrame:Hide();
		end

		local numLoot = EJ_GetNumLoot();

		InstanceFrame.Title:SetFontObject('GameFont'..(numLoot == 0 and 'Disable' or 'Highlight')..'Large');
		InstanceFrame.Bg:SetDesaturated(numLoot == 0);
		InstanceFrame:SetAlpha(numLoot == 0 and 0.8 or 1);

		i = i+1;
		id, name, _, _, buttonImage = EJ_GetInstanceByIndex(i, false);
	end
end
Addon.API.UpdateInstances = UpdateInstances;