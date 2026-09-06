local AddonName, KeystoneLoot  = ...;

local Keystone                 = KeystoneLoot.Keystone;
local Favorites                = KeystoneLoot.Favorites;
local Query                    = KeystoneLoot.Query;
local Character                = KeystoneLoot.Character;
local DB                       = KeystoneLoot.DB;
local L                        = KeystoneLoot.L;

local SPEC_FRAME_WIDTH         = 180;
local SPEC_FRAME_HEIGHT        = 90;
local SPEC_FRAME_SPACING       = 20;
local FRAME_PADDING            = 20;
local FRAME_HEADER_HEIGHT      = 80;
local SPEC_TITLE_HEIGHT        = 24;
local SPEC_BUTTON_HEIGHT       = 30;

local FULL_GROUP_SIZE          = 5;
local ADDON_PREFIX             = "KeystoneLoot";
local MSG_ENTER                = "E";
local MSG_REPLY                = "R";
local SEND_DELAY               = 0.5;
local EVALUATE_DELAY           = 10;

KeystoneLootReminderFrameMixin = {};

function KeystoneLootReminderFrameMixin:OnLoad()
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("GROUP_ROSTER_UPDATE");
    self:RegisterForDrag("LeftButton");

    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_PREFIX);

    self.Inset:Hide();
    self.Bg:SetPoint("TOPLEFT", 0, -6);
    self.Bg:SetPoint("BOTTOMRIGHT", -4, 3);
    self.HeadlineBg:SetVertexColor(0.1, 0.1, 0.1, 1);
    self.AddonLabel:SetText(AddonName);

    self.specPool = CreateFramePool("Frame", self.Container, "KeystoneLootReminderSpecTemplate");
    self.groupGuids = {};
    self.partyFavorites = {};
end

function KeystoneLootReminderFrameMixin:OnShow()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN);
end

function KeystoneLootReminderFrameMixin:OnHide()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);
end

function KeystoneLootReminderFrameMixin:OnDragStart()
    self:StartMoving();
    self:SetUserPlaced(true);
end

function KeystoneLootReminderFrameMixin:OnDragStop()
    self:StopMovingOrSizing();
end

function KeystoneLootReminderFrameMixin:OnEvent(event, ...)
    if (event == "PLAYER_ENTERING_WORLD") then
        self:Hide();
        self.challengeMapId = Keystone:GetCurrentChallengeMapId();
        self.isLocked = false;
        self.isEvaluated = false;

        if (self.evaluateTimer) then
            self.evaluateTimer:Cancel();
            self.evaluateTimer = nil;
        end

        if (IsInGroup()) then
            self:RegisterEvent("CHAT_MSG_ADDON");
            self.groupGuids = self:GetGroupGuids();
        else
            self:UnregisterEvent("CHAT_MSG_ADDON");
        end

        if (not self.challengeMapId) then
            self:UnregisterEvent("CHALLENGE_MODE_START");
            self:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
            return;
        end

        self:RegisterEvent("CHALLENGE_MODE_START");
        self:RegisterEvent("ZONE_CHANGED_NEW_AREA");

        if (C_ChallengeMode.IsChallengeModeActive()) then
            self.isLocked = true;
            return;
        end

        if (DB:Get("settings.lootReminder.dungeons")) then
            self:Open(Keystone:GetLootReminderItemList(self.challengeMapId));
        end

        self:SendFavorites(MSG_ENTER);
        self:CheckGroup();
    elseif (event == "GROUP_ROSTER_UPDATE") then
        if (not IsInGroup()) then
            self:UnregisterEvent("CHAT_MSG_ADDON");
            self.groupGuids = {};
            return;
        end

        self:RegisterEvent("CHAT_MSG_ADDON");

        if (not self.challengeMapId) then
            return;
        end

        local groupGuids = self:GetGroupGuids();
        local hasNewMember = false;

        for guid in pairs(groupGuids) do
            if (not self.groupGuids[guid]) then
                hasNewMember = true;
                break;
            end
        end

        self.groupGuids = groupGuids;

        if (hasNewMember) then
            self:QueueReply();
        end

        self:CheckGroup();
    elseif (event == "ZONE_CHANGED_NEW_AREA") then
        self:CheckGroup();
    elseif (event == "CHALLENGE_MODE_START") then
        self.isLocked = true;

        if (self:IsShown() and self.isParty) then
            self:Hide();
        end
    elseif (event == "CHAT_MSG_ADDON") then
        local prefix, text, _, sender = ...;
        if (prefix == ADDON_PREFIX) then
            self:OnAddonMessage(text, sender);
        end
    end
