--[[
	@author Selina Ruesch <selina.ruesch@gmail.com>
	@license http://creativecommons.org/licenses/by-nc-sa/3.0/ CC BY-NC-SA 3.0
]]

local AddonName, Addon = ...;

local clientLocale = GetLocale();
local translation = {};


if (clientLocale == 'deDE') then
	translation = {
		['Left click: Open overview'] = 'Linksklick: Übersicht öffnen',
		['Right click: Open settings'] = 'Rechtsklick: Einstellungen öffnen'
	};
elseif (clientLocale == 'esES' or clientLocale == 'esMX') then
	translation = {
		['Left click: Open overview'] = 'Clic izquierdo: Abrir vista general',
		['Right click: Open settings'] = 'Clic derecho: Abrir configuraciones'
	};
elseif (clientLocale == 'frFR') then
	translation = {
		['Left click: Open overview'] = 'Clic gauche : Ouvrir l\'aperçu',
		['Right click: Open settings'] = 'RClic droit : Ouvrir les paramètres'
	};
elseif (clientLocale == 'itIT') then
	translation = {
		['Left click: Open overview'] = 'Clic sinistro: Apri panoramica',
		['Right click: Open settings'] = 'Clic destro: Apri impostazioni'
	};
elseif (clientLocale == 'ptBR') then
	translation = {
		['Left click: Open overview'] = 'Clique esquerdo: Abrir visão geral',
		['Right click: Open settings'] = 'Clique direito: Abrir configurações'
	};
elseif (clientLocale == 'ruRU') then
	translation = {
		['Left click: Open overview'] = 'Левый клик: Открыть обзор',
		['Right click: Open settings'] = 'Правый клик: Открыть настройки'
	};
elseif (clientLocale == 'koKR') then
	translation = {
		['Left click: Open overview'] = '왼쪽 클릭: 개요 열기',
		['Right click: Open settings'] = '오른쪽 클릭: 설정 열기'
	};
elseif (clientLocale == 'zhCN' or clientLocale == 'zhTW') then
	translation = {
		['Left click: Open overview'] = '左键单击：打开概览',
		['Right click: Open settings'] = '右键单击：打开设置'
	};
end

Addon.Translate = setmetatable(translation, {
	__index = function (t, key)
		rawset(t, key, key);
		return key;
	end
});
