local AddonName, KeystoneLoot = ...;

local DB                      = KeystoneLoot.DB;
local L                       = KeystoneLoot.L;

local DEFAULT_WHISPER_MESSAGE = "Can I have {item} please?";

local function BuildWhisperMessage(itemLink)
    local template = DB:Get("settings.lootReminder.whisperMessage") or DEFAULT_WHISPER_MESSAGE;
    return string.gsub(template, "{item}", itemLink);
end

KeystoneLootDropNotificationWhisperButtonMixin = {};

function KeystoneLootDropNotificationWhisperButtonMixin:OnClick()
    local Parent     = self:GetParent();
    local playerName = Parent.PlayerName:GetText();
    local itemLink   = Parent.itemLink;
    local message    = BuildWhisperMessage(itemLink);

    C_ChatInfo.SendChatMessage(message, "WHISPER", nil, playerName);
end

function KeystoneLootDropNotificationWhisperButtonMixin:OnEnter()
    local Parent     = self:GetParent();
    local playerName = Parent.PlayerName:GetText();
    local itemLink   = Parent.itemLink;
    local message    = BuildWhisperMessage(itemLink);

    if (self:GetCenter() > GetScreenWidth() / 2) then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT");
    else
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    end

    GameTooltip:SetText(WHISPER, 1, 1, 1);
    GameTooltip:AddLine(message, nil, nil, nil, true);
    GameTooltip:AddLine(L["Text can be modified in the settings."], GRAY_FONT_COLOR:GetRGB());
    GameTooltip:Show();
end

function KeystoneLootDropNotificationWhisperButtonMixin:OnLeave()
    GameTooltip:Hide();
end
