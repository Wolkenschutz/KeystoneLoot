local AddonName, KeystoneLoot = ...;

local DB = KeystoneLoot.DB;
local Upgrade = KeystoneLoot.Upgrade;
local Favorites = KeystoneLoot.Favorites;
local Character = KeystoneLoot.Character;
local Query = KeystoneLoot.Query;
local Voidcore = KeystoneLoot.Voidcore;
local Owned = KeystoneLoot.Owned;
local CopyPopup = KeystoneLoot.CopyPopup;
local L = KeystoneLoot.L;

local OWNED_ICON_ALPHA = 0.3;
local OWNED_TEXT_ALPHA = 0.7;

local STAT_HIGHLIGHT_KEYS = {
    [0] = "crit",
    [1] = "haste",
    [2] = "mastery",
    [3] = "versatility"
};

local SLOT_NAMES = {
    ["INVTYPE_HEAD"] = L["Head"],
    ["INVTYPE_NECK"] = L["Neck"],
    ["INVTYPE_SHOULDER"] = L["Shoulder"],
    ["INVTYPE_CLOAK"] = L["Back"],
    ["INVTYPE_CHEST"] = L["Chest"],
    ["INVTYPE_ROBE"] = L["Chest"],
    ["INVTYPE_WRIST"] = L["Wrist"],
    ["INVTYPE_HAND"] = L["Hands"],
    ["INVTYPE_WAIST"] = L["Waist"],
    ["INVTYPE_LEGS"] = L["Legs"],
    ["INVTYPE_FEET"] = L["Feet"],
    ["INVTYPE_WEAPON"] = L["1H"],
    ["INVTYPE_2HWEAPON"] = L["2H"],
    ["INVTYPE_WEAPONMAINHAND"] = L["Main"],
    ["INVTYPE_RANGED"] = L["Ranged"],
    ["INVTYPE_RANGEDRIGHT"] = L["Ranged"],
    ["INVTYPE_WEAPONOFFHAND"] = L["Off"],
    ["INVTYPE_HOLDABLE"] = L["Off"],
    ["INVTYPE_SHIELD"] = L["Shield"],
    ["INVTYPE_FINGER"] = L["Ring"],
    ["INVTYPE_TRINKET"] = L["Trinket"]
};

local SECONDARY_STAT_NAMES = {
    [ITEM_MOD_CRIT_RATING_SHORT] = true,
    [ITEM_MOD_HASTE_RATING_SHORT] = true,
    [ITEM_MOD_MASTERY_RATING_SHORT] = true,
    [ITEM_MOD_VERSATILITY] = true
};

local function GetCopyItemIds(itemLink)
    local enchantId, gem1, gem2, gem3, gem4 = string.match(itemLink, "^item:%d+:(%d*):(%d*):(%d*):(%d*):(%d*)");
    local itemIds = {};

    local enchantItemId = KeystoneLoot.EnchantDatabase[tonumber(enchantId)];
    if (enchantItemId) then
        table.insert(itemIds, enchantItemId);
    end

    for _, gemId in ipairs({ gem1, gem2, gem3, gem4 }) do
        if (gemId and gemId ~= "") then
            table.insert(itemIds, gemId);
        end
    end

    return itemIds;
end

local function PreloadCopyItems(itemLink)
    for _, copyItemId in ipairs(GetCopyItemIds(itemLink)) do
        if (not C_Item.IsItemDataCachedByID(copyItemId)) then
            C_Item.RequestLoadItemDataByID(copyItemId);
        end
    end
end

