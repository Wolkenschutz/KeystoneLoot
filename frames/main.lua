local AddonName, Addon = ...;
Addon.Frames = {};


local function Frame_OnShow(self)
	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);

	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN);
end

local function Frame_OnHide(self)
	PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);
end

local Frame = CreateFrame('Frame', nil, UIParent, 'PortraitFrameTexturedBaseTemplate');
Addon.Frames.Main = Frame;

Frame:SetSize(476, 620);
Frame:SetPoint('CENTER');

Frame:SetToplevel(true);
Frame:SetMovable(true);
Frame:SetUserPlaced(true);
Frame:SetClampedToScreen(true);

Frame:EnableMouse(true);
Frame:RegisterForDrag('LeftButton');

Frame:SetScript('OnDragStart', Frame.StartMoving);
Frame:SetScript('OnDragStop', Frame.StopMovingOrSizing);
Frame:SetScript('OnShow', Frame_OnShow);
Frame:SetScript('OnHide', Frame_OnHide);

Frame:SetPortraitToAsset('Interface\\Icons\\INV_Relics_Hourglass_02');
Frame:SetTitle('Keystone Loot');


local function CloseButton_OnClick(self)
	self:GetParent():Hide();
end

local CloseButton = CreateFrame('Button', nil, Frame, 'UIPanelCloseButtonDefaultAnchors');
CloseButton:SetScript('OnClick', CloseButton_OnClick);


local AddonMarker = Frame:CreateFontString('ARTWORK', nil, 'GameFontDisableSmall');
AddonMarker:SetPoint('BOTTOM', 0, 6);
AddonMarker:SetShadowOffset(0, 0);
AddonMarker:SetText('Made with LOVE in Germany');