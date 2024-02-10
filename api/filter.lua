local AddonName, Addon = ...;

local Filter = {};
Addon.Filter = Filter;

local _buttons = {};

local function OnClick(self)
	Addon.DropDownMenu:Toggle(self);

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

local function OnEvent(self, event)
	self:UnregisterEvent(event);
	self:SetScript('OnEvent', nil);

	C_Timer.After(3, function()
		Addon.DropDownMenu:SetCurrent(self);

		self:Init();
	end)
end

function Filter:CreateButton(parent, filterID)
	local Button = CreateFrame('Button', nil, parent, 'UIMenuButtonStretchTemplate');
	Button.ID = filterID;

	Button:SetSize(110, 24);
	Button:SetPoint('TOP', -55, -35);
	Button:SetScript('OnClick', OnClick);
	Button:SetScript('OnEvent', OnEvent);
	Button:RegisterEvent('PLAYER_ENTERING_WORLD');

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

	table.insert(_buttons, Button);

	return Button;
end

function Filter:GetButton(filterID)
	for index, FilterButton in next, _buttons do
		if (FilterButton.ID == filterID) then
			return FilterButton;
		end
	end
end