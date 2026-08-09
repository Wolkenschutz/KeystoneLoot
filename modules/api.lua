local AddonName, KeystoneLoot = ...;

-- Public API, exposed as the global "KeystoneLootAPI" - see README.md
KeystoneLoot.API              = {};
KeystoneLoot.APIInternal      = {};

local API                     = KeystoneLoot.API;
local Internal                = KeystoneLoot.APIInternal;

local Character               = KeystoneLoot.Character;
local DB                      = KeystoneLoot.DB;
local Favorites               = KeystoneLoot.Favorites;
local Query                   = KeystoneLoot.Query;

local API_VERSION             = 1;

local isReady                 = false;
local isRefreshPending        = false;
local callbacks               = {};

API.Tier                      = {
    NICE     = Favorites.TIER_NICE,
    MUST     = Favorites.TIER_MUST,
    BIS      = Favorites.TIER_BIS,
    TRANSMOG = Favorites.TIER_TRANSMOG,
};

API.Event                     = {
    READY                 = "READY",
    FAVORITE_ADDED        = "FAVORITE_ADDED",
    FAVORITE_REMOVED      = "FAVORITE_REMOVED",
    FAVORITE_TIER_CHANGED = "FAVORITE_TIER_CHANGED",
    FAVORITES_IMPORTED    = "FAVORITES_IMPORTED",
    FAVORITES_CHANGED     = "FAVORITES_CHANGED",
};

local MUTATION_EVENTS         = {
    [API.Event.FAVORITE_ADDED]        = true,
    [API.Event.FAVORITE_REMOVED]      = true,
    [API.Event.FAVORITE_TIER_CHANGED] = true,
    [API.Event.FAVORITES_IMPORTED]    = true,
};

local function Dispatch(event, ...)
    local handlers = callbacks[event];
    if (not handlers) then
        return;
    end

    local snapshot = {};
    for _, callback in pairs(handlers) do
        table.insert(snapshot, callback);
    end

    for _, callback in ipairs(snapshot) do
        securecallfunction(callback, event, ...);
    end
end

local function RefreshUI()
    if (isRefreshPending or not isReady) then
        return;
    end

    isRefreshPending = true;

    C_Timer.After(0, function()
        isRefreshPending = false;

        local Frame = KeystoneLootFrame;
        if (not Frame) then
            return;
        end

        if (Frame.DungeonsFrame and Frame.DungeonsFrame:IsShown()) then
            Frame.DungeonsFrame:Refresh();
        end

        if (Frame.RaidsFrame and Frame.RaidsFrame:IsShown()) then
            Frame.RaidsFrame:Refresh();
        end

        if (Frame.CatalystFrame) then
            Frame.CatalystFrame:Refresh();
        end

        if (Frame.CustomItemFrame) then
            Frame.CustomItemFrame:Refresh();
        end
    end);
end

local function ToItemId(itemId)
    itemId = tonumber(itemId);

    if (not itemId or itemId <= 0) then
        return nil;
    end

    return itemId;
end

local function ToSpecId(specId, allowAll)
    specId = tonumber(specId);

    if (not specId or specId < 0) then
        return nil;
    end

    if (specId == 0 and not allowAll) then
        return nil;
    end

    return specId;
end

local function ToTier(tier)
    tier = tonumber(tier);

    if (not tier or not Favorites.TIER_NAME[tier]) then
        return nil;
    end

    return tier;
end

local function ToCharacterKey(characterKey)
    if (characterKey == nil) then
        return Character:GetSelectedKey();
    end

    if (type(characterKey) ~= "string" or not Character:ParseKey(characterKey)) then
        return nil;
    end

    return characterKey;
end

local function GetCharacterFavorites(characterKey)
    local favorites = DB:Get("favorites");

    if (type(favorites) ~= "table") then
        return nil;
    end

    return favorites[characterKey];
end

local function BuildEntry(sourceId, specId, itemId, itemInfo)
    local tier = itemInfo.tier or Favorites.TIER_MUST;

    return {
        itemId   = itemId,
        specId   = specId,
        sourceId = sourceId,
        tier     = tier,
        tierName = Favorites.TIER_NAME[tier],
        bonusIds = CopyTableSafe(itemInfo.bonusIds, true),
        gems     = CopyTableSafe(itemInfo.gems, true),
        enchant  = itemInfo.enchant,
    };
