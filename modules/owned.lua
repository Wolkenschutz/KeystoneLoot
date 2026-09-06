local AddonName, KeystoneLoot = ...;

KeystoneLoot.Owned = {};

local Owned = KeystoneLoot.Owned;
local L = KeystoneLoot.L;

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
