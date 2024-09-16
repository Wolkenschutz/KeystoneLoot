# Changelog

## 1.9.2 - 2024-09-16

### Bugfixes

- Fixed incorrect raid NPC IDs

## 1.9.1 - 2024-09-11

### Bugfixes

- Fresh update for TWW Season 1

### Other Changes

- Update ruRU.lua
- Merge pull request [#28](https://github.com/Wolkenschutz/KeystoneLoot/pull/28) by [Hollicsh](https://github.com/Hollicsh) from Hollicsh/patch-5

## 1.9.0 - 2024-09-09

### New Features

- Highlighting items by stats

### Bugfixes

- Added missing npc ids
- Dungeon title now automatically scales so it isn't truncated
- Raid boss title now automatically scales so it isn't truncated

### Improvements

- Added class sets for the Catalyst

### Other Changes

- Merge branch 'main' of https://github.com/Wolkenschutz/KeystoneLoot
- Language files updated

## 1.8.7 - 2024-09-04

### Other Changes

- M+ dungeon update for TWW Season 1

## 1.8.6 - 2024-08-29

### Other Changes

- Raid update for TWW Season 1 (M+ dungeons coming later)

## 1.8.5 - 2024-08-14

### Bugfixes

- Cooldown error with the teleport buttons has been fixed #26

### Other Changes

- Update zhTW.lua
- Update zhTW.lua
- Merge pull request [#25](https://github.com/Wolkenschutz/KeystoneLoot/pull/25) by [EKE00372](https://github.com/EKE00372) from EKE00372/patch-2

### Other Changes

- Bump TOC version

## 1.8.4 - 2024-08-03

### Bugfixes

- Translation fixed

### Other Changes

- "New" lettering removed
- Texture no longer necessary as it is now implemented in the game
- DF Season 3 removed
- Bump interface version

## 1.8.3 - 2024-06-28

### Other Changes

- Update zhTW.lua
- Update zhCN.lua
- Update zhTW.lua
- Update zhTW/zhCN from EKE00372

## 1.8.2 - 2024-06-11

### Bugfixes

- Catalyst items for Monk and Evoker now display the correct tooltip. #22

### Other Changes

- Update ruRU.lua

## 1.8.1 - 2024-06-05

### Improvements

- The dropdown menu now has the new design from TWW.
- The options icon has the new design from TWW.

## 1.8.0 - 2024-05-27

### New Features

- Show item level in keystone tooltip

## 1.7.2 - 2024-05-13

### Bugfixes

- Fixed an error that caused a Taint error "CastSpellById".
- Allow the frame to be opened and closed while in combat.

## 1.7.1

## Bugfixes

- Fixed missing texture for Glimmeron.
- Fixed a bug in loot reminder where the same item was shown multiple times.
- Fixed a bug that displayed the loot reminder when it wasn't necessary.

### Improvements

- Loot reminder enabled for raids.

### Other Changes

- TOC version updated.

## 1.7.0

### New Feature

- KeystoneLoot now includes raids. \o/

### Bugfixes

- Items from 'Miscellaneous' now have the correct tooltip.

### Improvements

- M+0 has been added to the item levels for Champion for completeness.
- Now, a small exclamation mark appears on the item icons in the favorites when it drops for a different specialization.

### Other Changes

- English is now always loaded as the default language and can be overridden by other languages.

## 1.6.1

### Improvements

- Added Dragonflight Season 4 Catalyst items

### Other Changes

- Season 4 activated

## 1.6.0

### New Features

- Dungeon teleports added. A small button next to the title.
- The window now closes with the ESC key.

### Bugfixes

- The season is no longer automatically detected. There were too many errors.
- The minimap button is now displayed correctly.

### Improvements

- Some parts of the code have been completely reworked.

### Other Changes

- Season 4 information added.
- All settings have been reset due to the rework.
- TOC version updated.

## 1.5.3

### Other Changes

- Update ruRU by Hollicsh

## 1.5.2

### Improvements

- Renew Options, now directly in KeystoneLoot
- New Option, Favorites across all specializations

### Bugfixes

- Bump DB Version
- Fixed Catalyst items for new favorites option
- Fixed Catalyst items for people who had never favorited a Catalyst item (Thanks Kuuhaku@WoW)

## 1.5.1

* If no specialization name was present, there was a nil error.
* Update ruRU. (Thanks Valdemar@Github)

## 1.5.0

* New feature! You will now be notified that you could change your loot specialization because you have favorited items for a different specialization.
* "All Specializations" has been removed due to the new feature.
* The first steps for raids are done. (not finished yet)

## 1.4.4

* An error with the 'PeriodicTable' library has been fixed.
* TOC bump.

## 1.4.3

* Another bug has been fixed that caused items from "Rise" to appear in "Fall".
* Fixed a minor issue when it was a new character.

## 1.4.2

* A bug has been fixed that caused items from "Rise" to appear in "Fall".

## 1.4.1

* The last selection will now be saved.

## 1.4.0

* "Dawn of the Infinite" is now displayed as 2 dungeons! Unfortunately, this requires resetting the favorites for this dungeon...

## 1.3.6

* An issue has been fixed where the item level of some items was not displayed correctly, and Divergent items now have their bonus effect!
* Added a small text for the mega dungeon to better understand from which section you obtain this item. Previously favorited items must be favored again for the text to be displayed.

## 1.3.5

* An issue has been resolved where Season 3 Catalyst items were not visible.

## 1.3.4

* Old Season 2 removed. (Addon is automatically ready for Season 3 as soon as it starts)

## 1.3.3

* Preparations for Patch 10.2.0 (New Dropdown Entries, New Catalyst Items)

## 1.3.2

* TOC bump for Patch 10.1.7

## 1.3.1

* Favorites are now saved based on the selected specialization.

## 1.3.0

* Revival Catalyst items are now also displayed if the selected slot has one.
* Minor adjustments in the code.

## 1.2.1

* Restructured item level dropdown menu.
* Update ruRU. (Thanks Valdemar@Github)

## 1.2.0

* Completely rebuilt the dropdown menu. (Patch 10.1.5 Taint error, thanks Blizzard...)
* If no information is available for the tooltip, it updates automatically once information becomes available.
* Dress-up cursor is displayed when a modifier key is pressed.
* Update zhTW/zhCN. (Thanks EKE00372@Github)
* Added a new item subtitle for Patch 10.1.5. (Myth: x/3)

## 1.1.0

* Added dropdown menu to change the item level.

## 1.0.2

* Added text if no season is active.
* Title now displays the current season.
* Minor adjustments in the code.

## 1.0.1

* Bug fix for zhTW clients.
