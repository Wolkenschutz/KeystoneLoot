# KeystoneLoot

KeystoneLoot is a World of Warcraft addon that gives you a compact, filterable overview of loot from Mythic+ dungeons, raids, and the Catalyst, all in one place.

**Want a head start?** Grab import-ready BiS lists for every class and spec at [keystoneloot.io](https://www.keystoneloot.io).

---

## Features

### Smart Loot Filtering
Filter displayed items by class, specialization, item slot, and item level. Filters automatically sync when you switch characters via the character dropdown, so you always see what's relevant to your current alt.

### Favorites System
Mark items as favorites on a per-character, per-spec basis, with four priority tiers: **Nice to have**, **Must have**, **Best in Slot**, and **Transmog**. The system supports:
- Favoriting for a single spec or all specs at once
- Viewing another character's wishlist via the character dropdown
- **Export & Import** of favorites using a compact string format (`KeystoneLoot:v3,...`), great for sharing wishlists or migrating between accounts. Building your own tool? See [Import String Format](#import-string-format-v3).

### Void Core (Bonus Roll) Tracking
See exactly which items you've already secured with Void Cores and what's still left to collect from each dungeon and raid boss. It even works retroactively: anything you'd already obtained is filled in automatically when you install it, so you're never starting from scratch.

### Drop Alert
When a groupmate loots an item you have marked as a favorite, a notification pops up showing the item and who got it. You can whisper them directly from the notification with a fully customizable message.

### Loot Spec Reminder
When you enter a Mythic+ dungeon, KeystoneLoot checks whether your active loot specialization matches your favorited items. It also compares loot pool sizes across specs, so if a different spec has a smaller pool but can still drop what you want, it recommends that one instead for better odds.

### Teleport Buttons
Quick-teleport buttons on dungeon entries let you jump straight to a dungeon entrance without leaving the addon.

### Revival Catalyst
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
| `tier` | integer | no | Favorite tier, `1`-`4`. Defaults to `2`. |
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

### Things to know when generating strings

- On import, entries for specs that don't belong to the importing character's class are **skipped**.
- Known items (Mythic+ dungeon, raid, or Catalyst loot) are imported only if they are valid for the target class/spec.
- Any item that isn't in KeystoneLoot's database is imported as a **Custom Item**, as long as it's a real, existing item. Custom Items aren't validated against class/spec the way known items are (anything unknown is simply treated as custom), but they are still keyed under a spec, so that spec must belong to the character's class. Custom Items also do **not** inherit the addon's configured item level; if it matters (e.g. for crafted gear), set it explicitly via `bonusIds`.
- The legacy `KeystoneLoot:v1` and `KeystoneLoot:v2` formats are still parsed for backwards compatibility, but `v3` is the current format and the one you should generate.

The canonical implementation lives in [`modules/favorites.lua`](modules/favorites.lua) (`Favorites:Export` and `ParseV3`) if you want to match it exactly.