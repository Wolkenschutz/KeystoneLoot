local AddonName, Addon = ...;


local function OnEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT');

	local itemLink = Addon.API.UpgradeItemTo(self.link, Addon.SELECTED_ITEMLEVEL, Addon.SELECTED_ITEMLEVEL_BONUSID);
	if (itemLink) then
		GameTooltip:SetHyperlink(itemLink);
	else
		GameTooltip:SetText(RETRIEVING_ITEM_INFO, RED_FONT_COLOR:GetRGB());
	end

	GameTooltip:Show();

	local _, _, classID = UnitClass('player');
	if (not self.isFavorite and (Addon.SELECTED_CLASS_ID == classID or Addon.SELECTED_SLOT_ID == -1)) then
		local FavoriteStar = self.FavoriteStar;

		FavoriteStar:SetDesaturated(true);
		FavoriteStar:Show();
	end

	if (IsModifiedClick('DRESSUP')) then
		ShowInspectCursor();
	else
		ResetCursor();
	end

	Addon.API.CloseDropDownMenu();
end

local function OnLeave(self)
	GameTooltip:Hide();

	if (not self.isFavorite) then
		self.FavoriteStar:Hide();
	end

	ResetCursor();
end

local function OnClick(self)
	if (IsModifierKeyDown()) then
		local _, itemLink = GetItemInfo(self.link); -- NOTE: Man kann keine modifizierten Items posten
		HandleModifiedItemClick(itemLink);
		return;
	end

	local instanceID = self:GetParent().instanceID;
	local itemID = self.itemID;
	local icon = self.Icon:GetTexture();

	local _, _, classID = UnitClass('player');
	local db = Addon.API.GetFavorite(instanceID, itemID);
	if (db == nil and (Addon.SELECTED_CLASS_ID == classID or Addon.SELECTED_SLOT_ID == -1)) then
		self.isFavorite = true;
		self.FavoriteStar:SetDesaturated(false);

		Addon.API.SetFavorite(instanceID, itemID, icon);
	else
		self.isFavorite = false;
		self.FavoriteStar:SetDesaturated(true);

		Addon.API.RemoveFavorite(instanceID, itemID);
	end
end

local function CreateItemFrame(i, parent)
	local Frame = CreateFrame('Button', nil, parent);
	Frame:SetSize(32, 32);

	Frame.UpdateTooltip = OnEnter;
	Frame:SetScript('OnEnter', OnEnter);
	Frame:SetScript('OnLeave', OnLeave);
	Frame:SetScript('OnClick', OnClick);

	if (i == 1) then
		Frame:SetPoint('TOPLEFT', 11, -10);
	elseif (mod(i, 4) == 1) then
		Frame:SetPoint('TOP', parent.ItemFrames[i - 4], 'BOTTOM', 0, -8);
	else
		Frame:SetPoint('LEFT', parent.ItemFrames[i - 1], 'RIGHT', 10, 0);
	end

	local Icon = Frame:CreateTexture();
	Frame.Icon = Icon;
	Icon:SetDrawLayer('ARTWORK', 1);
	Icon:SetAllPoints();
	Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92);

	local IconBorder = Frame:CreateTexture();
	IconBorder:SetDrawLayer('ARTWORK', 2);
	IconBorder:SetSize(58, 58);
	IconBorder:SetPoint('CENTER', Icon);
	IconBorder:SetTexture('Interface\\Buttons\\UI-Quickslot2');

	local FavoriteStar = Frame:CreateTexture();
	Frame.FavoriteStar = FavoriteStar;
	FavoriteStar:SetDrawLayer('ARTWORK', 3);
	FavoriteStar:SetSize(24, 24);
	FavoriteStar:SetPoint('TOPRIGHT', 8, 8);
	FavoriteStar:SetAtlas('PetJournal-FavoritesIcon');
	FavoriteStar:Hide();


	table.insert(parent.ItemFrames, Frame);

	return Frame;
end


local function GetItemFrame(i, parent)
	return parent.ItemFrames[i] or CreateItemFrame(i, parent);
end
Addon.GetItemFrame = GetItemFrame;