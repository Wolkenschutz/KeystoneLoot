local AddonName, Addon = ...;


local Dungeon = {};
Addon.Dungeon = Dungeon;

local Translate = Addon.Translate;

local _dungeonFrames = {};
local _rows = 1;


local function CreateDungeonFrame()
	local index = #_dungeonFrames + 1;

	local Frame = CreateFrame('Frame', nil, Addon.Overview:GetTab('Dungeon'), 'InsetFrameTemplate');
	Frame.ItemFrames = {};
	Frame:SetSize(180, 90);

	if (index == 1) then
		Frame:SetPoint('TOP', -110, -100);
	elseif (mod(index, 2) == 1) then
		Frame:SetPoint('TOP', _dungeonFrames[index - 2], 'BOTTOM', 0, -40);

		_rows = _rows + 1;
	else
		Frame:SetPoint('LEFT', _dungeonFrames[index - 1], 'RIGHT', 40, 0);
	end

	local FrameBg = Frame.Bg;
	FrameBg:SetHorizTile(false);
	FrameBg:SetVertTile(false);
	FrameBg:SetTexCoord(5/256, 169/256, 5/128, 91/128);

	local Title = Frame:CreateFontString('ARTWORK', nil, 'GameFontDisableLarge');
	Frame.Title = Title;
	Title:SetPoint('BOTTOM', Frame, 'TOP', 0, 5);

	function Frame:SetDisabled(isDisabled)
		self.Title:SetTextColor((isDisabled and GRAY_FONT_COLOR or HIGHLIGHT_FONT_COLOR):GetRGB());
		self.Bg:SetDesaturated(isDisabled);
		self:SetAlpha(isDisabled and 0.8 or 1);
	end

	table.insert(_dungeonFrames, Frame);

	return Frame;
end

function Dungeon:GetFrames()
	return _dungeonFrames;
end

local isCreated = false;
function Dungeon:Update()
	if (isCreated) then
		Addon.Overview:SetHeight(100 + (_rows * 130));
		return;
	end
	isCreated = true;

	for _, dungeon in next, Addon.GameData:GetDungeonList() do
		local Frame = CreateDungeonFrame();
		Frame.mapID = dungeon.mapID;
		Frame.instanceID = dungeon.instanceID;

		Frame.Title:SetText(Translate[dungeon.name]);
		Frame.Bg:SetTexture(dungeon.bgTexture);
	end

	Addon.Overview:SetHeight(100 + (_rows * 130));
end