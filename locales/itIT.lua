local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "itIT") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s Stagione %d)";
L["Import BIS items from %s"] = "Importa oggetti BIS da %s";

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
L["Favorite on item icons"] = "Preferito sulle icone degli oggetti";
L["Slot name on item icons"] = "Nome dello slot sulle icone degli oggetti";
L["Owned in item tooltip"] = "Posseduto nel tooltip dell'oggetto";
L["Shows in the item tooltip where the item is: equipped, bags or bank."] = "Mostra nel tooltip dell'oggetto dove si trova: equipaggiato, inventario o banca.";
L["Already shown by another addon."] = "Già mostrato da un altro addon.";
L['Hide "Other" in All Slots'] = "Nascondi \"Altro\" in Tutti gli slot";
L["Loot reminder (dungeons)"] = "Promemoria bottino (sotterranei)";
L["Own favorites"] = "Preferiti propri";
L["Group favorites"] = "Preferiti del gruppo";
L["Share favorites with group"] = "Condividi i preferiti con il gruppo";
L["Highlighting"] = "Evidenzia";
L["No stats"] = "Nessuna statistica";
L["Combination mode"] = "Modalità combinazione";
L["Highlights an item only if its stats match a combination of your selection. Otherwise one matching stat is enough."] = "Evidenzia un oggetto solo se le sue statistiche corrispondono a una combinazione della tua selezione. Altrimenti basta una statistica corrispondente.";
L["Export..."] = "Esporta...";
L["Import..."] = "Importa...";
L["Export favorites of %s"] = "Esporta preferiti di %s";
L["Import favorites for %s\nPaste import string here:"] = "Importa preferiti di %s\nIncolla qui la stringa di importazione:";
L["Merge"] = "Unisci";
L["Overwrite"] = "Sovrascrivi";
L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."] = "Unisci mantiene i tuoi preferiti esistenti e aggiunge solo nuovi oggetti. Sovrascrivi li sostituisce tutti.";
L["%d |4favorite:favorites; imported%s."] = "%d |4preferito:preferiti; importato%s.";
L[" (overwritten)"] = " (sovrascritto)";
L["Import failed - %s"] = "Importazione fallita - %s";
L["All items are already in your favorites."] = "Tutti gli oggetti sono già nei tuoi preferiti.";
L["Some specs were skipped - import string belongs to a different class."] = "Alcune specializzazioni sono state saltate - la stringa di importazione appartiene a una classe diversa.";
L["Manage characters"] = "Gestisci personaggi";
L["Hidden"] = "Nascosto";
L["Delete..."] = "Elimina...";
L["Delete all data for %s?"] = "Eliminare tutti i dati per %s?";
L["Reset..."] = "Reimposta...";
L["Reset all favorites of %s?"] = "Reimpostare tutti i preferiti di %s?";
L["Removes all favorites of the selected character."] = "Rimuove tutti i preferiti del personaggio selezionato.";
L["Removes the selected character and all of its data."] = "Rimuove il personaggio selezionato e tutti i suoi dati.";
L["Cannot delete the currently logged in character."] = "Impossibile eliminare il personaggio attualmente connesso.";
L["This character is hidden."] = "Questo personaggio è nascosto.";
L["Wide mode"] = "Modalità estesa";
L["Drop notification (favorites)"] = "Avviso drop (preferiti)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Ti ricorda all'ingresso del sotterraneo se la tua specializzazione bottino non corrisponde ai preferiti o se cambiarla potrebbe aumentare le probabilità di ottenerli.";
L["If you have no favorites in a dungeon, shows you the loot spec that lets items drop for you which your group members have marked as favorites. Only works if other group members also have this addon."] = "Se non hai preferiti in un sotterraneo, ti mostra la specializzazione bottino con cui possono caderti oggetti che i membri del tuo gruppo hanno segnato come preferiti. Funziona solo se anche gli altri membri del gruppo hanno questo addon.";
L["Shares your favorites with your group members so they can choose their loot spec in a way that lets your favorites drop for them."] = "Condivide i tuoi preferiti con i membri del tuo gruppo così possono scegliere la loro specializzazione bottino in modo che i tuoi preferiti cadano a loro.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Mostra una notifica quando un altro giocatore ottiene un oggetto che hai contrassegnato come preferito.";
L["Teleport notification (Mythic+)"] = "Notifica di teletrasporto (Mitica+)";
L["Shows the dungeon and your role with a teleport button when you join a Mythic+ group or the group becomes full."] = "Mostra il sotterraneo e il tuo ruolo con un pulsante di teletrasporto quando entri in un gruppo Mitica+ o il gruppo si completa.";
L["Whisper message..."] = "Messaggio sussurro...";
L["Whisper message\n{item} will be replaced with the item link."] = "Messaggio sussurro\n{item} verrà sostituito con il link dell'oggetto.";
L["Multiple slot filtering"] = "Filtro slot multipli";
L["Auto Keystone response"] = "Risposta automatica chiave";
L["Enable party chat"] = "Attiva chat del gruppo";
L["Enable guild chat"] = "Attiva chat di gilda";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "Risponde automaticamente con la tua chiave Mitica+ attuale quando qualcuno scrive \"!keys\" nei canali chat selezionati. Funziona solo se anche gli altri membri del gruppo hanno questo addon.";

