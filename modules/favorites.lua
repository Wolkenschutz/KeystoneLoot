local AddonName, KeystoneLoot = ...;

KeystoneLoot.Favorites        = {};

local Favorites               = KeystoneLoot.Favorites;
local Character               = KeystoneLoot.Character;
local DB                      = KeystoneLoot.DB;
local Query                   = KeystoneLoot.Query;
local L                       = KeystoneLoot.L;

local EXPORT_PREFIX           = "KeystoneLoot:v2";

Favorites.TIER_NICE           = 1;
Favorites.TIER_MUST           = 2;
Favorites.TIER_BIS            = 3;
Favorites.TIER_TRANSMOG       = 4;

Favorites.TIER_TEXTURE        = {
    [1] = "Interface\\AddOns\\KeystoneLoot\\assets\\tier_nice",
    [2] = "Interface\\AddOns\\KeystoneLoot\\assets\\tier_must",
    [3] = "Interface\\AddOns\\KeystoneLoot\\assets\\tier_bis",
    [4] = "Interface\\AddOns\\KeystoneLoot\\assets\\tier_transmog",
};

Favorites.TIER_NAME           = {
    [1] = L["Nice to have"],
    [2] = L["Must have"],
    [3] = L["Best in Slot"],
    [4] = L["Transmog"],
};

