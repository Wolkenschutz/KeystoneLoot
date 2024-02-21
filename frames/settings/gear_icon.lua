local AddonName, Addon = ...;


local Translate = Addon.Translate;
local Database = Addon.Database;

local Overview = Addon.Frames.Overview;


local function OnEnter(self)
	self:SetAlpha(1);
end

local function OnLeave(self)
	self:SetAlpha(0.7);
end

local function OnClick(self)
	Addon.DropDownMenu:Toggle(self);

	self.GlowArrow:Hide();
	Database:SetNewTextShown(false);

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

local function OnMouseDown(self)
	self:SetPoint('TOPRIGHT', -27, -4);
end

local function OnMouseUp(self)
	self:SetPoint('TOPRIGHT', -28, -3);
end

local function OnShow(self)
	self.GlowArrow:SetShown(Database:IsNewTextShown());
end

local Button = CreateFrame('Button', nil, Overview);
Addon.Frames.OptionButton = Button;
Button:SetAlpha(0.7);
Button:SetSize(18, 18);
Button:SetFrameLevel(510);
Button:RegisterForClicks('LeftButtonUp', 'RightButtonUp');
Button:SetPoint('TOPRIGHT', -28, -3);
Button:SetScript('OnShow', OnShow);
Button:SetScript('OnEnter', OnEnter);
Button:SetScript('OnLeave', OnLeave);
Button:SetScript('OnClick', OnClick);
Button:SetScript('OnMouseDown', OnMouseDown);
Button:SetScript('OnMouseUp', OnMouseUp);

local GearTexture = Button:CreateTexture(nil, 'ARTWORK');
GearTexture:SetAllPoints();
GearTexture:SetTexture('Interface\\WorldMap\\GEAR_64GREY');

local GlowArrow = CreateFrame('Frame', 'KeystoneLootGlowArrow', Overview, 'GlowBoxArrowTemplate');
Button.GlowArrow = GlowArrow;
GlowArrow:SetFrameLevel(510);
GlowArrow:SetPoint('TOP', Button,'BOTTOM', 7, -5);
GlowArrow.Arrow:SetSize(40, 16);
GlowArrow.Arrow:SetRotation(math.rad(180));
GlowArrow.Glow:Hide();

local NewText  = GlowArrow:CreateFontString('ARTWORK', nil, 'GameFontNormal');
NewText:SetPoint('TOP', GlowArrow,'BOTTOM', -6, 0);
NewText:SetSize(40, 10);
NewText:SetJustifyH('CENTER');
NewText:SetText(NEW:upper());


function Button:List()
	local _list = {};

	local info = {};
	info.text = NORMAL_FONT_COLOR:WrapTextInColorCode(SETTINGS_TITLE);
	info.checked = false;
	info.notCheckable = true;
	info.disabled = true;
	table.insert(_list, info);

	local info = {};
	info.text = Translate['Enable Minimap Button'];
	info.checked = Addon.Database:IsMinimapEnabled();
	info.keepShownOnClick = true;
	info.args = not Addon.Database:IsMinimapEnabled();
	info.func = function (enable)
		Database:SetMinimapEnabled(enable);
		Addon.MinimapButton:Update();
	end;
	table.insert(_list, info);

	local info = {};
	info.text = Translate['Enable Loot Reminder'];
	info.checked = Addon.Database:IsReminderEnabled();
	info.keepShownOnClick = true;
	info.args = not Addon.Database:IsReminderEnabled();
	info.func = function (enable)
		Addon.Database:SetReminderEnabled(enable);
	end;
	table.insert(_list, info);

	return _list;
end