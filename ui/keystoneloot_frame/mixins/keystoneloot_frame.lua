local AddonName, KeystoneLoot = ...;

local DB = KeystoneLoot.DB;
local Favorites = KeystoneLoot.Favorites;
local Character = KeystoneLoot.Character;
local Voidcore = KeystoneLoot.Voidcore;
local Keystone = KeystoneLoot.Keystone;
local CopyPopup = KeystoneLoot.CopyPopup;
local L = KeystoneLoot.L;

local WEBSITE_URL = "keystoneloot.io";

local isResponsePaused = false;

KeystoneLootFrameMixin = {};

function KeystoneLootFrameMixin:OnLoad()
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("BONUS_ROLL_RESULT");
    self:RegisterForDrag("LeftButton");

    CallbackRegistryMixin.OnLoad(self);
    TabSystemOwnerMixin.OnLoad(self);

    self:SetPortraitToAsset("Interface\\Icons\\INV_Relics_Hourglass_02");
    self:SetTitle(string.format(L['%s (%s Season %d)'], AddonName, KeystoneLoot.Config.expansionName, KeystoneLoot.Config.seasonNumber));

    local website = string.format(L["Import BIS items from %s"], ACCOUNT_WIDE_FONT_COLOR:WrapTextInColorCode(WEBSITE_URL));

    self.FooterText:SetText("Made with LOVE in Germany - " .. website);

    self.FooterButton:SetScript("OnClick", function()
        CopyPopup:Show("https://" .. WEBSITE_URL);
    end);

    table.insert(UISpecialFrames, self:GetName());
end

function KeystoneLootFrameMixin:InitializeTabSystem()
    self:SetTabSystem(self.TabSystem);

    self.DungeonsFrame = CreateFrame("Frame", nil, self, "KeystoneLootDungeonsFrameTemplate");
    self.DungeonsFrame:Init();
    self.dungeonsTabId = self:AddNamedTab(DUNGEONS, self.DungeonsFrame);

    self.RaidsFrame = CreateFrame("Frame", nil, self, "KeystoneLootRaidsFrameTemplate");
    self.RaidsFrame:Init();
    self.raidsTabId = self:AddNamedTab(RAIDS, self.RaidsFrame);

    self:SetTab(self.dungeonsTabId);
end

function KeystoneLootFrameMixin:OnEvent(event, ...)
    if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
        self:SyncSpecFilter();
        return;
    elseif (event == "BAG_UPDATE_DELAYED" or event == "PLAYER_EQUIPMENT_CHANGED") then
        self:RefreshOwnedIcons();
        return;
    elseif (event == "BONUS_ROLL_RESULT") then
        local rewardType, rewardLink = ...;
        if (rewardType ~= "item" or not rewardLink) then
            return;
        end

        local itemId = tonumber(string.match(rewardLink, "item:(%d+)"));
        if (not itemId) then
            return;
        end

        Voidcore:OnBonusRoll(itemId);
        return;
    elseif (event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_GUILD") then
        if (not DB:Get("settings.keyCommand." .. event) or isResponsePaused) then
            return;
        end

        local msg = ...;
        if (not issecretvalue(msg) and string.match(string.lower(msg), "^!key")) then
            local link = Keystone:GetKeystoneItemLink();
            if (not link) then
                return;
            end

            local channel = event == "CHAT_MSG_GUILD" and "GUILD" or "PARTY";
            C_ChatInfo.SendChatMessage("[KeystoneLoot]: " .. link, channel);

            isResponsePaused = true;
            C_Timer.After(2, function()
                isResponsePaused = false;
            end);
        end
        return;
    end

    self:UnregisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
    self:RegisterEvent("CHAT_MSG_PARTY");
    self:RegisterEvent("CHAT_MSG_PARTY_LEADER");
    self:RegisterEvent("CHAT_MSG_GUILD");

    DB:Init();
    Favorites:Init();

    self:InitSpecFilter();

    self:InitializeTabSystem();

    self.ClassDropdown:Init();
    self.SlotDropdown:Init();
    self.ItemLevelDropdown:Init();
    self.CharacterDropdown:Init();
    self.SettingsDropdown:Init();
    self.CatalystFrame:Init();
    self.CustomItemFrame:Init();
    KeystoneLootMinimapButton:Init();

    KeystoneLoot.APIInternal.SetReady();

    if (DB:Get("voidcoreChecked") or UnitLevel("player") < 90) then
        return;
    end

    C_Timer.After(3, function()
        Voidcore:CheckAll();
    end);
end

function KeystoneLootFrameMixin:SyncSpecFilter()
    local currentClassId = Character:GetCurrentClassId();

    if (DB:Get("filters.classId") == currentClassId) then
        DB:Set("filters.classId", currentClassId);
        DB:Set("filters.specId", Character:GetCurrentSpecId());
    end
end

function KeystoneLootFrameMixin:InitSpecFilter()
    local currentClassId = Character:GetCurrentClassId();
    local currentSpecId = Character:GetCurrentSpecId();

    if (DB:Get("filters.classId") ~= currentClassId) then
        DB:Set("filters.classId", currentClassId);
        DB:Set("filters.specId", currentSpecId);
    elseif (DB:Get("filters.specId") ~= 0) then
        DB:Set("filters.specId", currentSpecId);
    end
end

function KeystoneLootFrameMixin:SetTab(tabId)
    TabSystemOwnerMixin.SetTab(self, tabId);

    local tabName = self:GetTabName(tabId);
    DB:Set("ui.selectedTab", tabName);

    self:RefreshSize(tabId);
end

function KeystoneLootFrameMixin:RefreshOwnedIcons()
    for _, Frame in ipairs({ self.DungeonsFrame, self.RaidsFrame, self.CatalystFrame, self.CustomItemFrame }) do
        Frame:RefreshOwnedIcons();
    end
end

function KeystoneLootFrameMixin:OnShow()
    PlaySound(SOUNDKIT.IG_QUEST_LIST_OPEN);

    self:RegisterEvent("BAG_UPDATE_DELAYED");
    self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");

    self:RefreshOwnedIcons();
end

function KeystoneLootFrameMixin:OnHide()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);

    self:UnregisterEvent("BAG_UPDATE_DELAYED");
    self:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED");
end

function KeystoneLootFrameMixin:OnDragStart()
    self:StartMoving();
    self:SetUserPlaced(true);
end

function KeystoneLootFrameMixin:OnDragStop()
    self:StopMovingOrSizing();
end

function KeystoneLootFrameMixin:RefreshSize(tabId)
    local Frame = self:GetElementsForTab(tabId)[1];
    self:SetSize(Frame:GetSize());
end

function KeystoneLootFrameMixin:GetTabName(tabId)
    if (tabId == self.dungeonsTabId) then
        return "dungeons";
    elseif (tabId == self.raidsTabId) then
        return "raids";
    end

    return "dungeons"; -- Fallback
end
