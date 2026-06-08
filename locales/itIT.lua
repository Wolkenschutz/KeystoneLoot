local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "itIT") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s Stagione %d)";
L["Import BIS items from |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r"] = "Importa oggetti BIS da |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r";

-- itemlevel_dropdown.lua
L["Veteran"] = "Veterano";
L["Champion"] = "Campione";
L["Hero"] = "Eroe";

-- upgrade_tracks.lua
L["Myth"] = "Mito";

-- catalyst_frame.lua
L["The Catalyst"] = "Catalizzatore";

-- settings_dropdown.lua
L["Minimap button"] = "Pulsante minimappa";
L["Item level in keystone tooltip"] = "Livello oggetto nel tooltip della chiave";
L["Favorite in item tooltip"] = "Preferito nel tooltip dell'oggetto";
L['Hide "Other" in All Slots'] = "Nascondi \"Altro\" in Tutti gli slot";
L["Loot reminder (dungeons)"] = "Promemoria bottino (sotterranei)";
L["Highlighting"] = "Evidenzia";
L["No stats"] = "Nessuna statistica";
L["Combination mode"] = "Modalità combinazione";
L["Export..."] = "Esporta...";
L["Import..."] = "Importa...";
L["Export favorites of %s"] = "Esporta preferiti di %s";
L["Import favorites for %s\nPaste import string here:"] = "Importa preferiti di %s\nIncolla qui la stringa di importazione:";
L["Merge"] = "Unisci";
L["Overwrite"] = "Sovrascrivi";
L["%d |4favorite:favorites; imported%s."] = "%d |4preferito:preferiti; importato%s.";
L[" (overwritten)"] = " (sovrascritto)";
L["Import failed - %s"] = "Importazione fallita - %s";
L["Some specs were skipped - import string belongs to a different class."] = "Alcune specializzazioni sono state saltate - la stringa di importazione appartiene a una classe diversa.";
L["Manage characters"] = "Gestisci personaggi";
L["Hidden"] = "Nascosto";
L["Delete..."] = "Elimina...";
L["Delete all data for %s?"] = "Eliminare tutti i dati per %s?";
L["Cannot delete the currently logged in character."] = "Impossibile eliminare il personaggio attualmente connesso.";
L["This character is hidden."] = "Questo personaggio è nascosto.";
L["Wide mode"] = "Modalità estesa";
L["Drop alert (favorites)"] = "Avviso drop (preferiti)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Ti ricorda all'ingresso del sotterraneo se la tua specializzazione bottino non corrisponde ai preferiti o se cambiarla potrebbe aumentare le probabilità di ottenerli.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Mostra una notifica quando un altro giocatore ottiene un oggetto che hai contrassegnato come preferito.";
L["Whisper message..."] = "Messaggio sussurro...";
L["Whisper message\n{item} will be replaced with the item link."] = "Messaggio sussurro\n{item} verrà sostituito con il link dell'oggetto.";
L["Multiple slot filtering"] = "Filtro slot multipli";

-- custom_item_icon.lua
L["Custom Items"] = "Oggetti personalizzati";
L["Import items from external sources like www.keystoneloot.io"] = "Oggetti importati da fonti esterne come www.keystoneloot.io";

-- favorites.lua
L["No favorites found"] = "Nessun preferito trovato";
L["Invalid import string."] = "Stringa di importazione non valida.";
L["No character selected."] = "Nessun personaggio selezionato.";
L["No valid items found."] = "Nessun oggetto valido trovato.";
L["This import string requires a newer version of KeystoneLoot."] = "Questa stringa di importazione richiede una versione più recente di KeystoneLoot.";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "Imposta preferito";
L["Nice to have"] = "Utile averlo";
L["Must have"] = "Indispensabile";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Specializzazione bottino corretta?";
L["+1 item dropping for all specs."] = "+1 oggetto che cade per tutte le specializzazioni.";
L["+%d items dropping for all specs."] = "+%d oggetti che cadono per tutte le specializzazioni.";
L["%s has a smaller loot pool than %s"] = "%s ha un pool di bottino più piccolo di %s";

-- minimap_button.lua
L["Left click: Open overview"] = "Clic sinistro: Apri panoramica";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "Preferito droppato!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "Il testo può essere modificato nelle impostazioni.";