end

local function SortEntries(a, b)
    if (a.specId ~= b.specId) then
        return a.specId < b.specId;
    end

    return a.itemId < b.itemId;
end

function Internal.SetReady()
    if (isReady) then
        return;
    end

    isReady = true;
    Dispatch(API.Event.READY);
end

function Internal.Fire(event, ...)
    Dispatch(event, ...);

    if (MUTATION_EVENTS[event]) then
        local characterKey = ...;
        Dispatch(API.Event.FAVORITES_CHANGED, characterKey);
    end
end

-- Returns: apiVersion, addonVersion
function API:GetVersion()
    return API_VERSION, C_AddOns.GetAddOnMetadata(AddonName, "Version");
end

-- True once the saved variables are loaded
function API:IsReady()
    return isReady;
end

-- Localized name of a tier
function API:GetTierName(tier)
    tier = ToTier(tier);

    if (not tier) then
        return nil;
    end

    return Favorites.TIER_NAME[tier];
end

-- Texture path of the tier icon
function API:GetTierTexture(tier)
    tier = ToTier(tier);

    if (not tier) then
        return nil;
    end

    return Favorites.TIER_TEXTURE[tier];
end

-- Key of the character you are logged in with
function API:GetCurrentCharacterKey()
    return Character:GetKey();
end

-- Key of the character shown in the addon - the default of every characterKey argument
function API:GetSelectedCharacterKey()
    if (not isReady) then
        return nil;
    end

    return Character:GetSelectedKey();
end

-- All known characters: { key, name, realm, classId, className, classFile, isHidden }
function API:GetCharacters(includeHidden)
    if (not isReady) then
        return {};
    end

    return Character:GetAllCharacters(includeHidden);
end

-- Splits a characterKey into { realm, name, classId }
function API:ParseCharacterKey(characterKey)
    if (type(characterKey) ~= "string") then
        return nil;
    end

    return Character:ParseKey(characterKey);
end

-- All favorites: { itemId, specId, sourceId, tier, tierName, bonusIds, gems, enchant }
function API:GetFavorites(characterKey)
    characterKey = ToCharacterKey(characterKey);

    if (not isReady or not characterKey) then
        return {};
    end

    local characterFavorites = GetCharacterFavorites(characterKey);
    if (not characterFavorites) then
        return {};
    end

    local entries = {};

    for sourceId, sourceData in pairs(characterFavorites) do
        for specId, specData in pairs(sourceData) do
            for itemId, itemInfo in pairs(specData) do
                table.insert(entries, BuildEntry(sourceId, specId, itemId, itemInfo));
            end
        end
    end

    table.sort(entries, SortEntries);

    return entries;
end

-- Same as GetFavorites, limited to one spec
function API:GetFavoritesBySpec(specId, characterKey)
    specId = ToSpecId(specId);
    characterKey = ToCharacterKey(characterKey);

    if (not isReady or not specId or not characterKey) then
        return {};
    end

    local characterFavorites = GetCharacterFavorites(characterKey);
    if (not characterFavorites) then
        return {};
    end

    local entries = {};

    for sourceId, sourceData in pairs(characterFavorites) do
        if (sourceData[specId]) then
            for itemId, itemInfo in pairs(sourceData[specId]) do
                table.insert(entries, BuildEntry(sourceId, specId, itemId, itemInfo));
            end
        end
    end

    table.sort(entries, SortEntries);

    return entries;
end

-- A single entry or nil. specId 0 or nil returns the one with the highest tier
function API:GetFavorite(itemId, specId, characterKey)
    itemId = ToItemId(itemId);
    specId = ToSpecId(specId or 0, true);
    characterKey = ToCharacterKey(characterKey);

    if (not isReady or not itemId or not specId or not characterKey) then
        return nil;
    end

    local characterFavorites = GetCharacterFavorites(characterKey);
    if (not characterFavorites) then
        return nil;
    end

    local bestEntry = nil;

    for sourceId, sourceData in pairs(characterFavorites) do
        for currentSpecId, specData in pairs(sourceData) do
            if ((specId == 0 or currentSpecId == specId) and specData[itemId]) then
                local entry = BuildEntry(sourceId, currentSpecId, itemId, specData[itemId]);

                if (specId ~= 0) then
                    return entry;
                end

                if (not bestEntry or entry.tier > bestEntry.tier) then
                    bestEntry = entry;
                end
            end
        end
    end

    return bestEntry;
