local AddonName, Addon = ...;

local MainFrame = Addon.Frames.Main;

local CreateInstanceFrame = Addon.CreateInstanceFrame;
local CreateItemFrame = Addon.CreateItemFrame;


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
		local InstanceFrame = CreateInstanceFrame();

		InstanceFrame.Title:SetText(name);
		InstanceFrame.Bg:SetTexture(buttonImage);

		local rand = random(0, 5);
		InstanceFrame.Bg:SetDesaturated(rand == 0);
		InstanceFrame:SetAlpha(rand == 0 and 0.8 or 1);
		InstanceFrame.Title:SetFontObject('GameFont'..(rand == 0 and 'Disable' or 'Highlight')..'Large');

		for i=1, rand do
			local ItemFrame = CreateItemFrame(InstanceFrame);

			ItemFrame.Icon:SetTexture('Interface\\Icons\\temp');
		end

		i = i+1;
		_, name, _, _, buttonImage = EJ_GetInstanceByIndex(i, false);
	end
end);


SlashCmdList.KEYSTONELOOT = function(msg)
	MainFrame:SetShown(not MainFrame:IsShown());
end;

SLASH_KEYSTONELOOT1 = "/ksl";
SLASH_KEYSTONELOOT2 = "/keyloot";
SLASH_KEYSTONELOOT3 = "/keystoneloot";