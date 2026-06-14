local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "frFR") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s Saison %d)";
L["Import BIS items from |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r"] = "Importez des objets BIS depuis |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r";

-- itemlevel_dropdown.lua
L["Veteran"] = "Vétéran";
L["Champion"] = "Champion";
L["Hero"] = "Héros";

-- upgrade_tracks.lua
L["Myth"] = "Mythe";

-- catalyst_frame.lua
L["The Catalyst"] = "Le catalyseur";

-- settings_dropdown.lua
L["Minimap button"] = "Bouton de la mini-carte";
L["Item level in keystone tooltip"] = "Niveau d'objet dans l'infobulle de la clé";
L["Favorite in item tooltip"] = "Favori dans l'infobulle de l'objet";
L['Hide "Other" in All Slots'] = "Masquer « Autre » dans Tous les emplacements";
L["Loot reminder (dungeons)"] = "Rappel de butin (donjons)";
L["Highlighting"] = "Surlignage";
L["No stats"] = "Aucune statistique";
L["Combination mode"] = "Mode combinaison";
L["Export..."] = "Exporter...";
L["Import..."] = "Importer...";
L["Export favorites of %s"] = "Exporter les favoris de %s";
L["Import favorites for %s\nPaste import string here:"] = "Importer les favoris de %s\nCollez la chaîne d'importation ici :";
L["Merge"] = "Fusionner";
L["Overwrite"] = "Écraser";
L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."] = "Fusionner conserve vos favoris existants et n'ajoute que les nouveaux objets. Écraser les remplace tous.";
L["%d |4favorite:favorites; imported%s."] = "%d |4favori:favoris; importé%s.";
L[" (overwritten)"] = " (écrasé)";
L["Import failed - %s"] = "Échec de l'importation - %s";
L["All items are already in your favorites."] = "Tous les objets sont déjà dans vos favoris.";
L["Some specs were skipped - import string belongs to a different class."] = "Certaines spécialisations ont été ignorées - la chaîne d'importation appartient à une autre classe.";
L["Manage characters"] = "Gérer les personnages";
L["Hidden"] = "Masqué";
L["Delete..."] = "Supprimer...";
L["Delete all data for %s?"] = "Supprimer toutes les données de %s ?";
L["Cannot delete the currently logged in character."] = "Impossible de supprimer le personnage actuellement connecté.";
L["This character is hidden."] = "Ce personnage est masqué.";
L["Wide mode"] = "Mode large";
L["Drop alert (favorites)"] = "Alerte de butin (favoris)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Vous rappelle à l'entrée d'un donjon si votre spécialisation de butin ne correspond pas à vos favoris ou si en changer pourrait augmenter vos chances de les obtenir.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Affiche une notification lorsqu'un autre joueur récupère un objet que vous avez marqué comme favori.";
L["Whisper message..."] = "Message chuchoté...";
L["Whisper message\n{item} will be replaced with the item link."] = "Message chuchoté\n{item} sera remplacé par le lien de l'objet.";
L["Multiple slot filtering"] = "Filtrage de plusieurs emplacements";
L["Auto Keystone response"] = "Réponse automatique de clé";
L["Enable party chat"] = "Activer le canal de groupe";
L["Enable guild chat"] = "Activer le canal de guilde";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "Répond automatiquement avec votre clé Mythique+ actuelle lorsqu'un joueur tape « !keys » dans les canaux de discussion sélectionnés. Fonctionne uniquement si les autres membres du groupe ont aussi cet addon.";

-- custom_item_icon.lua
L["Custom Items"] = "Objets personnalisés";
L["Import items from external sources like www.keystoneloot.io"] = "Objets importés depuis des sources externes comme www.keystoneloot.io";

-- favorites.lua
L["No favorites found"] = "Aucun favori trouvé";
L["Invalid import string."] = "Chaîne d'importation non valide.";
L["No character selected."] = "Aucun personnage sélectionné.";
L["No valid items found."] = "Aucun objet valide trouvé.";
L["This import string requires a newer version of KeystoneLoot."] = "Cette chaîne d'importation nécessite une version plus récente de KeystoneLoot.";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "Définir le favori";
L["Nice to have"] = "Serait utile";
L["Must have"] = "Indispensable";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Spécialisation de butin correcte définie ?";
L["+1 item dropping for all specs."] = "+1 objet qui tombe pour toutes les spécialisations.";
L["+%d items dropping for all specs."] = "+%d objets qui tombent pour toutes les spécialisations.";
L["%s has a smaller loot pool than %s"] = "%s a un pool de butin plus petit que %s";

-- minimap_button.lua
L["Left click: Open overview"] = "Clic gauche : Ouvrir l'aperçu";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "Favori obtenu !";

-- whisper_button.lua
L["Text can be modified in the settings."] = "Le texte peut être modifié dans les paramètres.";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "Nouvelle analyse des jets bonus...";
L["Rescan bonus rolls"] = "Rescanner les jets bonus";
L["Checking for past bonus rolls (one time)..."] = "Recherche d'anciens jets bonus (unique)...";
L["%d past |4bonus roll:bonus rolls; detected."] = "%d |4ancien jet bonus détecté:anciens jets bonus détectés;.";
L["No untracked bonus rolls found."] = "Aucun jet bonus non suivi trouvé.";
