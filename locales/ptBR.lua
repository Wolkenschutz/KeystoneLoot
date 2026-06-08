local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "ptBR") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s Série %d)";
L["Import BIS items from |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r"] = "Importe itens BIS de |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r";

-- itemlevel_dropdown.lua
L["Veteran"] = "Veterano";
L["Champion"] = "Campeão";
L["Hero"] = "Herói";

-- upgrade_tracks.lua
L["Myth"] = "Mito";

-- catalyst_frame.lua
L["The Catalyst"] = "O Catalisador";

-- settings_dropdown.lua
L["Minimap button"] = "Botão do minimapa";
L["Item level in keystone tooltip"] = "Nível do item na dica da chave";
L["Favorite in item tooltip"] = "Favorito na dica do item";
L['Hide "Other" in All Slots'] = "Ocultar \"Outro\" em Todos os espaços";
L["Loot reminder (dungeons)"] = "Lembrete de saque (masmorras)";
L["Highlighting"] = "Destaques";
L["No stats"] = "Sem atributos";
L["Combination mode"] = "Modo combinação";
L["Export..."] = "Exportar...";
L["Import..."] = "Importar...";
L["Export favorites of %s"] = "Exportar favoritos de %s";
L["Import favorites for %s\nPaste import string here:"] = "Importar favoritos de %s\nCole a string de importação aqui:";
L["Merge"] = "Mesclar";
L["Overwrite"] = "Substituir";
L["%d |4favorite:favorites; imported%s."] = "%d |4favorito:favoritos; importado%s.";
L[" (overwritten)"] = " (substituído)";
L["Import failed - %s"] = "Falha na importação - %s";
L["Some specs were skipped - import string belongs to a different class."] = "Algumas especializações foram ignoradas - a string de importação pertence a outra classe.";
L["Manage characters"] = "Gerenciar personagens";
L["Hidden"] = "Oculto";
L["Delete..."] = "Excluir...";
L["Delete all data for %s?"] = "Excluir todos os dados de %s?";
L["Cannot delete the currently logged in character."] = "Não é possível excluir o personagem atualmente conectado.";
L["This character is hidden."] = "Este personagem está oculto.";
L["Wide mode"] = "Modo largo";
L["Drop alert (favorites)"] = "Alerta de saque (favoritos)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Lembra você ao entrar numa masmorra se sua especialização de saque não corresponde aos favoritos ou se trocá-la poderia aumentar suas chances de obtê-los.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Exibe uma notificação quando outro jogador saqueia um item que você marcou como favorito.";
L["Whisper message..."] = "Mensagem sussurro...";
L["Whisper message\n{item} will be replaced with the item link."] = "Mensagem sussurro\n{item} será substituído pelo link do item.";
L["Multiple slot filtering"] = "Filtro de varios espacos";

-- custom_item_icon.lua
L["Custom Items"] = "Itens personalizados";
L["Import items from external sources like www.keystoneloot.io"] = "Itens importados de fontes externas como www.keystoneloot.io";

-- favorites.lua
L["No favorites found"] = "Nenhum favorito encontrado";
L["Invalid import string."] = "String de importação inválida.";
L["No character selected."] = "Nenhum personagem selecionado.";
L["No valid items found."] = "Nenhum item válido encontrado.";
L["This import string requires a newer version of KeystoneLoot."] = "Esta string de importação requer uma versão mais recente do KeystoneLoot.";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "Definir favorito";
L["Nice to have"] = "Seria bom ter";
L["Must have"] = "Essencial";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Especialização de saque correta configurada?";
L["+1 item dropping for all specs."] = "+1 item caindo para todas as especializações.";
L["+%d items dropping for all specs."] = "+%d itens caindo para todas as especializações.";
L["%s has a smaller loot pool than %s"] = "%s tem um pool de saque menor que %s";

-- minimap_button.lua
L["Left click: Open overview"] = "Clique esquerdo: Abrir visão geral";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "Favorito obtido!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "O texto pode ser modificado nas configurações.";
