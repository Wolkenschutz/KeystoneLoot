local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "ruRU") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s сезон %d)";
L["Import BIS items from %s"] = "Импортировать БиС-предметы из %s";

-- itemlevel_dropdown.lua
L["Veteran"] = "Ветеран";
L["Champion"] = "Защитник";
L["Hero"] = "Герой";

-- upgrade_tracks.lua
L["Myth"] = "Легенда";

-- catalyst_frame.lua
L["The Catalyst"] = "Катализатор";

-- settings_dropdown.lua
L["Minimap button"] = "Включить иконку на миникарте";
L["Item level in keystone tooltip"] = "Показать уровень предметов во всплывающей подсказке ключа";
L["Favorite in item tooltip"] = "Избранное в подсказке предмета";
L["Favorite on item icons"] = "Избранное на значках предметов";
L["Slot name on item icons"] = "Название слота на значках предметов";
L['Hide "Other" in All Slots'] = "Скрывать \"Прочее\" при показе всех слотов";
L["Loot reminder (dungeons)"] = "Включить напоминание о добыче";
L["Own favorites"] = "Своё избранное";
L["Group favorites"] = "Избранное группы";
L["Highlighting"] = "Подсветка";
L["No stats"] = "Характеристика отсутствует";
L["Combination mode"] = "Комбинированный режим";
L["Highlights an item only if its stats match a combination of your selection. Otherwise one matching stat is enough."] = "Подсвечивает предмет, только если его характеристики совпадают с комбинацией из вашего выбора. Иначе достаточно одной совпадающей характеристики.";
L["Export..."] = "Экспорт...";
L["Import..."] = "Импорт...";
L["Export favorites of %s"] = "Экспортировать избранное %s";
L["Import favorites for %s\nPaste import string here:"] = "Импортировать избранное для %s\nВставьте строку импорта сюда:";
L["Merge"] = "Объединить";
L["Overwrite"] = "Перезаписать";
L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."] = "При объединении сохраняются Ваши текущие избранные предметы, а добавляются только новые. При замене все они будут перезаписаны.";
L["%d |4favorite:favorites; imported%s."] = "Успешно импортировано %d |4предмет:предмета:предметов;%s.";
L[" (overwritten)"] = " (перезаписано)";
L["Import failed - %s"] = "Ошибка импорта - %s";
L["All items are already in your favorites."] = "Все предметы уже находятся в Вашем избранном.";
L["Some specs were skipped - import string belongs to a different class."] = "Некоторые специализации пропущены - строка импорта принадлежит другому классу.";
L["Manage characters"] = "Управление персонажами";
L["Hidden"] = "Скрытый";
L["Delete..."] = "Удалить...";
L["Delete all data for %s?"] = "Удалить все данные для %s?";
L["Reset..."] = "Сбросить...";
L["Reset all favorites of %s?"] = "Сбросить все избранное %s?";
L["Removes all favorites of the selected character."] = "Удаляет все избранное выбранного персонажа.";
L["Removes the selected character and all of its data."] = "Удаляет выбранного персонажа и все его данные.";
L["Cannot delete the currently logged in character."] = "Невозможно удалить персонажа, под которым выполнен вход.";
L["This character is hidden."] = "Этот персонаж скрыт.";
L["Wide mode"] = "Широкий режим";
L["Drop notification (favorites)"] = "Уведомление о выпадении (избранное)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Напоминает при входе в подземелье, если Ваша специализация добычи не соответствует избранному или смена специализации может повысить шанс получить нужные предметы.";
L["If you have no favorites in a dungeon, shows you the loot spec that lets items drop for you which your group members have marked as favorites. Only works if other group members also have this addon."] = "Если у Вас нет избранного в подземелье, показывает специализацию добычи, при которой Вам могут выпасть предметы, добавленные участниками Вашей группы в избранное. Работает только если у других участников группы тоже установлен этот аддон.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Показывает уведомление, когда другой игрок получает предмет, отмеченный Вами как избранный.";
L["Mythic+ notification"] = "Уведомление М+";
L["Shows the dungeon and your role with a teleport button when you join a Mythic+ group or the group becomes full."] = "Показывает подземелье и Вашу роль с кнопкой телепортации, когда Вы вступаете в группу М+ или группа заполняется.";
L["Whisper message..."] = "Сообщение в шёпот...";
L["Whisper message\n{item} will be replaced with the item link."] = "Сообщение в шёпот\n{item} будет заменено ссылкой на предмет.";
L["Multiple slot filtering"] = "Фильтрация нескольких слотов";
L["Auto Keystone response"] = "Автоответ с ключом";
L["Enable party chat"] = "Включить в чате группы";
L["Enable guild chat"] = "Включить в чате гильдии";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "Автоматически отправляет Ваш текущий М+ ключ, когда кто-то пишет \"!keys\" в выбранных каналах чата. Работает только если у других участников группы тоже установлен этот аддон.";

