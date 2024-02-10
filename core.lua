local AddonName, Addon = ...;


local Overview = Addon.Frames.Overview;


local function OnEvent(self, event, ...)
	if (event == 'PLAYER_ENTERING_WORLD') then
		self:UnregisterEvent(event);

		self:RegisterEvent('CHALLENGE_MODE_MAPS_UPDATE');
		self:RegisterEvent('CHALLENGE_MODE_START');

		C_AddOns.LoadAddOn('Blizzard_EncounterJournal');
		C_MythicPlus.RequestMapInfo();
	elseif (event == 'CHALLENGE_MODE_MAPS_UPDATE') then
		self:UnregisterEvent(event);

		Addon.Database:CheckDB();
		Addon.Database:CheckCharacterDB();
		Addon.MinimapButton:Update();
	elseif (event == 'CHALLENGE_MODE_START' and Addon.Database:IsReminderEnabled()) then
		Addon.LootReminder:Update();
	end
end

Overview:RegisterEvent('PLAYER_ENTERING_WORLD');
Overview:SetScript('OnEvent', OnEvent);


SlashCmdList.KEYSTONELOOT = function(msg)
	Overview:SetShown(not Overview:IsShown());
end;

SLASH_KEYSTONELOOT1 = "/ksl";
SLASH_KEYSTONELOOT2 = "/keyloot";
SLASH_KEYSTONELOOT3 = "/keystoneloot";