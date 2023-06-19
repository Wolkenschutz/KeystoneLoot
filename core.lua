local AddonName, Addon = ...;

local Frame = Addon.Frames.MainFrame;
local CreateInstanceFrame = Addon.CreateInstanceFrame;


-- Test test
C_Timer.After(5, function()
	local selectedTier = 0;

	for i=1, EJ_GetNumTiers() do
		if (CHALLENGES == (EJ_GetTierInfo(i))) then
			selectedTier = i;
			break;
		end
	end

	if (selectedTier == 0) then
		return;
	end

	EJ_SelectTier(selectedTier);
	EJ_SetDifficulty(DifficultyUtil.ID.DungeonChallenge);

	local i = 1;
	local _, name, _, _, buttonImage = EJ_GetInstanceByIndex(i, false);

	while (name) do
		local InstanceFrame = CreateInstanceFrame(Frame);

		InstanceFrame:SetTitle(name);
		InstanceFrame:SetBackground(buttonImage);

		i = i+1;
		_, name, _, _, buttonImage = EJ_GetInstanceByIndex(i, false);
	end
end);


SlashCmdList.KEYSTONELOOT = function(msg)
	Frame:SetShown(not Frame:IsShown());
end;

SLASH_KEYSTONELOOT1 = "/ksl";
SLASH_KEYSTONELOOT2 = "/keyloot";
SLASH_KEYSTONELOOT3 = "/keystoneloot";