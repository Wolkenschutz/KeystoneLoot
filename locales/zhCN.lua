local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "zhCN") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s（%s 第 %d 赛季）";
L["Import BIS items from %s"] = "从 %s 导入 BIS 物品";

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
L["Favorite on item icons"] = "在物品图标上显示收藏";
L["Slot name on item icons"] = "在物品图标上显示部位";
L["Owned in item tooltip"] = "在物品提示中显示拥有情况";
L["Shows in the item tooltip where the item is: equipped, bags or bank."] = "在物品提示中显示该物品的位置：已装备、背包或银行。";
L["Already shown by another addon."] = "已由其他插件显示。";
L['Hide "Other" in All Slots'] = "在「全部栏位」中隐藏「其他」物品";
L["Loot reminder (dungeons)"] = "拾取专精提醒（地下城）";
L["Own favorites"] = "自己的收藏";
L["Group favorites"] = "队伍收藏";
L["Share favorites with group"] = "与队伍共享收藏";
L["Highlighting"] = "高亮显示";
L["No stats"] = "无属性";
L["Combination mode"] = "组合模式";
L["Highlights an item only if its stats match a combination of your selection. Otherwise one matching stat is enough."] = "仅当物品的属性与你所选属性的组合相符时才高亮显示。否则只需一项相符的属性。";
L["Export..."] = "导出...";
L["Import..."] = "导入...";
L["Export favorites of %s"] = "导出 %s 的收藏夹";
L["Import favorites for %s\nPaste import string here:"] = "导入 %s 的收藏夹\n在此粘贴导入字符串：";
L["Merge"] = "合并";
L["Overwrite"] = "覆盖";
L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."] = "合并会保留你现有的收藏，只添加新物品。覆盖则会替换全部。";
L["%d |4favorite:favorites; imported%s."] = "成功导入 %d 件物品%s。";
L[" (overwritten)"] = "（已覆盖）";
L["Import failed - %s"] = "导入失败 - %s";
L["All items are already in your favorites."] = "所有物品已在你的收藏中。";
L["Some specs were skipped - import string belongs to a different class."] = "部分专精已跳过 - 导入字符串属于其他职业。";
L["Manage characters"] = "管理角色";
L["Hidden"] = "已隐藏";
L["Delete..."] = "删除...";
L["Delete all data for %s?"] = "删除 %s 的所有数据？";
L["Reset..."] = "重置...";
L["Reset all favorites of %s?"] = "重置 %s 的所有收藏夹？";
L["Removes all favorites of the selected character."] = "移除所选角色的所有收藏。";
L["Removes the selected character and all of its data."] = "移除所选角色及其所有数据。";
L["Cannot delete the currently logged in character."] = "无法删除当前登录的角色。";
L["This character is hidden."] = "该角色已被隐藏。";
L["Wide mode"] = "宽屏模式";
L["Drop notification (favorites)"] = "掉落提醒（收藏）";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "进入地下城时，若拾取专精与收藏夹不符或切换专精可提高获得概率，则发出提醒。";
L["If you have no favorites in a dungeon, shows you the loot spec that lets items drop for you which your group members have marked as favorites. Only works if other group members also have this addon."] = "当你在某地下城没有收藏时，显示可以让队伍成员收藏的物品掉落给你的拾取专精。仅当其他队伍成员也安装了此插件时才有效。";
L["Shares your favorites with your group members so they can choose their loot spec in a way that lets your favorites drop for them."] = "与队伍成员共享你的收藏，让他们可以选择能让你的收藏物品掉落给他们的拾取专精。";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "当其他玩家拾取你标记为收藏的物品时显示通知。";
L["Teleport notification (Mythic+)"] = "传送通知（史诗+）";
L["Shows the dungeon and your role with a teleport button when you join a Mythic+ group or the group becomes full."] = "当你加入史诗+队伍或队伍满员时，显示地下城和你的职责，并提供传送按钮。";
L["Whisper message..."] = "悄悄话消息...";
L["Whisper message\n{item} will be replaced with the item link."] = "悄悄话消息\n{item} 将被替换为物品链接。";
L["Multiple slot filtering"] = "多栏位筛选";
L["Auto Keystone response"] = "钥石自动回复";
L["Enable party chat"] = "在小队聊天中启用";
L["Enable guild chat"] = "在公会聊天中启用";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "当有人在所选聊天频道输入 \"!keys\" 时，自动回复你当前的史诗钥石。仅当其他队伍成员也安装了此插件时才有效。";

-- custom_item_icon.lua
L["Custom Items"] = "自定义物品";
L["Import items from external sources like keystoneloot.io"] = "从 keystoneloot.io 等外部来源导入的物品";

-- favorites.lua
L["No favorites found"] = "未找到收藏";
L["Invalid import string."] = "导入字符串无效。";
L["No character selected."] = "未选择角色。";
L["No valid items found."] = "未找到有效物品。";
L["This import string requires a newer version of KeystoneLoot."] = "此导入字符串需要更新版本的 KeystoneLoot。";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "设置收藏";
L["Nice to have"] = "锦上添花";
L["Must have"] = "必须获取";
L["Best in Slot"] = "最佳装备";
L["Catalyst"] = "化生台";
L["+Secondary stats of the base item"] = "+基础物品的副属性";
L["Tier token"] = "套装标记";

-- icon_button.lua
L["Head"] = "头";
L["Neck"] = "项链";
L["Shoulder"] = "肩";
L["Back"] = "披风";
L["Chest"] = "胸";
L["Wrist"] = "腕";
L["Hands"] = "手";
L["Waist"] = "腰";
L["Legs"] = "腿";
L["Feet"] = "脚";
L["1H"] = "单手";
L["2H"] = "双手";
L["Main"] = "主手";
L["Off"] = "副手";
L["Shield"] = "盾牌";
L["Ranged"] = "远程";
L["Ring"] = "戒指";
L["Trinket"] = "饰品";

-- owned.lua
L["Already equipped"] = "已装备";
L["In your bags"] = "在背包中";
L["In your bank"] = "在银行中";

-- copy_popup.lua
L["Press CTRL+C to copy"] = "按 CTRL+C 复制";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "拾取专精是否正确？";
L["+1 item dropping for all specs."] = "+1 件物品对所有专精掉落。";
L["+%d items dropping for all specs."] = "+%d 件物品对所有专精掉落。";
L["%s has a smaller loot pool than %s"] = "%s的战利品池比%s更小。";
L["Your group needs loot from here"] = "你的队伍需要这里的战利品";
L["Wanted by %s"] = "%s想要";

-- minimap_button.lua
L["Left click: Open overview"] = "左键点击：打开概览";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "收藏物品已掉落！";

-- mythicplus_notification_frame.lua
L["Mythic+ group joined!"] = "已加入史诗+队伍！";
L["Group is full!"] = "队伍已满员！";

-- whisper_button.lua
L["Text can be modified in the settings."] = "可在设置中修改文本。";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "正在重新扫描额外拾取...";
L["Rescan bonus rolls"] = "重新扫描额外拾取";
L["Checking for past bonus rolls (one time)..."] = "正在检查过去的额外拾取（一次性）...";
L["%d past |4bonus roll:bonus rolls; detected."] = "检测到 %d 次过去的额外拾取。";
L["No untracked bonus rolls found."] = "未发现未记录的额外拾取。";

-- bindings.lua
L["Toggle Window"] = "打开/关闭窗口";
