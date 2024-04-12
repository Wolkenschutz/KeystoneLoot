local AddonName, KeystoneLoot = ...;




local function OnEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT');

	local itemLink = KeystoneLoot:GetUpgradeItemLink(self.itemId);
	if (itemLink) then
		GameTooltip:SetHyperlink(itemLink);
	else
		GameTooltip:SetText(RETRIEVING_ITEM_INFO, RED_FONT_COLOR:GetRGB());
	end

	GameTooltip:Show();

	local _, _, playerClassId = UnitClass('player');
	local classId = KeystoneLootCharDB.selectedClassId;
	local slotId = KeystoneLootCharDB.selectedSlotId;

	if (not self.isFavorite and (classId == playerClassId or slotId == -1)) then
		local FavoriteStar = self.FavoriteStar;

		FavoriteStar:SetDesaturated(true);
		FavoriteStar:Show();
	end

	if (IsModifiedClick('DRESSUP')) then
		ShowInspectCursor();
	else
		ResetCursor();
	end

	KeystoneLoot:GetOverview().TooltipFrame:Hide();
end

local function OnLeave(self)
	GameTooltip:Hide();

	if (not self.isFavorite) then
		self.FavoriteStar:Hide();
	end

	ResetCursor();
end

local function OnClick(self)
	local itemId = self.itemId;

	if (IsModifierKeyDown()) then
		local _, itemLink = C_Item.GetItemInfo(itemId); -- NOTE: Man kann keine modifizierten Items posten
		HandleModifiedItemClick(itemLink);
		return;
	end

	local _, _, playerClassId = UnitClass('player');
	local classId = KeystoneLootCharDB.selectedClassId;
	local slotId = KeystoneLootCharDB.selectedSlotId;

	if (classId ~= playerClassId and slotId ~= -1) then
		return;
	end

	local specId = KeystoneLootCharDB.selectedSpecId;
	if (slotId == -1 and KeystoneLootDB.favoritesShowAllSpecs) then
		specId = self.specId;
	end

	local isFavoriteItem = KeystoneLoot:IsFavoriteItem(itemId, specId);
	if (not isFavoriteItem) then
		self.isFavorite = true;
		self.FavoriteStar:SetDesaturated(false);

		local challengeModeId = self:GetParent().challengeModeId;
		local icon = self.Icon:GetTexture();
		KeystoneLoot:AddFavoriteItem(challengeModeId, specId, itemId, icon);
	else
		self.isFavorite = false;
		self.FavoriteStar:SetDesaturated(true);

		if (slotId == -1 and KeystoneLootDB.favoritesShowAllSpecs) then
			specId = nil;
		end
		KeystoneLoot:RemoveFavoriteItem(itemId, specId);
	end
end

function KeystoneLoot:CreateItemButton(parent)
	local Button = CreateFrame('Button', nil, parent);
	Button:SetSize(32, 32);

	Button.UpdateTooltip = OnEnter;
	Button:SetScript('OnEnter', OnEnter);
	Button:SetScript('OnLeave', OnLeave);
	Button:SetScript('OnClick', OnClick);

	local Icon = Button:CreateTexture(nil, 'ARTWORK', nil, 1);
	Button.Icon = Icon;
	Icon:SetAllPoints();
	Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92);

	local IconBorder = Button:CreateTexture(nil, 'ARTWORK', nil, 2);
	IconBorder:SetSize(58, 58);
	IconBorder:SetPoint('CENTER', Icon);
	IconBorder:SetTexture('Interface\\Buttons\\UI-Quickslot2');

	local FavoriteStar = Button:CreateTexture(nil, 'ARTWORK', nil, 3);
	Button.FavoriteStar = FavoriteStar;
	FavoriteStar:SetSize(24, 24);
	FavoriteStar:SetPoint('TOPRIGHT', 8, 8);
	FavoriteStar:SetAtlas('PetJournal-FavoritesIcon');
	FavoriteStar:Hide();

	return Button;
end