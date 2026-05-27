local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "zhCN") then
    return;
end

local L = KeystoneLoot.L;

L["Multiple slot filtering"] = "Multiple slot filtering";

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s（%s 第 %d 赛季）";

-- itemlevel_dropdown.lua
L["Veteran"] = "老兵";
L["Champion"] = "勇士";
L["Hero"] = "英雄";

-- upgrade_tracks.lua
L["Myth"] = "神话";

-- catalyst_frame.lua
L["The Catalyst"] = "化生台";

-- settings_dropdown.lua
L["Minimap button"] = "小地图按钮";
L["Item level in keystone tooltip"] = "在史诗钥匙显示对应等级";
L["Favorite in item tooltip"] = "在物品提示中显示收藏";
L['Hide "Other" in All Slots'] = "在「全部栏位」中隐藏「其他」物品";
L["Loot reminder (dungeons)"] = "拾取专精提醒（地下城）";
L["Highlighting"] = "高亮显示";
L["No stats"] = "无属性";
L["Combination mode"] = "组合模式";
L["Export..."] = "导出...";
L["Import..."] = "导入...";
L["Export favorites of %s"] = "导出 %s 的收藏夹";
L["Import favorites for %s\nPaste import string here:"] = "导入 %s 的收藏夹\n在此粘贴导入字符串：";
L["Merge"] = "合并";
L["Overwrite"] = "覆盖";
L["%d |4favorite:favorites; imported%s."] = "成功导入 %d 件物品%s。";
L[" (overwritten)"] = "（已覆盖）";
L["Import failed - %s"] = "导入失败 - %s";
L["Some specs were skipped - import string belongs to a different class."] = "部分专精已跳过 - 导入字符串属于其他职业。";
L["Manage characters"] = "管理角色";
L["Hidden"] = "已隐藏";
L["Delete..."] = "删除...";
L["Delete all data for %s?"] = "删除 %s 的所有数据？";
L["Cannot delete the currently logged in character."] = "无法删除当前登录的角色。";
L["This character is hidden."] = "该角色已被隐藏。";
L["Wide mode"] = "宽屏模式";
L["Drop alert (favorites)"] = "掉落提醒（收藏）";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "进入地下城时，若拾取专精与收藏夹不符或切换专精可提高获得概率，则发出提醒。";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "当其他玩家拾取你标记为收藏的物品时显示通知。";
L["Whisper message..."] = "悄悄话消息...";
L["Whisper message\n{item} will be replaced with the item link."] = "悄悄话消息\n{item} 将被替换为物品链接。";

-- favorites.lua
L["No favorites found"] = "未找到收藏";
L["Invalid import string."] = "导入字符串无效。";
L["No character selected."] = "未选择角色。";
L["No valid items found."] = "未找到有效物品。";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "设置收藏";
L["Nice to have"] = "锦上添花";
L["Must have"] = "必须获取";
L["Best in Slot"] = "最佳装备";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "拾取专精是否正确？";
L["+1 item dropping for all specs."] = "+1 件物品对所有专精掉落。";
L["+%d items dropping for all specs."] = "+%d 件物品对所有专精掉落。";
L["%s has a smaller loot pool than %s"] = "%s的战利品池比%s更小。";

-- minimap_button.lua
L["Left click: Open overview"] = "左键点击：打开概览";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "收藏物品已掉落！";

-- whisper_button.lua
L["Text can be modified in the settings."] = "可在设置中修改文本。";
