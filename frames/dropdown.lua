local AddonName, Addon = ...;


local BUTTONS = {};


local function DropDownMenu_OnShow(self)
	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);
end

local Frame = CreateFrame('Frame', nil, Addon.Frames.Main, 'TooltipBackdropTemplate');
Addon.Frames.DropDownMenu = Frame;
Frame:Hide();
Frame:SetToplevel(true);
Frame:SetFrameStrata('FULLSCREEN_DIALOG');
Frame:SetSize(180, 24);
Frame:SetPoint('TOP', 0, -60);
Frame:SetScript('OnShow', DropDownMenu_OnShow);


local function DropDownButton_OnEnter(self)
	self.Background:Show();
end

local function DropDownButton_OnLeave(self)
	self.Background:Hide();
end

local function DropDownButton_OnClick(self)
	local info = self.info;

	if (type(info.args) == 'table') then
		info.func(unpack(info.args));
	else
		info.func(info.args);
	end

	if (not info.keepShownOnClick) then
		Addon.API.CloseDropDownMenu();
	else
		Addon.API.UpdateDropDownMenu();
	end

	PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
end

local function CreateDropDownButton(i)
	local Button = CreateFrame('Button', nil, Frame);
	Button:SetSize(180, 18);
	Button:SetScript('OnEnter', DropDownButton_OnEnter);
	Button:SetScript('OnLeave', DropDownButton_OnLeave);
	Button:SetScript('OnClick', DropDownButton_OnClick);

	if (i == 1) then
		Button:SetPoint('TOPLEFT', 15, -10);
		Button:SetPoint('TOPRIGHT', -15, -10);
	else
		Button:SetPoint('TOPLEFT', BUTTONS[i - 1], 'BOTTOMLEFT');
		Button:SetPoint('TOPRIGHT', BUTTONS[i - 1], 'BOTTOMRIGHT');
	end

	local Background = Button:CreateTexture(nil, 'BACKGROUND');
	Button.Background = Background;
	Background:Hide();
	Background:SetAllPoints();
	Background:SetTexture('Interface\\QuestFrame\\UI-QuestLogTitleHighlight');
	Background:SetBlendMode('ADD');
	Background:SetVertexColor(0.8, 0.6, 0, 1);

	local Check = Button:CreateTexture(nil, 'ARTWORK');
	Button.Check = Check;
	Check:SetSize(16, 16);
	Check:SetPoint('LEFT');
	Check:SetTexture('Interface\\Common\\UI-DropDownRadioChecks');
	Check:SetTexCoord(0.5, 1, 0, 0.5);

	local Divider = Button:CreateTexture(nil, 'BACKGROUND');
	Button.Divider = Divider;
	Divider:SetAllPoints();
	Divider:SetTexture('Interface\\Common\\UI-TooltipDivider-Transparent');

	local Text = Button:CreateFontString('ARTWORK', nil, 'GameFontHighlightSmallLeft');
	Button.Text = Text;
	Text:SetWordWrap(false);
	Text:SetPoint('LEFT', Check, 'RIGHT', 4, -1);

	table.insert(BUTTONS, Button);

	return Button;
end

local function GetDropDownButton(i)
	return BUTTONS[i] or CreateDropDownButton(i);
end
Addon.GetDropDownButton = GetDropDownButton;


local function GetDropDownButtons()
	return BUTTONS;
end
Addon.GetDropDownButtons = GetDropDownButtons;