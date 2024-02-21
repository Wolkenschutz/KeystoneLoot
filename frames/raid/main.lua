local AddonName, Addon = ...;


local function OnShow(self)
    self:RegisterEvent('EJ_LOOT_DATA_RECIEVED');

    Addon.Overview:SetHeight(230);

	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);

	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN);
end

local function OnHide(self)
    self:UnregisterAllEvents();

	PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);
end

local function OnEvent(self, event, ...)
    if (event == 'EJ_LOOT_DATA_RECIEVED') then
		self:UnregisterEvent(event);

		--[[C_Timer.After(1, function()
			Addon:LoadRaidData();
		end);]]
	end
end


local Frame = Addon.Overview:RegisterTab('Raid', RAIDS);
Frame:Hide();
Frame:SetScript('OnShow', OnShow);
Frame:SetScript('OnHide', OnHide);
Frame:SetScript('OnEvent', OnEvent);

function Frame:Update()
end


local NoSeasonText = Frame:CreateFontString('ARTWORK', nil, 'GameFontHighlightLarge');
NoSeasonText:SetPoint('TOPLEFT', 20, -80);
NoSeasonText:SetPoint('BOTTOMRIGHT', -20, 26);
NoSeasonText:SetText(FEATURE_NOT_YET_AVAILABLE);