local function AddCopyEntries(rootDescription, itemId)
    local names = {};

    for _, copyItemId in ipairs(GetCopyItemIds(Upgrade:BuildItemLink(itemId))) do
        local name = C_Item.GetItemInfo(copyItemId);
        if (name) then
            table.insert(names, name);
        end
    end

    if (#names == 0) then
        return;
    end

    rootDescription:CreateDivider();
    rootDescription:CreateTitle(COPY_NAME);

    for _, name in ipairs(names) do
        rootDescription:CreateButton(name, function()
            CopyPopup:Show(name);
        end);
    end
end

local function GenerateContextMenu(Button, rootDescription, specId, sourceId, currentTier)
    local itemId = Button.itemId;

    local function IsTierSelected(tier)
        return currentTier == tier;
    end

    local function SetTierSelected(tier)
        if (currentTier > 0) then
            Favorites:SetTier(itemId, specId, tier);
        else
            Favorites:Add(sourceId, specId, itemId, tier);
        end

        currentTier = tier;
        Button:UpdateFavoriteIcon();
    end

    rootDescription:CreateTitle(L["Set Favorite"]);

    for _, tier in ipairs(Favorites:GetTiers(itemId)) do
        rootDescription:CreateRadio(Favorites:GetTierName(tier), IsTierSelected, SetTierSelected, tier);
    end

    if (currentTier > 0) then
        rootDescription:CreateButton(REMOVE, function()
            Favorites:Remove(itemId, specId);

            currentTier = 0;
            Button:UpdateFavoriteIcon();
        end);
    end

    if (Voidcore:IsEligible(itemId)) then
        local function IsVoidcoreUsed()
            return Voidcore:IsUsed(itemId);
        end

        local function SetVoidcoreUsed()
            Voidcore:SetUsed(itemId, not Voidcore:IsUsed(itemId));
            Button:UpdateVoidcoreIcon();
        end

        rootDescription:CreateDivider();
        rootDescription:CreateTitle(BONUS_LOOT_LABEL);
        rootDescription:CreateCheckbox(L["Voidcore used"], IsVoidcoreUsed, SetVoidcoreUsed);
    end

    AddCopyEntries(rootDescription, itemId);
end

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

local function IsOwnCharacterSelected()
    return Character:GetSelectedKey() == Character:GetKey();
end

local function AddOwnedLineToTooltip(itemId)
    if (not DB:Get("settings.ownedTooltip") or not IsOwnCharacterSelected() or Owned:IsBagSyncLoaded()) then
        return;
    end

    local locations = Owned:GetLocations(itemId);
    if (#locations == 0) then
        return;
    end

    GameTooltip:AddLine(" ");

    for _, location in ipairs(locations) do
        GameTooltip:AddLine(string.format("|A:common-icon-checkmark:14:14:0:0|a %s", location),
            GREEN_FONT_COLOR:GetRGB());
    end
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

local function GetSecondaryStatName(text)
    local statName = string.match(text or "", "^%+[%d%.,]+ (.+)$");

    return statName and SECONDARY_STAT_NAMES[statName] and statName or nil;
end

local function GetBaseItem(itemId)
    local catalystItem = KeystoneLoot.CatalystDatabase[itemId];
    local baseItemId = catalystItem and Favorites:GetCatalystItemForSlot(catalystItem.slotId);
    if (not baseItemId) then
        return nil;
    end

    if (not C_Item.IsItemDataCachedByID(baseItemId)) then
        C_Item.RequestLoadItemDataByID(baseItemId);
        return nil;
    end

    local data = C_TooltipInfo.GetHyperlink(Upgrade:BuildItemLink(baseItemId));
    if (not data) then
        return nil;
    end

    local statLines = {};
    for _, lineData in ipairs(data.lines) do
        if (GetSecondaryStatName(lineData.leftText)) then
            table.insert(statLines, lineData.leftText);
        end
    end

    if (#statLines == 0) then
        return nil;
    end

    return C_Item.GetItemInfo(baseItemId), statLines;
end

local function CountSecondaryStatLines(itemLink)
    local data = C_TooltipInfo.GetHyperlink(itemLink);
    if (not data) then
        return 0;
    end

    local count = 0;
    for _, lineData in ipairs(data.lines) do
        if (GetSecondaryStatName(lineData.leftText)) then
            count = count + 1;
        end
    end

    return count;
end

local function SetCatalystTooltip(itemId, itemLink)
    local baseName, statLines = GetBaseItem(itemId);
    local lastStatLine = CountSecondaryStatLines(itemLink);
    local Info = CreateBaseTooltipInfo("GetHyperlink", itemLink);
    local index = 0;

    Info.linePreCall = function(Tooltip, lineData)
        if (not GetSecondaryStatName(lineData.leftText)) then
            return;
        end

        index = index + 1;
        if (index == 1) then
            Tooltip:AddLine(" ");
            Tooltip:AddLine(string.format("|cff9d5db8%s:|r", L["Tier token"]));
        end
    end;

    Info.linePostCall = function(Tooltip, lineData)
        if (index ~= lastStatLine or not GetSecondaryStatName(lineData.leftText)) then
            return;
        end

        local color = lineData.leftColor or NORMAL_FONT_COLOR;

        Tooltip:AddLine(" ");
        Tooltip:AddLine(string.format("|cff9d5db8%s:%s|r", L["Catalyst"], baseName and (" " .. baseName) or ""));

        if (not statLines) then
            Tooltip:AddLine(L["+Secondary stats of the base item"], color:GetRGB());
            return;
        end

        for _, statLine in ipairs(statLines) do
            Tooltip:AddLine(statLine, color:GetRGB());
        end
    end;

    GameTooltip:ProcessInfo(Info);
end

KeystoneLootLootIconButtonMixin = {};

function KeystoneLootLootIconButtonMixin:OnLoad()
    local file, height = self.Content.SlotText:GetFont();
    self.Content.SlotText:SetFont(file, height, "OUTLINE");
end

function KeystoneLootLootIconButtonMixin:Init(item)
    self:SetEnabled(item.itemId ~= 0);

    self.itemId = item.itemId;
    self.isHovered = false;

    self.Content.Icon:SetTexture(Query:GetItemIcon(item.itemId));
    self:UpdateFavoriteIcon();
    self:UpdateOwnedIcon();
    self:UpdateVoidcoreIcon();
    self:UpdateSlotText();
    self:UpdateHighlight();
end

function KeystoneLootLootIconButtonMixin:UpdateSlotText()
    if (not self:IsEnabled() or not DB:Get("settings.slotName")) then
        self.Content.SlotText:Hide();
        return;
    end

    local _, _, _, equipLoc = C_Item.GetItemInfoInstant(self.itemId);
    local slotName = SLOT_NAMES[equipLoc];

    if (not slotName or C_Item.IsCosmeticItem(self.itemId)) then
        self.Content.SlotText:Hide();
        return;
    end

    self.Content.SlotText:SetText(slotName);
    self.Content.SlotText:Show();
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
        self.Content.FavoriteIcon:SetTexture(Favorites:GetTierIcon(tier));
        self.Content.FavoriteIcon:SetDesaturated(false);
        self.Content.FavoriteIcon:Show();
    elseif (self.isHovered and (isFavoritesSlot or classesMatch)) then
        self.Content.FavoriteIcon:SetTexture(Favorites:GetTierIcon(Favorites.TIER_MUST));
        self.Content.FavoriteIcon:SetDesaturated(true);
        self.Content.FavoriteIcon:Show();
    else
        self.Content.FavoriteIcon:Hide();
    end
end

function KeystoneLootLootIconButtonMixin:UpdateOwnedIcon()
    local isOwned = self:IsEnabled() and IsOwnCharacterSelected() and Owned:Has(self.itemId);

    self.Content.OwnedIcon:SetShown(isOwned);

    self.Content.Icon:SetAlpha(isOwned and OWNED_ICON_ALPHA or 1);
    self.Content.SlotText:SetAlpha(isOwned and OWNED_TEXT_ALPHA or 1);
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

    local itemLink = Upgrade:BuildItemLink(self.itemId);

    PreloadCopyItems(itemLink);

    GameTooltip.KeystoneLootOwned = true;

    if (KeystoneLoot.CatalystDatabase[self.itemId]) then
        SetCatalystTooltip(self.itemId, itemLink);
    else
        GameTooltip:SetHyperlink(itemLink);
    end

    AddSpecLinesToTooltip(self.itemId);
    AddOwnedLineToTooltip(self.itemId);
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

    GameTooltip:Hide();
    KSLMenuUtil.CreateContextMenu(self, GenerateContextMenu, specId, sourceId, currentTier);
end
