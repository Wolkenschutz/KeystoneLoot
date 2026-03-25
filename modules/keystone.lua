local AddonName, KeystoneLoot = ...;

KeystoneLoot.Keystone = {}

local Keystone = KeystoneLoot.Keystone;
local DB = KeystoneLoot.DB;
local Query = KeystoneLoot.Query;
local Character = KeystoneLoot.Character;

function Keystone:GetLootReminderItemList(challengeModeId)
    local favorites = DB:Get("favorites");
    local characterKey = Character:GetKey();

    if (not favorites or not favorites[characterKey] or not favorites[characterKey][challengeModeId]) then
        return {};
    end

    local sourceFavorites = favorites[characterKey][challengeModeId];
    local classId = Character:GetCurrentClassId();
    local numSpecs = GetNumSpecializations();

    -- Collect all specs that have at least one favorited item
    local specHasFavorite = {};
    for i = 1, numSpecs do
        local specId = GetSpecializationInfo(i);
        if (sourceFavorites[specId] and next(sourceFavorites[specId])) then
            specHasFavorite[specId] = true;
        end
    end

    -- Collect all favorited items across all specs (deduplicated)
    local favoriteItems = {};
    for specId in pairs(specHasFavorite) do
        for itemId, itemInfo in pairs(sourceFavorites[specId]) do
            if (not favoriteItems[itemId]) then
                favoriteItems[itemId] = itemInfo.icon;
            end
        end
    end

    -- Build item list per spec based on drop specs
    local itemList = {};
    local allSpecItems = {};
    for itemId, icon in pairs(favoriteItems) do
        local item = Query:GetItemInfo(itemId);
        if (item) then
            local dropSpecs = item.classes[classId];
            if (not dropSpecs) then
                -- skip
            elseif (#dropSpecs == numSpecs) then
                allSpecItems[itemId] = { itemId = itemId, icon = icon };
            else
                for _, dropSpecId in ipairs(dropSpecs) do
                    if (specHasFavorite[dropSpecId]) then
                        itemList[dropSpecId] = itemList[dropSpecId] or {};
                        table.insert(itemList[dropSpecId], { itemId = itemId, icon = icon });
                    end
                end
            end
        end
    end

    -- Resolve loot spec
    local lootSpecId = GetLootSpecialization();
    if (lootSpecId == 0) then
        lootSpecId = GetSpecializationInfo(GetSpecialization());
    end

    -- If no other spec has items the loot spec doesn't also have, return empty
    if (itemList[lootSpecId]) then
        local lootSpecItemIds = {};
        for _, item in ipairs(itemList[lootSpecId]) do
            lootSpecItemIds[item.itemId] = true;
        end

        local hasExclusiveItems = false;
        for specId, items in pairs(itemList) do
            if (specId ~= lootSpecId and not hasExclusiveItems) then
                for _, item in ipairs(items) do
                    if (not lootSpecItemIds[item.itemId]) then
                        hasExclusiveItems = true;
                        break;
                    end
                end
            end
        end

        if (not hasExclusiveItems) then
            return {};
        end
    end

    -- Subset check: remove specs whose item list is fully covered by another spec
    -- Never remove the loot spec, it is the baseline
    local toRemove = {};
    for specIdA, itemsA in pairs(itemList) do
        if (specIdA ~= lootSpecId) then
            for specIdB, itemsB in pairs(itemList) do
                if (specIdA ~= specIdB and not toRemove[specIdA]) then
                    local aIsSubsetOfB = true;
                    for _, itemA in ipairs(itemsA) do
                        local found = false;
                        for _, itemB in ipairs(itemsB) do
                            if (itemA.itemId == itemB.itemId) then
                                found = true;
                                break;
                            end
                        end
                        if (not found) then
                            aIsSubsetOfB = false;
                            break;
                        end
                    end
                    if (aIsSubsetOfB) then
                        local bIsSubsetOfA = true;
                        for _, itemB in ipairs(itemsB) do
                            local found = false;
                            for _, itemA in ipairs(itemsA) do
                                if (itemB.itemId == itemA.itemId) then
                                    found = true;
                                    break;
                                end
                            end
                            if (not found) then
                                bIsSubsetOfA = false;
                                break;
                            end
                        end

                        if (bIsSubsetOfA and specIdA > specIdB and specIdB ~= lootSpecId) then
                            -- Equal sets: keep the lower specId, unless specIdB is the loot spec
                        else
                            toRemove[specIdA] = true;
                        end
                    end
                end
            end
        end
    end

    for specId in pairs(toRemove) do
        itemList[specId] = nil;
    end

    return itemList, allSpecItems;
end

function Keystone:GetRewards(keystoneLevel)
    if (not keystoneLevel or keystoneLevel < 2) then
        return;
    end

    if (keystoneLevel > 10) then
        keystoneLevel = 10;
    end

    local mapping = KeystoneLoot.KeystoneMapping
    if (not mapping or not mapping.rules) then
        return;
    end

    -- Find matching rule
    for _, rule in ipairs(mapping.rules) do
        for _, level in ipairs(rule.keystones) do
            if (level == keystoneLevel) then
                -- Get upgrade tracks
                local endTrack = KeystoneLoot.UpgradeTracks.dungeon[rule.endOfRun.track][rule.endOfRun.rank];
                local vaultTrack = KeystoneLoot.UpgradeTracks.dungeon[rule.greatVault.track][rule.greatVault.rank];

                return {
                    endOfRun = {
                        level = endTrack.ilvl,
                        text = endTrack.label,
                        rank = endTrack.rank
                    },
                    greatVault = {
                        level = vaultTrack.ilvl,
                        text = vaultTrack.label,
                        rank = vaultTrack.rank
                    }
                };
            end
        end
    end
end
