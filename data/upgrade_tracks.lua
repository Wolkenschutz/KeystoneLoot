local AddonName, KeystoneLoot = ...;

local L = KeystoneLoot.L;

local function CreateTrackEntry(ilvl, bonusId, quality, suffix, rank)
    return {
        rank = rank,
        ilvl = ilvl,
        bonusId = bonusId,
        label = string.format(RECENT_ALLY_RAID_NAME_STRING_FORMAT, ColorManager.GetFormattedStringForItemQuality(ilvl, quality), suffix)
    };
end

KeystoneLoot.UpgradeTrackOrder = {
    dungeon = { "champion", "hero", "greatvault" },
    raid = { "lfr", "normal", "heroic", "mythic" }
};


KeystoneLoot.UpgradeTracks = {
    dungeon = {
        champion = {
            CreateTrackEntry(292, 12833, Enum.ItemQuality.Uncommon, "+0", L["Champion"]),
            CreateTrackEntry(295, 12834, Enum.ItemQuality.Uncommon, "+2 +3", L["Champion"]),
            CreateTrackEntry(298, 12835, Enum.ItemQuality.Uncommon, "+4", L["Champion"]),
            CreateTrackEntry(302, 12836, Enum.ItemQuality.Uncommon, "+5", L["Champion"]),
            CreateTrackEntry(305, 12837, Enum.ItemQuality.Rare, ITEM_UPGRADE, L["Champion"]),
            CreateTrackEntry(308, 12838, Enum.ItemQuality.Rare, ITEM_UPGRADE, L["Champion"])
        },
        hero = {
            CreateTrackEntry(305, 12841, Enum.ItemQuality.Rare, "+6 +7", L["Hero"]),
            CreateTrackEntry(308, 12842, Enum.ItemQuality.Rare, "+8 +9", L["Hero"]),
            CreateTrackEntry(311, 12843, Enum.ItemQuality.Rare, "+10", L["Hero"]),
            CreateTrackEntry(315, 12844, Enum.ItemQuality.Rare, ITEM_UPGRADE, L["Hero"]),
            CreateTrackEntry(318, 12845, Enum.ItemQuality.Epic, ITEM_UPGRADE, L["Hero"]),
            CreateTrackEntry(321, 12846, Enum.ItemQuality.Epic, ITEM_UPGRADE, L["Hero"])
        },
        greatvault = {
            CreateTrackEntry(318, 12849, Enum.ItemQuality.Epic, "+10", L["Myth"]),
            CreateTrackEntry(321, 12850, Enum.ItemQuality.Epic, ITEM_UPGRADE, L["Myth"]),
            CreateTrackEntry(324, 12851, Enum.ItemQuality.Epic, ITEM_UPGRADE, L["Myth"]),
            CreateTrackEntry(328, 12852, Enum.ItemQuality.Epic, ITEM_UPGRADE, L["Myth"]),
            CreateTrackEntry(331, 12853, Enum.ItemQuality.Legendary, ITEM_UPGRADE, L["Myth"]),
            CreateTrackEntry(334, 12854, Enum.ItemQuality.Legendary, ITEM_UPGRADE, L["Myth"])
        }
    },
    raid = {
        lfr = {
            CreateTrackEntry(279, 12825, Enum.ItemQuality.Poor, BOSS),
            CreateTrackEntry(282, 12826, Enum.ItemQuality.Poor, BOSS),
            CreateTrackEntry(285, 12827, Enum.ItemQuality.Poor, BOSS),
            CreateTrackEntry(289, 12828, Enum.ItemQuality.Poor, BOSS),
            CreateTrackEntry(292, 12829, Enum.ItemQuality.Uncommon, ITEM_UPGRADE),
            CreateTrackEntry(295, 12830, Enum.ItemQuality.Uncommon, ITEM_UPGRADE)
        },
        normal = {
            CreateTrackEntry(292, 12833, Enum.ItemQuality.Uncommon, BOSS),
            CreateTrackEntry(295, 12834, Enum.ItemQuality.Uncommon, BOSS),
            CreateTrackEntry(298, 12835, Enum.ItemQuality.Uncommon, BOSS),
            CreateTrackEntry(302, 12836, Enum.ItemQuality.Uncommon, BOSS),
            CreateTrackEntry(305, 12837, Enum.ItemQuality.Rare, ITEM_UPGRADE),
            CreateTrackEntry(308, 12838, Enum.ItemQuality.Rare, ITEM_UPGRADE)
        },
        heroic = {
            CreateTrackEntry(305, 12841, Enum.ItemQuality.Rare, BOSS),
            CreateTrackEntry(308, 12842, Enum.ItemQuality.Rare, BOSS),
            CreateTrackEntry(311, 12843, Enum.ItemQuality.Rare, BOSS),
            CreateTrackEntry(315, 12844, Enum.ItemQuality.Rare, BOSS),
            CreateTrackEntry(318, 12845, Enum.ItemQuality.Epic, ITEM_UPGRADE),
            CreateTrackEntry(321, 12846, Enum.ItemQuality.Epic, ITEM_UPGRADE)
        },
        mythic = {
            CreateTrackEntry(318, 12849, Enum.ItemQuality.Epic, BOSS),
            CreateTrackEntry(321, 12850, Enum.ItemQuality.Epic, BOSS),
            CreateTrackEntry(324, 12851, Enum.ItemQuality.Epic, BOSS),
            CreateTrackEntry(328, 12852, Enum.ItemQuality.Epic, BOSS),
            CreateTrackEntry(331, 12853, Enum.ItemQuality.Legendary, ITEM_UPGRADE),
            CreateTrackEntry(334, 12854, Enum.ItemQuality.Legendary, ITEM_UPGRADE)
        }
    }
};
