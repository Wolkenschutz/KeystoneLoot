if (GetLocale() ~= 'enUS' and GetLocale() ~= 'enGB') then
    return;
end

local AddonName, KeystoneLoot = ...;
local Translate = KeystoneLoot.Translate;


Translate['Dawn of the Infinite: Galakrond\'s Fall'] = 'Galakrond\'s Fall';
Translate['Dawn of the Infinite: Murozond\'s Rise'] = 'Murozond\'s Rise';