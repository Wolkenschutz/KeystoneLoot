local AddonName, Addon = ...;


local DropDownMenu = {};
Addon.DropDownMenu = DropDownMenu;

local _currentDropdownParent;
local _buttons = {};


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
		DropDownMenu:Close();
	else
		DropDownMenu:Update();
	end

	PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
end

local function CreateDropDownButton(i)
	local Button = CreateFrame('Button', nil, Addon.Frames.DropDownMenu);
	Button:SetSize(180, 18);
	Button:SetScript('OnEnter', DropDownButton_OnEnter);
	Button:SetScript('OnLeave', DropDownButton_OnLeave);
	Button:SetScript('OnClick', DropDownButton_OnClick);

	if (i == 1) then
		Button:SetPoint('TOPLEFT', 15, -10);
		Button:SetPoint('TOPRIGHT', -15, -10);
	else
		Button:SetPoint('TOPLEFT', _buttons[i - 1], 'BOTTOMLEFT');
		Button:SetPoint('TOPRIGHT', _buttons[i - 1], 'BOTTOMRIGHT');
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

	table.insert(_buttons, Button);

	return Button;
end

local function GetDropDownMenuButton(i)
	return _buttons[i] or CreateDropDownButton(i);
end

local function GetDropDownMenuButtons()
	return _buttons;
end

function DropDownMenu:Toggle(parent)
	local DropDownMenuFrame = Addon.Frames.DropDownMenu;

	if (DropDownMenuFrame:IsShown()) then
		if (parent ~= _currentDropdownParent) then
			_currentDropdownParent = parent;

			self:Update();
			return;
		end

		DropDownMenuFrame:Hide();
	else
		_currentDropdownParent = parent;

		local numButtons = 0;
		local dropdownWidth = 0;
		local dropdownHeight = 0;

		for i, info in next, parent:List() do
			if (info.disabled == nil) then
				info.disabled = false;
			end
			if (info.hasGrayColor == nil) then
				info.hasGrayColor = false;
			end

			local Button = GetDropDownMenuButton(i);
			Button:Show();

			local Check = Button.Check;
			local Divider = Button.Divider;
			local Text = Button.Text;

			local leftPadding = 0;

			if (info.divider) then
				Button:Disable();
				Button:SetHeight(8);
				Check:Hide();
				Divider:Show();
				Text:SetText('');

				dropdownHeight = dropdownHeight + 8;
			else
				Button:SetHeight(18);
				Check:Show();
				Divider:Hide();
				Text:SetText(info.text);

				Button:SetEnabled(not info.disabled);

				if (info.hasGrayColor) then
					Button.Text:SetFontObject('GameFontDisableSmallLeft');
				else
					Button.Text:SetFontObject('GameFontHighlightSmallLeft');
				end

				if (info.checked) then
					Check:SetTexCoord(0, 0.5, 0, 0.5);
				else
					Check:SetTexCoord(0.5, 1, 0, 0.5);
				end

				if (info.notCheckable) then
					Check:SetAlpha(0);
					leftPadding = leftPadding - 20;
				else
					Check:SetAlpha(1);
				end

				if (info.leftPadding) then
					leftPadding = leftPadding + info.leftPadding;
				end

				Check:SetPoint('LEFT', leftPadding, 1);

				dropdownHeight = dropdownHeight + 18;
			end

			Button.info = info;

			dropdownWidth = math.max(dropdownWidth, Button.Text:GetWidth() + leftPadding);
			numButtons = numButtons + 1;
		end

		local buttons = GetDropDownMenuButtons();
		for i=(numButtons + 1), #buttons do
			local Button = GetDropDownMenuButton(i);
			Button:Hide();
		end

		DropDownMenuFrame:SetSize(dropdownWidth + 50, dropdownHeight + 20);
		DropDownMenuFrame:SetPoint('TOPLEFT', parent, 'BOTTOMLEFT', 5, 0);
		DropDownMenuFrame:Show();
	end
end

function DropDownMenu:Close()
	Addon.Frames.DropDownMenu:Hide();
end

function DropDownMenu:Update()
	self:Close();

	local parent = _currentDropdownParent;
	local ListFunction = parent.ListFunction;

	self:Toggle(parent, ListFunction);
end

function DropDownMenu:SetText(text)
	_currentDropdownParent:SetText(text);
end

function DropDownMenu:SetCurrent(frame)
	_currentDropdownParent = frame;
end