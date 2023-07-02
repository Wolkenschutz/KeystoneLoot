local AddonName, Addon = ...;


local function ToogleDropDownMenu(parent, ListFunction)
	local DropDownMenu = Addon.Frames.DropDownMenu;

	if (DropDownMenu:IsShown()) then
		if (parent ~= Addon.SELECTED_FILTER_BUTTON) then
			Addon.SELECTED_FILTER_BUTTON = parent;

			Addon.API.UpdateDropDownMenu();
			return;
		end

		DropDownMenu:Hide();
	else
		Addon.SELECTED_FILTER_BUTTON = parent;

		local minWidth = 0;
		local shownButtons = 0;
		local dropdownHeight = 0;

		for i, info in next, ListFunction() do
			shownButtons = i;

			if (info.disabled == nil) then
				info.disabled = false;
			end

			local Button = Addon.GetDropDownButton(i);
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

				Check:SetPoint('LEFT', leftPadding, 0);

				dropdownHeight = dropdownHeight + 18;
			end

			Button.info = info;

			minWidth = math.max(minWidth, Button.Text:GetWidth() + leftPadding);
		end

		local buttons = Addon.GetDropDownButtons();
		for i = (shownButtons + 1), #buttons do
			local Button = Addon.GetDropDownButton(i);
			Button:Hide();
		end

		DropDownMenu:SetSize(minWidth + 50, dropdownHeight + 20);
		DropDownMenu:SetPoint('TOPLEFT', parent, 'BOTTOMLEFT', 5, 0);
		DropDownMenu:Show();
	end
end
Addon.API.ToogleDropDownMenu = ToogleDropDownMenu;

local function CloseDropDownMenu()
	Addon.Frames.DropDownMenu:Hide();
end
Addon.API.CloseDropDownMenu = CloseDropDownMenu;

local function UpdateDropDownMenu()
	CloseDropDownMenu();

	local parent = Addon.SELECTED_FILTER_BUTTON;
	local ListFunction = parent.ListFunction;

	ToogleDropDownMenu(parent, ListFunction);
end
Addon.API.UpdateDropDownMenu = UpdateDropDownMenu;

local function SetDropDownMenuText(text)
	Addon.SELECTED_FILTER_BUTTON:SetText(text);
end
Addon.API.SetDropDownMenuText = SetDropDownMenuText;