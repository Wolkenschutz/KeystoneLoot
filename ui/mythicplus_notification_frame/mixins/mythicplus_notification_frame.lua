local AddonName, KeystoneLoot                = ...;

local DB                                     = KeystoneLoot.DB;
local Keystone                               = KeystoneLoot.Keystone;
local Query                                  = KeystoneLoot.Query;
local L                                      = KeystoneLoot.L;

local FRAME_PADDING                          = 30;
local CARD_TEXT_LEFT                         = 40;
local CARD_PADDING                           = 7;

local FULL_GROUP_SIZE                        = 5;

local ROLE_ATLAS                             = {
    TANK    = "GM-icon-role-tank",
    HEALER  = "GM-icon-role-healer",
    DAMAGER = "GM-icon-role-dps"
};

local instanceIdToDungeon                    = {};

KeystoneLootMythicPlusNotificationFrameMixin = {};

function KeystoneLootMythicPlusNotificationFrameMixin:OnLoad()
    self:RegisterEvent("LFG_LIST_APPLICATION_STATUS_UPDATED");
    self:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterForDrag("LeftButton");

    self.Inset:Hide();
    self.Bg:SetPoint("TOPLEFT", 0, -6);
    self.Bg:SetPoint("BOTTOMRIGHT", -4, 3);
    self.HeadlineBg:SetVertexColor(0.1, 0.1, 0.1, 1);
    self.AddonLabel:SetText(AddonName);

    for _, dungeon in ipairs(Query:GetDungeons()) do
        instanceIdToDungeon[dungeon.instanceId] = dungeon;
    end
end

function KeystoneLootMythicPlusNotificationFrameMixin:OnShow()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN);
end

function KeystoneLootMythicPlusNotificationFrameMixin:OnHide()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);
end

function KeystoneLootMythicPlusNotificationFrameMixin:OnDragStart()
    self:StartMoving();
    self:SetUserPlaced(true);
end

function KeystoneLootMythicPlusNotificationFrameMixin:OnDragStop()
    self:StopMovingOrSizing();
end

function KeystoneLootMythicPlusNotificationFrameMixin:OnEvent(event, ...)
    if (event == "PLAYER_ENTERING_WORLD") then
        self:Hide();
        return;
    end

    if (event == "PLAYER_REGEN_ENABLED") then
        self:UnregisterEvent("PLAYER_REGEN_ENABLED");

        local groupInfo = self.groupInfo;
        if (groupInfo and self.pendingOpen) then
            self.pendingOpen = nil;
            self:Open(groupInfo.instanceId, groupInfo.activityName, self.pendingIsFull);
        end

        return;
    end

    if (event == "GROUP_LEFT") then
        self.groupInfo = nil;
        self.pendingOpen = nil;
        self.suppressResultId = nil;
        self.appliedRole = nil;

        self:UnregisterEvent("GROUP_ROSTER_UPDATE");
        self:UnregisterEvent("GROUP_LEFT");
        self:UnregisterEvent("PLAYER_REGEN_ENABLED");
        return;
    end

    if (event == "GROUP_ROSTER_UPDATE") then
        self:CheckFullGroup();
        return;
    end

    if (event == "LFG_LIST_ACTIVE_ENTRY_UPDATE") then
        self:CheckActiveEntry();
        return;
    end

    local searchResultId, newStatus = ...;
    if (newStatus ~= "inviteaccepted") then
        return;
    end

    local showJoined = DB:Get("settings.mythicPlusNotification.joined");
    if (not showJoined and not DB:Get("settings.mythicPlusNotification.full")) then
        return;
    end

    local searchResultInfo = C_LFGList.GetSearchResultInfo(searchResultId);
    if (not searchResultInfo) then
        return;
    end

    local activityInfo = C_LFGList.GetActivityInfoTable(searchResultInfo.activityIDs[1], nil, searchResultInfo.isWarMode);
    if (not activityInfo or not activityInfo.isMythicPlusActivity) then
        return;
    end

    local _, _, _, _, role = C_LFGList.GetApplicationInfo(searchResultId);
    self.appliedRole = role;

    self:RegisterEvent("GROUP_ROSTER_UPDATE");
    self:RegisterEvent("GROUP_LEFT");

    if (showJoined) then
        self.suppressResultId = searchResultId;
        self:HideJoinDialog();

        self:Open(activityInfo.mapID, activityInfo.fullName, false);
    else
        self.groupInfo = {
            instanceId    = activityInfo.mapID,
            activityName  = activityInfo.fullName,
            sawIncomplete = true
        };
    end
