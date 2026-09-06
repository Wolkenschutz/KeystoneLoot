local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "zhTW") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s（%s 第 %d 賽季）";
L["Import BIS items from %s"] = "從 %s 匯入 BIS 物品";

-- itemlevel_dropdown.lua
L["Veteran"] = "精兵";
L["Champion"] = "勇士";
L["Hero"] = "英雄";

-- upgrade_tracks.lua
L["Myth"] = "神話";

-- catalyst_frame.lua
L["The Catalyst"] = "催化器";

-- settings_dropdown.lua
L["Minimap button"] = "小地圖按鈕";
L["Item level in keystone tooltip"] = "在傳奇鑰石顯示對應等級";
L["Favorite in item tooltip"] = "在物品提示中顯示最愛";
L["Favorite on item icons"] = "在物品圖示上顯示最愛";
L["Slot name on item icons"] = "在物品圖示上顯示部位";
L['Hide "Other" in All Slots'] = "在「所有欄位」中隱藏「其他」物品";
L["Loot reminder (dungeons)"] = "戰利品提醒（地城）";
L["Own favorites"] = "自己的最愛";
L["Group favorites"] = "隊伍最愛";
L["Highlighting"] = "高亮顯示";
L["No stats"] = "無屬性";
L["Combination mode"] = "組合模式";
L["Highlights an item only if its stats match a combination of your selection. Otherwise one matching stat is enough."] = "僅當物品的屬性與你所選屬性的組合相符時才高亮顯示。否則只需一項相符的屬性。";
L["Export..."] = "匯出...";
L["Import..."] = "匯入...";
L["Export favorites of %s"] = "匯出 %s 的最愛";
L["Import favorites for %s\nPaste import string here:"] = "匯入 %s 的最愛\n在此貼上匯入字串：";
L["Merge"] = "合併";
L["Overwrite"] = "覆蓋";
L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."] = "合併會保留你現有的最愛，只新增物品。覆蓋則會取代全部。";
L["%d |4favorite:favorites; imported%s."] = "成功匯入 %d 件物品%s。";
L[" (overwritten)"] = "（已覆蓋）";
L["Import failed - %s"] = "匯入失敗 - %s";
L["All items are already in your favorites."] = "所有物品已在你的最愛中。";
L["Some specs were skipped - import string belongs to a different class."] = "部分專精已略過 - 匯入字串屬於其他職業。";
L["Manage characters"] = "管理角色";
L["Hidden"] = "已隱藏";
L["Delete..."] = "刪除...";
L["Delete all data for %s?"] = "刪除 %s 的所有資料？";
L["Reset..."] = "重置...";
L["Reset all favorites of %s?"] = "重置 %s 的所有最愛？";
L["Removes all favorites of the selected character."] = "移除所選角色的所有最愛。";
L["Removes the selected character and all of its data."] = "移除所選角色及其所有資料。";
L["Cannot delete the currently logged in character."] = "無法刪除目前登入的角色。";
L["This character is hidden."] = "此角色已被隱藏。";
L["Wide mode"] = "寬屏模式";
L["Drop notification (favorites)"] = "掉落提醒（最愛）";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "進入地城時，若拾取專精與最愛不符或切換專精可提高獲得機率，則發出提醒。";
L["If you have no favorites in a dungeon, shows you the loot spec that lets items drop for you which your group members have marked as favorites. Only works if other group members also have this addon."] = "當你在某地城沒有最愛時，顯示可以讓隊伍成員標記為最愛的物品掉落給你的拾取專精。僅當其他隊伍成員也安裝了此插件時才有效。";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "當其他玩家拾取你標記為最愛的物品時顯示通知。";
L["Teleport notification (Mythic+)"] = "傳送通知（傳奇+）";
L["Shows the dungeon and your role with a teleport button when you join a Mythic+ group or the group becomes full."] = "當你加入傳奇+隊伍或隊伍滿員時，顯示地城和你的職責，並提供傳送按鈕。";
L["Whisper message..."] = "悄悄話訊息...";
L["Whisper message\n{item} will be replaced with the item link."] = "悄悄話訊息\n{item} 將被替換為物品連結。";
L["Multiple slot filtering"] = "多欄位篩選";
L["Auto Keystone response"] = "鑰石自動回覆";
L["Enable party chat"] = "在隊伍聊天中啟用";
L["Enable guild chat"] = "在公會聊天中啟用";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "當有人在所選聊天頻道輸入 \"!keys\" 時，自動回覆你目前的傳奇鑰石。僅當其他隊伍成員也安裝了此插件時才有效。";

-- custom_item_icon.lua
L["Custom Items"] = "自訂物品";
L["Import items from external sources like keystoneloot.io"] = "從 keystoneloot.io 等外部來源匯入的物品";

-- favorites.lua
L["No favorites found"] = "未找到最愛";
L["Invalid import string."] = "無效的匯入字串。";
L["No character selected."] = "未選擇角色。";
L["No valid items found."] = "未找到有效物品。";
L["This import string requires a newer version of KeystoneLoot."] = "此匯入字串需要更新版本的 KeystoneLoot。";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "設定最愛";
L["Nice to have"] = "有更好";
L["Must have"] = "必須取得";
L["Best in Slot"] = "最佳裝備";
L["Catalyst"] = "催化器";
L["+Secondary stats of the base item"] = "+基礎物品的副屬性";
L["Tier token"] = "套裝標記";

-- icon_button.lua
L["Head"] = "頭";
L["Neck"] = "項鍊";
L["Shoulder"] = "肩";
L["Back"] = "披風";
L["Chest"] = "胸";
L["Wrist"] = "腕";
L["Hands"] = "手";
L["Waist"] = "腰";
L["Legs"] = "腿";
L["Feet"] = "腳";
L["1H"] = "單手";
L["2H"] = "雙手";
L["Main"] = "主手";
L["Off"] = "副手";
L["Shield"] = "盾牌";
L["Ranged"] = "遠程";
L["Ring"] = "戒指";
L["Trinket"] = "飾品";

-- copy_popup.lua
L["Press CTRL+C to copy"] = "按 CTRL+C 複製";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "戰利品專精的設定是否正確？";
L["+1 item dropping for all specs."] = "+1 件物品對所有專精掉落。";
L["+%d items dropping for all specs."] = "+%d 件物品對所有專精掉落。";
L["%s has a smaller loot pool than %s"] = "%s的戰利品池比%s更小。";
L["Your group needs loot from here"] = "你的隊伍需要這裡的戰利品";
L["Wanted by %s"] = "%s想要";

-- minimap_button.lua
L["Left click: Open overview"] = "左鍵點擊：開啟概覽";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "最愛物品已掉落！";

-- mythicplus_notification_frame.lua
L["Mythic+ group joined!"] = "已加入傳奇+隊伍！";
L["Group is full!"] = "隊伍已滿員！";

-- whisper_button.lua
L["Text can be modified in the settings."] = "可在設定中修改文字。";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "正在重新掃描額外擲骰...";
L["Rescan bonus rolls"] = "重新掃描額外擲骰";
L["Checking for past bonus rolls (one time)..."] = "正在檢查過去的額外擲骰（單次）...";
L["%d past |4bonus roll:bonus rolls; detected."] = "偵測到 %d 次過去的額外擲骰。";
L["No untracked bonus rolls found."] = "未發現未記錄的額外擲骰。";

-- bindings.lua
L["Toggle Window"] = "開啟/關閉視窗";
