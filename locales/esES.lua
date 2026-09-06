local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "esES" and GetLocale() ~= "esMX") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s temporada %d)";
L["Import BIS items from %s"] = "Importa objetos BIS desde %s";

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
L["Favorite on item icons"] = "Favorito en los iconos de objeto";
L["Slot name on item icons"] = "Nombre del espacio en los iconos de objeto";
L['Hide "Other" in All Slots'] = "Ocultar \"Otro\" en Todos los espacios";
L["Loot reminder (dungeons)"] = "Recordatorio de botín (mazmorras)";
L["Own favorites"] = "Favoritos propios";
L["Group favorites"] = "Favoritos del grupo";
L["Highlighting"] = "Resaltar";
L["No stats"] = "Sin estadísticas";
L["Combination mode"] = "Modo combinación";
L["Highlights an item only if its stats match a combination of your selection. Otherwise one matching stat is enough."] = "Resalta un objeto solo si sus estadísticas coinciden con una combinación de tu selección. De lo contrario, basta con una estadística coincidente.";
L["Export..."] = "Exportar...";
L["Import..."] = "Importar...";
L["Export favorites of %s"] = "Exportar favoritos de %s";
L["Import favorites for %s\nPaste import string here:"] = "Importar favoritos de %s\nPega la cadena de importación aquí:";
L["Merge"] = "Combinar";
L["Overwrite"] = "Sobrescribir";
L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."] = "Combinar mantiene tus favoritos actuales y solo añade objetos nuevos. Sobrescribir los reemplaza todos.";
L["%d |4favorite:favorites; imported%s."] = "%d |4favorito:favoritos; importado%s.";
L[" (overwritten)"] = " (sobrescrito)";
L["Import failed - %s"] = "Importación fallida - %s";
L["All items are already in your favorites."] = "Todos los objetos ya están en tus favoritos.";
L["Some specs were skipped - import string belongs to a different class."] = "Algunas especializaciones fueron omitidas - la cadena de importación pertenece a una clase diferente.";
L["Manage characters"] = "Gestionar personajes";
L["Hidden"] = "Oculto";
L["Delete..."] = "Eliminar...";
L["Delete all data for %s?"] = "¿Eliminar todos los datos de %s?";
L["Reset..."] = "Restablecer...";
L["Reset all favorites of %s?"] = "¿Restablecer todos los favoritos de %s?";
L["Removes all favorites of the selected character."] = "Elimina todos los favoritos del personaje seleccionado.";
L["Removes the selected character and all of its data."] = "Elimina el personaje seleccionado y todos sus datos.";
L["Cannot delete the currently logged in character."] = "No se puede eliminar el personaje con sesión iniciada actualmente.";
L["This character is hidden."] = "Este personaje está oculto.";
L["Wide mode"] = "Modo amplio";
L["Drop notification (favorites)"] = "Alerta de botín (favoritos)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Te recuerda al entrar a una mazmorra si tu especialización de botín no coincide con tus favoritos o si cambiarla podría aumentar tus posibilidades de obtenerlos.";
L["If you have no favorites in a dungeon, shows you the loot spec that lets items drop for you which your group members have marked as favorites. Only works if other group members also have this addon."] = "Si no tienes favoritos en una mazmorra, te muestra la especialización de botín con la que pueden caerte objetos que los miembros de tu grupo han marcado como favoritos. Solo funciona si otros miembros del grupo también tienen este addon.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Muestra una notificación cuando otro jugador saquea un objeto que has marcado como favorito.";
L["Teleport notification (Mythic+)"] = "Notificación de teletransporte (Mítica+)";
L["Shows the dungeon and your role with a teleport button when you join a Mythic+ group or the group becomes full."] = "Muestra la mazmorra y tu rol con un botón de teletransporte cuando te unes a un grupo de Mítica+ o el grupo se completa.";
L["Whisper message..."] = "Mensaje susurro...";
L["Whisper message\n{item} will be replaced with the item link."] = "Mensaje susurro\n{item} será reemplazado por el enlace del objeto.";
L["Multiple slot filtering"] = "Filtrado de varios espacios";
L["Auto Keystone response"] = "Respuesta automática de sigilo";
L["Enable party chat"] = "Activar chat de grupo";
L["Enable guild chat"] = "Activar chat de hermandad";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "Responde automáticamente con tu sigilo de Mítica+ actual cuando alguien escribe \"!keys\" en los canales de chat seleccionados. Solo funciona si otros miembros del grupo también tienen este addon.";

-- custom_item_icon.lua
L["Custom Items"] = "Objetos personalizados";
L["Import items from external sources like keystoneloot.io"] = "Objetos importados de fuentes externas como keystoneloot.io";

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
L["Catalyst"] = "Catalizador";
L["+Secondary stats of the base item"] = "+Estadísticas secundarias del objeto base";
L["Tier token"] = "Ficha de tier";

-- icon_button.lua
L["Head"] = "Cabeza";
L["Neck"] = "Cuello";
L["Shoulder"] = "Hombros";
L["Back"] = "Espalda";
L["Chest"] = "Pecho";
L["Wrist"] = "Muñecas";
L["Hands"] = "Manos";
L["Waist"] = "Cintura";
L["Legs"] = "Piernas";
L["Feet"] = "Pies";
L["1H"] = "1M";
L["2H"] = "2M";
L["Main"] = "Princ.";
L["Off"] = "Secund.";
L["Shield"] = "Escudo";
L["Ranged"] = "Dist.";
L["Ring"] = "Anillo";
L["Trinket"] = "Abalorio";

-- copy_popup.lua
L["Press CTRL+C to copy"] = "Pulsa CTRL+C para copiar";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "¿Especialización de botín correcta?";
L["+1 item dropping for all specs."] = "+1 objeto que cae para todas las especializaciones.";
L["+%d items dropping for all specs."] = "+%d objetos que caen para todas las especializaciones.";
L["%s has a smaller loot pool than %s"] = "%s tiene un pool de botín más pequeño que %s";
L["Your group needs loot from here"] = "Tu grupo necesita botín de aquí";
L["Wanted by %s"] = "Deseado por %s";

-- minimap_button.lua
L["Left click: Open overview"] = "Clic izquierdo: Abrir vista general";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "¡Favorito obtenido!";

-- mythicplus_notification_frame.lua
L["Mythic+ group joined!"] = "¡Te has unido a un grupo de Mítica+!";
L["Group is full!"] = "¡Grupo completo!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "El texto se puede modificar en los ajustes.";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "Volviendo a escanear tiradas bonificadas...";
L["Rescan bonus rolls"] = "Volver a escanear tiradas bonificadas";
L["Checking for past bonus rolls (one time)..."] = "Buscando tiradas bonificadas anteriores (una vez)...";
L["%d past |4bonus roll:bonus rolls; detected."] = "%d |4tirada bonificada anterior detectada:tiradas bonificadas anteriores detectadas;.";
L["No untracked bonus rolls found."] = "No se encontraron tiradas bonificadas sin registrar.";

-- bindings.lua
L["Toggle Window"] = "Mostrar/ocultar ventana";
