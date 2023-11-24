local AddonName, Addon = ...;


local MainFrame = Addon.Frames.Main;
local NoSeason = Addon.Frames.NoSeason;

local INSTANCE_FRAMES = {};
local ROWS = 1;


local function CreateInstanceFrame(mapID)
	local index = #INSTANCE_FRAMES + 1;

	local Frame = CreateFrame('Frame', nil, MainFrame, 'InsetFrameTemplate');
	Frame.mapID = mapID;
	Frame.ItemFrames = {};
	Frame:SetSize(180, 90);

	if (index == 1) then
		Frame:SetPoint('TOP', -110, -100);
	elseif (mod(index, 2) == 1) then
		Frame:SetPoint('TOP', INSTANCE_FRAMES[index - 2], 'BOTTOM', 0, -40);

		ROWS = ROWS + 1;
	else
		Frame:SetPoint('LEFT', INSTANCE_FRAMES[index - 1], 'RIGHT', 40, 0);
	end

	local FrameBg = Frame.Bg;
	FrameBg:SetHorizTile(false);
	FrameBg:SetVertTile(false);
	FrameBg:SetTexCoord(5/256, 169/256, 5/128, 91/128);

	local Title = Frame:CreateFontString('ARTWORK', nil, 'GameFontDisableLarge');
	Frame.Title = Title;
	Title:SetPoint('BOTTOM', Frame, 'TOP', 0, 5);


	table.insert(INSTANCE_FRAMES, Frame);

	return Frame;
end

local function GetInstanceFrames()
	return INSTANCE_FRAMES;
end
Addon.GetInstanceFrames = GetInstanceFrames;

local function CreateInstanceFrames()
	local mythicTierID = Addon.API.GetMythicTierID();
	if (not mythicTierID) then
		NoSeason:Show();
		return;
	end

	for _, dungeon in next, Addon.API.GetSeasonDungeons() do
		local InstanceFrame = CreateInstanceFrame(dungeon.mapID);
		InstanceFrame.instanceID = dungeon.instanceID;

		InstanceFrame.Title:SetText(dungeon.name);
		InstanceFrame.Bg:SetTexture(dungeon.bgTexture);
	end

	MainFrame:SetHeight(100 + (ROWS * 130));
end
Addon.CreateInstanceFrames = CreateInstanceFrames;