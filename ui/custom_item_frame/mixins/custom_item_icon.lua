local AddonName, KeystoneLoot = ...;

local L = KeystoneLoot.L;

KeystoneLootCustomItemIconMixin = {};

function KeystoneLootCustomItemIconMixin:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:SetText(L["Custom Items"], HIGHLIGHT_FONT_COLOR:GetRGB());
    GameTooltip:AddLine(L["Import items from external sources like www.keystoneloot.io"], nil, nil, nil, true);
    GameTooltip:Show();
end

function KeystoneLootCustomItemIconMixin:OnLeave()
    GameTooltip:Hide();
end
