local AddonName, Addon = ...;


local MainFrame = Addon.Frames.Main;


	-- TODO: Minimap-Button hinzufügen.
	-- TODO: Slot ausgrauen, die keine Items haben.


local function OnEvent(self, event, ...)
	if (event == 'ADDON_LOADED' and (...) == AddonName) then
		self:UnregisterEvent(event);
		self:RegisterEvent('PLAYER_ENTERING_WORLD');
		self:RegisterEvent('ADDON_ACTION_FORBIDDEN');

		KEYSTONE_LOOT_DB = KEYSTONE_LOOT_DB or {
			minimapButtonPosition = 195,
			minimapButtonShown = true
		};
		KEYSTONE_LOOT_CHAR_DB = KEYSTONE_LOOT_CHAR_DB or {};
	elseif (event == 'PLAYER_ENTERING_WORLD') then
		self:UnregisterEvent(event);

		local _, _, classID = UnitClass('player');
		local specID = (GetSpecializationInfo(GetSpecialization()));

		Addon.SELECTED_CLASS_ID = classID;
		Addon.SELECTED_SPEC_ID = specID;

		Addon.SetClassFilter(nil, classID, specID);
		Addon.CreateInstanceFrames();
		Addon.UpdateMinimapButton();

		local currentSeasonDB = KEYSTONE_LOOT_CHAR_DB.currSeasion;
		local currentSeason = C_MythicPlus.GetCurrentUIDisplaySeason();
		if (currentSeason ~= currentSeasonDB) then
			Addon.API.RemoveAllFavorites();

			KEYSTONE_LOOT_CHAR_DB.currSeasion = currentSeason;
		end
	elseif (event == 'EJ_LOOT_DATA_RECIEVED') then
		Addon.API.UpdateLoot();
	elseif (event == 'ADDON_ACTION_FORBIDDEN' and (...) == AddonName) then
		StaticPopup1Button2:Click(); -- FIXME: Dirty... SetTab()?!
	end
end

MainFrame:RegisterEvent('ADDON_LOADED');
MainFrame:SetScript('OnEvent', OnEvent);


SlashCmdList.KEYSTONELOOT = function(msg)
	MainFrame:SetShown(not MainFrame:IsShown());
end;

SLASH_KEYSTONELOOT1 = "/ksl";
SLASH_KEYSTONELOOT2 = "/keyloot";
SLASH_KEYSTONELOOT3 = "/keystoneloot";