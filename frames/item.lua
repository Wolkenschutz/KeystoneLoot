local AddonName, Addon = ...;


local function OnEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT');
	GameTooltip:SetHyperlink(self.link);
	GameTooltip:Show();
end

local function OnLeave(self)
	GameTooltip:Hide()
end

local function CreateItemFrame(i, parent)
	local Frame = CreateFrame('Frame', nil, parent);
	Frame:SetSize(32, 32);

	Frame:SetScript('OnEnter', OnEnter);
	Frame:SetScript('OnLeave', OnLeave);

	if (i == 1) then
		Frame:SetPoint('TOPLEFT', 11, -10);
	elseif (mod(i, 4) == 1) then
		Frame:SetPoint('TOP', parent.ItemFrames[i - 4], 'BOTTOM', 0, -8);
	else
		Frame:SetPoint('LEFT', parent.ItemFrames[i - 1], 'RIGHT', 10, 0);
	end

	local Icon = Frame:CreateTexture();
	Frame.Icon = Icon;
	Icon:SetDrawLayer('ARTWORK', 1);
	Icon:SetAllPoints();
	Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92);

	local IconBorder = Frame:CreateTexture();
	IconBorder:SetDrawLayer('ARTWORK', 2);
	IconBorder:SetSize(32+26, 32+26);
	IconBorder:SetPoint('CENTER', Icon);
	IconBorder:SetTexture('Interface\\Buttons\\UI-Quickslot2');


	table.insert(parent.ItemFrames, Frame);

	return Frame;
end


local function GetItemFrame(i, parent)
	if (parent.ItemFrames[i]) then
		return parent.ItemFrames[i];
	end

	return CreateItemFrame(i, parent);
end
Addon.GetItemFrame = GetItemFrame;