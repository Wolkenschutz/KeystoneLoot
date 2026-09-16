local AddonName, KeystoneLoot = ...;

KeystoneLoot.RoleCheck     = {};

local RoleCheck            = KeystoneLoot.RoleCheck;
local DB                   = KeystoneLoot.DB;

RoleCheck.MODE_DISABLED    = 0;
RoleCheck.MODE_MYTHIC_PLUS = 1;
RoleCheck.MODE_EVERYWHERE  = 2;

local function IsMythicPlusActivity(activityId, isWarMode)
    if (not activityId) then
        return false;
    end

    local activityInfo = C_LFGList.GetActivityInfoTable(activityId, nil, isWarMode);
    return activityInfo ~= nil and activityInfo.isMythicPlusActivity == true;
end

local function IsMythicPlusSignup()
    local entryData = C_LFGList.GetActiveEntryInfo();
    if (entryData and IsMythicPlusActivity(entryData.activityIDs[1])) then
        return true;
    end

    for _, searchResultId in ipairs(C_LFGList.GetApplications()) do
        local searchResultInfo = C_LFGList.GetSearchResultInfo(searchResultId);

        if (searchResultInfo and IsMythicPlusActivity(searchResultInfo.activityIDs[1], searchResultInfo.isWarMode)) then
            return true;
        end
    end

    return false;
end

function RoleCheck:OnRoleCheckShow()
    local mode = DB:Get("settings.roleCheck");

    if (mode == self.MODE_DISABLED) then
        return;
    end

    if (mode == self.MODE_MYTHIC_PLUS and not IsMythicPlusSignup()) then
        return;
    end

    RunNextFrame(LFDRoleCheckPopupAccept_OnClick);
end