local function SplitOutsideParens(str, delimiter)
    local result = {};
    local depth  = 0;
    local start  = 1;

    for i = 1, #str do
        local c = string.sub(str, i, i);
        if (c == "(") then
            depth = depth + 1;
        elseif (c == ")") then
            depth = depth - 1;
        elseif (c == delimiter and depth == 0) then
            table.insert(result, string.sub(str, start, i - 1));
            start = i + 1;
        end
    end

    if (start <= #str) then
        table.insert(result, string.sub(str, start));
    end

    return result;
end

-- v1: KeystoneLoot:v1,specId:item1:item2[,specId:item3]
-- Returns: importedItems[specId] = { { itemId, tier, bonusIds }, ... }
local function ParseV1(dataStr)
    local importedItems = {};

    for specSection in string.gmatch(dataStr, "([^,]+)") do
        local specId, itemsStr = string.match(specSection, "^(%d+):(.+)$");

        if (specId and itemsStr) then
            specId = tonumber(specId);
            if (not importedItems[specId]) then
                importedItems[specId] = {};
            end

            for itemId in string.gmatch(itemsStr, "([^:]+)") do
                itemId = tonumber(itemId);
                if (itemId) then
                    table.insert(importedItems[specId], {
                        itemId = itemId,
                        tier   = Favorites.TIER_MUST
                    });
                end
            end
        end
    end

    return importedItems;
end

-- v2: KeystoneLoot:v2,specId:item1(tier,b1,b2):item2(tier)[,specId:item3(tier)]
-- Returns: importedItems[specId] = { { itemId, tier, bonusIds }, ... }
local function ParseV2(dataStr)
    local importedItems = {};

    for _, specSection in ipairs(SplitOutsideParens(dataStr, ",")) do
        local specId, itemsStr = string.match(specSection, "^(%d+):(.+)$");

        if (specId and itemsStr) then
            specId = tonumber(specId);
            if (not importedItems[specId]) then
                importedItems[specId] = {};
            end

            for itemToken in string.gmatch(itemsStr, "([^:]+)") do
                local itemId, metaStr = string.match(itemToken, "^(%d+)%(([^)]+)%)$");
                if (not itemId) then
                    itemId = string.match(itemToken, "^(%d+)$");
                end
                itemId = tonumber(itemId);

                if (itemId) then
                    local tier     = Favorites.TIER_MUST;
                    local bonusIds = nil;

                    if (metaStr) then
                        local values = {};
                        for v in string.gmatch(metaStr, "([^,]+)") do
                            table.insert(values, tonumber(v));
                        end

                        tier = values[1] or Favorites.TIER_MUST;
                        if (#values > 1) then
                            bonusIds = { unpack(values, 2) };
                        end
                    end

                    table.insert(importedItems[specId], {
                        itemId   = itemId,
                        tier     = tier,
                        bonusIds = bonusIds,
                    });
                end
            end
        end
    end

    return importedItems;
end

-- Ordered by preference: newest version first
local VERSIONS = {
    { prefix = "KeystoneLoot:v2", Parse = ParseV2 },
    { prefix = "KeystoneLoot:v1", Parse = ParseV1 },
};

local function DetectVersion(importStr)
    local dataStr = string.gsub(importStr, "%s+", "");

    for _, v in ipairs(VERSIONS) do
        if (string.sub(dataStr, 1, #v.prefix) == v.prefix) then
            return v.Parse, string.sub(dataStr, #v.prefix + 2);
        end
    end

    return nil, nil;
end

function Favorites:Init()
    local characterKey = Character:GetKey();
    local favorites = DB:Get("favorites") or {};

    if (not favorites[characterKey]) then
        favorites[characterKey] = {};
        DB:Set("favorites", favorites);
    end

    -- Reset selected character to current on each login
    DB:Set("ui.selectedCharacterKey", characterKey);
end

function Favorites:Add(sourceId, specId, itemId, tier, bonusIds)
    if (not sourceId or specId == nil or not itemId) then
        return false;
    end

    local characterKey = Character:GetSelectedKey();

    -- Resolve specId = 0 to all valid specs for this item/class
    if (specId == 0) then
        local info = Character:ParseKey(characterKey);
        local classId = info and info.classId;

        if (not classId) then
            return false;
        end

        if (KeystoneLoot.CatalystDatabase[itemId]) then
            -- Catalyst: add for all specs of the class
            for index = 1, C_SpecializationInfo.GetNumSpecializationsForClassID(classId) do
                local resolvedSpecId = GetSpecializationInfoForClassID(classId, index);
                self:Add(sourceId, resolvedSpecId, itemId, tier, bonusIds);
            end

            return true;
        end

        local item = KeystoneLoot.ItemDatabase[itemId];
        if (item and item.classes[classId]) then
            -- Regular item: add only for specs that can use it
            for _, resolvedSpecId in ipairs(item.classes[classId]) do
                self:Add(sourceId, resolvedSpecId, itemId, tier, bonusIds);
            end

            return true;
        end

        return false;
    end

    local favorites = DB:Get("favorites") or {};

    -- Initialize structure if needed
    if (not favorites[characterKey]) then
        favorites[characterKey] = {};
    end

    if (not favorites[characterKey][sourceId]) then
        favorites[characterKey][sourceId] = {};
    end

    if (not favorites[characterKey][sourceId][specId]) then
        favorites[characterKey][sourceId][specId] = {};
    end

    -- Add item
    favorites[characterKey][sourceId][specId][itemId] = {
        tier     = tier or self.TIER_MUST,
        bonusIds = bonusIds,
    };

    -- Save to DB
    DB:Set("favorites", favorites);

    return true;
end

function Favorites:Remove(itemId, specId)
    if (not itemId) then
        return false;
    end

    local characterKey = Character:GetSelectedKey();
    local favorites = DB:Get("favorites");

    if (not favorites or not favorites[characterKey]) then
        return false;
    end

    local removed = false;

    if (specId == 0) then
        -- Remove for all specs
        for _, sourceData in pairs(favorites[characterKey]) do
            for _, specData in pairs(sourceData) do
                if (specData[itemId]) then
                    specData[itemId] = nil;
                    removed = true;
                end
            end
        end
    else
        -- Remove for specific spec
        for _, sourceData in pairs(favorites[characterKey]) do
            if (sourceData[specId] and sourceData[specId][itemId]) then
                sourceData[specId][itemId] = nil;
                removed = true;
                break;
            end
        end
    end

    if (removed) then
        -- Save to DB
        DB:Set("favorites", favorites);
    end

    return removed;
end

function Favorites:GetTier(itemId, specId)
    if (not itemId) then
        return 0;
    end

    local characterKey = Character:GetSelectedKey();
    local favorites = DB:Get("favorites");

    if (not favorites or not favorites[characterKey]) then
        return 0;
    end

    specId = specId or DB:Get("filters.specId");

    if (specId == 0) then
        local info = Character:ParseKey(characterKey);
        if (not info or DB:Get("filters.classId") ~= info.classId) then
            return 0;
        end

        local maxTier = 0;
        for _, sourceData in pairs(favorites[characterKey]) do
            for _, specData in pairs(sourceData) do
                if (specData[itemId]) then
                    local tier = specData[itemId].tier or self.TIER_MUST;
                    if (tier > maxTier) then
                        maxTier = tier;
                    end
                end
            end
        end
        return maxTier;
    end

    for _, sourceData in pairs(favorites[characterKey]) do
        if (sourceData[specId] and sourceData[specId][itemId]) then
            return sourceData[specId][itemId].tier or self.TIER_MUST;
        end
    end

    return 0;
end

function Favorites:GetAnyTier(itemId, useCurrentChar)
    if (not itemId) then
        return 0;
    end

    local characterKey = useCurrentChar and Character:GetKey() or Character:GetSelectedKey();
    local favorites = DB:Get("favorites");

    if (not favorites or not favorites[characterKey]) then
        return 0;
    end

    local maxTier = 0;
    for _, sourceData in pairs(favorites[characterKey]) do
        for _, specData in pairs(sourceData) do
            if (specData[itemId]) then
                local tier = specData[itemId].tier or self.TIER_MUST;
                if (tier > maxTier) then
                    maxTier = tier;
                end
            end
        end
    end
    return maxTier;
end

function Favorites:GetBonusIds(itemId)
    if (not itemId) then
        return nil;
    end

    local characterKey = Character:GetSelectedKey();
    local favorites    = DB:Get("favorites");

    if (not favorites or not favorites[characterKey]) then
        return nil;
    end

    for _, sourceData in pairs(favorites[characterKey]) do
        for _, specData in pairs(sourceData) do
            if (specData[itemId] and specData[itemId].bonusIds) then
                return specData[itemId].bonusIds;
            end
        end
    end

    return nil;
end

function Favorites:SetTier(itemId, specId, tier)
    if (not itemId) then
        return false;
    end

    local characterKey = Character:GetSelectedKey();
    local favorites = DB:Get("favorites");

    if (not favorites or not favorites[characterKey]) then
        return false;
    end

    local updated = false;

    for _, sourceData in pairs(favorites[characterKey]) do
        if (specId == 0) then
            for _, specData in pairs(sourceData) do
                if (specData[itemId]) then
                    specData[itemId].tier = tier;
                    updated = true;
                end
            end
        elseif (sourceData[specId] and sourceData[specId][itemId]) then
            sourceData[specId][itemId].tier = tier;
            updated = true;
        end
    end

    if (updated) then
        DB:Set("favorites", favorites);
    end

    return updated;
end

function Favorites:IsFavorite(itemId, specId)
    return self:GetTier(itemId, specId) > 0;
end

function Favorites:IsAnyFavorite(itemId, useCurrentChar)
    if (not itemId) then
        return false;
    end

    local characterKey = useCurrentChar and Character:GetKey() or Character:GetSelectedKey();
    local favorites = DB:Get("favorites");

    if (not favorites or not favorites[characterKey]) then
        return false;
    end

    for _, sourceData in pairs(favorites[characterKey]) do
        for _, specData in pairs(sourceData) do
            if (specData[itemId]) then
                return true;
            end
        end
    end

    return false;
end

function Favorites:GetItemSpecs(itemId, useCurrentChar)
    local characterKey = useCurrentChar and Character:GetKey() or Character:GetSelectedKey();
    local favorites = DB:Get("favorites");

    if (not favorites or not favorites[characterKey]) then
        return {};
    end

    local specs = {};

    for _, sourceData in pairs(favorites[characterKey]) do
        for specId, specData in pairs(sourceData) do
            if (specData[itemId]) then
                table.insert(specs, specId);
            end
        end
    end

    return specs;
end

function Favorites:GetList(sourceId, specId)
    local characterKey = Character:GetSelectedKey();
    local favorites = DB:Get("favorites");

    if (not favorites or not favorites[characterKey] or not favorites[characterKey][sourceId]) then
        return {};
    end

    local sourceFavorites = favorites[characterKey][sourceId];
    local selectedSpecId = specId or DB:Get("filters.specId");
    local itemList = {};

    if (selectedSpecId == 0) then
        local tmp = {};

        for currentSpecId, specData in pairs(sourceFavorites) do
            for itemId, itemInfo in pairs(specData) do
                if (sourceId == "catalyst" or sourceId == "custom" or Query:GetItemInfo(itemId)) then
                    tmp[itemId] = {
                        itemId = itemId,
                        specId = currentSpecId,
                        bonusIds = itemInfo.bonusIds
                    };
                end
            end
        end

        for _, itemInfo in pairs(tmp) do
            table.insert(itemList, itemInfo);
        end
    elseif (sourceFavorites[selectedSpecId]) then
        for itemId, itemInfo in pairs(sourceFavorites[selectedSpecId]) do
            if (sourceId == "catalyst" or sourceId == "custom" or Query:GetItemInfo(itemId)) then
                table.insert(itemList, {
                    itemId = itemId,
                    bonusIds = itemInfo.bonusIds
                });
            end
        end
    end

    return itemList;
end

function Favorites:Export()
    local characterKey = Character:GetSelectedKey();
    local favorites = DB:Get("favorites");

    if (not favorites or not favorites[characterKey]) then
        return L["No favorites found"];
    end

    local exportTable = {};

    for _, sourceData in pairs(favorites[characterKey]) do
        for specId, specData in pairs(sourceData) do
            if (not exportTable[specId]) then
                exportTable[specId] = {};
            end

            for itemId, itemInfo in pairs(specData) do
                table.insert(exportTable[specId], {
                    itemId   = itemId,
                    tier     = itemInfo.tier or self.TIER_MUST,
                    bonusIds = itemInfo.bonusIds,
                });
            end
        end
    end

    local exportStr  = EXPORT_PREFIX;
    local hasEntries = false;

    for specId, itemList in pairs(exportTable) do
        if (#itemList > 0) then
            hasEntries = true;
            local itemTokens = {};

            for _, itemData in ipairs(itemList) do
                local meta = tostring(itemData.tier);
                if (itemData.bonusIds and #itemData.bonusIds > 0) then
                    meta = meta .. "," .. table.concat(itemData.bonusIds, ",");
                end
                table.insert(itemTokens, string.format("%d(%s)", itemData.itemId, meta));
            end

            exportStr = exportStr .. "," .. specId .. ":" .. table.concat(itemTokens, ":");
        end
    end

    if (not hasEntries) then
        return L["No favorites found"];
    end

    return exportStr;
end

function Favorites:Import(importStr, overwrite)
    if (not importStr) then
        return false, L["Invalid import string."], false;
    end

    local Parse, dataStr = DetectVersion(importStr);
    if (not Parse) then
        return false, L["Invalid import string."], false;
    end

    local characterKey = Character:GetSelectedKey();
    local info = Character:ParseKey(characterKey);
    if (not info) then
        return false, L["No character selected."], false;
    end

    local importedItems = Parse(dataStr);

    if (not next(importedItems)) then
        return false, L["Invalid import string."], false;
    end

    local classId = info.classId;

    -- Build valid spec lookup for this character's class
    local validSpecs = {};
    for index = 1, C_SpecializationInfo.GetNumSpecializationsForClassID(classId) do
        local specId = GetSpecializationInfoForClassID(classId, index);
        validSpecs[specId] = true;
    end

    local favorites = DB:Get("favorites") or {};

    -- Overwrite if requested
    if (overwrite) then
        favorites[characterKey] = {};
    end

    -- Track skipped specs due to class mismatch
    local skippedSpecs  = false;
    local totalImported = 0;

    -- Import items
    for specId, itemList in pairs(importedItems) do
        if (validSpecs[specId]) then
            for _, itemData in ipairs(itemList) do
                local sourceId     = Query:GetItemSource(itemData.itemId);
                local item         = KeystoneLoot.ItemDatabase[itemData.itemId];
                local catalystItem = KeystoneLoot.CatalystDatabase[itemData.itemId];

                if (sourceId) then
                    local isValid = false;

                    if (catalystItem) then
                        isValid = catalystItem.classId == classId;
                    elseif (item and item.classes[classId]) then
                        for _, itemSpecId in ipairs(item.classes[classId]) do
                            if (itemSpecId == specId) then
                                isValid = true;
                                break;
                            end
                        end
                    elseif (sourceId == "custom") then
                        isValid = Query:GetItemIcon(itemData.itemId) ~= nil;
                    end

                    if (isValid) then
                        self:Add(sourceId, specId, itemData.itemId, itemData.tier, itemData.bonusIds);
                        totalImported = totalImported + 1;
                    end
                end
            end
        else
            skippedSpecs = true;
        end
    end

    if (totalImported > 0) then
        return true, totalImported, skippedSpecs;
    end

    return false, L["No valid items found."], skippedSpecs;
end
