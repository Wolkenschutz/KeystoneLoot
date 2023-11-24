local AddonName, Addon = ...;
Addon.Frames = {};


local Translate = Addon.API.Translate;
local onlyOnce = false;


local function FixMapIdDB()
	if (KEYSTONE_LOOT_CHAR_DB.mapIdFix) then
		return;
	end

	local tempDB = {};
	tempDB.currSeasion = KEYSTONE_LOOT_CHAR_DB.currSeasion;
	tempDB.catalyst = KEYSTONE_LOOT_CHAR_DB.catalyst;

	for instanceID, data in next, KEYSTONE_LOOT_CHAR_DB do
		if (instanceID == 556) then
			tempDB[168] = data
		elseif (instanceID == 762) then
			tempDB[198] = data
		elseif (instanceID == 740) then
			tempDB[199] = data
		elseif (instanceID == 968) then
			tempDB[244] = data
		elseif (instanceID == 1021) then
			tempDB[248] = data
		elseif (instanceID == 65) then
			tempDB[456] = data
		elseif (instanceID == 1209) then
			-- reset :<
		else
			tempDB[instanceID] = data;
		end
	end

	KEYSTONE_LOOT_CHAR_DB = tempDB;
	KEYSTONE_LOOT_CHAR_DB.mapIdFix = true
end

local function FixFavDB()
	if (KEYSTONE_LOOT_CHAR_DB.favFix) then
		return;
	end

	local classSlug = Addon.SELECTED_CLASS_ID..':'..Addon.SELECTED_SPEC_ID;

	local tempDB = {};
	tempDB.currSeasion = KEYSTONE_LOOT_CHAR_DB.currSeasion;

	for instanceID, data in next, KEYSTONE_LOOT_CHAR_DB do
		if (type(instanceID) == 'number' or instanceID == 'catalyst') then
			tempDB[instanceID] = tempDB[instanceID] or {};
			tempDB[instanceID][classSlug] = tempDB[instanceID][classSlug] or {};
			tempDB[instanceID][classSlug] = data
		end
	end

	KEYSTONE_LOOT_CHAR_DB = tempDB;
	KEYSTONE_LOOT_CHAR_DB.favFix = true
end

local function UpdateTitle(self)
	local currentSeason = C_MythicPlus.GetCurrentUIDisplaySeason();
	if (not currentSeason) then
		self:SetTitle('Keystone Loot');
		return;
	end

	local expansionName = _G['EXPANSION_NAME'..GetExpansionLevel()] or UNKNOWN;
	local title = (Translate['%s (%s Season %d)']):format('Keystone Loot', expansionName, currentSeason);

	self:SetTitle(title);
end

local function OnShow(self)
	self:RegisterEvent('EJ_LOOT_DATA_RECIEVED');

	if (not onlyOnce) then
		onlyOnce = true;

		local _, _, classID = UnitClass('player');
		local specID = (GetSpecializationInfo(GetSpecialization()));

		Addon.SELECTED_CLASS_ID = classID;
		Addon.SELECTED_SPEC_ID = specID;

		Addon.SetClassFilter(classID, specID);
		Addon.CreateInstanceFrames();

		Addon.API.CleanUpDatabase();
		FixFavDB();
		FixMapIdDB();

		UpdateTitle(self);
	end

	Addon.API.UpdateLoot();

	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);

	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN);
end

local function OnHide(self)
	self:UnregisterEvent('EJ_LOOT_DATA_RECIEVED');

	Addon.API.CloseDropDownMenu();

	PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);
end


local Frame = CreateFrame('Frame', nil, UIParent, 'PortraitFrameTexturedBaseTemplate');
Addon.Frames.Main = Frame;

Frame:Hide();
Frame:SetFrameLevel(1);
Frame:SetSize(476, 230);
Frame:SetPoint('CENTER');

Frame:SetToplevel(true);
Frame:SetMovable(true);
Frame:SetUserPlaced(true);
Frame:SetClampedToScreen(true);

Frame:EnableMouse(true);
Frame:RegisterForDrag('LeftButton');

Frame:SetScript('OnDragStart', Frame.StartMoving);
Frame:SetScript('OnDragStop', Frame.StopMovingOrSizing);
Frame:SetScript('OnShow', OnShow);
Frame:SetScript('OnHide', OnHide);

Frame:SetPortraitToAsset('Interface\\Icons\\INV_Relics_Hourglass_02');


local NoSeason = Frame:CreateFontString('ARTWORK', nil, 'GameFontHighlightLarge');
Addon.Frames.NoSeason = NoSeason;
NoSeason:Hide();
NoSeason:SetPoint('TOPLEFT', 20, -80);
NoSeason:SetPoint('BOTTOMRIGHT', -20, 26);
NoSeason:SetText(MYTHIC_PLUS_TAB_DISABLE_TEXT);


local function CloseButton_OnClick(self)
	self:GetParent():Hide();
end

local CloseButton = CreateFrame('Button', nil, Frame, 'UIPanelCloseButtonDefaultAnchors');
CloseButton:SetScript('OnClick', CloseButton_OnClick);


local AddonMarker = Frame:CreateFontString('ARTWORK', nil, 'GameFontDisableSmall');
AddonMarker:SetPoint('BOTTOM', 0, 6);
AddonMarker:SetShadowOffset(0, 0);
AddonMarker:SetText(Translate['Made with LOVE in Germany']);
