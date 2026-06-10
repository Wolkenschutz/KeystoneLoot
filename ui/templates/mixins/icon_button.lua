local AddonName, KeystoneLoot = ...;

local DB = KeystoneLoot.DB;
local Upgrade = KeystoneLoot.Upgrade;
local Favorites = KeystoneLoot.Favorites;
local Character = KeystoneLoot.Character;
local Query = KeystoneLoot.Query;
local Voidcore = KeystoneLoot.Voidcore;

local STAT_HIGHLIGHT_KEYS = {
    [0] = "crit",
    [1] = "haste",
    [2] = "mastery",
    [3] = "versatility"
};

local function GetFavoritesSpecId()
    local info = Character:ParseKey(Character:GetSelectedKey());
    if (not info) then
        return 0;
    end

    local classId = DB:Get("filters.classId");
    if (classId ~= info.classId) then
        return 0;
    end

    return DB:Get("filters.specId");
end

local function IsItemValidForCharacter()
    local info = Character:ParseKey(Character:GetSelectedKey());
    if (not info) then
        return false;
    end

    return DB:Get("filters.classId") == info.classId;
end

local function AddSpecLinesToTooltip(itemId)
    local info = Character:ParseKey(Character:GetSelectedKey());
    if (not info) then
        return;
    end

    if (DB:Get("filters.classId") ~= info.classId) then
        return;
    end

    if (DB:Get("filters.specId") ~= 0) then
        return;
    end

    local item = KeystoneLoot.ItemDatabase[itemId];
    if (not item or not item.classes[info.classId]) then
        return;
    end

    local specNames = {};
    for _, specId in ipairs(item.classes[info.classId]) do
        local name = Character:GetSpecName(specId);
        if (name ~= "") then
            table.insert(specNames, WHITE_FONT_COLOR:WrapTextInColorCode(name));
        end
    end

    local numSpecs = #specNames;
    if (numSpecs == 0) then
        return;
    end

    local line;
    if (numSpecs == 1) then
        line = string.format(FOR_SPECIALIZATION, specNames[1]);
    elseif (numSpecs == 2) then
        line = string.format(FOR_OR_SPECIALIZATIONS, specNames[1], specNames[2]);
    else
        -- Fallback for items that are usable by more than 2 specs.
        line = string.format(FOR_SPECIALIZATION, table.concat(specNames, " / "));
    end

    GameTooltip:AddLine(" ");
    GameTooltip:AddLine("|A:quest-important-available:16:16:0:0|a " .. line, nil, nil, nil, true);
end

KeystoneLootLootIconButtonMixin = {};

function KeystoneLootLootIconButtonMixin:Init(item)
    self:SetEnabled(item.itemId ~= 0);

    self.itemId = item.itemId;
    self.isHovered = false;

    self.Content.Icon:SetTexture(Query:GetItemIcon(item.itemId));
    self:UpdateFavoriteIcon();
    self:UpdateVoidcoreIcon();
    self:UpdateHighlight();
end

function KeystoneLootLootIconButtonMixin:UpdateHighlight()
    if (not self:IsEnabled()) then
        return;
    end

    local item = Query:GetItemInfo(self.itemId);
    if (not item) then
        return;
    end

    local highlighted = false;

    if (DB:Get("settings.highlighting.comboMode")) then
        if (item.stats) then
            highlighted = true;

            for _, stat in ipairs(item.stats) do
                local key = STAT_HIGHLIGHT_KEYS[stat];
                if (key and not DB:Get("settings.highlighting." .. key)) then
                    highlighted = false;
                    break;
                end
            end
        end
    else
        if (not item.stats) then
            highlighted = DB:Get("settings.highlighting.noStats");
        else
            for _, stat in ipairs(item.stats) do
                local key = STAT_HIGHLIGHT_KEYS[stat];
                if (key and DB:Get("settings.highlighting." .. key)) then
                    highlighted = true;
                    break;
                end
            end
        end
    end

    self.Content.Icon:SetDesaturated(not highlighted);
    self:SetAlpha(highlighted and 1 or 0.6);
end

