local AddonName, Addon = ...;
Addon.Frames.Settings = {};

local Setting = {};
Addon.Settings = Setting;

local Frame = CreateFrame('Frame');
Addon.Frames.Settings.Main = Frame;

local category = Settings.RegisterCanvasLayoutCategory(Frame, 'KeystoneLoot');
Settings.RegisterAddOnCategory(category);

Addon.Settings.ID = category:GetID();


local function OnEnter(self)
	local parent = self:GetParent();
	parent = parent.Background == nil and parent:GetParent() or parent;

	parent.Background:Show();
end

local function OnLeave(self)
	local parent = self:GetParent();
	parent = parent.Background == nil and parent:GetParent() or parent;

	parent.Background:Hide();
end

function Setting:CreateListElement()
	local ListElement = CreateFrame('Frame', nil, Frame);
	ListElement:SetSize(1, 26);

	local Trigger = CreateFrame('Button', nil, ListElement);
	ListElement.Trigger = Trigger;
	Trigger:SetSize(280, 26);
	Trigger:SetPoint('TOPLEFT');
	Trigger:SetScript('OnEnter', OnEnter);
	Trigger:SetScript('OnLeave', OnLeave);

	local Text = ListElement:CreateFontString('ARTWORK', nil, 'GameFontNormal');
	ListElement.Text = Text;
	Text:SetPoint('LEFT', 37, 0);
	Text:SetPoint('RIGHT', ListElement, 'CENTER', -85, 0);
	Text:SetJustifyH('LEFT');

	local Background = ListElement:CreateTexture(nil, 'BACKGROUND');
	ListElement.Background = Background;
	Background:Hide();
	Background:SetHeight(26);
	Background:SetPoint('TOPLEFT', ListElement);
	Background:SetPoint('RIGHT', ListElement, -5, 0);
	Background:SetColorTexture(1, 1, 1, 0.1);

	return ListElement;
end

function Setting:CreateCheckBox(listElement)
	local CheckBox = CreateFrame('CheckButton', nil, listElement.Trigger);
	listElement.CheckBox = CheckBox;
	CheckBox:SetSize(30, 29);
	CheckBox:SetPoint('LEFT', listElement, 'CENTER', -80, 0);

	CheckBox:SetNormalTexture('checkbox-minimal');
	CheckBox:SetPushedTexture('checkbox-minimal');
	CheckBox:SetCheckedTexture('checkmark-minimal');
	CheckBox:SetDisabledTexture('checkmark-minimal-disabled');

	CheckBox:SetScript('OnEnter', OnEnter);
	CheckBox:SetScript('OnLeave', OnLeave);

	return CheckBox;
end