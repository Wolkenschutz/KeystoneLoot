local AddonName, Addon = ...;


Addon.SELECTED_CLASS_ID = 0;
Addon.SELECTED_SPEC_ID = 0;


local function SetClassFilter(self, classID, specID)
	Addon.SELECTED_CLASS_ID = classID;
	Addon.SELECTED_SPEC_ID = specID;
	Addon.API.UpdateLoot();

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
Addon.SetClassFilter = SetClassFilter;

local function InitClassDropDownMenu(self, level)
	local SELECTED_CLASS_ID = Addon.SELECTED_CLASS_ID;
	local SELECTED_SPEC_ID = Addon.SELECTED_SPEC_ID;

	local info = UIDropDownMenu_CreateInfo();
	info.keepShownOnClick = nil;

	if (UIDROPDOWNMENU_MENU_VALUE == 1) then
		for i=1, GetNumClasses() do
			local classDisplayName, classFile, classID = GetClassInfo(i);
			local classColorStr = RAID_CLASS_COLORS[classFile].colorStr;

			info.text = HEIRLOOMS_CLASS_FILTER_FORMAT:format(classColorStr, classDisplayName);
			info.checked = SELECTED_CLASS_ID == classID;
			info.arg1 = classID;
			info.arg2 = 0;
			info.func = SetClassFilter;
			UIDropDownMenu_AddButton(info, level);
		end
	end

	if (level == 1) then
		local classDisplayName, classFile, classID;

		info.text = CLASS;
		info.func =  nil;
		info.notCheckable = true;
		info.hasArrow = true;
		info.value = 1;
		UIDropDownMenu_AddButton(info, level);

		if (SELECTED_CLASS_ID > 0) then
			classID = SELECTED_CLASS_ID;

			local classInfo = C_CreatureInfo.GetClassInfo(classID);

			classDisplayName = classInfo.className;
			classFile = classInfo.classFile;
		else
			classDisplayName, classFile, classID = UnitClass('player');
		end

		local classColorStr = RAID_CLASS_COLORS[classFile].colorStr;

		info.text = HEIRLOOMS_CLASS_FILTER_FORMAT:format(classColorStr, classDisplayName);
		info.arg1 = nil;
		info.arg2 = nil;
		info.func = nil;
		info.hasArrow = false;
		info.disabled = true;
		UIDropDownMenu_AddButton(info, level);
		info.notCheckable = nil;
		info.disabled = nil;

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
		info.checked = (SELECTED_CLASS_ID == classID and SELECTED_SPEC_ID == 0);
		info.arg1 = classID;
		info.arg2 = 0;
		info.func = SetClassFilter;
		UIDropDownMenu_AddButton(info, level);
	end
end


local ClassFilter = Addon.CreateFilterButton('class', InitClassDropDownMenu);
ClassFilter:SetPoint('TOP', -65, -35);

Addon.SELECTED_FILTER_BUTTON = ClassFilter;