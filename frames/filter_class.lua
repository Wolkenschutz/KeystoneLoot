local AddonName, Addon = ...;


local CreateFilterButton = Addon.CreateFilterButton;

local SELECTED_CLASS_ID = 0;
local SELECTED_SPEC_ID = 0;


local function SetClassFilter(self, classID, specID)
	SELECTED_CLASS_ID = classID;
	SELECTED_SPEC_ID = specID;

	local text;
	local classInfo = C_CreatureInfo.GetClassInfo(classID);
	local classColorStr = RAID_CLASS_COLORS[classInfo.classFile].colorStr;

	if (specID > 0) then
		local specName = GetSpecializationNameForSpecID(specID) or UNKNOWN;

		text = HEIRLOOMS_CLASS_SPEC_FILTER_FORMAT:format(classColorStr, classInfo.className, specName);
	else
		text = HEIRLOOMS_CLASS_FILTER_FORMAT:format(classColorStr, classInfo.className);
	end

	UIDropDownMenu_SetText(Addon.SELECTED_FILTER_BUTTON, text);

	CloseDropDownMenus(1);
end

local function InitClassDropDownMenu(self, level)
	local info = UIDropDownMenu_CreateInfo();
	info.keepShownOnClick = nil;

	if (UIDROPDOWNMENU_MENU_VALUE == 1) then
		for i=1, GetNumClasses() do
			local classDisplayName, _, classID = GetClassInfo(i);

			info.text = classDisplayName;
			info.checked = SELECTED_CLASS_ID == classID;
			info.arg1 = classID;
			info.arg2 = 0;
			info.func = SetClassFilter;
			UIDropDownMenu_AddButton(info, level);
		end
	end

	if (level == 1) then
		local classDisplayName, _, classID;

		info.text = CLASS;
		info.func =  nil;
		info.notCheckable = true;
		info.hasArrow = true;
		info.value = 1;
		UIDropDownMenu_AddButton(info, level)

		if (SELECTED_CLASS_ID > 0) then
			classID = SELECTED_CLASS_ID;
			classDisplayName = C_CreatureInfo.GetClassInfo(SELECTED_CLASS_ID).className;
		else
			classDisplayName, _, classID = UnitClass('player');
		end

		info.text = classDisplayName;
		info.notCheckable = true;
		info.arg1 = nil;
		info.arg2 = nil;
		info.func =  nil;
		info.hasArrow = false;
		UIDropDownMenu_AddButton(info, level);
		info.notCheckable = nil;

		for i=1, GetNumSpecializationsForClassID(classID) do
			local specID, specName = GetSpecializationInfoForClassID(classID, i);
			info.leftPadding = 10;
			info.text = specName;
			info.checked = SELECTED_SPEC_ID == specID;
			info.arg1 = classID;
			info.arg2 = specID;
			info.func = SetClassFilter;
			UIDropDownMenu_AddButton(info, level);
		end

		info.text = ALL_SPECS;
		info.leftPadding = 10;
		info.checked = (SELECTED_CLASS_ID == classID and SELECTED_SPEC_ID == 0);
		info.arg1 = classID;
		info.arg2 = 0;
		info.func = SetClassFilter;
		UIDropDownMenu_AddButton(info, level);
	end
end


local ClassFilter = CreateFilterButton('class', InitClassDropDownMenu);
Addon.Frames.Filter.Class = ClassFilter;

ClassFilter:SetPoint('TOP', -55, -35);
ClassFilter:RegisterEvent('PLAYER_ENTERING_WORLD');
ClassFilter:SetScript('OnEvent', function(self)
	self:UnregisterAllEvents();

	local _, _, classID = UnitClass('player');
	SELECTED_CLASS_ID = classID;
	SELECTED_SPEC_ID = (GetSpecializationInfo(GetSpecialization()));
	Addon.SELECTED_FILTER_BUTTON = self;

	SetClassFilter(nil, SELECTED_CLASS_ID, SELECTED_SPEC_ID);
end);