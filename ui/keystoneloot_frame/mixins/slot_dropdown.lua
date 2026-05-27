local AddonName, KeystoneLoot = ...;

local DB = KeystoneLoot.DB;
local Query = KeystoneLoot.Query;

local SLOTS = {
    INVTYPE_HEAD,
    INVTYPE_NECK,
    INVTYPE_SHOULDER,
    INVTYPE_CLOAK,
    INVTYPE_CHEST,
    INVTYPE_WRIST,
    INVTYPE_HAND,
    INVTYPE_WAIST,
    INVTYPE_LEGS,
    INVTYPE_FEET,
    INVTYPE_WEAPONMAINHAND,
    INVTYPE_WEAPONOFFHAND,
    INVTYPE_FINGER,
    INVTYPE_TRINKET,
    EJ_LOOT_SLOT_FILTER_OTHER
};

KeystoneLootSlotDropdownMixin = {};

local function GetSelectedSlots()
    local slotId = DB:Get("filters.slotId");
    if (not DB:Get("settings.multiSlotFilter") or slotId == -1 or slotId == -2) then
        return {};
    end

    local selectedSlots = DB:Get("filters.slotIds");

    if (type(selectedSlots) == "table") then
        for _, selected in pairs(selectedSlots) do
            if (selected) then
                return selectedSlots;
            end
        end
    end

    if (slotId and slotId >= 0) then
        return { [slotId] = true };
    end

    return {};
end

local function HasSelectedSlot(selectedSlots)
    for _, selected in pairs(selectedSlots) do
        if (selected) then
            return true;
        end
    end

    return false;
end

local function GetFirstSelectedSlot(selectedSlots)
    local firstSlotId;

    for slotId, selected in pairs(selectedSlots) do
        if (selected and (not firstSlotId or slotId < firstSlotId)) then
            firstSlotId = slotId;
        end
    end

    return firstSlotId;
end

local function GetSelectedSlotCount(selectedSlots)
    local count = 0;

    for _, selected in pairs(selectedSlots) do
        if (selected) then
            count = count + 1;
        end
    end

    return count;
end

function KeystoneLootSlotDropdownMixin:Init()
    self:SetSelectionText(function(selections)
        local slotId = DB:Get("filters.slotId");

        if (slotId == -1) then
            return FAVORITES;
        end

        if (slotId == -2) then
            return ALL_INVENTORY_SLOTS;
        end

        if (not DB:Get("settings.multiSlotFilter")) then
            return SLOTS[slotId + 1];
        end

        local selectedSlots = GetSelectedSlots();
        local count = GetSelectedSlotCount(selectedSlots);
        local firstSlotId = GetFirstSelectedSlot(selectedSlots);

        if (count == 0 or not firstSlotId) then
            return ALL_INVENTORY_SLOTS;
        end

        local firstSlotName = SLOTS[firstSlotId + 1];
        if (count == 1) then
            return firstSlotName;
        end

        return string.format("%s + %d", firstSlotName, count - 1);
    end);

    self:SetupMenu(function(dropdown, rootDescription)
        rootDescription:SetTag("MENU_KEYSTONELOOT_SLOT_DROPDOWN");

        local function IsSpecialSelected(data)
            return DB:Get("filters.slotId") == data.slotId;
        end

        local function SetSpecialSelected(data)
            DB:Set("filters.slotIds", {});
            DB:Set("filters.slotId", data.slotId);
        end

        local function SetSlotSelected(data)
            DB:Set("filters.slotIds", {});
            DB:Set("filters.slotId", data.slotId);
        end

        local function IsSlotSelected(data)
            if (not DB:Get("settings.multiSlotFilter")) then
                return DB:Get("filters.slotId") == data.slotId;
            end

            local selectedSlots = GetSelectedSlots();
            return selectedSlots[data.slotId];
        end

        local function ToggleSlot(data)
            local selectedSlots = GetSelectedSlots();
            selectedSlots[data.slotId] = not selectedSlots[data.slotId] or nil;

            if (HasSelectedSlot(selectedSlots)) then
                DB:Set("filters.slotIds", selectedSlots);
                DB:Set("filters.slotId", GetFirstSelectedSlot(selectedSlots));
            else
                DB:Set("filters.slotIds", {});
                DB:Set("filters.slotId", -2);
            end
        end

        rootDescription:CreateRadio(FAVORITES, IsSpecialSelected, SetSpecialSelected, { slotId = -1 });
        rootDescription:CreateDivider();
        rootDescription:CreateRadio(ALL_INVENTORY_SLOTS, IsSpecialSelected, SetSpecialSelected, { slotId = -2 });

        for index, slotName in ipairs(SLOTS) do
            local slotId = index - 1; -- 0-based
            local checkbox;
            if (DB:Get("settings.multiSlotFilter")) then
                checkbox = rootDescription:CreateCheckbox(slotName, IsSlotSelected, ToggleSlot, { slotId = slotId });
            else
                checkbox = rootDescription:CreateRadio(slotName, IsSlotSelected, SetSlotSelected, { slotId = slotId });
            end

            if (not self:SlotHasItems(slotId)) then
                checkbox:SetEnabled(false);

                checkbox:SetTooltip(function(tooltip, elementDescription)
                    GameTooltip_AddColoredLine(tooltip, BROWSE_NO_RESULTS, RED_FONT_COLOR);
                end);
            end
        end
    end);

    local function OnChanged()
        -- Check if current slot still has items
        local currentSlot = DB:Get("filters.slotId");

        -- Skip favorites and all-slots modes
        if (currentSlot ~= -1 and currentSlot ~= -2) then
            if (not DB:Get("settings.multiSlotFilter")) then
                DB:Set("filters.slotIds", {});

                if (not self:SlotHasItems(currentSlot)) then
                    DB:Set("filters.slotId", -2);
                end

                self:GenerateMenu();
                return;
            end

            local selectedSlots = GetSelectedSlots();
            for slotId, selected in pairs(selectedSlots) do
                if (selected and not self:SlotHasItems(slotId)) then
                    selectedSlots[slotId] = nil;
                end
            end

            -- If selected slots are now empty, reset to all slots.
            if (HasSelectedSlot(selectedSlots)) then
                DB:Set("filters.slotIds", selectedSlots);
                DB:Set("filters.slotId", GetFirstSelectedSlot(selectedSlots));
            else
                DB:Set("filters.slotIds", {});
                DB:Set("filters.slotId", -2);
            end
        end

        self:GenerateMenu();
    end

    DB:AddObserver("ui.selectedTab", OnChanged);
    DB:AddObserver("ui.selectedRaidTab", OnChanged);
    DB:AddObserver("filters.specId", OnChanged);
    DB:AddObserver("settings.multiSlotFilter", OnChanged);
end

function KeystoneLootSlotDropdownMixin:SlotHasItems(slotId)
    local selectedTab = DB:Get("ui.selectedTab");

    if (selectedTab == "dungeons") then
        return Query:HasDungeonSlotItems(slotId);
    end

    return Query:HasRaidSlotItems(slotId);
end
