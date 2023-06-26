local AddonName, Addon = ...;


local clientLocale = GetLocale();
local translation = {};


if (clientLocale == 'deDE') then
	translation = {
		['Left click: Open overview'] = 'Linksklick: Übersicht öffnen',
		['Right click: Open settings'] = 'Rechtsklick: Einstellungen öffnen',
		['Enable Minimap Button'] = 'Minimap-Button aktivieren',
		['%s (%s Season %d)'] = '%s (%s Saison %d)'
	};
elseif (clientLocale == 'esES' or clientLocale == 'esMX') then
	translation = {
		['Left click: Open overview'] = 'Clic izquierdo: Abrir vista general',
		['Right click: Open settings'] = 'Clic derecho: Abrir configuraciones',
		['Enable Minimap Button'] = 'Activar botón del minimapa',
		['%s (%s Season %d)'] = '%s (%s temporada %d)'
	};
elseif (clientLocale == 'frFR') then
	translation = {
		['Left click: Open overview'] = 'Clic gauche : Ouvrir l\'aperçu',
		['Right click: Open settings'] = 'RClic droit : Ouvrir les paramètres',
		['Enable Minimap Button'] = 'Activer le bouton de la mini-carte',
		['%s (%s Season %d)'] = '%s (%s Saison %d)'
	};
elseif (clientLocale == 'itIT') then
	translation = {
		['Left click: Open overview'] = 'Clic sinistro: Apri panoramica',
		['Right click: Open settings'] = 'Clic destro: Apri impostazioni',
		['Enable Minimap Button'] = 'Abilita pulsante della minimappa',
		['%s (%s Season %d)'] = '%s (%s Stagione %d)'
	};
elseif (clientLocale == 'ptBR') then
	translation = {
		['Left click: Open overview'] = 'Clique esquerdo: Abrir visão geral',
		['Right click: Open settings'] = 'Clique direito: Abrir configurações',
		['Enable Minimap Button'] = 'Ativar botão do minimapa',
		['%s (%s Season %d)'] = '%s (%s Série %d)'
	};
elseif (clientLocale == 'ruRU') then
	translation = {
		['Left click: Open overview'] = 'Левый клик: Открыть обзор',
		['Right click: Open settings'] = 'Правый клик: Открыть настройки',
		['Enable Minimap Button'] = 'Включить кнопку миникарты',
		['%s (%s Season %d)'] = '%s (%s сезон %d)'
	};
elseif (clientLocale == 'koKR') then
	translation = {
		['Left click: Open overview'] = '왼쪽 클릭: 개요 열기',
		['Right click: Open settings'] = '오른쪽 클릭: 설정 열기',
		['Enable Minimap Button'] = '미니맵 버튼 활성화',
		['%s (%s Season %d)'] = '%s (%s 시즌 %d)'
	};
elseif (clientLocale == 'zhCN') then
	translation = {
		['Left click: Open overview'] = '左键点击：打开概览',
		['Right click: Open settings'] = '右键点击：打开设置',
		['Enable Minimap Button'] = '启用小地图按钮',
		['%s (%s Season %d)'] = '%s（%s 赛季 %d）'
	};
elseif (clientLocale == 'zhTW') then
	translation = {
		['Left click: Open overview'] = '左鍵點擊：開啟概覽',
		['Right click: Open settings'] = '右鍵點擊：開啟設定',
		['Enable Minimap Button'] = '啟用小地圖按鈕',
		['%s (%s Season %d)'] = '%s(%s季%d)'
	};
end


Addon.API.Translate = setmetatable(translation, {
	__index = function (t, key)
		rawset(t, key, key);
		return key;
	end
});
