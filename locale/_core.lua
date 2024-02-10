local AddonName, Addon = ...;

Addon.Translate = setmetatable({}, {
	__index = function (t, key)
		rawset(t, key, key);
		return key;
	end
});