-- custom_item_icon.lua
L["Custom Items"] = "Oggetti personalizzati";
L["Import items from external sources like keystoneloot.io"] = "Oggetti importati da fonti esterne come keystoneloot.io";

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
L["Catalyst"] = "Catalizzatore";
L["+Secondary stats of the base item"] = "+Statistiche secondarie dell'oggetto base";
L["Tier token"] = "Gettone tier";

-- icon_button.lua
L["Head"] = "Testa";
L["Neck"] = "Collo";
L["Shoulder"] = "Spalle";
L["Back"] = "Schiena";
L["Chest"] = "Petto";
L["Wrist"] = "Polsi";
L["Hands"] = "Mani";
L["Waist"] = "Vita";
L["Legs"] = "Gambe";
L["Feet"] = "Piedi";
L["1H"] = "1M";
L["2H"] = "2M";
L["Main"] = "Princ.";
L["Off"] = "Second.";
L["Shield"] = "Scudo";
L["Ranged"] = "Dist.";
L["Ring"] = "Anello";
L["Trinket"] = "Monile";

-- owned.lua
L["Already equipped"] = "Già equipaggiato";
L["In your bags"] = "Nel tuo inventario";
L["In your bank"] = "Nella tua banca";

-- copy_popup.lua
L["Press CTRL+C to copy"] = "Premi CTRL+C per copiare";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Specializzazione bottino corretta?";
L["+1 item dropping for all specs."] = "+1 oggetto che cade per tutte le specializzazioni.";
L["+%d items dropping for all specs."] = "+%d oggetti che cadono per tutte le specializzazioni.";
L["%s has a smaller loot pool than %s"] = "%s ha un pool di bottino più piccolo di %s";
L["Your group needs loot from here"] = "Il tuo gruppo ha bisogno di bottino da qui";
L["Wanted by %s"] = "Desiderato da %s";

-- minimap_button.lua
L["Left click: Open overview"] = "Clic sinistro: Apri panoramica";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "Preferito droppato!";

-- mythicplus_notification_frame.lua
L["Mythic+ group joined!"] = "Entrato in un gruppo Mitica+!";
L["Group is full!"] = "Gruppo al completo!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "Il testo può essere modificato nelle impostazioni.";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "Nuova scansione dei tiri bonus...";
L["Rescan bonus rolls"] = "Riscansiona i tiri bonus";
L["Checking for past bonus rolls (one time)..."] = "Ricerca di tiri bonus passati (una volta)...";
L["%d past |4bonus roll:bonus rolls; detected."] = "%d |4tiro bonus passato rilevato:tiri bonus passati rilevati;.";
L["No untracked bonus rolls found."] = "Nessun tiro bonus non tracciato trovato.";

-- bindings.lua
L["Toggle Window"] = "Finestra";
