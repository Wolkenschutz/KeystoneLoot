local AddonName, KeystoneLoot = ...;

KeystoneLoot.Query = {};

local Query = KeystoneLoot.Query;
local DB = KeystoneLoot.DB;
local Character = KeystoneLoot.Character;

local function GetFavoritesListSpecId()
    local info = Character:ParseKey(Character:GetSelectedKey());

    if (info and DB:Get("filters.classId") == info.classId) then
        return DB:Get("filters.specId");
    end

    return 0;
end

function Query:GetDungeons()
    return KeystoneLoot.DungeonDatabase;
end

function Query:GetDungeonItems(challengeModeId)
    local slotId = DB:Get("filters.slotId");

    -- Favorites slot
    if (slotId == -1) then
        return KeystoneLoot.Favorites:GetList(challengeModeId, GetFavoritesListSpecId());
    end

    local specId = DB:Get("filters.specId");
    local classId = DB:Get("filters.classId");
    local results = {};

    for _, dungeon in ipairs(KeystoneLoot.DungeonDatabase) do
        if (dungeon.challengeModeId == challengeModeId) then
            for _, itemId in ipairs(dungeon.lootTable) do
                local item = self:GetItemInfo(itemId);

                if (item and (slotId == -2 or item.slotId == slotId) and item.classes[classId]) then
                    if (specId == 0) then
                        table.insert(results, { itemId = itemId, icon = item.icon });
                    else
                        for _, itemSpecId in ipairs(item.classes[classId]) do
                            if (itemSpecId == specId) then
                                table.insert(results, { itemId = itemId, icon = item.icon });
                                break;
                            end
                        end
                    end
                end
            end

            break;
        end
    end

    return results;
end

function Query:HasDungeonSlotItems(slotId)
    if (slotId == -2) then
        return true;
    end

    local specId = DB:Get("filters.specId");
    local classId = DB:Get("filters.classId");

    for _, dungeon in ipairs(KeystoneLoot.DungeonDatabase) do
        for _, itemId in ipairs(dungeon.lootTable) do
            local item = self:GetItemInfo(itemId);

            if (item and item.slotId == slotId and item.classes[classId]) then
                if (specId == 0) then
                    return true;
                else
                    for _, itemSpecId in ipairs(item.classes[classId]) do
                        if (itemSpecId == specId) then
                            return true;
                        end
                    end
                end
            end
        end
    end

    return false;
end

function Query:GetRaids()
    return KeystoneLoot.RaidDatabase;
end

function Query:GetRaidItems(bossId)
    local slotId = DB:Get("filters.slotId");

    -- Favorites slot
    if (slotId == -1) then
        return KeystoneLoot.Favorites:GetList(bossId, GetFavoritesListSpecId());
    end

    local specId = DB:Get("filters.specId");
    local difficultyId = self:GetRaidDifficultyId();
    local classId = DB:Get("filters.classId");
    local results = {};

    for _, raid in ipairs(KeystoneLoot.RaidDatabase) do
        for _, boss in ipairs(raid.bossList) do
            if (boss.bossId == bossId) then
                local loot = boss.lootTable[difficultyId] or {};

                for _, itemId in ipairs(loot) do
                    local item = self:GetItemInfo(itemId)

                    if (item and (slotId == -2 or item.slotId == slotId) and item.classes[classId]) then
                        if (specId == 0) then
                            table.insert(results, { itemId = itemId, icon = item.icon });
                        else
                            for _, itemSpecId in ipairs(item.classes[classId]) do
                                if (itemSpecId == specId) then
                                    table.insert(results, { itemId = itemId, icon = item.icon });
                                    break;
                                end
                            end
                        end
                    end
                end

                return results;
            end
        end
    end

    return results;
end

function Query:HasRaidSlotItems(slotId)
    if (slotId == -2) then
        return true;
    end

    local difficultyId = self:GetRaidDifficultyId();
    local journalInstanceId = DB:Get("ui.selectedRaidTab");
    local classId = DB:Get("filters.classId");
    local specId = DB:Get("filters.specId");

    for _, raid in ipairs(KeystoneLoot.RaidDatabase) do
        if (raid.journalInstanceId == journalInstanceId) then
            for _, boss in ipairs(raid.bossList) do
                local loot = boss.lootTable[difficultyId] or {};

                for _, itemId in ipairs(loot) do
                    local item = self:GetItemInfo(itemId);

                    if (item and item.slotId == slotId and item.classes[classId]) then
                        if (specId == 0) then
                            return true;
                        else
                            for _, itemSpecId in ipairs(item.classes[classId]) do
                                if (itemSpecId == specId) then
                                    return true;
                                end
                            end
                        end
                    end
                end
            end

            break;
        end
    end

    return false;
end

function Query:GetRaidDifficultyId()
    local selectedDifficulty = DB:Get("filters.raid.difficulty");

    local difficultyMap = {
        lfr = DifficultyUtil.ID.PrimaryRaidLFR,
        normal = DifficultyUtil.ID.PrimaryRaidNormal,
        heroic = DifficultyUtil.ID.PrimaryRaidHeroic,
        mythic = DifficultyUtil.ID.PrimaryRaidMythic
    };

    return difficultyMap[selectedDifficulty] or DifficultyUtil.ID.PrimaryRaidLFR;
end

function Query:GetCatalystItems()
    local classId = DB:Get("filters.classId");
    local slotId = DB:Get("filters.slotId");

    -- Favorites slot
    if (slotId == -1) then
        return KeystoneLoot.Favorites:GetList("catalyst", GetFavoritesListSpecId());
    end

    local results = {};

    for itemId, item in pairs(KeystoneLoot.CatalystDatabase) do
        if (item.classId == classId and (slotId == -2 or item.slotId == slotId)) then
            table.insert(results, {
                itemId = itemId,
                icon = item.icon
            });
        end
    end

    return results;
end

function Query:GetItemInfo(itemId)
    return KeystoneLoot.ItemDatabase[itemId];
end

function Query:GetItemSource(itemId)
    -- Check catalyst
    if (KeystoneLoot.CatalystDatabase[itemId]) then
        return "catalyst";
    end

    -- Check item info
    if (not self:GetItemInfo(itemId)) then
        return;
    end

    -- Check dungeons
    for _, dungeon in ipairs(KeystoneLoot.DungeonDatabase) do
        for _, lootItemId in ipairs(dungeon.lootTable) do
            if (lootItemId == itemId) then
                return dungeon.challengeModeId;
            end
        end
    end

    -- Check raids
    for _, raid in ipairs(KeystoneLoot.RaidDatabase) do
        for _, boss in ipairs(raid.bossList) do
            for _, lootTable in pairs(boss.lootTable) do
                for _, lootItemId in ipairs(lootTable) do
                    if (lootItemId == itemId) then
                        return boss.bossId;
                    end
                end
            end
        end
    end
end