end

-- specId 0 or nil checks every spec
function API:IsFavorite(itemId, specId, characterKey)
    return self:GetFavorite(itemId, specId, characterKey) ~= nil;
end

-- Tier 1-4, or 0 if the item is not a favorite
function API:GetTier(itemId, specId, characterKey)
    local entry = self:GetFavorite(itemId, specId, characterKey);

    return entry and entry.tier or 0;
end

-- Every specId the item is favorited for
function API:GetItemSpecs(itemId, characterKey)
    itemId = ToItemId(itemId);
    characterKey = ToCharacterKey(characterKey);

    if (not isReady or not itemId or not characterKey) then
        return {};
    end

    local characterFavorites = GetCharacterFavorites(characterKey);
    if (not characterFavorites) then
        return {};
    end

    local seen = {};
    local specs = {};

    for _, sourceData in pairs(characterFavorites) do
        for specId, specData in pairs(sourceData) do
            if (specData[itemId] and not seen[specId]) then
                seen[specId] = true;
                table.insert(specs, specId);
            end
        end
    end

    table.sort(specs);

    return specs;
end

-- A challengeModeId (dungeon), a bossId (raid), "catalyst" or "custom"
function API:GetItemSource(itemId)
    itemId = ToItemId(itemId);

    if (not itemId) then
        return nil;
    end

    return Query:GetItemSource(itemId);
end

-- Resolves a sourceId into { type, name, ... }
function API:GetSourceInfo(sourceId)
    if (sourceId == "catalyst" or sourceId == "custom") then
        return { type = sourceId };
    end

    sourceId = tonumber(sourceId);
    if (not sourceId) then
        return nil;
    end

    for _, dungeon in ipairs(Query:GetDungeons()) do
        if (dungeon.challengeModeId == sourceId) then
            return {
                type            = "dungeon",
                name            = C_ChallengeMode.GetMapUIInfo(dungeon.challengeModeId),
                challengeModeId = dungeon.challengeModeId,
                instanceId      = dungeon.instanceId,
            };
        end
    end

    for _, raid in ipairs(Query:GetRaids()) do
        for _, boss in ipairs(raid.bossList) do
            if (boss.bossId == sourceId) then
                return {
                    type              = "raid",
                    name              = EJ_GetEncounterInfo(boss.bossId),
                    bossId            = boss.bossId,
                    raidName          = EJ_GetInstanceInfo(raid.journalInstanceId),
                    journalInstanceId = raid.journalInstanceId,
                    instanceId        = raid.instanceId,
                };
            end
        end
    end

    return nil;
end

-- The addon's own item data: { itemId, slotId, icon, isCatalyst, isCustom, classes }
-- Custom items are not in the database, so only itemId, icon and isCustom are set
function API:GetItemInfo(itemId)
    itemId = ToItemId(itemId);

    if (not itemId) then
        return nil;
    end

    local catalystItem = KeystoneLoot.CatalystDatabase[itemId];
    if (catalystItem) then
        local specIds = {};
        for _, spec in ipairs(Character:GetAllSpecs(catalystItem.classId)) do
            table.insert(specIds, spec.specId);
        end

        return {
            itemId     = itemId,
            slotId     = catalystItem.slotId,
            icon       = Query:GetItemIcon(itemId),
            isCatalyst = true,
            isCustom   = false,
            classes    = { [catalystItem.classId] = specIds },
        };
    end

    local icon = Query:GetItemIcon(itemId);
    local item = Query:GetItemInfo(itemId);

    if (not item) then
        if (not icon) then
            return nil;
        end

        return {
            itemId     = itemId,
            icon       = icon,
            isCatalyst = false,
            isCustom   = true,
        };
    end

    return {
        itemId     = itemId,
        slotId     = item.slotId,
        icon       = icon,
        isCatalyst = false,
        isCustom   = false,
        classes    = CopyTable(item.classes),
    };
end

