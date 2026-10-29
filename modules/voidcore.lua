local AddonName, KeystoneLoot = ...;

KeystoneLoot.Voidcore = {};

local Voidcore = KeystoneLoot.Voidcore;
local DB = KeystoneLoot.DB;
local Query = KeystoneLoot.Query;
local Character = KeystoneLoot.Character;

local itemChest; -- Cache

local OTHER_SLOT = 14;

local MIRROR_ITEMS = {
    [249806] = 260235 -- Strahlende Feder - Umbralfeder
};

local EXCLUDED_ITEMS = {
    [151299] = true, -- Not in the bonus roll chest - Blizzard bug?
    [260235] = true, -- Umbralfeder
    [258045] = true, -- Dämmerklinges Gleven
    [281227] = true, -- Rush'kah des Seelenwinders
    [275937] = true, -- Antlitz des Hexlords
    [275938] = true, -- Blick des Hexfürsten
};

local function MatchesSpec(item, classId, specId)
    local specs = item.classes[classId];
    if (not specs) then
        return false;
    end

    for _, itemSpecId in ipairs(specs) do
        if (itemSpecId == specId) then
            return true;
        end
    end

    return false;
end

function Voidcore:IsEligible(itemId)
    local item = Query:GetItemInfo(itemId);
    if (not item) then
        return false;
    end

    if (EXCLUDED_ITEMS[itemId]) then
        return false;
    end

    return item.slotId ~= OTHER_SLOT;
end

function Voidcore:IsUsed(itemId)
    local voidcores = DB:Get("voidcore");
    return voidcores ~= nil and voidcores[itemId] == true;
end

function Voidcore:SetUsed(itemId, value)
    local voidcores = DB:Get("voidcore") or {};
    voidcores[itemId] = value or nil;
    DB:Set("voidcore", voidcores);

    local mirror = MIRROR_ITEMS[itemId];
    if (mirror) then
        self:SetUsed(mirror, value or nil);
    end
end

local function GetLootTable(source)
    if (source.challengeModeId) then
        for _, dungeon in ipairs(Query:GetDungeons()) do
            if (dungeon.challengeModeId == source.challengeModeId) then
                return dungeon.lootTable;
            end
        end
    elseif (source.bossId) then
        for _, raid in ipairs(Query:GetRaids()) do
            for _, boss in ipairs(raid.bossList) do
                if (boss.bossId == source.bossId) then
                    return boss.lootTable[DifficultyUtil.ID.PrimaryRaidMythic];
                end
            end
        end
    end
end

local function GetItemChest(itemId)
    if (not itemChest) then
        itemChest = {};

        for chestItemId, source in pairs(KeystoneLoot.VoidcoreDatabase) do
            local lootTable = GetLootTable(source);
            if (lootTable) then
                for _, id in ipairs(lootTable) do
                    itemChest[id] = chestItemId;
                end
            end
        end
    end

    return itemChest[itemId];
end

function Voidcore:GetSourceItems(chestItemId, specId)
    local source = KeystoneLoot.VoidcoreDatabase[chestItemId];
    if (not source) then
        return {};
    end

    local lootTable = GetLootTable(source);
    if (not lootTable) then
        return {};
    end

    local classId = Character:GetCurrentClassId();
    local results = {};

    for _, itemId in ipairs(lootTable) do
        if (self:IsEligible(itemId)) then
            local item = Query:GetItemInfo(itemId);
            if (item and MatchesSpec(item, classId, specId)) then
                table.insert(results, itemId);
            end
        end
    end

    return results;
end

function Voidcore:ResetSource(candidates)
    for _, itemId in ipairs(candidates) do
        self:SetUsed(itemId, nil);
    end
end

function Voidcore:ImportSimc()
    local simcData = SimulationCraftDB.char and SimulationCraftDB.char[UnitName("player") .. " - " .. GetRealmName()];
    if (not simcData or not simcData.bonusRolls) then
        return;
    end

    local seasonId = C_SeasonInfo.GetCurrentDisplaySeasonID();

    for _, roll in ipairs(simcData.bonusRolls) do
        if (roll.season == seasonId) then
            self:OnBonusRoll(roll.itemId);
        end
    end
end

function Voidcore:OnBonusRoll(itemId)
    if (not self:IsEligible(itemId)) then
        return;
    end

    self:SetUsed(itemId, true);

    local chestItemId = GetItemChest(itemId);
    if (not chestItemId) then
        return;
    end

    -- If this completed the source's pool, Blizzard resets it -> clear that source
    local candidates = self:GetSourceItems(chestItemId, Character:GetLootSpecId());

    for _, candidateId in ipairs(candidates) do
        if (not self:IsUsed(candidateId)) then
            return;
        end
    end

    self:ResetSource(candidates);
end
