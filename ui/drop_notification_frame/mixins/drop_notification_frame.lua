local AddonName, KeystoneLoot          = ...;

local DB                               = KeystoneLoot.DB;
local Favorites                        = KeystoneLoot.Favorites;
local Query                            = KeystoneLoot.Query;
local L                                = KeystoneLoot.L;

local FRAME_HEADER_HEIGHT              = 60;
local ROW_HEIGHT                       = 45;
local FRAME_PADDING_BOTTOM             = 14;

KeystoneLootDropNotificationFrameMixin = {};

function KeystoneLootDropNotificationFrameMixin:OnLoad()
    self:RegisterEvent("ENCOUNTER_LOOT_RECEIVED");
    self:RegisterForDrag("LeftButton");

    self.Inset:Hide();
    self.Bg:SetPoint("TOPLEFT", 0, -6);
    self.Bg:SetPoint("BOTTOMRIGHT", -4, 3);
    self.HeadlineBg:SetVertexColor(0.1, 0.1, 0.1, 1);
    self.Title:SetText(L["Favorite dropped!"]);

    self.drops   = {};
    self.rowPool = CreateFramePool("Button", self, "KeystoneLootDropNotificationRowTemplate");
end

function KeystoneLootDropNotificationFrameMixin:OnShow()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN);
end

function KeystoneLootDropNotificationFrameMixin:OnHide()
    table.wipe(self.drops);
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);
end

function KeystoneLootDropNotificationFrameMixin:OnDragStart()
    self:StartMoving();
    self:SetUserPlaced(true);
end

function KeystoneLootDropNotificationFrameMixin:OnDragStop()
    self:StopMovingOrSizing();
end

function KeystoneLootDropNotificationFrameMixin:OnEvent(event, ...)
    local _, itemId, itemLink, _, playerName = ...;

    if (not DB:Get("settings.lootReminder.dropAlert")) then
        return;
    end

    if (playerName == UnitName("player")) then
        return;
    end

    local _, instanceType = GetInstanceInfo();
    if (instanceType ~= "party" and instanceType ~= "raid") then
        return;
    end

    if (not Query:GetItemInfo(itemId)) then
        return;
    end

    local tier = Favorites:GetAnyTier(itemId, true);
    if (tier == 0) then
        return;
    end

    local item = Item:CreateFromItemLink(itemLink);
    item:ContinueOnItemLoad(function()
        local _, _, _, _, _, _, _, _, _, _, _, _, _, bindType = C_Item.GetItemInfo(itemLink);

        if (Enum.ItemBind.OnAcquire ~= bindType) then
            return;
        end

        table.insert(self.drops, {
            itemId     = itemId,
            itemLink   = itemLink,
            playerName = playerName,
        });

        self:Refresh();

        if (not self:IsShown()) then
            self:Show();
        end
    end);
end

function KeystoneLootDropNotificationFrameMixin:Refresh()
    self.rowPool:ReleaseAll();

    local PrevRow = nil;
    for _, drop in ipairs(self.drops) do
        local Row = self.rowPool:Acquire();
        Row:ClearAllPoints();

        if (PrevRow) then
            Row:SetPoint("TOPLEFT", PrevRow, "BOTTOMLEFT", 0, -5);
        else
            Row:SetPoint("TOP", self, -2, -FRAME_HEADER_HEIGHT);
        end

        Row:Init(drop);
        Row:Show();
        PrevRow = Row;
    end

    local numRows     = #self.drops;
    local totalHeight = FRAME_HEADER_HEIGHT + numRows * ROW_HEIGHT + FRAME_PADDING_BOTTOM;

    self:SetHeight(totalHeight);
end
