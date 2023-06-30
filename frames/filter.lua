local AddonName, Addon = ...;
Addon.Frames.Filter = {};


local MainFrame = Addon.Frames.Main;


local function OnClick(self)
	Addon.SELECTED_FILTER_BUTTON = self;

	ToggleDropDownMenu(1, nil, self.DropDownMenu, self, 5, 0);
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end


local function CreateFilterButton(filterType, initDropDownFunction)
	local Button = CreateFrame('Button', nil, MainFrame, 'UIMenuButtonStretchTemplate');
	Button.filterType = filterType;

	local DropDownMenu = CreateFrame('Frame', nil, nil, 'UIDropDownMenuTemplate');
	Button.DropDownMenu = DropDownMenu;

	Button:SetSize(110, 24);
	Button:SetPoint('TOP', -55, -35);
	Button:SetScript('OnClick', OnClick);

	local Icon = Button:CreateTexture(nil, 'ARTWORK');
	Button.Icon = Icon;
	Icon:SetSize(10, 12);
	Icon:SetPoint('RIGHT', -5, 0);
	Icon:SetTexture('Interface\\ChatFrame\\ChatFrameExpandArrow');

	local Text = Button.Text;
	Text:SetWordWrap(false);
	Text:SetJustifyH('LEFT');
	Text:SetPoint('LEFT', 8, 0);
	Text:SetPoint('RIGHT', Icon, 'LEFT', -2, 0);

	UIDropDownMenu_Initialize(DropDownMenu, initDropDownFunction, 'MENU');

	return Button;
end
Addon.CreateFilterButton = CreateFilterButton;


local FilterBg = MainFrame:CreateTexture(nil, 'BACKGROUND');
FilterBg:SetSize(340, 34);
FilterBg:SetPoint('TOP', 0, -30);
FilterBg:SetTexture('Interface\\QuestFrame\\UI-QuestLogTitleHighlight');
FilterBg:SetBlendMode('ADD');
FilterBg:SetVertexColor(0.1, 0.1, 0.1, 1);