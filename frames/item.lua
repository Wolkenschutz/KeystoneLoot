local AddonName, Addon = ...;


local function CreateItemFrame(parent)
	local i = #parent.ItemFrames + 1;

	local Frame = CreateFrame('Frame', nil, parent);
	Frame:SetSize(32, 32);

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

Addon.CreateItemFrame = CreateItemFrame;