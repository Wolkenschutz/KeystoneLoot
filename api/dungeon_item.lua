local AddonName, Addon = ...;


local DungeonItem = {};
Addon.DungeonItem = DungeonItem;


local function OnEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT');

	local itemLink = Addon.UpgradeItem:GetItemLink(self.itemID);
	if (itemLink) then
		GameTooltip:SetHyperlink(itemLink);
	else
		GameTooltip:SetText(RETRIEVING_ITEM_INFO, RED_FONT_COLOR:GetRGB());
	end

	GameTooltip:Show();

	local _, _, playerClassID = UnitClass('player');
	local classID = Addon.Database:GetSelectedClass();
	local slotID = Addon.Database:GetSelectedSlot();

	if (not self.isFavorite and (classID == playerClassID or slotID == -1)) then
		local FavoriteStar = self.FavoriteStar;

		FavoriteStar:SetDesaturated(true);
		FavoriteStar:Show();
	end

	if (IsModifiedClick('DRESSUP')) then
		ShowInspectCursor();
	else
		ResetCursor();
	end

	Addon.DropDownMenu:Close();
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
		local _, itemLink = GetItemInfo(self.itemID); -- NOTE: Man kann keine modifizierten Items posten
		HandleModifiedItemClick(itemLink);
		return;
	end

	local mapID = self:GetParent().mapID;
	local itemID = self.itemID;
	local icon = self.Icon:GetTexture();

	local classID, specID = Addon.Database:GetSelectedClass();
	local slotID = Addon.Database:GetSelectedSlot();
	local _, _, playerClassID = UnitClass('Player');

	if (self.isLootReminder) then
		specID = self:GetParent().specID;
	elseif (Addon.Database:IsFavoritesShowAllSpecs()) then
		specID = self.specID;
	end

	local db = Addon.Database:GetFavorite(mapID, specID, itemID);
	if (db == nil and (self.isLootReminder ~= nil or classID == playerClassID or slotID == -1)) then
		self.isFavorite = true;
		self.FavoriteStar:SetDesaturated(false);

		Addon.Database:SetFavorite(mapID, specID, itemID, icon);
	else
		self.isFavorite = false;
		self.FavoriteStar:SetDesaturated(true);

		Addon.Database:RemoveFavorite(mapID, specID, itemID);
	end
end

local function CreateItemFrame(index, parent)
	local Frame = CreateFrame('Button', nil, parent);
	Frame:SetSize(32, 32);

	Frame.UpdateTooltip = OnEnter;
	Frame:SetScript('OnEnter', OnEnter);
	Frame:SetScript('OnLeave', OnLeave);
	Frame:SetScript('OnClick', OnClick);

	if (index == 1) then
		Frame:SetPoint('TOPLEFT', 11, -10);
	elseif (mod(index, 4) == 1) then
		Frame:SetPoint('TOP', parent.ItemFrames[index - 4], 'BOTTOM', 0, -8);
	else
		Frame:SetPoint('LEFT', parent.ItemFrames[index - 1], 'RIGHT', 10, 0);
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

function DungeonItem:GetFrame(index, parent)
	return parent.ItemFrames[index] or CreateItemFrame(index, parent);
end


function DungeonItem:Update()
	local classID, specID = Addon.Database:GetSelectedClass();
	local slotID = Addon.Database:GetSelectedSlot();

	Addon.Catalyst:Update();

	for _, dungeon in next, Addon.Dungeon:GetFrames() do
		local mapID = dungeon.mapID;
		local numItems = 0;

		for index, itemInfo in next, Addon.GameData:GetLootTable(mapID, slotID, classID, specID) do
			numItems = numItems + 1;

			local Frame = self:GetFrame(index, dungeon);
			local FavoriteStar = Frame.FavoriteStar;

			local specID = itemInfo.specID or specID;
			local itemID = itemInfo.itemID;
			local isFavoriteItem = Addon.Database:GetFavorite(mapID, specID, itemID) ~= nil;

			FavoriteStar:SetDesaturated(not isFavoriteItem);
			FavoriteStar:SetShown(isFavoriteItem);

			Frame.isFavorite = isFavoriteItem;
			Frame.itemID = itemID;
			Frame.specID = specID;
			Frame.Icon:SetTexture(itemInfo.icon);
			Frame:Show();
		end

		for index=(numItems + 1), #dungeon.ItemFrames do
			local Frame = self:GetFrame(index, dungeon);
			Frame:Hide();
		end

		dungeon:SetDisabled(numItems == 0);
	end
end