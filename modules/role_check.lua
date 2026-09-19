local AddonName, KeystoneLoot = ...;

KeystoneLoot.RoleCheck        = {};

local RoleCheck               = KeystoneLoot.RoleCheck;
local DB                      = KeystoneLoot.DB;

RoleCheck.MODE_DISABLED       = 0;
RoleCheck.MODE_MYTHIC_PLUS    = 1;
RoleCheck.MODE_EVERYWHERE     = 2;

local function IsMythicPlusRoleCheck()
    local isLFGList, activityId = C_LFGList.GetRoleCheckInfo();
    if (not isLFGList or not activityId) then
        return false;
    end

    local activityInfo = C_LFGList.GetActivityInfoTable(activityId);
    return activityInfo ~= nil and activityInfo.isMythicPlusActivity == true;
end

function RoleCheck:OnRoleCheckShow()
    local mode = DB:Get("settings.roleCheck");

    if (mode == self.MODE_DISABLED) then
        return;
    end

    if (mode == self.MODE_MYTHIC_PLUS and not IsMythicPlusRoleCheck()) then
        return;
    end

    RunNextFrame(LFDRoleCheckPopupAccept_OnClick);
end
