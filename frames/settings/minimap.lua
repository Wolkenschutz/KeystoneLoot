local AddonName, Addon = ...;


local Main = Addon.Frames.Settings.Main;
local Translate = Addon.API.Translate;


local ListElement = Addon.CreateSettingListElement(Main);
ListElement:SetPoint('TOPLEFT', 10, -62);
ListElement:SetPoint('TOPRIGHT', -20, -62);
ListElement.Text:SetText(Translate['Enable Minimap Button']);

local function OnClick(self)
	local isCheckBox = self:GetParent().CheckBox;

	local isChecked;
	if (isCheckBox) then
		isChecked = not isCheckBox:GetChecked();
	else
		isChecked = self:GetChecked();
	end

	(isCheckBox or self):SetChecked(isChecked);

	KEYSTONE_LOOT_DB.minimapButtonEnabled = isChecked;
	Addon.UpdateMinimapButton();

	if (isChecked) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
	end
end

local function OnShow(self)
	self:SetChecked(KEYSTONE_LOOT_DB.minimapButtonEnabled);
end

local CheckBox = Addon.CreateSettingCheckBox(ListElement, OnClick, OnShow);
CheckBox:SetScript('OnShow', OnShow);

CheckBox:SetScript('OnClick', OnClick);
ListElement.Trigger:SetScript('OnClick', OnClick);