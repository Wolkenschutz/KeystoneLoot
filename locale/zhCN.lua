if (GetLocale() ~= 'zhCN') then
    return;
end

local AddonName, Addon = ...;
local Translate = Addon.Translate;


Translate['Left click: Open overview'] = '左键点击：打开概览';
Translate['Right click: Open settings'] = '右键点击：打开设置';
Translate['Enable Minimap Button'] = '启用小地图按钮';
Translate['Enable Loot Reminder'] = '启用拾取提醒';
--Translate['Favorites Show All Specializations'] = '';
Translate['%s (%s Season %d)'] = '%s（%s 第 %d 赛季）';
Translate['Veteran'] = '老兵';
Translate['Champion'] = '勇士';
Translate['Hero'] = '英雄';
Translate['Great Vault'] = RATED_PVP_WEEKLY_VAULT;
Translate['Revival Catalyst'] = '复苏化生台';
Translate['Correct loot specialization set?'] = '设置正确的战利品专精吗？';