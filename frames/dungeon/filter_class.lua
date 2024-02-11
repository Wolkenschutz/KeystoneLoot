local AddonName, Addon = ...;


local Filter = Addon.Filter:CreateButton(Addon.Overview:GetTab('Dungeon'), 'Class');
Filter:SetPoint('TOP', -120, -35);

local function SetFilterText()
	local selectedClassID, selectedSpecID = Addon.Database:GetSelectedClass();

	local classInfo = C_CreatureInfo.GetClassInfo(selectedClassID);
	local classColorStr = RAID_CLASS_COLORS[classInfo.classFile].colorStr;
	local specName = GetSpecializationNameForSpecID(selectedSpecID);

	local text;
	if (specName == nil or specName =='') then
		text = HEIRLOOMS_CLASS_FILTER_FORMAT:format(classColorStr, classInfo.className);
	else
		text = HEIRLOOMS_CLASS_SPEC_FILTER_FORMAT:format(classColorStr, classInfo.className, specName);
	end

	Addon.DropDownMenu:SetText(text);
end

local function SetFilter(classID, specID)
	if (specID == 0) then
		local _, _, playerClassID = UnitClass('player');
		specID = playerClassID == classID and (GetSpecializationInfo(GetSpecialization())) or (GetSpecializationInfoForClassID(classID, 1));
	end

	Addon.Database:SetSelectedClass(classID, specID);
	Addon.Overview:GetTab('Dungeon'):Update();

	SetFilterText();
end

function Filter:GetDefaultValue()
	return select(3, UnitClass('player')), (GetSpecializationInfo(GetSpecialization()));
end

function Filter:Init()
	SetFilterText();
end

function Filter:List()
	local selectedClassID, selectedSpecID = Addon.Database:GetSelectedClass();
	local _list = {};

	local numClasses = GetNumClasses();
	for classIndex=1, numClasses do
		local classDisplayName, classFile, classID = GetClassInfo(classIndex);
		local classColorStr = RAID_CLASS_COLORS[classFile].colorStr;
		local isSelectedClass = classID == selectedClassID;

		if (isSelectedClass and classIndex ~= 1) then
			local info = {};
			info.divider = true;
			table.insert(_list, info);
		end

		local info = {};
		info.text = HEIRLOOMS_CLASS_FILTER_FORMAT:format(classColorStr, classDisplayName)..(isSelectedClass and '' or ' ...');
		info.checked = isSelectedClass;
		info.notCheckable = isSelectedClass;
		info.disabled = isSelectedClass;
		info.args = { classID, 0 };
		info.func = SetFilter;
		info.keepShownOnClick = true;
		table.insert(_list, info);

		if (isSelectedClass) then
			for specIndex=1, GetNumSpecializationsForClassID(classID) do
				local specID, specName = GetSpecializationInfoForClassID(classID, specIndex);

				local info = {};
				info.leftPadding = 10;
				info.text = specName;
				info.checked = selectedSpecID == specID;
				info.disabled = info.checked;
				info.args = { classID, specID };
				info.func = SetFilter;
				table.insert(_list, info);
			end

			if (classIndex ~= numClasses) then
				local info = {};
				info.divider = true;
				table.insert(_list, info);
			end
		end
	end

	return _list;
end