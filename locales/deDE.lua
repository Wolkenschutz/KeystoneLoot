local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "deDE") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s Saison %d)";
L["Import BIS items from %s"] = "Importiere BIS-Gegenstände von %s";

-- itemlevel_dropdown.lua
L["Veteran"] = "Veteran";
L["Champion"] = "Champion";
L["Hero"] = "Held";

-- upgrade_tracks.lua
L["Myth"] = "Mythos";

-- itemlevel_dropdown.lua / keystone_tooltip.lua
L["Great Vault"] = "Große Schatzkammer";

-- catalyst_frame.lua
L["The Catalyst"] = "Der Katalysator";

-- settings_dropdown.lua
L["Minimap button"] = "Minimap-Button";
L["Item level in keystone tooltip"] = "Gegenstandsstufe im Schlüsselstein-Tooltip";
L["Favorite in item tooltip"] = "Favorit im Gegenstand-Tooltip";
L["Favorite on item icons"] = "Favorit auf Gegenstand-Icons";
L["Slot name on item icons"] = "Slot-Name auf Gegenstand-Icons";
L['Hide "Other" in All Slots'] = "\"Sonstiges\" in Alle Slots ausblenden";
L["Loot reminder (dungeons)"] = "Beute-Erinnerung (Dungeons)";
L["Own favorites"] = "Eigene Favoriten";
L["Group favorites"] = "Gruppen-Favoriten";
L["Highlighting"] = "Hervorhebungen";
L["No stats"] = "Keine Stats";
L["Combination mode"] = "Kombinationsmodus";
L["Highlights an item only if its stats match a combination of your selection. Otherwise one matching stat is enough."] = "Hebt den Gegenstand nur hervor, wenn seine Stats mit einer Kombination deiner Auswahl übereinstimmen. Sonst reicht ein passender Stat.";
L["Export..."] = "Exportieren...";
L["Import..."] = "Importieren...";
L["Export favorites of %s"] = "Favoriten von %s exportieren";
L["Import favorites for %s\nPaste import string here:"] = "Favoriten für %s importiert\nImport-String hier einfügen:";
L["Merge"] = "Zusammenführen";
L["Overwrite"] = "Überschreiben";
L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."] = "Zusammenführen behält deine vorhandenen Favoriten und fügt nur neue Gegenstände hinzu. Überschreiben ersetzt alle.";
L["%d |4favorite:favorites; imported%s."] = "%d |4Favorit:Favoriten; importiert%s.";
L[" (overwritten)"] = " (überschrieben)";
L["Import failed - %s"] = "Import fehlgeschlagen - %s";
L["All items are already in your favorites."] = "Alle Gegenstände sind bereits in deinen Favoriten.";
L["Some specs were skipped - import string belongs to a different class."] = "Einige Spezialisierungen wurden übersprungen - der Import-String gehört zu einer anderen Klasse.";
L["Manage characters"] = "Charaktere verwalten";
L["Hidden"] = "Ausgeblendet";
L["Delete..."] = "Löschen...";
L["Delete all data for %s?"] = "Alle Daten für %s löschen?";
L["Reset..."] = "Zurücksetzen...";
L["Reset all favorites of %s?"] = "Alle Favoriten von %s zurücksetzen?";
L["Removes all favorites of the selected character."] = "Entfernt alle Favoriten des gewählten Charakters.";
L["Removes the selected character and all of its data."] = "Entfernt den gewählten Charakter und alle seine Daten.";
L["Cannot delete the currently logged in character."] = "Der aktuell eingeloggte Charakter kann nicht gelöscht werden.";
L["This character is hidden."] = "Dieser Charakter ist ausgeblendet.";
L["Wide mode"] = "Breiter Modus";
L["Drop notification (favorites)"] = "Drop-Benachrichtigung (Favoriten)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Erinnert dich beim Betreten eines Dungeons, wenn deine Beutespezialisierung nicht zu deinen Favoriten passt oder ein Wechsel die Chance erhöhen würde.";
L["If you have no favorites in a dungeon, shows you the loot spec that lets items drop for you which your group members have marked as favorites. Only works if other group members also have this addon."] = "Hast du in einem Dungeon keine Favoriten, zeigt dir das Addon die Beutespezialisierung, mit der bei dir Gegenstände droppen können, die deine Gruppenmitglieder als Favoriten markiert haben. Funktioniert nur, wenn andere Gruppenmitglieder dieses Addon ebenfalls haben.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Zeigt eine Benachrichtigung, wenn ein anderer Spieler einen Gegenstand plündert, den du als Favorit markiert hast.";
L["Mythic+ notification"] = "Mythisch+-Benachrichtigung";
L["Shows the dungeon and your role with a teleport button when you join a Mythic+ group or the group becomes full."] = "Zeigt den Dungeon und deine Rolle mit einem Teleport-Button, wenn du einer Mythisch+-Gruppe beitrittst oder die Gruppe voll wird.";
L["Whisper message..."] = "Flüsternachricht...";
L["Whisper message\n{item} will be replaced with the item link."] = "Flüsternachricht\n{item} wird durch den Gegenstandslink ersetzt.";
L["Multiple slot filtering"] = "Mehrere Slots filtern";
L["Auto Keystone response"] = "Automatische Schlüsselstein-Antwort";
L["Enable party chat"] = "Gruppenchat aktivieren";
L["Enable guild chat"] = "Gildenchat aktivieren";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "Antwortet automatisch mit deinem aktuellen Mythic+-Schlüsselstein, wenn jemand \"!keys\" in den ausgewählten Chat-Kanälen schreibt. Funktioniert nur, wenn andere Gruppenmitglieder dieses Addon ebenfalls haben.";

