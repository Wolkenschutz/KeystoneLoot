local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "deDE") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s Saison %d)";

-- itemlevel_dropdown.lua
L["Veteran"] = "Veteran";
L["Champion"] = "Champion";
L["Hero"] = "Held";

-- itemlevel_dropdown.lua / keystone_tooltip.lua
L["Great Vault"] = "Große Schatzkammer";

-- catalyst_frame.lua
L["The Catalyst"] = "Der Katalysator";

-- settings_dropdown.lua
L["Minimap button"] = "Minimap-Button";
L["Item level in keystone tooltip"] = "Gegenstandsstufe im Schlüsselstein-Tooltip";
L["Favorite in item tooltip"] = "Favorit im Gegenstand-Tooltip";
L["Loot reminder (dungeons)"] = "Beute-Erinnerung (Dungeons)";
L["Highlighting"] = "Hervorhebungen";
L["No stats"] = "Keine Stats";
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

-- favorites.lua
L["No favorites found"] = "Keine Favoriten gefunden";
L["Invalid import string."] = "Ungültiger Import-String.";
L["No character selected."] = "Kein Charakter ausgewählt.";
L["No valid items found."] = "Keine gültigen Gegenstände gefunden.";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Richtige Beutespezialisierung eingestellt?";
L["+1 item dropping for all specs."] = "+1 weiterer Gegenstand, der bei allen Spezialisierungen droppt.";
L["+%d items dropping for all specs."] = "+%d weitere Gegenstände, die bei allen Spezialisierungen droppen.";

-- minimap_button.lua
L["Left click: Open overview"] = "Linksklick: Übersicht öffnen";