end

function KeystoneLootReminderFrameMixin:GetGroupGuids()
    local guids = {};

    if (IsInGroup()) then
        for i = 1, GetNumSubgroupMembers() do
            local guid = UnitGUID("party" .. i);
            if (guid) then
                guids[guid] = true;
            end
        end
    end

    return guids;
end

function KeystoneLootReminderFrameMixin:QueueReply()
    if (self.pendingSend) then
        return;
    end

    self.pendingSend = true;

    C_Timer.After(SEND_DELAY, function()
        self.pendingSend = nil;
        self:SendFavorites(MSG_REPLY);
    end);
end

function KeystoneLootReminderFrameMixin:SendFavorites(msgType)
    if (not IsInGroup()) then
        return;
    end

    local groupClassIds = {};
    for i = 1, GetNumSubgroupMembers() do
        local _, _, classId = UnitClass("party" .. i);
        groupClassIds[classId] = true;
    end

    local itemIds = {};
    for _, itemInfo in ipairs(Favorites:GetList(self.challengeMapId, 0, true)) do
        for classId in pairs(Query:GetItemInfo(itemInfo.itemId).classes) do
            if (groupClassIds[classId]) then
                table.insert(itemIds, itemInfo.itemId);
                break;
            end
        end
    end

    local message = string.format("%s:%d:%s", msgType, self.challengeMapId, table.concat(itemIds, ","));
    C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "PARTY");
end

function KeystoneLootReminderFrameMixin:OnAddonMessage(text, sender)
    if (sender == UnitName("player") .. "-" .. GetNormalizedRealmName()) then
        return;
    end

    local msgType, challengeMapId, itemList = string.match(text, "^(%a):(%d+):(.*)$");
    if (not msgType) then
        return;
    end

    local name = Ambiguate(sender, "none");
    local guid = UnitGUID(name);
    if (not guid) then
        return;
    end

    local itemIds = {};
    for itemId in string.gmatch(itemList, "%d+") do
        table.insert(itemIds, tonumber(itemId));
    end

    challengeMapId = tonumber(challengeMapId);
    if (not self.partyFavorites[challengeMapId]) then
        self.partyFavorites[challengeMapId] = {};
    end

    self.partyFavorites[challengeMapId][guid] = {
        name    = name,
        itemIds = itemIds,
    };

    if (challengeMapId ~= self.challengeMapId) then
        return;
    end

    if (msgType == MSG_ENTER) then
        self:QueueReply();
    end

    if (self.evaluateTimer and self:HasAllMessages()) then
        self.evaluateTimer:Cancel();
        self:Evaluate();
    end
end

function KeystoneLootReminderFrameMixin:HasAllMessages()
    if (not self.partyFavorites[self.challengeMapId]) then
        return false;
    end

    for guid in pairs(self.groupGuids) do
        if (not self.partyFavorites[self.challengeMapId][guid]) then
            return false;
        end
    end

    return true;
end

function KeystoneLootReminderFrameMixin:IsGroupComplete()
    if (GetNumGroupMembers() ~= FULL_GROUP_SIZE) then
        return false;
    end

    local myMapId = C_Map.GetBestMapForUnit("player");
    local complete = true;

    for i = 1, GetNumSubgroupMembers() do
        local unit = "party" .. i;
        local mapId = C_Map.GetBestMapForUnit(unit);

        if (mapId ~= myMapId) then
            complete = false;
        end
    end

    return complete;
end

