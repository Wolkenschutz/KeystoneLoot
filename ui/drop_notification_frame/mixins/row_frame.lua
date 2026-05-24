local AddonName, KeystoneLoot        = ...;

local Favorites                      = KeystoneLoot.Favorites;

KeystoneLootDropNotificationRowMixin = {};

function KeystoneLootDropNotificationRowMixin:Init(drop)
    self.itemLink = drop.itemLink;

    local _, _, _, _, icon = C_Item.GetItemInfoInstant(drop.itemId);
    local tier = Favorites:GetAnyTier(drop.itemId);

    self.IconFrame.FavoriteIcon:SetTexture(Favorites.TIER_TEXTURE[tier]);
    self.IconFrame.Icon:SetTexture(icon);

    self.ItemName:SetText(string.gsub(drop.itemLink, "[%[%]]", ""));
    self.PlayerName:SetText(drop.playerName);
end

function KeystoneLootDropNotificationRowMixin:OnEnter()
    self.HighlightTexture:Show();

    if (self:GetCenter() > GetScreenWidth() / 2) then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
    else
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
    end

    GameTooltip:SetHyperlink(self.itemLink);
    GameTooltip:Show();

    if (IsModifiedClick("DRESSUP")) then
        SetCursorByMode(Enum.Cursormode.InspectCursor);
    else
        ResetCursor();
    end

    self.UpdateTooltip = self.OnEnter;
end

function KeystoneLootDropNotificationRowMixin:OnLeave()
    self.HighlightTexture:Hide();

    GameTooltip:Hide();
    ResetCursor();

    self.UpdateTooltip = nil;
end

function KeystoneLootDropNotificationRowMixin:OnClick()
    if (IsModifierKeyDown()) then
        HandleModifiedItemClick(self.itemLink);
    end
end
