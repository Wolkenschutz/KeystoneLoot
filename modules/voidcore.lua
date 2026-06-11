local AddonName, KeystoneLoot = ...;

KeystoneLoot.Voidcore = {};

local Voidcore = KeystoneLoot.Voidcore;
local DB = KeystoneLoot.DB;
local Query = KeystoneLoot.Query;
local Character = KeystoneLoot.Character;
local L = KeystoneLoot.L;

local itemChest; -- Cache

local OTHER_SLOT = 14;

local POLL_INTERVAL = 0.3;
local EMPTY_ATTEMPTS = 5;
local STABLE_NEEDED = 3;
local MAX_ATTEMPTS = 10;

local MIRROR_ITEMS = {
    [249806] = 260235 -- Strahlende Feder - Umbralfeder
};

local EXCLUDED_ITEMS = {
    [151299] = true, -- Not in the bonus roll chest - Blizzard bug?
    [260235] = true -- Umbralfeder
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
        if (not EXCLUDED_ITEMS[itemId] and self:IsEligible(itemId)) then
            local item = Query:GetItemInfo(itemId);
            if (item and MatchesSpec(item, classId, specId)) then
                table.insert(results, itemId);
            end
        end
    end

    return results;
end

function Voidcore:ApplyResults(candidates, remaining)
    for _, itemId in ipairs(candidates) do
        local item = Item:CreateFromItemID(itemId);
        item:ContinueOnItemLoad(function()
            local name = item:GetItemName();
            local obtained = name ~= nil and not remaining[name];

            if (obtained) then
                self:SetUsed(itemId, true);
            end
        end);
    end
end

function Voidcore:ResetSource(candidates)
    for _, itemId in ipairs(candidates) do
        self:SetUsed(itemId, nil);
    end
end

function Voidcore:CheckSupply(chestItemId, OnDone)
    local specId = Character:GetLootSpecId();
    local candidates = self:GetSourceItems(chestItemId, specId);

    if (#candidates == 0) then
        if (OnDone) then
            OnDone(0);
        end
        return;
    end

    local attempts = 0;
    local prevCount = -1;
    local stableHits = 0;

    local function Poll()
        attempts = attempts + 1;

        local data = C_TooltipInfo.GetItemByID(chestItemId);
        local remaining = GetRemainingNames(data);

        local count = 0;
        for _ in pairs(remaining) do
            count = count + 1;
        end

        if (count == 0) then
            if (attempts >= EMPTY_ATTEMPTS) then
                -- No loot list found -> do nothing
                if (OnDone) then
                    OnDone(0);
                end
            else
                C_Timer.After(POLL_INTERVAL, Poll);
            end

            return;
        end

        if (count == prevCount) then
            stableHits = stableHits + 1;

            if (stableHits >= STABLE_NEEDED) then
                if (count >= #candidates) then
                    -- Full pool visible -> fresh character or reset, clear all source items
                    self:ResetSource(candidates);

                    if (OnDone) then
                        OnDone(0);
                    end
                else
                    self:ApplyResults(candidates, remaining);

                    if (OnDone) then
                        OnDone(#candidates - count);
                    end
                end
                return;
            end
        else
            prevCount = count;
            stableHits = 1;
        end

        if (attempts >= MAX_ATTEMPTS) then
            if (OnDone) then
                OnDone(0);
            end
            return;
        end

        C_Timer.After(POLL_INTERVAL, Poll);
    end

    Poll();
end

function Voidcore:CheckAll(rescan)
    local chestIds = {};
    for chestItemId in pairs(KeystoneLoot.VoidcoreDatabase) do
        table.insert(chestIds, chestItemId);
    end

    local prefix = "|cff9d5db8KeystoneLoot|r: ";

    if (rescan) then
        print(prefix .. L["Rescanning for bonus rolls..."]);
    else
        print(prefix .. L["Checking for past bonus rolls (one time)..."]);
    end

    local total = 0;
    local index = 0;

    local function Next(obtained)
        total = total + (obtained or 0);

        index = index + 1;
        local chestItemId = chestIds[index];
        if (not chestItemId) then
            if (total > 0) then
                print(prefix .. string.format(L["%d past |4bonus roll:bonus rolls; detected."], total));
            else
                print(prefix .. L["No untracked bonus rolls found."]);
            end

            DB:Set("voidcoreChecked", true);
            return;
        end

        self:CheckSupply(chestItemId, Next);
    end

    Next();
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