function KeystoneLootReminderFrameMixin:CheckGroup()
    if (self.isLocked or self.isEvaluated) then
        return;
    end

    if (not DB:Get("settings.lootReminder.party")) then
        return;
    end

    if (#Favorites:GetList(self.challengeMapId, 0, true) > 0) then
        return;
    end

    if (not self:IsGroupComplete()) then
        return;
    end

    self.isEvaluated = true;

    if (self:HasAllMessages()) then
        self:Evaluate();
        return;
    end

    self.evaluateTimer = C_Timer.NewTimer(EVALUATE_DELAY, function()
        self:Evaluate();
    end);
end

function KeystoneLootReminderFrameMixin:Evaluate()
    self.evaluateTimer = nil;

    if (self.isLocked) then
        return;
    end

    local itemList = Keystone:GetPartyLootReminderItemList(self.challengeMapId, self:GetPartyItems());
    self:Open(itemList, {}, true);
end

function KeystoneLootReminderFrameMixin:GetPartyItems()
    local items = {};

    if (not self.partyFavorites[self.challengeMapId]) then
        return items;
    end

    for guid, data in pairs(self.partyFavorites[self.challengeMapId]) do
        if (self.groupGuids[guid]) then
            for _, itemId in ipairs(data.itemIds) do
                if (not items[itemId]) then
                    items[itemId] = {};
                end

                table.insert(items[itemId], data.name);
            end
        end
    end

    return items;
end

function KeystoneLootReminderFrameMixin:Open(itemList, allSpecItems, isParty)
    if (not next(itemList)) then
        return;
    end

    self.isParty = isParty;
    self.Title:SetText(isParty and L["Your group needs loot from here"] or L["Correct loot specialization set?"]);
    self.specPool:ReleaseAll();

    local lootSpecId = Character:GetLootSpecId()

    -- Sort by favo spec id for deterministic ordering
    local sortedSpecs = {};
    for favoSpecId in pairs(itemList) do
        table.insert(sortedSpecs, favoSpecId);
    end
    table.sort(sortedSpecs);

    local PrevFrame = nil;
    for _, favoSpecId in ipairs(sortedSpecs) do
        local entry = itemList[favoSpecId];
        local SpecFrame = self.specPool:Acquire();
        SpecFrame:ClearAllPoints();

        if (PrevFrame) then
            SpecFrame:SetPoint("LEFT", PrevFrame, "RIGHT", SPEC_FRAME_SPACING, 0);
        else
            SpecFrame:SetPoint("TOPLEFT", self.Container);
        end

        SpecFrame:Init(entry.displaySpecId, entry.favoSpecId, entry.items, lootSpecId, allSpecItems);
        SpecFrame:Show();
        PrevFrame = SpecFrame;
    end

    -- Resize frame to fit all spec cards
    local numSpecs = #sortedSpecs;
    local totalWidth = FRAME_PADDING * 2 + numSpecs * SPEC_FRAME_WIDTH + (numSpecs - 1) * SPEC_FRAME_SPACING;
    local totalHeight = FRAME_HEADER_HEIGHT + SPEC_TITLE_HEIGHT + SPEC_FRAME_HEIGHT + SPEC_BUTTON_HEIGHT;

    -- Shared items footer
    local numShared = 0;
    for _ in pairs(allSpecItems) do
        numShared = numShared + 1;
    end

    if (numShared > 0) then
        local text;
        if (numShared == 1) then
            text = L["+1 item dropping for all specs."];
        else
            text = string.format(L["+%d items dropping for all specs."], numShared);
        end

        self.SharedItemsText:SetText(text);
        self.SharedItemsText:Show();

        if (totalWidth > 220) then
            totalHeight = totalHeight + 10;
        else
            totalHeight = totalHeight + 20;
        end
    else
        self.SharedItemsText:Hide();
        totalHeight = totalHeight - 5;
    end

    self:SetSize(totalWidth, totalHeight);
    self.Container:SetSize(totalWidth - FRAME_PADDING * 2, SPEC_FRAME_HEIGHT);
    self:Show();
end

function KeystoneLootReminderFrameMixin:UpdateLootSpec(lootSpecId)
    for SpecFrame in self.specPool:EnumerateActive() do
        SpecFrame:UpdateLootSpec(lootSpecId);
    end
end

hooksecurefunc("SetLootSpecialization", function(newLootSpecId)
    if (not KeystoneLootReminderFrame:IsShown()) then
        return;
    end

    KeystoneLootReminderFrame:UpdateLootSpec(newLootSpecId);
end);
