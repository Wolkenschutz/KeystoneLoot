local AddonName, Addon = ...;


local Main = Addon.Frames.Settings.Main;


local Title = Main:CreateFontString('ARTWORK', nil, 'GameFontHighlightHuge');
Title:SetPoint('TOPLEFT', 7, -22);
Title:SetText('Keystone Loot');

local Divider = Main:CreateTexture(nil, 'ARTWORK');
Divider:SetPoint('TOP', 0, -50);
Divider:SetAtlas('Options_HorizontalDivider', true);