--[[
KSLMenuVariants functions are suitable to be overwritten for game specific implementations. Some
implementations are here for reference despite being shared code.
]]--

KSLMenuVariants = {};

KSLMenuVariants.GearButtonTexture = [[Interface\WorldMap\GEAR_64GREY]];
KSLMenuVariants.GearButtonAnchor = CreateAnchor("RIGHT");
KSLMenuVariants.CancelButtonTexture = [[Interface\Buttons\UI-GroupLoot-Pass-Up]];
KSLMenuVariants.CancelButtonAnchor = CreateAnchor("RIGHT", nil, "LEFT", -3, 0);

KSLMenuVariants.DisabledHighlightOpacity = .4;

function KSLMenuVariants.CreateFontString(frame)
	local fontString = frame:AttachFontString();
	fontString:SetPoint("LEFT");
	fontString:SetHeight(20);
	return fontString;
end

function KSLMenuVariants.CreateDivider(frame)
	local divider = frame:AttachTexture();
	divider:SetPoint("LEFT");
	divider:SetPoint("RIGHT");
	divider:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent");
	divider:SetHeight(13);
	return divider;
end

function KSLMenuVariants.CreateSubmenuArrow(frame)
	local arrow = frame:AttachTexture();
	frame.arrow = arrow;
	arrow:SetPoint("RIGHT");
	arrow:SetSize(16, 16);
	arrow:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow");
	arrow:SetDrawLayer("ARTWORK");
	return arrow;
end

function KSLMenuVariants.CreateHighlight(frame)
	local highlight = frame:AttachTexture();
	frame.highlight = highlight;
	highlight:SetAllPoints();
	highlight:SetBlendMode("ADD");
	highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	highlight:SetDrawLayer("BACKGROUND");
	highlight:Hide();
	return highlight;
end

function KSLMenuVariants.GetCheckboxCheckSoundKit()
	return SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON;
end

function KSLMenuVariants.GetCheckboxUncheckSoundKit()
	return SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF;
end

function KSLMenuVariants.GetButtonSoundKit()
	return SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON;
end

function KSLMenuVariants.GetDropdownOpenSoundKit()
	return SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON;
end

function KSLMenuVariants.GetDropdownCloseSoundKit()
	return SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF;
end

local function GenerateError()
	error("Requires implementation in game specific version of MenuVariants.lua");
end

function KSLMenuVariants.GetDefaultMenuMixin()
	GenerateError();
end

function KSLMenuVariants.GetDefaultContextMenuMixin()
	GenerateError();
end