function KeystoneLootLootIconButtonMixin:UpdateFavoriteIcon()
    if (not self:IsEnabled()) then
        self.Content.FavoriteIcon:Hide();
        return;
    end

    local slotId = DB:Get("filters.slotId");
    local isFavoritesSlot = slotId == -1;
    local info = Character:ParseKey(Character:GetSelectedKey());
    local classesMatch = info and DB:Get("filters.classId") == info.classId;

    local tier;
    if (isFavoritesSlot and not classesMatch) then
        tier = Favorites:GetAnyTier(self.itemId);
    else
        local specId = isFavoritesSlot and GetFavoritesSpecId() or DB:Get("filters.specId");
        tier = Favorites:GetTier(self.itemId, specId);
    end

    if (tier > 0) then
        self.Content.FavoriteIcon:SetTexture(Favorites.TIER_TEXTURE[tier]);
        self.Content.FavoriteIcon:SetDesaturated(false);
        self.Content.FavoriteIcon:Show();
    elseif (self.isHovered and (isFavoritesSlot or classesMatch)) then
        self.Content.FavoriteIcon:SetTexture(Favorites.TIER_TEXTURE[Favorites.TIER_MUST]);
        self.Content.FavoriteIcon:SetDesaturated(true);
        self.Content.FavoriteIcon:Show();
    else
        self.Content.FavoriteIcon:Hide();
    end
end

function KeystoneLootLootIconButtonMixin:UpdateVoidcoreIcon()
    if (not self:IsEnabled() or not Voidcore:IsEligible(self.itemId)) then
        self.Content.VoidcoreIcon:Hide();
        return;
    end

    if (Voidcore:IsUsed(self.itemId)) then
        self.Content.VoidcoreIcon:Show();
    else
        self.Content.VoidcoreIcon:Hide();
    end
end

function KeystoneLootLootIconButtonMixin:OnEnter()
    if (not self:IsEnabled()) then
        return;
    end

    if (self:GetCenter() > GetScreenWidth() / 2) then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 0, 12);
    else
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 12);
    end

    GameTooltip.KeystoneLootOwned = true;
    GameTooltip:SetHyperlink(Upgrade:BuildItemLink(self.itemId));
    AddSpecLinesToTooltip(self.itemId);
    GameTooltip:Show();

    if (IsModifiedClick("DRESSUP")) then
        SetCursorByMode(Enum.Cursormode.InspectCursor);
    else
        ResetCursor();
    end

    self.isHovered = true;
    self.UpdateTooltip = self.OnEnter;
    self:UpdateFavoriteIcon();
end

function KeystoneLootLootIconButtonMixin:OnLeave()
    if (not self:IsEnabled()) then
        return;
    end

    GameTooltip.KeystoneLootOwned = nil;
    GameTooltip:Hide();
    ResetCursor();

    self.isHovered = false;
    self.UpdateTooltip = nil;
    self:UpdateFavoriteIcon();
end

function KeystoneLootLootIconButtonMixin:OnClick()
    if (not self:IsEnabled()) then
        return;
    end

    if (IsModifierKeyDown()) then
        -- Cannot link modified links, so we convert the link to an link from the GetItemInfo API which can be linked.
        local _, itemLink = C_Item.GetItemInfo(Upgrade:BuildItemLink(self.itemId));
        HandleModifiedItemClick(itemLink);
        return;
    end

    local slotId = DB:Get("filters.slotId");
    local isFavoritesSlot = slotId == -1;
    local specId = isFavoritesSlot and GetFavoritesSpecId() or DB:Get("filters.specId");

    if (not isFavoritesSlot and not IsItemValidForCharacter()) then
        return;
    end

    local sourceId = Query:GetItemSource(self.itemId);
    if (not sourceId) then
        return;
    end

    local info = Character:ParseKey(Character:GetSelectedKey());
    local classesMatch = info and DB:Get("filters.classId") == info.classId;

    local currentTier;
    if (isFavoritesSlot and not classesMatch) then
        currentTier = Favorites:GetAnyTier(self.itemId);
    else
        currentTier = Favorites:GetTier(self.itemId, specId);
    end

    if (KeystoneLootContextMenu:IsShown()) then
        local isOwnMenu = KeystoneLootContextMenu.data and KeystoneLootContextMenu.data.Button == self;

        KeystoneLootContextMenu:Close();

        if (isOwnMenu) then
            return;
        end
    end

    KeystoneLootContextMenu:Open(self, {
        Button      = self,
        itemId      = self.itemId,
        specId      = specId,
        sourceId    = sourceId,
        currentTier = currentTier,
    });
end

function KeystoneLootLootIconButtonMixin:HandlesGlobalMouse(buttonName, event)
    return KeystoneLootContextMenu:IsShown() and event == "GLOBAL_MOUSE_DOWN" and buttonName == "LeftButton";
end
