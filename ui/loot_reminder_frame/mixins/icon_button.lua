local AddonName, KeystoneLoot = ...;

local Upgrade = KeystoneLoot.Upgrade;
local L = KeystoneLoot.L;

KeystoneLootReminderIconMixin = {};

function KeystoneLootReminderIconMixin:Init(itemId, icon, isShared, players)
    self.itemId = itemId;
    self.players = players;

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

    GameTooltip.KeystoneLootOwned = true;
    GameTooltip:SetHyperlink(Upgrade:BuildItemLink(self.itemId));

    if (self.players) then
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine(string.format(L["Wanted by %s"], table.concat(self.players, ", ")), nil, nil, nil, true);
    end

    GameTooltip:Show();

    self.UpdateTooltip = self.OnEnter;
end

function KeystoneLootReminderIconMixin:OnLeave()
    GameTooltip.KeystoneLootOwned = nil;
    GameTooltip:Hide();

    self.UpdateTooltip = nil;
end
