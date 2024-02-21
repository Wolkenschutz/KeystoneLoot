if (GetLocale() ~= 'zhTW') then
    return;
end

local AddonName, Addon = ...;
local Translate = Addon.Translate;


Translate['Left click: Open overview'] = '左鍵點擊：開啟概覽';
Translate['Right click: Open settings'] = '右鍵點擊：開啟設定';
Translate['Enable Minimap Button'] = '啟用小地圖按鈕';
Translate['Enable Loot Reminder'] = '啟用戰利品提醒';
--Translate['Favorites Show All Specializations'] = '';
Translate['%s (%s Season %d)'] = '%s（%s 第 %d 賽季）';
Translate['Veteran'] = '老兵';
Translate['Champion'] = '勇士';
Translate['Hero'] = '英雄';
Translate['Great Vault'] = RATED_PVP_WEEKLY_VAULT;
Translate['Revival Catalyst'] = '复苏化生台';
Translate['Correct loot specialization set?'] = '設置正確的戰利品專精嗎？';