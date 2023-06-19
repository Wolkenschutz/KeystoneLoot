local AddonName, Addon = ...;


local MainFrame = Addon.Frames.Main;

local INSTANCE_FRAMES = {};
local ROWS = 1;


local function CreateInstanceFrame()
	local i = #INSTANCE_FRAMES + 1;

	local Frame = CreateFrame('Frame', nil, MainFrame, 'InsetFrameTemplate');
	Frame.ItemFrames = {};
	Frame:SetSize(180, 90);

	if (i == 1) then
		Frame:SetPoint('TOP', -110, -100);
	elseif (mod(i, 2) == 1) then
		Frame:SetPoint('TOP', INSTANCE_FRAMES[i - 2], 'BOTTOM', 0, -40);

		ROWS = ROWS + 1;
	else
		Frame:SetPoint('LEFT', INSTANCE_FRAMES[i - 1], 'RIGHT', 40, 0);
	end

	local FrameBg = Frame.Bg;
	FrameBg:SetHorizTile(false);
	FrameBg:SetVertTile(false);
	FrameBg:SetTexCoord(5/256, 169/256, 5/128, 91/128);

	local Title = Frame:CreateFontString('ARTWORK', nil, 'GameFontDisableLarge');
	Frame.Title = Title;
	Title:SetPoint('BOTTOM', Frame, 'TOP', 0, 5);


	-- TODO: Main frame dynamische Höhe
	table.insert(INSTANCE_FRAMES, Frame);

	return Frame;
end

Addon.CreateInstanceFrame = CreateInstanceFrame;