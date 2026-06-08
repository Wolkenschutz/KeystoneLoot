local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "esES" and GetLocale() ~= "esMX") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s temporada %d)";
L["Import BIS items from |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r"] = "Importa objetos BIS desde |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r";

-- itemlevel_dropdown.lua
L["Veteran"] = "Veterano";
L["Champion"] = "Campeón";
L["Hero"] = "Héroe";

-- upgrade_tracks.lua
L["Myth"] = "Mito";

-- catalyst_frame.lua
L["The Catalyst"] = "El catalizador";

-- settings_dropdown.lua
L["Minimap button"] = "Botón del minimapa";
L["Item level in keystone tooltip"] = "Nivel de objeto en la descripción del sigilo";
L["Favorite in item tooltip"] = "Favorito en la descripción del objeto";
L['Hide "Other" in All Slots'] = "Ocultar \"Otro\" en Todos los espacios";
L["Loot reminder (dungeons)"] = "Recordatorio de botín (mazmorras)";
L["Highlighting"] = "Resaltar";
L["No stats"] = "Sin estadísticas";
L["Combination mode"] = "Modo combinación";
L["Export..."] = "Exportar...";
L["Import..."] = "Importar...";
L["Export favorites of %s"] = "Exportar favoritos de %s";
L["Import favorites for %s\nPaste import string here:"] = "Importar favoritos de %s\nPega la cadena de importación aquí:";
L["Merge"] = "Combinar";
L["Overwrite"] = "Sobrescribir";
L["%d |4favorite:favorites; imported%s."] = "%d |4favorito:favoritos; importado%s.";
L[" (overwritten)"] = " (sobrescrito)";
L["Import failed - %s"] = "Importación fallida - %s";
L["Some specs were skipped - import string belongs to a different class."] = "Algunas especializaciones fueron omitidas - la cadena de importación pertenece a una clase diferente.";
L["Manage characters"] = "Gestionar personajes";
L["Hidden"] = "Oculto";
L["Delete..."] = "Eliminar...";
L["Delete all data for %s?"] = "¿Eliminar todos los datos de %s?";
L["Cannot delete the currently logged in character."] = "No se puede eliminar el personaje con sesión iniciada actualmente.";
L["This character is hidden."] = "Este personaje está oculto.";
L["Wide mode"] = "Modo amplio";
L["Drop alert (favorites)"] = "Alerta de botín (favoritos)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Te recuerda al entrar a una mazmorra si tu especialización de botín no coincide con tus favoritos o si cambiarla podría aumentar tus posibilidades de obtenerlos.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Muestra una notificación cuando otro jugador saquea un objeto que has marcado como favorito.";
L["Whisper message..."] = "Mensaje susurro...";
L["Whisper message\n{item} will be replaced with the item link."] = "Mensaje susurro\n{item} será reemplazado por el enlace del objeto.";
L["Multiple slot filtering"] = "Filtrado de varios espacios";

-- custom_item_icon.lua
L["Custom Items"] = "Objetos personalizados";
L["Import items from external sources like www.keystoneloot.io"] = "Objetos importados de fuentes externas como www.keystoneloot.io";

-- favorites.lua
L["No favorites found"] = "No se encontraron favoritos";
L["Invalid import string."] = "Cadena de importación no válida.";
L["No character selected."] = "Ningún personaje seleccionado.";
L["No valid items found."] = "No se encontraron objetos válidos.";
L["This import string requires a newer version of KeystoneLoot."] = "Esta cadena de importación requiere una versión más reciente de KeystoneLoot.";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "Establecer favorito";
L["Nice to have"] = "Estaría bien tenerlo";
L["Must have"] = "Imprescindible";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "¿Especialización de botín correcta?";
L["+1 item dropping for all specs."] = "+1 objeto que cae para todas las especializaciones.";
L["+%d items dropping for all specs."] = "+%d objetos que caen para todas las especializaciones.";
L["%s has a smaller loot pool than %s"] = "%s tiene un pool de botín más pequeño que %s";

-- minimap_button.lua
L["Left click: Open overview"] = "Clic izquierdo: Abrir vista general";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "¡Favorito obtenido!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "El texto se puede modificar en los ajustes.";
