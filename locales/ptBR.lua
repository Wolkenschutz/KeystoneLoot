local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "ptBR") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s Série %d)";
L["Import BIS items from %s"] = "Importe itens BIS de %s";

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
L["Favorite on item icons"] = "Favorito nos ícones de itens";
L["Slot name on item icons"] = "Nome do espaço nos ícones de itens";
L["Owned in item tooltip"] = "Posse na dica do item";
L["Shows in the item tooltip where the item is: equipped, bags or bank."] = "Mostra na dica do item onde ele se encontra: equipado, mochila ou banco.";
L["Already shown by another addon."] = "Já exibido por outro addon.";
L['Hide "Other" in All Slots'] = "Ocultar \"Outro\" em Todos os espaços";
L["Loot reminder (dungeons)"] = "Lembrete de saque (masmorras)";
L["Own favorites"] = "Favoritos próprios";
L["Group favorites"] = "Favoritos do grupo";
L["Share favorites with group"] = "Compartilhar favoritos com o grupo";
L["Highlighting"] = "Destaques";
L["No stats"] = "Sem atributos";
L["Combination mode"] = "Modo combinação";
L["Highlights an item only if its stats match a combination of your selection. Otherwise one matching stat is enough."] = "Destaca um item apenas se seus atributos corresponderem a uma combinação da sua seleção. Caso contrário, um atributo correspondente é suficiente.";
L["Export..."] = "Exportar...";
L["Import..."] = "Importar...";
L["Export favorites of %s"] = "Exportar favoritos de %s";
L["Import favorites for %s\nPaste import string here:"] = "Importar favoritos de %s\nCole a string de importação aqui:";
L["Merge"] = "Mesclar";
L["Overwrite"] = "Substituir";
L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."] = "Mesclar mantém seus favoritos atuais e adiciona apenas itens novos. Substituir troca todos eles.";
L["%d |4favorite:favorites; imported%s."] = "%d |4favorito:favoritos; importado%s.";
L[" (overwritten)"] = " (substituído)";
L["Import failed - %s"] = "Falha na importação - %s";
L["All items are already in your favorites."] = "Todos os itens já estão nos seus favoritos.";
L["Some specs were skipped - import string belongs to a different class."] = "Algumas especializações foram ignoradas - a string de importação pertence a outra classe.";
L["Manage characters"] = "Gerenciar personagens";
L["Hidden"] = "Oculto";
L["Delete..."] = "Excluir...";
L["Delete all data for %s?"] = "Excluir todos os dados de %s?";
L["Reset..."] = "Redefinir...";
L["Reset all favorites of %s?"] = "Redefinir todos os favoritos de %s?";
L["Removes all favorites of the selected character."] = "Remove todos os favoritos do personagem selecionado.";
L["Removes the selected character and all of its data."] = "Remove o personagem selecionado e todos os seus dados.";
L["Cannot delete the currently logged in character."] = "Não é possível excluir o personagem atualmente conectado.";
L["This character is hidden."] = "Este personagem está oculto.";
L["Wide mode"] = "Modo largo";
L["Drop notification (favorites)"] = "Alerta de saque (favoritos)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Lembra você ao entrar numa masmorra se sua especialização de saque não corresponde aos favoritos ou se trocá-la poderia aumentar suas chances de obtê-los.";
L["If you have no favorites in a dungeon, shows you the loot spec that lets items drop for you which your group members have marked as favorites. Only works if other group members also have this addon."] = "Se você não tiver favoritos numa masmorra, mostra a especialização de saque com a qual podem cair para você itens que os membros do seu grupo marcaram como favoritos. Funciona apenas se outros membros do grupo também tiverem este addon.";
L["Shares your favorites with your group members so they can choose their loot spec in a way that lets your favorites drop for them."] = "Compartilha seus favoritos com os membros do seu grupo para que eles possam escolher a especialização de saque de forma que seus favoritos caiam para eles.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Exibe uma notificação quando outro jogador saqueia um item que você marcou como favorito.";
L["Teleport notification (Mythic+)"] = "Notificação de teletransporte (Mítica+)";
L["Shows the dungeon and your role with a teleport button when you join a Mythic+ group or the group becomes full."] = "Mostra a masmorra e sua função com um botão de teletransporte quando você entra em um grupo Mítica+ ou o grupo fica completo.";
L["Whisper message..."] = "Mensagem sussurro...";
L["Whisper message\n{item} will be replaced with the item link."] = "Mensagem sussurro\n{item} será substituído pelo link do item.";
L["Multiple slot filtering"] = "Filtro de varios espacos";
L["Auto Keystone response"] = "Resposta automática de chave";
L["Enable party chat"] = "Ativar chat do grupo";
L["Enable guild chat"] = "Ativar chat de guilda";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "Responde automaticamente com sua chave Mítica+ atual quando alguém digita \"!keys\" nos canais de chat selecionados. Funciona apenas se outros membros do grupo também tiverem este addon.";

-- custom_item_icon.lua
L["Custom Items"] = "Itens personalizados";
L["Import items from external sources like keystoneloot.io"] = "Itens importados de fontes externas como keystoneloot.io";

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
L["Catalyst"] = "Catalisador";
L["+Secondary stats of the base item"] = "+Atributos secundários do item base";
L["Tier token"] = "Ficha de tier";

-- icon_button.lua
L["Head"] = "Cabeça";
L["Neck"] = "Pescoço";
L["Shoulder"] = "Ombros";
L["Back"] = "Costas";
L["Chest"] = "Peito";
L["Wrist"] = "Pulsos";
L["Hands"] = "Mãos";
L["Waist"] = "Cintura";
L["Legs"] = "Pernas";
L["Feet"] = "Pés";
L["1H"] = "1M";
L["2H"] = "2M";
L["Main"] = "Princ.";
L["Off"] = "Secund.";
L["Shield"] = "Escudo";
L["Ranged"] = "Dist.";
L["Ring"] = "Anel";
L["Trinket"] = "Berloque";

-- owned.lua
L["Already equipped"] = "Já equipado";
L["In your bags"] = "Na sua mochila";
L["In your bank"] = "No seu banco";

-- copy_popup.lua
L["Press CTRL+C to copy"] = "Pressione CTRL+C para copiar";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Especialização de saque correta configurada?";
L["+1 item dropping for all specs."] = "+1 item caindo para todas as especializações.";
L["+%d items dropping for all specs."] = "+%d itens caindo para todas as especializações.";
L["%s has a smaller loot pool than %s"] = "%s tem um pool de saque menor que %s";
L["Your group needs loot from here"] = "Seu grupo precisa de saque daqui";
L["Wanted by %s"] = "Desejado por %s";

-- minimap_button.lua
L["Left click: Open overview"] = "Clique esquerdo: Abrir visão geral";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "Favorito obtido!";

-- mythicplus_notification_frame.lua
L["Mythic+ group joined!"] = "Você entrou em um grupo Mítica+!";
L["Group is full!"] = "Grupo completo!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "O texto pode ser modificado nas configurações.";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "Reescaneando rolagens bônus...";
L["Rescan bonus rolls"] = "Reescanear rolagens bônus";
L["Checking for past bonus rolls (one time)..."] = "Procurando rolagens bônus anteriores (uma vez)...";
L["%d past |4bonus roll:bonus rolls; detected."] = "%d |4rolagem bônus anterior detectada:rolagens bônus anteriores detectadas;.";
L["No untracked bonus rolls found."] = "Nenhuma rolagem bônus não rastreada encontrada.";

-- bindings.lua
L["Toggle Window"] = "Mostrar/Ocultar janela";
