local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "ruRU") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s сезон %d)";
L["Import BIS items from |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r"] = "Импортируйте БиС-предметы с |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r";

-- itemlevel_dropdown.lua
L["Veteran"] = "Ветеран";
L["Champion"] = "Защитник";
L["Hero"] = "Герой";

-- upgrade_tracks.lua
L["Myth"] = "Легенда";

-- catalyst_frame.lua
L["The Catalyst"] = "Катализатор";

-- settings_dropdown.lua
L["Minimap button"] = "Включить кнопку на миникарте";
L["Item level in keystone tooltip"] = "Показать уровень предметов во всплывающей подсказке ключа";
L["Favorite in item tooltip"] = "Избранное в подсказке предмета";
L['Hide "Other" in All Slots'] = "Скрывать \"Прочее\" при показе всех слотов";
L["Loot reminder (dungeons)"] = "Включить напоминание о добыче";
L["Highlighting"] = "Подсветка";
L["No stats"] = "Характеристика отсутствует";
L["Combination mode"] = "Комбинированный режим";
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
L["Cannot delete the currently logged in character."] = "Невозможно удалить персонажа, под которым выполнен вход.";
L["This character is hidden."] = "Этот персонаж скрыт.";
L["Wide mode"] = "Широкий режим";
L["Drop alert (favorites)"] = "Уведомление о дропе (избранное)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "Напоминает при входе в подземелье, если Ваша специализация добычи не соответствует избранному или смена специализации может повысить шанс получить нужные предметы.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "Показывает уведомление, когда другой игрок получает предмет, отмеченный Вами как избранный.";
L["Whisper message..."] = "Сообщение в шёпот...";
L["Whisper message\n{item} will be replaced with the item link."] = "Сообщение в шёпот\n{item} будет заменено ссылкой на предмет.";
L["Multiple slot filtering"] = "Фильтрация нескольких слотов";
L["Auto Keystone response"] = "Автоответ с ключом";
L["Enable party chat"] = "Включить в чате группы";
L["Enable guild chat"] = "Включить в чате гильдии";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "Автоматически отправляет ваш текущий ключ Эпохального+, когда кто-то пишет \"!keys\" в выбранных каналах чата. Работает только если у других участников группы тоже установлен этот аддон.";

-- custom_item_icon.lua
L["Custom Items"] = "Пользовательские предметы";
L["Import items from external sources like www.keystoneloot.io"] = "Предметы, импортированные из внешних источников, например www.keystoneloot.io";

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
L["Voidcore used"] = "Использован сердечник Бездны";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "Правильная установка специализации для добычи?";
L["+1 item dropping for all specs."] = "+1 предмет выпадает для всех специализаций.";
L["+%d items dropping for all specs."] = "+%d предметов выпадает для всех специализаций.";
L["%s has a smaller loot pool than %s"] = "%s имеет меньший набор добычи, чем %s";

-- minimap_button.lua
L["Left click: Open overview"] = "ЛКМ: Открыть окно KeystoneLoot";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "Избранный предмет выпал!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "Текст можно изменить в настройках.";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "Повторное сканирование бонусных бросков...";
L["Rescan bonus rolls"] = "Сканировать бонусные броски заново";
L["Checking for past bonus rolls (one time)..."] = "Поиск прошлых бонусных бросков (однократно)...";
L["%d past |4bonus roll:bonus rolls; detected."] = "Обнаружено прошлых бонусных бросков: %d.";
L["No untracked bonus rolls found."] = "Неотслеженных бонусных бросков не найдено.";
