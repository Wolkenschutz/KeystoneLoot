local AddonName, Addon = ...;


local function DropDownMenu_OnShow(self)
	self:SetAlpha(0);
	UIFrameFadeIn(self, 0.2, 0, 1);
end

local Frame = CreateFrame('Frame', nil, Addon.Frames.Overview, 'TooltipBackdropTemplate');
Addon.Frames.DropDownMenu = Frame;
Frame:Hide();
Frame:SetToplevel(true);
Frame:SetFrameStrata('FULLSCREEN_DIALOG');
Frame:SetSize(180, 24);
Frame:SetPoint('TOP', 0, -60);
Frame:SetScript('OnShow', DropDownMenu_OnShow);