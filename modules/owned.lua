local AddonName, KeystoneLoot = ...;

KeystoneLoot.Owned = {};

local Owned = KeystoneLoot.Owned;
local DB = KeystoneLoot.DB;
local L = KeystoneLoot.L;

local ORDER_BY_ID = {};
local ORDER_BY_KEY = {};
for order, entry in ipairs(KeystoneLoot.TrackStrings) do
    ORDER_BY_ID[entry.trackId] = order;
    ORDER_BY_KEY[entry.key] = order;
end

local trackIds = {};

-- Counts rather than using C_Item.IsEquippedItem: two one-handers of the same item can be worn at once.
local function GetEquippedCount(itemId)
    local count = 0;

    for slotId = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
        if (GetInventoryItemID("player", slotId) == itemId) then
            count = count + 1;
        end
    end

    return count;
end

function Owned:IsBagSyncLoaded()
    return C_AddOns.IsAddOnLoaded("BagSync");
end

function Owned:Has(itemId)
    return C_Item.IsEquippedItem(itemId) or C_Item.GetItemCount(itemId, true) > 0;
end

function Owned:GetLocations(itemId)
    local equipped = GetEquippedCount(itemId);

    -- GetItemCount counts equipped pieces, so they have to come off the bag total.
    local carried = C_Item.GetItemCount(itemId);
    local withBank = C_Item.GetItemCount(itemId, true);
    local bags = carried - equipped;
    local bank = withBank - carried;

    local locations = {};

    if (equipped > 0) then
        table.insert(locations, L["Already equipped"]);
    end

    if (bags > 0) then
        table.insert(locations, L["In your bags"]);
    end

    if (bank > 0) then
        table.insert(locations, L["In your bank"]);
    end

    return locations;
end

local function IsKnownItem(itemId)
    local info = KeystoneLoot.API:GetItemInfo(itemId);
    return info ~= nil and not info.isCustom;
end

local function AddTrack(target, itemId, trackId)
    local order = ORDER_BY_ID[trackId];
    if (not order) then
        return;
    end

    local current = target[itemId];
    if (not current or ORDER_BY_ID[current] < order) then
        target[itemId] = trackId;
    end
end

local function AddLocation(target, location)
    if (not C_Item.DoesItemExist(location)) then
        return;
    end

    local itemId = C_Item.GetItemID(location);
    if (not itemId or not IsKnownItem(itemId)) then
        return;
    end

    if (not C_Item.IsItemDataCached(location)) then
        C_Item.RequestLoadItemData(location);
        return;
    end

    local info = C_Item.GetItemUpgradeInfo(C_Item.GetItemLink(location));
    AddTrack(target, itemId, info and info.trackStringID);
end

local function AddTrackedLocation(location)
    AddLocation(trackIds, location);
end

local function AddContainer(target, bag)
    for slot = 1, C_Container.GetContainerNumSlots(bag) do
        AddLocation(target, ItemLocation:CreateFromBagAndSlot(bag, slot));
    end
end

function Owned:ScanBank()
    local bankTracks = {};

    for bag = Enum.BagIndex.CharacterBankTab_1, Enum.BagIndex.CharacterBankTab_6 do
        AddContainer(bankTracks, bag);
    end

    DB:Set("bankTracks", bankTracks);
end

function Owned:RefreshTracks()
    wipe(trackIds);

    ItemUtil.IteratePlayerInventoryAndEquipment(AddTrackedLocation);

    local bankTracks = DB:Get("bankTracks");
    if (not bankTracks) then
        return;
    end

    for itemId, trackId in pairs(bankTracks) do
        AddTrack(trackIds, itemId, trackId);
    end
end

function Owned:HasTrack(itemId)
    local order = ORDER_BY_ID[trackIds[itemId]];
    local minOrder = ORDER_BY_KEY[DB:Get("settings.ownedCheck")];

    return order ~= nil and minOrder ~= nil and order >= minOrder;
end
