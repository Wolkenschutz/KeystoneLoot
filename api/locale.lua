local AddonName, Addon = ...;
Addon.API = {};


local clientLocale = GetLocale();
local translation = {};


if (clientLocale == 'deDE') then
	translation = {
		['Left click: Open overview'] = 'Linksklick: Übersicht öffnen',
		['Right click: Open settings'] = 'Rechtsklick: Einstellungen öffnen',
		['Enable Minimap Button'] = 'Minimap-Button aktivieren',
		['%s (%s Season %d)'] = '%s (%s Saison %d)',
		['Veteran'] = 'Veteran',
		['Champion'] = 'Champion',
		['Hero'] = 'Held',
		['Great Vault'] = 'Große Schatzkammer',
		['Revival Catalyst'] = 'Belebungskatalysator',
		['Dämmerung des Ewigen: Galakronds Sturz'] = 'Galakronds Sturz',
		['Dämmerung des Ewigen: Murozonds Erhebung'] = 'Murozonds Erhebung'
	};
elseif (clientLocale == 'esES' or clientLocale == 'esMX') then
	translation = {
		['Left click: Open overview'] = 'Clic izquierdo: Abrir vista general',
		['Right click: Open settings'] = 'Clic derecho: Abrir configuraciones',
		['Enable Minimap Button'] = 'Activar botón del minimapa',
		['%s (%s Season %d)'] = '%s (%s temporada %d)',
		['Veteran'] = 'Veterano',
		['Champion'] = 'Campeón',
		['Hero'] = 'Héroe',
		['Great Vault'] = RATED_PVP_WEEKLY_VAULT,
		['Revival Catalyst'] = 'Catalizador de reanimación',
		['El Alba del Infinito: Caída de Galakrond'] = 'Caída de Galakrond',
		['El Alba del Infinito: El Ascenso de Murozond'] = 'Ascenso de Murozond'
	};
elseif (clientLocale == 'frFR') then
	translation = {
		['Left click: Open overview'] = 'Clic gauche : Ouvrir l\'aperçu',
		['Right click: Open settings'] = 'RClic droit : Ouvrir les paramètres',
		['Enable Minimap Button'] = 'Activer le bouton de la mini-carte',
		['%s (%s Season %d)'] = '%s (%s Saison %d)',
		['Veteran'] = 'Vétéran',
		['Champion'] = 'Champion',
		['Hero'] = 'Héros',
		['Great Vault'] = RATED_PVP_WEEKLY_VAULT,
		['Revival Catalyst'] = 'Catalyseur de renouveau',
		['Aube de l’Infini : Repos de Galakrond'] = 'Repos de Galakrond',
		['Aube de l’Infini : cime de Murozond'] = 'cime de Murozond'
	};
elseif (clientLocale == 'itIT') then
	translation = {
		['Left click: Open overview'] = 'Clic sinistro: Apri panoramica',
		['Right click: Open settings'] = 'Clic destro: Apri impostazioni',
		['Enable Minimap Button'] = 'Abilita pulsante della minimappa',
		['%s (%s Season %d)'] = '%s (%s Stagione %d)',
		['Veteran'] = 'Veterano',
		['Champion'] = 'Campione',
		['Hero'] = 'Eroe',
		['Great Vault'] = RATED_PVP_WEEKLY_VAULT,
		['Revival Catalyst'] = 'Catalizzatore del Ripristino',
		['Alba degli Infiniti: Caduta di Galakrond'] = 'Caduta di Galakrond',
		['Alba degli Infiniti: Ascesa di Murozond'] = 'Ascesa di Murozond'
	};
elseif (clientLocale == 'ptBR') then
	translation = {
		['Left click: Open overview'] = 'Clique esquerdo: Abrir visão geral',
		['Right click: Open settings'] = 'Clique direito: Abrir configurações',
		['Enable Minimap Button'] = 'Ativar botão do minimapa',
		['%s (%s Season %d)'] = '%s (%s Série %d)',
		['Veteran'] = 'Veterano',
		['Champion'] = 'Campeão',
		['Hero'] = 'Herói',
		['Great Vault'] = RATED_PVP_WEEKLY_VAULT,
		['Revival Catalyst'] = 'Catalisador de Revivescência',
		['Despertar do Infinito: Ruína de Galakrond'] = 'Ruína de Galakrond',
		['Despertar do Infinito: Ascensão de Murozond'] = 'Ascensão de Murozond'
	};
elseif (clientLocale == 'ruRU') then
	translation = {
		['Left click: Open overview'] = 'ЛКМ: Открыть окно KeystoneLoot',
		['Right click: Open settings'] = 'ПКМ: Открыть настройки',
		['Enable Minimap Button'] = 'Включить кнопку миникарты',
		['%s (%s Season %d)'] = '%s (%s сезон %d)',
		['Veteran'] = 'Ветеран',
		['Champion'] = 'Защитник',
		['Hero'] = 'Герой',
		['Great Vault'] = RATED_PVP_WEEKLY_VAULT,
		['Revival Catalyst'] = 'Катализатор возрождения',
		['Made with LOVE in Germany'] = 'Keystone Loot © 2024',
		['Рассвет Бесконечности: падение Галакронда'] = 'Падение Галакронда',
		['Рассвет Бесконечности: подъем Дорнозму'] = 'Подъем Дорнозму'
	};
elseif (clientLocale == 'koKR') then
	translation = {
		['Left click: Open overview'] = '왼쪽 클릭: 개요 열기',
		['Right click: Open settings'] = '오른쪽 클릭: 설정 열기',
		['Enable Minimap Button'] = '미니맵 버튼 활성화',
		['%s (%s Season %d)'] = '%s (%s 시즌 %d)',
		['Veteran'] = '노련가',
		['Champion'] = '챔피언',
		['Hero'] = '영웅',
		['Great Vault'] = RATED_PVP_WEEKLY_VAULT,
		['Revival Catalyst'] = '소생의 촉매'
	};
elseif (clientLocale == 'zhCN') then
	translation = {
		['Left click: Open overview'] = '左键点击：打开概览',
		['Right click: Open settings'] = '右键点击：打开设置',
		['Enable Minimap Button'] = '启用小地图按钮',
		['%s (%s Season %d)'] = '%s（%s 第 %d 赛季）',
		['Veteran'] = '老兵',
		['Champion'] = '勇士',
		['Hero'] = '英雄',
		['Great Vault'] = RATED_PVP_WEEKLY_VAULT,
		['Revival Catalyst'] = '复苏化生台'
	};
elseif (clientLocale == 'zhTW') then
	translation = {
		['Left click: Open overview'] = '左鍵點擊：開啟概覽',
		['Right click: Open settings'] = '右鍵點擊：開啟設定',
		['Enable Minimap Button'] = '啟用小地圖按鈕',
		['%s (%s Season %d)'] = '%s（%s 第 %d 賽季）',
		['Veteran'] = '老兵',
		['Champion'] = '勇士',
		['Hero'] = '英雄',
		['Great Vault'] = RATED_PVP_WEEKLY_VAULT,
		['Revival Catalyst'] = '复苏化生台'
	};
else
	translation = {
		['Dawn of the Infinite: Galakrond\'s Fall'] = 'Galakrond\'s Fall',
		['Dawn of the Infinite: Murozond\'s Rise'] = 'Murozond\'s Rise'
	};
end


Addon.API.Translate = setmetatable(translation, {
	__index = function (t, key)
		rawset(t, key, key);
		return key;
	end
});