end

function KeystoneLootMythicPlusNotificationFrameMixin:CheckActiveEntry()
    if (self.groupInfo or not DB:Get("settings.mythicPlusNotification.full")) then
        return;
    end

    local entryData = C_LFGList.GetActiveEntryInfo();
    if (not entryData) then
        return;
    end

    local activityInfo = C_LFGList.GetActivityInfoTable(entryData.activityIDs[1]);
    if (not activityInfo or not activityInfo.isMythicPlusActivity) then
        return;
    end

    self.groupInfo = {
        instanceId    = activityInfo.mapID,
        activityName  = activityInfo.fullName,
        sawIncomplete = GetNumGroupMembers() < FULL_GROUP_SIZE
    };

    self:RegisterEvent("GROUP_ROSTER_UPDATE");
    self:RegisterEvent("GROUP_LEFT");
end

function KeystoneLootMythicPlusNotificationFrameMixin:HideJoinDialog()
    local Dialog = LFGListInviteDialog;

    if (Dialog and Dialog:IsShown() and Dialog.informational and Dialog.resultID == self.suppressResultId) then
        StaticPopupSpecial_Hide(Dialog);
    end
end

function KeystoneLootMythicPlusNotificationFrameMixin:CheckFullGroup()
    local groupInfo = self.groupInfo;
    if (not groupInfo) then
        return;
    end

    if (GetNumGroupMembers() < FULL_GROUP_SIZE) then
        groupInfo.sawIncomplete = true;
        return;
    end

    self:UnregisterEvent("GROUP_ROSTER_UPDATE");

    if (groupInfo.sawIncomplete and DB:Get("settings.mythicPlusNotification.full")) then
        self:Open(groupInfo.instanceId, groupInfo.activityName, true);
    else
        self.groupInfo = nil;
    end
end

function KeystoneLootMythicPlusNotificationFrameMixin:Open(instanceId, activityName, isFull)
    local dungeon = instanceIdToDungeon[instanceId];
    if (dungeon and Keystone:GetCurrentChallengeMapId() == dungeon.challengeModeId) then
        self.groupInfo = nil;
        return;
    end

    local groupInfo = self.groupInfo or {};

    groupInfo.instanceId = instanceId;
    groupInfo.activityName = activityName;
    self.groupInfo = groupInfo;

    if (InCombatLockdown()) then
        self.pendingOpen = true;
        self.pendingIsFull = isFull;
        self:RegisterEvent("PLAYER_REGEN_ENABLED");
        return;
    end

    local Card = self.Card;
    local dungeonName = activityName;

    if (dungeon) then
        local mapName, _, _, texture = C_ChallengeMode.GetMapUIInfo(dungeon.challengeModeId);
        dungeonName = mapName or dungeonName;

        Card:Init(dungeon, texture);
        Card:UpdateCooldown();
    else
        Card.Icon:SetTexture(nil);
        Card.Cooldown:Hide();
        Card:Disable();
    end

    self.Title:SetText(isFull and L["Group is full!"] or L["Mythic+ group joined!"]);
    Card.DungeonName:SetText(dungeonName);

    local role = UnitGroupRolesAssigned("player");
    if (not ROLE_ATLAS[role]) then
        role = self.appliedRole;
    end

    local atlas = role and ROLE_ATLAS[role];
    Card.RoleIcon:SetShown(atlas ~= nil);
    Card.RoleText:SetText(atlas and _G[role] or "");

    if (atlas) then
        Card.RoleIcon:SetAtlas(atlas);
    end

    self:SetWidth(FRAME_PADDING * 2 + CARD_TEXT_LEFT + CARD_PADDING + Card.DungeonName:GetStringWidth());
    self:Show();

    if (isFull) then
        self.groupInfo = nil;
    end
end

EventUtil.ContinueOnAddOnLoaded("Blizzard_GroupFinder", function()
    hooksecurefunc("LFGListInviteDialog_Show", function(Dialog)
        KeystoneLootMythicPlusNotificationFrame:HideJoinDialog();
    end);
end);
