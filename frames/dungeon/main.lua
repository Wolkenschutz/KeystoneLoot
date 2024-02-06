local AddonName, Addon = ...;


local isSeason = false;


local function OnShow(self)
	self:RegisterEvent('EJ_LOOT_DATA_RECIEVED');

	self:Update();

	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);

	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN);
end

local function OnHide(self)
	self:UnregisterAllEvents();

	PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);
end


local Frame = Addon.Overview:RegisterTab('Dungeon', DUNGEONS);
Frame:SetScript('OnShow', OnShow);
Frame:SetScript('OnHide', OnHide);

function Frame:Update()
	local classID = Addon.Database:GetSelectedClass();
	isSeason = Addon.GameData:LoadDungeonData(classID);

	if (isSeason) then
		self.NoSeasonText:Hide();

		Addon.Dungeon:Update();
		Addon.DungeonItem:Update();
	else
		self.NoSeasonText:Show();
    	Addon.Overview:SetHeight(230);
	end
end

local NoSeasonText = Frame:CreateFontString('ARTWORK', nil, 'GameFontHighlightLarge');
Frame.NoSeasonText = NoSeasonText;
NoSeasonText:SetPoint('TOPLEFT', 20, -80);
NoSeasonText:SetPoint('BOTTOMRIGHT', -20, 26);
NoSeasonText:SetText(MYTHIC_PLUS_TAB_DISABLE_TEXT);


-- FIXME: Erstmal nur eine Notlösung. Knoten im Kopf.
local function _loadData(self)
	C_Timer.After(1, function()
		self:RegisterEvent('EJ_LOOT_DATA_RECIEVED');

		local _, _, classID = UnitClass('player');
		isSeason = Addon.GameData:LoadDungeonData(classID);
	end);

	C_Timer.After(6, function()
		self:UnregisterEvent('EJ_LOOT_DATA_RECIEVED');
	end);
end
local _handler = CreateFrame('Frame');
_handler:SetScript('OnEvent', function(self, event)
	if (event == 'PLAYER_ENTERING_WORLD') then
		self:UnregisterEvent(event);
		_loadData(self);
	elseif (event == 'EJ_LOOT_DATA_RECIEVED') then
		self:UnregisterEvent(event);
		_loadData(self);
	end
end);
_handler:RegisterEvent('PLAYER_ENTERING_WORLD');