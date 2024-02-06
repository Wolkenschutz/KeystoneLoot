local AddonName, Addon = ...;


local Translate = Addon.Translate;
local OverviewFrame = Addon.Frames.Overview;


local function OnShow(self)
	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);
end


local Frame = CreateFrame('Frame', nil, OverviewFrame);
Addon.Frames.CatalystPopout = Frame;
Frame.mapID = 'catalyst';
Frame.ItemFrames = {};
Frame:Hide();
Frame:SetFrameLevel(0);
Frame:SetSize(70, 140);
Frame:SetPoint('TOPLEFT', OverviewFrame, 'TOPRIGHT', -10, -40);
Frame:SetScript('OnShow', OnShow);

local Border = CreateFrame('Frame', nil, Frame, 'DialogBorderTemplate');
Frame.Border = Border;

Border.Bg:SetTexture('Interface\\FrameGeneral\\UI-Background-Marble');


local function OnEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_RIGHT');
	GameTooltip:SetText(Translate['Revival Catalyst'], HIGHLIGHT_FONT_COLOR:GetRGB());
	GameTooltip:Show();
end

local function OnLeave(self)
	GameTooltip:Hide();
end

local CatalystIconFrame = CreateFrame('Frame', nil, Frame);
CatalystIconFrame:SetSize(32, 32);
CatalystIconFrame:SetPoint('TOP', 0, -20);
CatalystIconFrame:SetScript('OnEnter', OnEnter);
CatalystIconFrame:SetScript('OnLeave', OnLeave);

local CatalystIcon = CatalystIconFrame:CreateTexture(nil, 'ARTWORK');
CatalystIcon:SetAllPoints();
CatalystIcon:SetAtlas('CreationCatalyst-32x32');

local Arrow = CatalystIconFrame:CreateTexture(nil, 'ARTWORK');
Arrow:SetSize(20, 40);
Arrow:SetPoint('TOP', 0, -31);
Arrow:SetAtlas('ItemUpgrade_HelpTipArrow');
Arrow:SetRotation(29.85);