local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "deDE") then
    return;
end

local L = KeystoneLoot.L;

L["Multiple slot filtering"] = "Mehrere Slots filtern";

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s Saison %d)";

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
L['Hide "Other" in All Slots'] = "\"Sonstiges\" in Alle Slots ausblenden";
L["Loot reminder (dungeons)"] = "Beute-Erinnerung (Dungeons)";
L["Highlighting"] = "Hervorhebungen";
L["No stats"] = "Keine Stats";
L["Combination mode"] = "Kombinationsmodus";
L["Export..."] = "Exportieren...";
L["Import..."] = "Importieren...";
L["Export favorites of %s"] = "Favoriten von %s exportieren";
L["Import favorites for %s\nPaste import string here:"] = "Favoriten für %s importieren\nImport-String hier einfügen:";
L["Merge"] = "Zusammenführen";
L["Overwrite"] = "Überschreiben";
L["%d |4favorite:favorites; imported%s."] = "%d |4Favorit:Favoriten; importiert%s.";
L[" (overwritten)"] = " (überschrieben)";
L["Import failed - %s"] = "Import fehlgeschlagen - %s";
L["Some specs were skipped - import string belongs to a different class."] = "Einige Spezialisierungen wurden übersprungen - der Import-String gehört zu einer anderen Klasse.";
L["Manage characters"] = "Charaktere verwalten";
L["Hidden"] = "Ausgeblendet";
L["Delete..."] = "Löschen...";
L["Delete all data for %s?"] = "Alle Daten für %s löschen?";
L["Cannot delete the currently logged in character."] = "Der aktuell eingeloggte Charakter kann nicht gelöscht werden.";
L["This character is hidden."] = "Dieser Charakter ist ausgeblendet.";
L["Wide mode"] = "Breiter Modus";
L["Drop alert (favorites)"] = "Drop-Benachrichtigung (Favoriten)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Erinnert dich beim Betreten eines Dungeons, wenn deine Beutespezialisierung nicht zu deinen Favoriten passt oder ein Wechsel die Chance erhöhen würde.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Zeigt eine Benachrichtigung, wenn ein anderer Spieler einen Gegenstand plündert, den du als Favorit markiert hast.";
L["Whisper message..."] = "Flüsternachricht...";
L["Whisper message\n{item} will be replaced with the item link."] = "Flüsternachricht\n{item} wird durch den Gegenstandslink ersetzt.";

-- favorites.lua
L["No favorites found"] = "Keine Favoriten gefunden";
L["Invalid import string."] = "Ungültiger Import-String.";
L["No character selected."] = "Kein Charakter ausgewählt.";
L["No valid items found."] = "Keine gültigen Gegenstände gefunden.";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "Favorit festlegen";
L["Nice to have"] = "Wäre schön";
L["Must have"] = "Muss haben";
L["Voidcore used"] = "Leerenkern benutzt";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Richtige Beutespezialisierung eingestellt?";
L["+1 item dropping for all specs."] = "+1 weiterer Gegenstand, der bei allen Spezialisierungen droppt.";
L["+%d items dropping for all specs."] = "+%d weitere Gegenstände, die bei allen Spezialisierungen droppen.";
L["%s has a smaller loot pool than %s"] = "%s hat eine kleinere Beutetabelle als %s";

-- minimap_button.lua
L["Left click: Open overview"] = "Linksklick: Übersicht öffnen";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "Favorit gedroppt!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "Der Text kann in den Einstellungen geändert werden.";