-- options: { bonusIds, gems, enchant, characterKey } - all optional
-- specId 0 adds the item for every spec of the class that can use it
function API:AddFavorite(itemId, specId, tier, options)
    itemId = ToItemId(itemId);
    specId = ToSpecId(specId, true);
    tier = ToTier(tier or Favorites.TIER_MUST);

    if (options ~= nil and type(options) ~= "table") then
        return false;
    end

    options = options or {};

    if ((options.bonusIds ~= nil and type(options.bonusIds) ~= "table")
            or (options.gems ~= nil and type(options.gems) ~= "table")) then
        return false;
    end

    local characterKey = ToCharacterKey(options.characterKey);

    if (not isReady or not itemId or not specId or not tier or not characterKey) then
        return false;
    end

    local info = Character:ParseKey(characterKey);
    if (not info) then
        return false;
    end

    local isValid, sourceId = Favorites:IsValidForSpec(itemId, specId, info.classId);
    if (not sourceId) then
        return false;
    end

    -- specId 0 is resolved to the usable specs inside Favorites:Add
    if (specId ~= 0 and not isValid) then
        return false;
    end

    local success = Favorites:Add(sourceId, specId, itemId, tier, CopyTableSafe(options.bonusIds, true),
        CopyTableSafe(options.gems, true), tonumber(options.enchant), characterKey);

    if (success) then
        RefreshUI();
    end

    return success;
end

-- specId 0 or nil removes the item from every spec
function API:RemoveFavorite(itemId, specId, characterKey)
    itemId = ToItemId(itemId);
    specId = ToSpecId(specId or 0, true);
    characterKey = ToCharacterKey(characterKey);

    if (not isReady or not itemId or not specId or not characterKey) then
        return false;
    end

    local success = Favorites:Remove(itemId, specId, characterKey);

    if (success) then
        RefreshUI();
    end

    return success;
end

-- Only changes items that already are a favorite. specId 0 or nil updates every spec
function API:SetTier(itemId, specId, tier, characterKey)
    itemId = ToItemId(itemId);
    specId = ToSpecId(specId or 0, true);
    tier = ToTier(tier);
    characterKey = ToCharacterKey(characterKey);

    if (not isReady or not itemId or not specId or not tier or not characterKey) then
        return false;
    end

    local success = Favorites:SetTier(itemId, specId, tier, characterKey);

    if (success) then
        RefreshUI();
    end

    return success;
end

-- Import string of the character, or nil if there is nothing to export
function API:Export(characterKey)
    characterKey = ToCharacterKey(characterKey);

    if (not isReady or not characterKey) then
        return nil;
    end

    local exportString = Favorites:Export(characterKey);

    -- Export returns a localized message when there is nothing to export
    if (type(exportString) ~= "string" or not string.match(exportString, "^KeystoneLoot:v%d+,")) then
        return nil;
    end

    return exportString;
end

-- Returns: success, importedCount or error message, skippedSpecs
function API:Import(importString, overwrite, characterKey)
    characterKey = ToCharacterKey(characterKey);

    if (type(importString) ~= "string") then
        return false, "Invalid import string.", false;
    end

    if (not isReady or not characterKey) then
        return false, "KeystoneLoot is not ready yet.", false;
    end

    local success, result, skippedSpecs = Favorites:Import(importString, overwrite and true or false, characterKey);

    if (success) then
        RefreshUI();
    end

    return success, result, skippedSpecs;
end

-- callback(event, ...) - owner is the handle to unregister with, defaults to the callback
function API:RegisterCallback(event, callback, owner)
    if (type(event) ~= "string" or not API.Event[event]) then
        return false;
    end

    if (type(callback) ~= "function") then
        return false;
    end

    owner = owner or callback;

    if (not callbacks[event]) then
        callbacks[event] = {};
    end

    callbacks[event][owner] = callback;

    if (event == API.Event.READY and isReady) then
        securecallfunction(callback, API.Event.READY);
    end

    return true;
end

function API:UnregisterCallback(event, owner)
    if (type(event) ~= "string" or owner == nil or not callbacks[event]) then
        return false;
    end

    if (callbacks[event][owner] == nil) then
        return false;
    end

    callbacks[event][owner] = nil;

    return true;
end

_G.KeystoneLootAPI = API;
