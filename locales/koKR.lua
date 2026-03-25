local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "koKR") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s 시즌 %d)";

-- itemlevel_dropdown.lua
L["Veteran"] = "노련가";
L["Champion"] = "챔피언";
L["Hero"] = "영웅";

-- upgrade_tracks.lua
L["Myth"] = "신화";

-- catalyst_frame.lua
L["The Catalyst"] = "촉매";

-- settings_dropdown.lua
L["Minimap button"] = "미니맵 버튼";
L["Item level in keystone tooltip"] = "쐐기돌 툴팁에 장비 수준 표시";
L["Favorite in item tooltip"] = "아이템 툴팁에 즐겨찾기 표시";
L["Loot reminder (dungeons)"] = "전리품 리마인더 (던전)";
L["Highlighting"] = "강조";
L["No stats"] = "능력치 없음";
L["Export..."] = "내보내기...";
L["Import..."] = "가져오기...";
L["Export favorites of %s"] = "%s의 즐겨찾기 내보내기";
L["Import favorites for %s\nPaste import string here:"] = "%s의 즐겨찾기 가져오기\n가져오기 문자열을 여기에 붙여넣으세요:";
L["Merge"] = "합치기";
L["Overwrite"] = "덮어쓰기";
L["%d |4favorite:favorites; imported%s."] = "즐겨찾기 %d개 가져옴%s.";
L[" (overwritten)"] = " (덮어씀)";
L["Import failed - %s"] = "가져오기 실패 - %s";
L["Some specs were skipped - import string belongs to a different class."] = "일부 전문화를 건너뜀 - 가져오기 문자열이 다른 직업에 속함.";

-- favorites.lua
L["No favorites found"] = "즐겨찾기 없음";
L["Invalid import string."] = "유효하지 않은 가져오기 문자열.";
L["No character selected."] = "캐릭터가 선택되지 않았습니다.";
L["No valid items found."] = "유효한 아이템을 찾을 수 없습니다.";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "올바른 전리품 전문화 설정?";
L["+1 item dropping for all specs."] = "+1 모든 전문화에 드롭되는 아이템.";
L["+%d items dropping for all specs."] = "+%d 모든 전문화에 드롭되는 아이템.";

-- minimap_button.lua
L["Left click: Open overview"] = "왼쪽 클릭: 개요 열기";
