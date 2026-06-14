local AddonName, KeystoneLoot = ...;

if (GetLocale() ~= "koKR") then
    return;
end

local L = KeystoneLoot.L;

-- keystoneloot_frame.lua
L["%s (%s Season %d)"] = "%s (%s 시즌 %d)";
L["Import BIS items from |cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r"] = "|cnACCOUNT_WIDE_FONT_COLOR:www.keystoneloot.io|r에서 BIS 아이템 가져오기";

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
L['Hide "Other" in All Slots'] = "전체 슬롯에서 \"기타\" 숨기기";
L["Loot reminder (dungeons)"] = "전리품 리마인더 (던전)";
L["Highlighting"] = "강조";
L["No stats"] = "능력치 없음";
L["Combination mode"] = "조합 모드";
L["Export..."] = "내보내기...";
L["Import..."] = "가져오기...";
L["Export favorites of %s"] = "%s의 즐겨찾기 내보내기";
L["Import favorites for %s\nPaste import string here:"] = "%s의 즐겨찾기 가져오기\n가져오기 문자열을 여기에 붙여넣으세요:";
L["Merge"] = "합치기";
L["Overwrite"] = "덮어쓰기";
L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."] = "합치기는 기존 즐겨찾기를 유지하고 새 아이템만 추가합니다. 덮어쓰기는 전부 교체합니다.";
L["%d |4favorite:favorites; imported%s."] = "즐겨찾기 %d개 가져옴%s.";
L[" (overwritten)"] = " (덮어씀)";
L["Import failed - %s"] = "가져오기 실패 - %s";
L["All items are already in your favorites."] = "모든 아이템이 이미 즐겨찾기에 있습니다.";
L["Some specs were skipped - import string belongs to a different class."] = "일부 전문화를 건너뜀 - 가져오기 문자열이 다른 직업에 속함.";
L["Manage characters"] = "캐릭터 관리";
L["Hidden"] = "숨김";
L["Delete..."] = "삭제...";
L["Delete all data for %s?"] = "%s의 모든 데이터를 삭제하시겠습니까?";
L["Cannot delete the currently logged in character."] = "현재 로그인한 캐릭터는 삭제할 수 없습니다.";
L["This character is hidden."] = "이 캐릭터는 숨겨져 있습니다.";
L["Wide mode"] = "넓은 모드";
L["Drop alert (favorites)"] = "드롭 알림 (즐겨찾기)";
L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."] = "던전 입장 시 전리품 전문화가 즐겨찾기와 맞지 않거나 변경 시 획득 확률이 높아질 경우 알려줍니다.";
L["Shows a notification when another player loots an item you have marked as a favorite."] = "다른 플레이어가 즐겨찾기로 표시한 아이템을 획득하면 알림을 표시합니다.";
L["Whisper message..."] = "귓속말 메시지...";
L["Whisper message\n{item} will be replaced with the item link."] = "귓속말 메시지\n{item}은(는) 아이템 링크로 대체됩니다.";
--L["Multiple slot filtering"] = "";
L["Auto Keystone response"] = "쐐기돌 자동 응답";
L["Enable party chat"] = "파티 채팅에서 활성화";
L["Enable guild chat"] = "길드 채팅에서 활성화";
L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."] = "누군가 선택한 채팅 채널에서 \"!keys\"를 입력하면 현재 신화+ 쐐기돌로 자동 응답합니다. 다른 그룹원도 이 애드온을 설치한 경우에만 작동합니다.";

-- custom_item_icon.lua
L["Custom Items"] = "커스텀 아이템";
L["Import items from external sources like www.keystoneloot.io"] = "www.keystoneloot.io 같은 외부 사이트에서 가져온 아이템";

-- favorites.lua
L["No favorites found"] = "즐겨찾기 없음";
L["Invalid import string."] = "유효하지 않은 가져오기 문자열.";
L["No character selected."] = "캐릭터가 선택되지 않았습니다.";
L["No valid items found."] = "유효한 아이템을 찾을 수 없습니다.";
L["This import string requires a newer version of KeystoneLoot."] = "이 가져오기 문자열에는 더 최신 버전의 KeystoneLoot이(가) 필요합니다.";

-- icon_button.lua / favorites.lua
L["Set Favorite"] = "즐겨찾기 설정";
L["Nice to have"] = "있으면 좋음";
L["Must have"] = "필수";
L["Best in Slot"] = "최고 장비";

-- loot_reminder_frame.lua
L["Correct loot specialization set?"] = "올바른 전리품 전문화 설정?";
L["+1 item dropping for all specs."] = "+1 모든 전문화에 드롭되는 아이템.";
L["+%d items dropping for all specs."] = "+%d 모든 전문화에 드롭되는 아이템.";
L["%s has a smaller loot pool than %s"] = "%s은(는) %s보다 전리품 풀이 더 작습니다.";

-- minimap_button.lua
L["Left click: Open overview"] = "왼쪽 클릭: 개요 열기";

-- drop_notification_frame.lua
L["Favorite dropped!"] = "즐겨찾기 아이템 드롭!";

-- whisper_button.lua
L["Text can be modified in the settings."] = "텍스트는 설정에서 수정할 수 있습니다.";

-- voidcore.lua
L["Rescanning for bonus rolls..."] = "보너스 주사위를 다시 검사하는 중...";
L["Rescan bonus rolls"] = "보너스 주사위 다시 검사";
L["Checking for past bonus rolls (one time)..."] = "지난 보너스 주사위 확인 중 (최초 1회)...";
L["%d past |4bonus roll:bonus rolls; detected."] = "지난 보너스 주사위 %d개를 감지했습니다.";
L["No untracked bonus rolls found."] = "추적되지 않은 보너스 주사위가 없습니다.";