-- custom_item_icon.lua
L["Custom Items"] = "Individuelle Gegenstände";
L["Import items from external sources like keystoneloot.io"] = "Gegenstände aus externen Quellen wie keystoneloot.io importiert";

-- favorites.lua
L["No favorites found"] = "Keine Favoriten gefunden";
L["Invalid import string."] = "Ungültiger Import-String.";
L["No character selected."] = "Kein Charakter ausgewählt.";
L["No valid items found."] = "Keine gültigen Gegenstände gefunden.";
L["This import string requires a newer version of KeystoneLoot."] = "Dieser Import-String benötigt eine neuere Version von KeystoneLoot.";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "Favorit festlegen";
L["Nice to have"] = "Wäre schön";
L["Must have"] = "Muss haben";
L["Catalyst"] = "Katalysator";
L["Voidcore used"] = "Leerenkern benutzt";
L["+Secondary stats of the base item"] = "+Sekundärwerte des Basis-Gegenstands";
L["Tier token"] = "Tier-Token";

-- icon_button.lua
L["Head"] = "Kopf";
L["Neck"] = "Hals";
L["Shoulder"] = "Schulter";
L["Back"] = "Rücken";
L["Chest"] = "Brust";
L["Wrist"] = "Handgel.";
L["Hands"] = "Hände";
L["Waist"] = "Taille";
L["Legs"] = "Beine";
L["Feet"] = "Füße";
L["1H"] = "1H";
L["2H"] = "2H";
L["Main"] = "MH";
L["Off"] = "OH";
L["Shield"] = "Schild";
L["Ranged"] = "Fern";
L["Ring"] = "Ring";
L["Trinket"] = "Schmuck";

-- copy_popup.lua
L["Press CTRL+C to copy"] = "STRG+C zum Kopieren";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Richtige Beutespezialisierung eingestellt?";
L["+1 item dropping for all specs."] = "+1 weiterer Gegenstand, der bei allen Spezialisierungen droppt.";
L["+%d items dropping for all specs."] = "+%d weitere Gegenstände, die bei allen Spezialisierungen droppen.";
L["%s has a smaller loot pool than %s"] = "%s hat eine kleinere Beutetabelle als %s";
L["Your group needs loot from here"] = "Deine Gruppe braucht Beute von hier";
L["Wanted by %s"] = "Gewünscht von %s";

-- minimap_button.lua
L["Left click: Open overview"] = "Linksklick: Übersicht öffnen";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "Favorit gedroppt!";

-- mythicplus_notification_frame.lua
L["Mythic+ group joined!"] = "Mythisch+-Gruppe beigetreten!";
L["Group is full!"] = "Gruppe ist voll!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "Der Text kann in den Einstellungen geändert werden.";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "Bonuswürfe werden erneut gescannt...";
L["Rescan bonus rolls"] = "Bonuswürfe scannen";
L["Checking for past bonus rolls (one time)..."] = "Suche nach vergangenen Bonuswürfen (einmalig)...";
L["%d past |4bonus roll:bonus rolls; detected."] = "%d |4Bonuswurf:Bonuswürfe; erkannt.";
L["No untracked bonus rolls found."] = "Alle Bonuswürfe sind bereits erfasst.";

-- bindings.lua
L["Toggle Window"] = "Fenster ein/aus";
