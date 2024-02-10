local AddonName, Addon = ...;


local Translate = Addon.Translate;


local function OnShow(self)
	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);

	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN);
end

local function OnHide(self)
	PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);
end


local Frame = CreateFrame('Frame', nil, UIParent, 'SimplePanelTemplate');
Addon.Frames.LootReminder = Frame;

Frame:Hide();
Frame:SetSize(520, 217);
Frame:SetPoint('CENTER', 0, 217);

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

Frame.Inset:Hide();

Frame.Bg:SetPoint('TOPLEFT', 0, -6);
Frame.Bg:SetPoint('BOTTOMRIGHT', -4, 3);

local HeadlineBg = Frame:CreateTexture(nil, 'BACKGROUND');
HeadlineBg:SetHeight(26);
HeadlineBg:SetPoint('TOPLEFT', 40, -21);
HeadlineBg:SetPoint('TOPRIGHT', -40, -21);
HeadlineBg:SetTexture('Interface\\QuestFrame\\UI-QuestLogTitleHighlight');
HeadlineBg:SetBlendMode('ADD');
HeadlineBg:SetVertexColor(0.1, 0.1, 0.1, 1);

local HeadlineText = Frame:CreateFontString('ARTWORK', nil, 'GameFontNormal');
HeadlineText:SetHeight(26);
HeadlineText:SetPoint('TOPLEFT', 18, -21);
HeadlineText:SetPoint('TOPRIGHT', -20, -21);
HeadlineText:SetText(Translate['Correct loot specialization set?']);


local function CloseButton_OnClick(self)
	self:GetParent():Hide();
end

local CloseButton = CreateFrame('Button', nil, Frame, 'UIPanelCloseButtonDefaultAnchors');
CloseButton:SetScript('OnClick', CloseButton_OnClick);
