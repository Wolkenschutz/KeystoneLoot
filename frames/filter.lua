local AddonName, Addon = ...;
Addon.Frames.Filter = {};


local MainFrame = Addon.Frames.MainFrame;


local FilterBg = MainFrame:CreateTexture(nil, 'BACKGROUND');
FilterBg:SetSize(300, 34);
FilterBg:SetPoint('TOP', 0, -30);
FilterBg:SetTexture('Interface\\QuestFrame\\UI-QuestLogTitleHighlight');
FilterBg:SetBlendMode('ADD');
FilterBg:SetVertexColor(0.1, 0.1, 0.1, 1);


local function GearFilter_OnClick(self)
	print('Gear filter clicked');
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

local GearFilter = CreateFrame('Button', nil, MainFrame, 'UIMenuButtonStretchTemplate');
Addon.Frames.Filter.Gear = GearFilter;

GearFilter:SetSize(100, 24);
GearFilter:SetPoint('TOP', -55, -35);
GearFilter:SetScript('OnClick', GearFilter_OnClick);

local GearFilterIcon = GearFilter:CreateTexture(nil, 'ARTWORK');
GearFilter.Icon = GearFilterIcon;
GearFilterIcon:SetSize(10, 12);
GearFilterIcon:SetPoint('RIGHT', -5, 0);
GearFilterIcon:SetTexture('Interface\\ChatFrame\\ChatFrameExpandArrow');

local GearFilterText = GearFilter.Text;
GearFilterText:SetWordWrap(false);
GearFilterText:SetJustifyH('LEFT');
GearFilterText:SetPoint('LEFT', 8, 0);
GearFilterText:SetPoint('RIGHT', GearFilterIcon, 'LEFT', -2, 0);


local function SlotFilter_OnClick(self)
	print('Slot filter clicked');
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

local SlotFilter = CreateFrame('Button', nil, MainFrame, 'UIMenuButtonStretchTemplate');
Addon.Frames.Filter.Slot = GearFilter;

SlotFilter:SetSize(100, 24);
SlotFilter:SetPoint('TOP', 55, -35);
SlotFilter:SetScript('OnClick', SlotFilter_OnClick);
SlotFilter:SetText(INVTYPE_HEAD);

local SlotFilterIcon = SlotFilter:CreateTexture(nil, 'ARTWORK');
SlotFilter.Icon = SlotFilterIcon;
SlotFilterIcon:SetSize(10, 12);
SlotFilterIcon:SetPoint('RIGHT', -5, 0);
SlotFilterIcon:SetTexture('Interface\\ChatFrame\\ChatFrameExpandArrow');

local SlotFilterText = SlotFilter.Text;
SlotFilterText:SetWordWrap(false);
SlotFilterText:SetJustifyH('LEFT');
SlotFilterText:SetPoint('LEFT', 8, 0);
SlotFilterText:SetPoint('RIGHT', SlotFilterIcon, 'LEFT', -2, 0);