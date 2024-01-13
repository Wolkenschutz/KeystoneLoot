local AddonName, Addon = ...;
Addon.Frames.Filter = {};


local MainFrame = Addon.Frames.Main;


local function OnClick(self)
	Addon.API.ToggleDropDownMenu(self, self.ListFunction);

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end


local function CreateFilterButton(filterType, ListFunction, InitFuntion)
	local Button = CreateFrame('Button', nil, MainFrame, 'UIMenuButtonStretchTemplate');
	Button.filterType = filterType;
	Button.ListFunction = ListFunction;
	Button.InitFuntion = InitFuntion;

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

	return Button;
end
Addon.CreateFilterButton = CreateFilterButton;


local FilterBg = MainFrame:CreateTexture(nil, 'BACKGROUND');
FilterBg:SetSize(340, 34);
FilterBg:SetPoint('TOP', 0, -30);
FilterBg:SetTexture('Interface\\QuestFrame\\UI-QuestLogTitleHighlight');
FilterBg:SetBlendMode('ADD');
FilterBg:SetVertexColor(0.1, 0.1, 0.1, 1);