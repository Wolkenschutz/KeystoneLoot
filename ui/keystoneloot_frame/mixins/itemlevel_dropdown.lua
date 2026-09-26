local AddonName, KeystoneLoot = ...;

local DB = KeystoneLoot.DB;

KeystoneLootItemLevelDropdownMixin = {};

function KeystoneLootItemLevelDropdownMixin:Init()
    self:SetSelectionText(function(selections)
        if (#selections == 0) then
            return STAT_AVERAGE_ITEM_LEVEL;
        end

        local data = selections[1].data;
        if (not data or not data.label) then
            return STAT_AVERAGE_ITEM_LEVEL;
        end

        return data.label;
    end);

    self:SetupMenu(function(dropdown, rootDescription)
        rootDescription:SetTag("MENU_KEYSTONELOOT_ITEMLEVEL_DROPDOWN");

        local selectedTab = DB:Get("ui.selectedTab");
        if (selectedTab == "dungeons") then
            self:BuildTrackMenu(rootDescription, "dungeon", "track");
        else
            self:BuildTrackMenu(rootDescription, "raid", "difficulty");
        end
    end);

    DB:AddObserver("ui.selectedTab", function() self:GenerateMenu(); end);
end

function KeystoneLootItemLevelDropdownMixin:BuildTrackMenu(rootDescription, context, trackSetting)
    local trackPath = "filters." .. context .. "." .. trackSetting;
    local rankPath = "filters." .. context .. ".rank";

    local function IsSelected(data)
        return DB:Get(trackPath) == data.key and DB:Get(rankPath) == data.rank;
    end

    local function SetSelected(data)
        DB:Set(trackPath, data.key);
        DB:Set(rankPath, data.rank);
    end

    for _, menu in ipairs(KeystoneLoot.UpgradeTrackMenus[context]) do
        local trackMenu = rootDescription:CreateButton(menu.label);

        for rank, entry in ipairs(menu.entries) do
            trackMenu:CreateRadio(entry.label, IsSelected, SetSelected, { key = menu.key, rank = rank, label = entry.label });
        end
    end
end
