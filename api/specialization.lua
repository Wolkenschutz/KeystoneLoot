local AddonName, Addon = ...;

local Specialization = {};
Addon.Specialization = Specialization;

local _specializationFrames = {};
local _column = 1;
local SPEC_FORMAT_STRINGS = { -- https://www.townlong-yak.com/framexml/live/Blizzard_ClassTalentUI/Blizzard_ClassTalentSpecTab.lua
	[62] = 'mage-arcane',
	[63] = 'mage-fire',
	[64] = 'mage-frost',
	[65] = 'paladin-holy',
	[66] = 'paladin-protection',
	[70] = 'paladin-retribution',
	[71] = 'warrior-arms',
	[72] = 'warrior-fury',
	[73] = 'warrior-protection',
	[102] = 'druid-balance',
	[103] = 'druid-feral',
	[104] = 'druid-guardian',
	[105] = 'druid-restoration',
	[250] = 'deathknight-blood',
	[251] = 'deathknight-frost',
	[252] = 'deathknight-unholy',
	[253] = 'hunter-beastmastery',
	[254] = 'hunter-marksmanship',
	[255] = 'hunter-survival',
	[256] = 'priest-discipline',
	[257] = 'priest-holy',
	[258] = 'priest-shadow',
	[259] = 'rogue-assassination',
	[260] = 'rogue-outlaw',
	[261] = 'rogue-subtlety',
	[262] = 'shaman-elemental',
	[263] = 'shaman-enhancement',
	[264] = 'shaman-restoration',
	[265] = 'warlock-affliction',
	[266] = 'warlock-demonology',
	[267] = 'warlock-destruction',
	[268] = 'monk-brewmaster',
	[269] = 'monk-windwalker',
	[270] = 'monk-mistweaver',
	[577] = 'demonhunter-havoc',
	[581] = 'demonhunter-vengeance',
	[1467] = 'evoker-devastation',
	[1468] = 'evoker-preservation',
	[1473] = 'evoker-augmentation',
}


local function OnClick(self)
	SetLootSpecialization(self:GetParent().specID);

	PlaySound(SOUNDKIT.UI_CLASS_TALENT_SPEC_ACTIVATE);
end

local function CreateSpecializationFrame()
	local index = #_specializationFrames + 1;

	local Frame = CreateFrame('Frame', nil, Addon.Frames.LootReminder, 'InsetFrameTemplate');
	Frame.ItemFrames = {};
	Frame:SetSize(180, 90);

	if (index == 1) then
		Frame:SetPoint('TOPLEFT', 20, -80);
	else
		Frame:SetPoint('LEFT', _specializationFrames[index - 1], 'RIGHT', 20, 0);
		_column = _column + 1;
	end

	local FrameBg = Frame.Bg;
	FrameBg:SetHorizTile(false);
	FrameBg:SetVertTile(false);

	local Title = Frame:CreateFontString('ARTWORK', nil, 'GameFontHighlightLarge');
	Frame.Title = Title;
	Title:SetPoint('BOTTOM', Frame, 'TOP', 0, 5);

	local Button = CreateFrame('Button', nil, Frame, 'SharedButtonSmallTemplate');
	Frame.Button = Button;
	Button:SetSize(120, 22);
	Button:SetPoint('TOP', Frame, 'BOTTOM', 0, -10);
	Button:SetScript('OnClick', OnClick);
	Button:SetText(TALENT_SPEC_ACTIVATE);

	local Active = Frame:CreateFontString('ARTWORK', nil, 'GameFontHighlightLarge');
	Frame.Active = Active;
	Active:SetTextColor(0, 1, 0);
	Active:SetPoint('TOP', Frame, 'BOTTOM', 0, -12);
	Active:SetText(SPEC_ACTIVE);

	table.insert(_specializationFrames, Frame);

	return Frame;
end

local function GetSpecializationFrame(index)
	return _specializationFrames[index] or CreateSpecializationFrame();
end

function Specialization:SetData(reminderData)
	local LootReminderFrame = Addon.Frames.LootReminder;

	local lootSpecID = Addon.Util:GetSelectedLootSpecialization();
	local numSpec = 0;

	for index, value in next, reminderData do
		numSpec = numSpec + 1;

		local specID, specName = GetSpecializationInfoByID(value.specID);
		local numItems = 0;

		local Frame = GetSpecializationFrame(index);
		Frame.mapID = value.mapID;
		Frame.specID = specID;

		Frame.Title:SetText(specName);
		Frame.Bg:SetAtlas('spec-thumbnail-'..(SPEC_FORMAT_STRINGS[specID] or 'mage-arcane'));

		Frame.Button:SetShown(lootSpecID ~= specID);
		Frame.Active:SetShown(lootSpecID == specID);

		for itemID, itemInfo in pairs(value.favoriteItems) do
			numItems = numItems + 1;

			local ItemFrame = Addon.DungeonItem:GetFrame(numItems, Frame);
			local FavoriteStar = ItemFrame.FavoriteStar;

			local isFavoriteItem = Addon.Database:GetFavorite(value.mapID, specID, itemID) ~= nil;

			FavoriteStar:SetDesaturated(not isFavoriteItem);
			FavoriteStar:SetShown(isFavoriteItem);

			ItemFrame.isLootReminder = true;
			ItemFrame.isFavorite = isFavoriteItem;
			ItemFrame.itemID = itemID;
			ItemFrame.Icon:SetTexture(itemInfo.icon);
			ItemFrame:Show();
		end

		for index=(numItems + 1), 8 do
			local ItemFrame = Addon.DungeonItem:GetFrame(index, Frame);
			ItemFrame:Hide();
		end
	end

	for index=(numSpec + 1), #_specializationFrames do
		local Frame = GetSpecializationFrame(index);
		Frame:Hide();
	end

	LootReminderFrame:SetWidth(23 + (_column * 200));
	LootReminderFrame:Show();
end

hooksecurefunc('SetLootSpecialization', function(newLootSpecID)
	if (Addon.Frames.LootReminder:IsShown()) then
		for index=1, #_specializationFrames do
			local Frame = GetSpecializationFrame(index);

			local specID = Frame.specID;

			Frame.Button:SetShown(newLootSpecID ~= specID);
			Frame.Active:SetShown(newLootSpecID == specID);
		end
	end
end);