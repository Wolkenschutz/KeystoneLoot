--[[
	@author Selina Ruesch <selina.ruesch@gmail.com>
	@license http://creativecommons.org/licenses/by-nc-sa/3.0/ CC BY-NC-SA 3.0
]]

local AddonName, Addon = ...;

local clientLocale = GetLocale();
local translation = {};


if (clientLocale == 'deDE') then
	translation = {};
elseif (clientLocale == 'esES' or clientLocale == 'esMX') then
	translation = {};
elseif (clientLocale == 'frFR') then
	translation = {};
elseif (clientLocale == 'itIT') then
	translation = {};
elseif (clientLocale == 'ptBR') then
	translation = {};
elseif (clientLocale == 'ruRU') then
	translation = {};
elseif (clientLocale == 'koKR') then
	translation = {};
elseif (clientLocale == 'zhCN' or clientLocale == 'zhTW') then
	translation = {};
end

Addon.Translate = setmetatable(translation, {
	__index = function (t, key)
		rawset(t, key, key);
		return key;
	end
});
