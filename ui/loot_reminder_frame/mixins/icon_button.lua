local AddonName, KeystoneLoot = ...;

local Upgrade = KeystoneLoot.Upgrade;

KeystoneLootReminderIconMixin = {};

function KeystoneLootReminderIconMixin:Init(itemId, icon, isShared)
    self.itemId = itemId;

    self.Icon:SetTexture(icon);
    self.Icon:SetDesaturated(isShared);
    self:SetAlpha(isShared and 0.5 or 1);
    self:Show();
end

function KeystoneLootReminderIconMixin:OnEnter()
    if (self:GetCenter() > GetScreenWidth() / 2) then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
    else
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
    end

    GameTooltip:SetHyperlink(Upgrade:BuildItemLink(self.itemId));
    GameTooltip:Show();
end

function KeystoneLootReminderIconMixin:OnLeave()
    GameTooltip:Hide();
end
