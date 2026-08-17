# KeystoneLoot

KeystoneLoot is a World of Warcraft addon that gives you a compact, filterable overview of loot from Mythic+ dungeons, raids, and the Catalyst, all in one place.

**Want a head start?** Grab import-ready BiS lists for every class and spec at [keystoneloot.io](https://www.keystoneloot.io).

---

## Features

### Smart Loot Filtering
Filter displayed items by class, specialization, item slot, and item level. Filters automatically sync when you switch characters via the character dropdown, so you always see what's relevant to your current alt.

### Favorites System
Mark items as favorites on a per-character, per-spec basis, with five priority tiers: **Nice to have**, **Must have**, **Best in Slot**, **Transmog**, and **Catalyst** (only for items the Catalyst can convert). The system supports:
- Favoriting for a single spec or all specs at once
- Viewing another character's wishlist via the character dropdown
- **Export & Import** of favorites using a compact string format (`KeystoneLoot:v3,...`), great for sharing wishlists or migrating between accounts. Building your own tool? See [Import String Format](#import-string-format-v3).
- A public **addon API** (`KeystoneLootAPI`) so other addons can read, change, and react to favorites. See [Addon API](#addon-api).

### Void Core (Bonus Roll) Tracking
See exactly which items you've already secured with Void Cores and what's still left to collect from each dungeon and raid boss. It even works retroactively: anything you'd already obtained is filled in automatically when you install it, so you're never starting from scratch.

### Drop Alert
When a groupmate loots an item you have marked as a favorite, a notification pops up showing the item and who got it. You can whisper them directly from the notification with a fully customizable message.

### Loot Spec Reminder
When you enter a Mythic+ dungeon, KeystoneLoot checks whether your active loot specialization matches your favorited items. It also compares loot pool sizes across specs, so if a different spec has a smaller pool but can still drop what you want, it recommends that one instead for better odds.

### Teleport Buttons
Quick-teleport buttons on dungeon entries let you jump straight to a dungeon entrance without leaving the addon.

### The Catalyst
View all Catalyst-convertible items for your class and spec directly within the addon, no need to look them up externally.

### Keystone Tooltip
Hovering over a keystone in your bags shows additional dungeon info directly in the tooltip.

### Minimap Button
Toggle the main window from a minimap button. Fully draggable and position-persistent.

---

## Installation
Install via [CurseForge](https://www.curseforge.com/wow/addons/keystoneloot)

---

## Localization
KeystoneLoot ships with support for: `enUS`, `deDE`, `esES`, `frFR`, `itIT`, `koKR`, `ptBR`, `ruRU`, `zhCN`, `zhTW`

---

## Import String Format (v3)

This section is for developers who want to generate KeystoneLoot import strings from their own website, addon, or tool (for example, to hand out ready-made BiS lists).

### Structure

A v3 string is the prefix `KeystoneLoot:v3,` followed by a Base64 blob:

```
KeystoneLoot:v3,<base64>
```

The blob is produced from your favorites data in three steps:

1. Serialize the data to a **JSON** string.
2. Compress that string with **zlib** (RFC 1950, i.e. with the zlib header, *not* raw DEFLATE).
3. **Base64**-encode the compressed bytes (standard alphabet, with padding).

Importing just reverses it: whitespace is stripped, the prefix is removed, then Base64-decode -> zlib-decompress -> parse JSON. Any step failing makes the whole string invalid.

### JSON layout

A JSON object keyed by **specialization ID as a string**, each mapping to a list of item entries:

```json
{
  "250": [
    { "itemId": 178712, "tier": 3, "bonusIds": [6652, 1498] },
    { "itemId": 178809, "tier": 2 }
  ],
  "251": [
    { "itemId": 178712, "tier": 1 }
  ]
}
```

*(The IDs above are illustrative.)*

Fields per item entry:

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `itemId` | integer | yes | The item's ID. |
| `tier` | integer | no | Favorite tier, `1`-`5`. Defaults to `2`. |
| `bonusIds` | integer[] | no | Bonus IDs applied to the item. |
| `gems` | integer[] | no | Socketed gem item IDs. |
| `enchant` | integer | no | Enchant ID. |

Most BiS-list generators only need `itemId`, `tier`, and (optionally) `bonusIds`; `gems` and `enchant` are extras that the addon simply round-trips.

Tier values:

| Value | Meaning |
| --- | --- |
| `1` | Nice to have |
| `2` | Must have |
| `3` | Best in Slot |
| `4` | Transmog |
| `5` | Catalyst |

`1` (Nice to have) and `2` (Must have) work on every item. The other three depend on the item's slot:

| Tier | Only valid for |
| --- | --- |
| `3` Best in Slot | Anything except *Other* - items that aren't a gear piece can't be rated as one. |
| `4` Transmog | Same as Best in Slot. |
| `5` Catalyst | Head, shoulder, back, chest, wrist, hands, legs and feet - the slots the Catalyst can convert. |

### Things to know when generating strings

- On import, entries for specs that don't belong to the importing character's class are **skipped**.
- A `tier` that is unknown, or not allowed for that item (see the table above), falls back to `2` - the item itself is still imported.
- Known items (Mythic+ dungeon, raid, or Catalyst loot) are imported only if they are valid for the target class/spec.
- Any item that isn't in KeystoneLoot's database is imported as a **Custom Item**, as long as it's a real, existing item. Custom Items aren't validated against class/spec the way known items are (anything unknown is simply treated as custom), but they are still keyed under a spec, so that spec must belong to the character's class. Custom Items also do **not** inherit the addon's configured item level; if it matters (e.g. for crafted gear), set it explicitly via `bonusIds`.
- The legacy `KeystoneLoot:v1` and `KeystoneLoot:v2` formats are still parsed for backwards compatibility, but `v3` is the current format and the one you should generate.

The canonical implementation lives in [`modules/favorites.lua`](modules/favorites.lua) (`Favorites:Export` and `ParseV3`) if you want to match it exactly.

---

## Addon API

KeystoneLoot exposes a global table `KeystoneLootAPI` that other addons can use to read, modify, and react to favorites. The implementation lives in [`modules/api.lua`](modules/api.lua).

All functions are called with a colon (`KeystoneLootAPI:GetFavorites()`). Invalid arguments never throw - read functions return `nil` or an empty table, write functions return `false`.

### Getting started

```lua
if (not KeystoneLootAPI) then
    return; -- KeystoneLoot is not installed
end

KeystoneLootAPI:RegisterCallback("READY", function()
    for _, entry in ipairs(KeystoneLootAPI:GetFavorites()) do
        print(entry.itemId, entry.specId, entry.tierName);
    end
end, "MyAddon");
```

The saved variables are only available once the player has entered the world. Until then `KeystoneLootAPI:IsReady()` returns `false` and all favorite functions return empty results. Registering for `READY` after it already fired calls your callback immediately, so it is always safe to use.

### Terms

| Term | Description |
| --- | --- |
| `characterKey` | Identifies a character as `"Realm-Name-ClassId"`. Defaults to the character currently selected in the addon. |
| `specId` | A Blizzard specialization ID. `0` means "all specs" (add for every usable spec, remove/read across all specs). |
| `tier` | Favorite tier `1`-`5`, see `KeystoneLootAPI.Tier`. |
| `sourceId` | Where an item comes from: a `challengeModeId` (dungeon), a `bossId` (raid), `"catalyst"` or `"custom"`. |

### Constants

```lua
KeystoneLootAPI.Tier   -- { NICE = 1, MUST = 2, BIS = 3, TRANSMOG = 4, CATALYST = 5 }
KeystoneLootAPI.Event  -- { READY, FAVORITE_ADDED, FAVORITE_REMOVED,
                       --   FAVORITE_TIER_CHANGED, FAVORITES_IMPORTED, FAVORITES_CHANGED }
```

Don't hardcode this list. `:GetTiers()` (below) returns whatever tiers the installed version has, so your addon keeps working if the list ever grows again.

### Functions

**Meta**

| Function | Returns |
| --- | --- |
| `:GetVersion()` | API version (number) and addon version (string). |
| `:IsReady()` | `true` once the database is loaded. |

The API version is currently `2`. Version `2` added the **Catalyst** tier plus `:GetTiers` and `:IsTierValidForItem`; check it if you need to support older installs.

**Tiers**

| Function | Returns |
| --- | --- |
| `:GetTiers(itemId)` | Every tier, most important first. With an `itemId` only the tiers that item accepts. |
| `:GetTierName(tier)` | Localized tier name. |
| `:GetTierTexture(tier)` | Texture path of the tier icon. |
| `:IsTierValidForItem(tier, itemId)` | `true` if that tier can be used for that item. |

`:GetTiers` is the way to stay independent of the tier list. It returns them in the addon's own order - Best in Slot, Must have, Nice to have, Catalyst, Transmog - which is the same order the right-click menu and the sorted item lists use, so a menu built from it matches the addon. Each entry looks like this:

```lua
{
    tier    = 5,
    name    = "Catalyst",  -- localized
    texture = "Interface\\AddOns\\KeystoneLoot\\assets\\tier_catalyst",
}
```

Not every tier works on every item - **Catalyst** needs a slot the Catalyst can convert, **Best in Slot** and **Transmog** need an actual gear piece (see [Tier values](#import-string-format-v3)). Passing an `itemId` to `:GetTiers` filters the list down to what `:AddFavorite` and `:SetTier` will actually accept for that item, which is why you should prefer it over hardcoding `KeystoneLootAPI.Tier`.

```lua
-- Build a tier menu for an item without knowing which tiers exist
for _, tierInfo in ipairs(KeystoneLootAPI:GetTiers(itemId)) do
    print(string.format("|T%s:16:16|t %s", tierInfo.texture, tierInfo.name), tierInfo.tier);
end
```

**Characters**

| Function | Returns |
| --- | --- |
| `:GetCurrentCharacterKey()` | The key of the character you are logged in with. |
| `:GetSelectedCharacterKey()` | The key of the character currently shown in the addon. |
| `:GetCharacters(includeHidden)` | List of `{ key, name, realm, classId, className, classFile, isHidden }`. |
| `:ParseCharacterKey(characterKey)` | `{ realm, name, classId }` or `nil`. |

**Reading favorites**

| Function | Returns |
| --- | --- |
| `:GetFavorites(characterKey)` | All favorites as a flat list of entries. |
| `:GetFavoritesBySpec(specId, characterKey)` | Favorites of a single spec. |
| `:GetFavorite(itemId, specId, characterKey)` | A single entry, or `nil`. With `specId = 0`/`nil` the entry with the highest tier. |
| `:IsFavorite(itemId, specId, characterKey)` | `true`/`false`. |
| `:GetTier(itemId, specId, characterKey)` | Tier `1`-`5`, or `0` if it is not a favorite. |
| `:GetItemSpecs(itemId, characterKey)` | List of specIds the item is favorited for. |

An entry looks like this:

```lua
{
    itemId   = 178712,
    specId   = 250,
    sourceId = 161,             -- challengeModeId, bossId, "catalyst" or "custom"
    tier     = 3,
    tierName = "Best in Slot",  -- localized
    bonusIds = { 6652, 1498 },  -- optional
    gems     = { 213743 },      -- optional
    enchant  = 7334,            -- optional
}
```

**Items**

| Function | Returns |
| --- | --- |
| `:GetItemSource(itemId)` | The `sourceId` of an item. |
| `:GetSourceInfo(sourceId)` | `{ type = "dungeon"/"raid"/"catalyst"/"custom", name, ... }`. |
| `:GetItemInfo(itemId)` | `{ itemId, slotId, icon, isCatalyst, isCustom, classes }`, where `classes` maps a classId to the specIds that can use the item. Custom Items are not in the database, so only `itemId`, `icon` and `isCustom` are set; `nil` for items that don't exist. |

**Writing favorites**

| Function | Returns |
| --- | --- |
| `:AddFavorite(itemId, specId, tier, options)` | `true` if the item was added. |
| `:RemoveFavorite(itemId, specId, characterKey)` | `true` if something was removed. |
| `:SetTier(itemId, specId, tier, characterKey)` | `true` if the tier of an already favorited item was changed. |
| `:Import(importString, overwrite, characterKey)` | `success, importedCount or error message, skippedSpecs`. |
| `:Export(characterKey)` | Import string of that character, or `nil` if there is nothing to export. |

`options` for `:AddFavorite` are all optional: `{ bonusIds = { ... }, gems = { ... }, enchant = 0, characterKey = "..." }`. `tier` defaults to *Must have*.

Items are validated exactly like an import: known dungeon, raid, and Catalyst items must be usable by the target class/spec, and unknown items are stored as Custom Items as long as the item really exists. The open window is redrawn automatically after a write.

The `tier` is validated too. Unlike an import, `:AddFavorite` and `:SetTier` return `false` instead of falling back to a default, so check with `:IsTierValidForItem(tier, itemId)` or use `:GetTiers(itemId)` when the tier can be a restricted one such as `Tier.CATALYST`.

```lua
-- Mark an item as BiS for the current character's active spec
local specId = C_SpecializationInfo.GetSpecializationInfo(C_SpecializationInfo.GetSpecialization());

KeystoneLootAPI:AddFavorite(178712, specId, KeystoneLootAPI.Tier.BIS, {
    bonusIds     = { 6652, 1498 },
    characterKey = KeystoneLootAPI:GetCurrentCharacterKey(),
});
```

### Events

`:RegisterCallback(event, callback, owner)` registers a callback, `:UnregisterCallback(event, owner)` removes it again. `owner` is the handle used to unregister and defaults to the callback itself. The callback always receives the event name as its first argument:

| Event | Payload |
| --- | --- |
| `READY` | - |
| `FAVORITE_ADDED` | `characterKey, itemId, specId, tier` |
| `FAVORITE_REMOVED` | `characterKey, itemId, specId` |
| `FAVORITE_TIER_CHANGED` | `characterKey, itemId, specId, tier` |
| `FAVORITES_IMPORTED` | `characterKey, importedCount` |
| `FAVORITES_CHANGED` | `characterKey` - fired after every one of the above |

Events fire for every change, no matter whether it came from the UI, an import, or the API itself. Adding an item for all specs (`specId = 0`) fires one `FAVORITE_ADDED` per resolved spec.

```lua
local function OnFavoritesChanged(event, characterKey)
    print("KeystoneLoot favorites changed for", characterKey);
end

KeystoneLootAPI:RegisterCallback("FAVORITES_CHANGED", OnFavoritesChanged, "MyAddon");
KeystoneLootAPI:UnregisterCallback("FAVORITES_CHANGED", "MyAddon");
```