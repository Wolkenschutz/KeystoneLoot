local AddonName, KeystoneLoot = ...;

KeystoneLoot.Voidcore = {};

local Voidcore = KeystoneLoot.Voidcore;
local DB = KeystoneLoot.DB;
local Query = KeystoneLoot.Query;
local Character = KeystoneLoot.Character;

local OTHER_SLOT = 14;
local MIRROR_ITEMS = {
    [249806] = 260235, -- Strahlende Feder - Umbralfeder
};

local IS_MIRROR = {};
for _, mirror in pairs(MIRROR_ITEMS) do
    IS_MIRROR[mirror] = true;
end

local function HasLootList(data)
    if (not data or not data.lines) then
        return false;
    end

    for _, line in ipairs(data.lines) do
        if ((line.leftText or ""):match("^%s*%-%s")) then
            return true;
        end
    end

    return false;
end

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

local function GetRemainingNames(data)
    local names = {};

    if (not data or not data.lines) then
        return names;
    end

    for i = #data.lines, 1, -1 do
        local name = (data.lines[i].leftText or ""):match("^%s*%-%s*(.+)$");

        if (name) then
            names[name] = true;
        elseif (next(names)) then
            break;
        end
    end

    return names;
end

function Voidcore:IsEligible(itemId)
    local item = Query:GetItemInfo(itemId);
    if (not item) then
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
end

function Voidcore:GetSourceItems(chestItemId, specId)
    local source = KeystoneLoot.VoidcoreDatabase[chestItemId];
    if (not source) then
        return {};
    end

    local lootTable;

    if (source.challengeModeId) then
        for _, dungeon in ipairs(Query:GetDungeons()) do
            if (dungeon.challengeModeId == source.challengeModeId) then
                lootTable = dungeon.lootTable;
                break;
            end
        end
    elseif (source.bossId) then
        for _, raid in ipairs(Query:GetRaids()) do
            for _, boss in ipairs(raid.bossList) do
                if (boss.bossId == source.bossId) then
                    lootTable = boss.lootTable[DifficultyUtil.ID.PrimaryRaidMythic];
                    break;
                end
            end

            if (lootTable) then
                break;
            end
        end
    end

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

function Voidcore:CheckSupply(chestItemId, OnDone)
    local specId = Character:GetLootSpecId();
    local candidates = self:GetSourceItems(chestItemId, specId);

    if (#candidates == 0) then
        if (OnDone) then
            OnDone();
        end
        return;
    end

    local attempts = 0;

    local function Compare()
        local data = C_TooltipInfo.GetItemByID(chestItemId);
        attempts = attempts + 1;

        if (not HasLootList(data)) then
            if (attempts < 5) then
                C_Timer.After(0.3, Compare);
                return;
            end

            if (OnDone) then
                OnDone();
            end
            return;
        end

        local remaining = GetRemainingNames(data);

        for _, itemId in ipairs(candidates) do
            local item = Item:CreateFromItemID(itemId);
            item:ContinueOnItemLoad(function()
                if (IS_MIRROR[itemId]) then
                    return;
                end

                local name = item:GetItemName();
                local obtained = name and not remaining[name] or false;

                if (obtained) then
                    self:SetUsed(itemId, true);
                end

                local mirror = MIRROR_ITEMS[itemId];
                if (mirror) then
                    self:SetUsed(mirror, obtained or nil);
                end
            end);
        end

        if (OnDone) then
            OnDone();
        end
    end

    Compare();
end

function Voidcore:CheckAll()
    local chestIds = {};
    for chestItemId in pairs(KeystoneLoot.VoidcoreDatabase) do
        table.insert(chestIds, chestItemId);
    end

    local index = 0;

    local function Next()
        index = index + 1;
        local chestItemId = chestIds[index];
        if (not chestItemId) then
            DB:Set("voidcoreChecked", true);
            return;
        end

        self:CheckSupply(chestItemId, Next);
    end

    Next();
end
