local AddonName, Addon = ...;


local Translate = Addon.API.Translate;
local MainFrame = Addon.Frames.Main;


local function OnShow(self)
	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);
end


local Frame = CreateFrame('Frame', nil, MainFrame);
Addon.Frames.CatalystPopout = Frame;

Frame.mapID = 'catalyst';
Frame.ItemFrames = {};

Frame:Hide();
Frame:SetFrameLevel(0);
Frame:SetSize(70, 140);
Frame:SetPoint('TOPLEFT', MainFrame, 'TOPRIGHT', -10, -40);
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


local function CreateItemFrame(i)
	local ItemFrame = Addon.GetItemFrame(i, Frame);
	ItemFrame:ClearAllPoints();

	if (i == 1) then
		ItemFrame:SetPoint('TOP', 0, -90);
	else
		ItemFrame:SetPoint('TOP', Frame.ItemFrames[i - 1], 'BOTTOM', 0, -8);
	end

	return ItemFrame;
end

local function GetCatalystItemFrame(i)
	return Frame.ItemFrames[i] or CreateItemFrame(i);
end
Addon.GetCatalystItemFrame = GetCatalystItemFrame;

local function GetCatalystItemFrames()
	return Frame.ItemFrames;
end
Addon.GetCatalystItemFrames = GetCatalystItemFrames;