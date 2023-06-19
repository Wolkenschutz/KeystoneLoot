local AddonName, Addon = ...;

local MainFrame = Addon.Frames.MainFrame;
local GearFilter = Addon.Frames.Filter.Gear;
local CreateInstanceFrame = Addon.CreateInstanceFrame;


-- Test test
C_Timer.After(5, function()
	local text;
	local classID, specID = EJ_GetLootFilter();
	specID = GetSpecializationInfo(3);

	local classInfo = C_CreatureInfo.GetClassInfo(classID);
	local classColorStr = RAID_CLASS_COLORS[classInfo.classFile].colorStr;

	if (specID > 0) then
		local specName = GetSpecializationNameForSpecID(specID);

		text = HEIRLOOMS_CLASS_SPEC_FILTER_FORMAT:format(classColorStr, classInfo.className, specName);
	else
		text = HEIRLOOMS_CLASS_FILTER_FORMAT:format(classColorStr, classInfo.className);
	end

	GearFilter:SetText(text);


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
		local InstanceFrame = CreateInstanceFrame(MainFrame);

		InstanceFrame:SetTitle(name);
		InstanceFrame:SetBackground(buttonImage);

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