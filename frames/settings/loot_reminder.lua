local AddonName, Addon = ...;


local Translate = Addon.Translate;


local ListElement = Addon.Settings:CreateListElement();
ListElement:SetPoint('TOPLEFT', 10, -97);
ListElement:SetPoint('TOPRIGHT', -20, -97);
ListElement.Text:SetText(Translate['Enable Loot Reminder']);

local function OnClick(self)
	local isCheckBox = self:GetParent().CheckBox;

	local isChecked;
	if (isCheckBox) then
		isChecked = not isCheckBox:GetChecked();
	else
		isChecked = self:GetChecked();
	end

	(isCheckBox or self):SetChecked(isChecked);

	Addon.Database:SetReminderEnabled(isChecked);

	if (isChecked) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
	end
end

local function OnShow(self)
	self:SetChecked(Addon.Database:IsReminderEnabled());
end

local CheckBox = Addon.Settings:CreateCheckBox(ListElement, OnClick, OnShow);
CheckBox:SetScript('OnShow', OnShow);

CheckBox:SetScript('OnClick', OnClick);
ListElement.Trigger:SetScript('OnClick', OnClick);