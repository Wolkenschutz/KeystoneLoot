local AddonName, Addon = ...;
Addon.Frames.Filter = {};


local MainFrame = Addon.Frames.Main;


local FilterBg = MainFrame:CreateTexture(nil, 'BACKGROUND');
FilterBg:SetSize(300, 34);
FilterBg:SetPoint('TOP', 0, -30);
FilterBg:SetTexture('Interface\\QuestFrame\\UI-QuestLogTitleHighlight');
FilterBg:SetBlendMode('ADD');
FilterBg:SetVertexColor(0.1, 0.1, 0.1, 1);


local function ClassFilter_OnClick(self)
	print('Class filter clicked');
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

local ClassFilter = CreateFrame('Button', nil, MainFrame, 'UIMenuButtonStretchTemplate');
Addon.Frames.Filter.Class = ClassFilter;

ClassFilter:SetSize(100, 24);
ClassFilter:SetPoint('TOP', -55, -35);
ClassFilter:SetScript('OnClick', ClassFilter_OnClick);

local ClassFilterIcon = ClassFilter:CreateTexture(nil, 'ARTWORK');
ClassFilter.Icon = ClassFilterIcon;
ClassFilterIcon:SetSize(10, 12);
ClassFilterIcon:SetPoint('RIGHT', -5, 0);
ClassFilterIcon:SetTexture('Interface\\ChatFrame\\ChatFrameExpandArrow');

local ClassFilterText = ClassFilter.Text;
ClassFilterText:SetWordWrap(false);
ClassFilterText:SetJustifyH('LEFT');
ClassFilterText:SetPoint('LEFT', 8, 0);
ClassFilterText:SetPoint('RIGHT', ClassFilterIcon, 'LEFT', -2, 0);


local function SlotFilter_OnClick(self)
	print('Slot filter clicked');
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

local SlotFilter = CreateFrame('Button', nil, MainFrame, 'UIMenuButtonStretchTemplate');
Addon.Frames.Filter.Slot = SlotFilter;

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