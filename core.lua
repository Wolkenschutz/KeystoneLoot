local AddonName, Addon = ...;

local MainFrame = Addon.Frames.Main;


	-- TODO: Main frame dynamische Höhe (Falls neue Season anfängt und die Anzahl nur 3 Reihen sind)
	-- FIXME: Beim ersten Mal werden keine Items angezeigt.
	-- FIXME: UpdateInstances() brauch nen Rework. Dirty shit!
	-- NOTE: Update-Rework: Wenn man das erste mal einloggt: Instanz-Frames werden
	-- erstellt und eingestellt. Beim öffnen werden die dann weder erstellt, noch
	-- eingestellt. Dann werden nur noch Item-Frames erstellt und eingestellt. 


-- Test test
C_Timer.After(5, function()

end);


SlashCmdList.KEYSTONELOOT = function(msg)
	MainFrame:SetShown(not MainFrame:IsShown());
end;

SLASH_KEYSTONELOOT1 = "/ksl";
SLASH_KEYSTONELOOT2 = "/keyloot";
SLASH_KEYSTONELOOT3 = "/keystoneloot";