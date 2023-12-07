local AddonName, Addon = ...;




local function SetFilterText(self)
	local SELECTED_CLASS_ID = KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID;
	local classInfo = C_CreatureInfo.GetClassInfo(SELECTED_CLASS_ID);
	local classColorStr = RAID_CLASS_COLORS[classInfo.classFile].colorStr;

	local SELECTED_SPEC_ID = KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID;
	local specName = GetSpecializationNameForSpecID(SELECTED_SPEC_ID);

	if (specName == nil or specName == '') then
		SELECTED_SPEC_ID = 0;
	end

	local text;
	if (SELECTED_SPEC_ID > 0) then
		text = HEIRLOOMS_CLASS_SPEC_FILTER_FORMAT:format(classColorStr, classInfo.className, specName);
	else
		text = HEIRLOOMS_CLASS_FILTER_FORMAT:format(classColorStr, classInfo.className);
	end

	if (self == nil) then
		Addon.API.SetDropDownMenuText(text);
	else
		self.Text:SetText(text);
	end
	
end

local function SetFilter(classID, specID)
	KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID = classID;
	KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID = specID;

	Addon.API.UpdateLoot();

	SetFilterText();
end

local function InitFunction(self)
	if (KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID == nil) then
		local _, _, classID = UnitClass('player');

		KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID = classID;
	end

	if (KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID == nil) then
		local specID = (GetSpecializationInfo(GetSpecialization()));

		KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID = specID;
	end

	SetFilterText(self);
end

local function ListFunction()
	local SELECTED_CLASS_ID = KEYSTONE_LOOT_CHAR_DB.SELECTED_CLASS_ID;
	local SELECTED_SPEC_ID = KEYSTONE_LOOT_CHAR_DB.SELECTED_SPEC_ID;
	local list = {};

	local numClasses = GetNumClasses();
	for i=1, numClasses do
		local classDisplayName, classFile, classID = GetClassInfo(i);
		local classColorStr = RAID_CLASS_COLORS[classFile].colorStr;
		local isSelectedClass = classID == SELECTED_CLASS_ID;

		if (isSelectedClass and i ~= 1) then
			local info = {};
			info.divider = true;
			table.insert(list, info);
		end

		local info = {};
		info.text = HEIRLOOMS_CLASS_FILTER_FORMAT:format(classColorStr, classDisplayName)..(isSelectedClass and '' or ' ...');
		info.checked = isSelectedClass;
		info.notCheckable = isSelectedClass;
		info.disabled = isSelectedClass;
		info.args = { classID, 0 };
		info.func = SetFilter;
		info.keepShownOnClick = true;
		table.insert(list, info);

		if (isSelectedClass) then
			for y=1, GetNumSpecializationsForClassID(classID) do
				local specID, specName = GetSpecializationInfoForClassID(classID, y);

				local info = {};
				info.leftPadding = 10;
				info.text = specName;
				info.checked = SELECTED_SPEC_ID == specID;
				info.disabled = info.checked;
				info.args = { classID, specID };
				info.func = SetFilter;
				table.insert(list, info);
			end

			local info = {};
			info.leftPadding = 10;
			info.text = ALL_SPECS;
			info.checked = (SELECTED_CLASS_ID == classID and SELECTED_SPEC_ID == 0);
			info.disabled = info.checked;
			info.args = { classID, 0 };
			info.func = SetFilter;
			table.insert(list, info);

			if (i ~= numClasses) then
				local info = {};
				info.divider = true;
				table.insert(list, info);
			end
		end
	end

	return list;
end


local Filter = Addon.CreateFilterButton('class', ListFunction, InitFunction);
Filter:SetPoint('TOP', -120, -35);