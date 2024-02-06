local AddonName, Addon = ...;
Addon.Frames = {};


local Translate = Addon.Translate;


local function UpdateTitle(self)
	local currentSeason = C_MythicPlus.GetCurrentUIDisplaySeason();
	if (not currentSeason) then
		self:SetTitle('KeystoneLoot');
		return;
	end

	local expansionName = _G['EXPANSION_NAME'..GetExpansionLevel()] or UNKNOWN;
	local title = (Translate['%s (%s Season %d)']):format('KeystoneLoot', expansionName, currentSeason);

	self:SetTitle(title);
end

local function OnShow(self)
    UpdateTitle(self);

	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);
end


local Frame = CreateFrame('Frame', nil, UIParent, 'PortraitFrameTexturedBaseTemplate');
Addon.Frames.Overview = Frame;
Frame.Tabs = {};
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

Frame:SetPortraitToAsset('Interface\\Icons\\INV_Relics_Hourglass_02');


local function CloseButton_OnClick(self)
	self:GetParent():Hide();
end

local CloseButton = CreateFrame('Button', nil, Frame, 'UIPanelCloseButtonDefaultAnchors');
CloseButton:SetScript('OnClick', CloseButton_OnClick);


local AddonMarkerText = Frame:CreateFontString('ARTWORK', nil, 'GameFontDisableSmall');
AddonMarkerText:SetPoint('BOTTOM', 0, 6);
AddonMarkerText:SetShadowOffset(0, 0);
AddonMarkerText:SetText(Translate['Made with LOVE in Germany']);