-- custom_item_icon.lua
L["Custom Items"] = "Пользовательские предметы";
L["Import items from external sources like keystoneloot.io"] = "Предметы, импортированные из внешних источников, например keystoneloot.io";

-- favorites.lua
L["No favorites found"] = "Избранное не найдено";
L["Invalid import string."] = "Неверная строка импорта.";
L["No character selected."] = "Персонаж не выбран.";
L["No valid items found."] = "Допустимые предметы не найдены.";
L["This import string requires a newer version of KeystoneLoot."] = "Эта строка импорта требует более новой версии KeystoneLoot.";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "Добавить в избранное";
L["Nice to have"] = "Желательно";
L["Must have"] = "Обязательно";
L["Best in Slot"] = "БиС";
L["Catalyst"] = "Катализатор";
L["Voidcore used"] = "Использован сердечник Бездны";
L["+Secondary stats of the base item"] = "+Вторичные характеристики базового предмета";
L["Tier token"] = "Жетон сета";

-- icon_button.lua
L["Head"] = "Голова";
L["Neck"] = "Шея";
L["Shoulder"] = "Плечи";
L["Back"] = "Спина";
L["Chest"] = "Грудь";
L["Wrist"] = "Запяст.";
L["Hands"] = "Кисти";
L["Waist"] = "Пояс";
L["Legs"] = "Ноги";
L["Feet"] = "Ступни";
L["1H"] = "1Р";
L["2H"] = "2Р";
L["Main"] = "Прав.";
L["Off"] = "Лев.";
L["Shield"] = "Щит";
L["Ranged"] = "Дальн.";
L["Ring"] = "Кольцо";
L["Trinket"] = "Аксесс.";

-- copy_popup.lua
L["Press CTRL+C to copy"] = "Нажмите CTRL+C, чтобы скопировать";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Правильная установка специализации для добычи?";
L["+1 item dropping for all specs."] = "+1 предмет выпадает для всех специализаций.";
L["+%d items dropping for all specs."] = "+%d предметов выпадает для всех специализаций.";
L["%s has a smaller loot pool than %s"] = "%s имеет меньший набор добычи, чем %s";
L["Your group needs loot from here"] = "Вашей группе нужна добыча отсюда";
L["Wanted by %s"] = "Нужно: %s";

-- minimap_button.lua
L["Left click: Open overview"] = "ЛКМ: Открыть окно KeystoneLoot";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "Избранный предмет выпал!";

-- mythicplus_notification_frame.lua
L["Mythic+ group joined!"] = "Вы вступили в группу М+!";
L["Group is full!"] = "Группа заполнена!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "Текст можно изменить в настройках.";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "Повторное сканирование бонусных бросков...";
L["Rescan bonus rolls"] = "Сканировать бонусные броски заново";
L["Checking for past bonus rolls (one time)..."] = "Поиск прошлых бонусных бросков (однократно)...";
L["%d past |4bonus roll:bonus rolls; detected."] = "Обнаружено прошлых бонусных бросков: %d.";
L["No untracked bonus rolls found."] = "Неотслеженных бонусных бросков не найдено.";

-- bindings.lua
L["Toggle Window"] = "Показать/скрыть окно";
