local SetPropagateMouseMotion = function(frame, propagate)
	frame:SetPropagateMouseMotion(propagate);
end;

-- Blizzard_EnvironmentCleanup nils out CreateSecureDelegate before addons load
local SetPropagateMouseMotionDelegate = SetPropagateMouseMotion;

KSLMenuTemplates = {};

--[[
Secure print for debugging purposes only. Remember to comment out the call to DebugPrintSecure
before committing.
]]
local function DebugShouldPrint()
	return KSLMenuConstants.PrintSecure;
end

local function DebugPrintSecure()
	if IsPublicBuild() or (not securecallfunction(DebugShouldPrint)) then
		return;
	end

	UIErrorsFrame:AddMessage("Secure: "..tostring(issecure()));
end

local function CreateMenuElementDescription(template, initializer, data)
	local elementDescription = KSLMenu.CreateMenuElementDescription();
	elementDescription:SetData(data);
	elementDescription:SetElementFactory(function(factory)
		factory(template, initializer);
	end);

	return elementDescription;
end

local function CallFunctionWithVarArgAsParam(func, ...)
	for index = 1, select("#", ...) do
		func(select(index, ...));
	end
end

local function GetCheckboxSoundKit(description)
	if description:IsSelected() then
		return KSLMenuVariants.GetCheckboxCheckSoundKit();
	else
		return KSLMenuVariants.GetCheckboxUncheckSoundKit();
	end
end

local function GetButtonSoundKit(description)
	return KSLMenuVariants.GetButtonSoundKit();
end

--[[
Final initializer is called after all other initializers are called so that
the recursion functions here can find any of the regions that were attached.
]]--
local function ButtonFinalInitializer(button, description, menu)
	KSLMenuTemplates.RecurseSetupFontString(button);

	local enabled = description:IsEnabled();
	button:SetEnabled(enabled);

	KSLMenuTemplates.SetHierarchyEnabled(button, enabled);
end

local function OnButtonEnable(button)
	KSLMenuTemplates.SetHierarchyEnabled(button, true);
end

local function OnButtonDisable(button)
	KSLMenuTemplates.SetHierarchyEnabled(button, false);
end

local function OnButtonClick(button, buttonName)
	local description = button:GetElementDescription();
	if not description:CanOpenSubmenu() or description:ShouldPlaySoundOnSubmenuClick() then
		PlaySound(description:GetSoundKit());
	end

	description:Pick(KSLMenuInputContext.MouseButton, buttonName);

	--securecallfunction(DebugPrintSecure);
end

local function ShowHighlight(button, description)
	button.highlight:Show();
	button.highlight:SetAlpha(description:IsEnabled() and 1 or KSLMenuVariants.DisabledHighlightOpacity);
end

local function OnButtonEnter(button, description)
	ShowHighlight(button, description);
end

local function OnButtonLeave(button)
	button.highlight:Hide();
end

local function ButtonInitializer(button, description, menu)
	if description:CanOpenSubmenu() then
		KSLMenuVariants.CreateSubmenuArrow(button);
	end

	KSLMenuVariants.CreateHighlight(button);

	--[[
	Visibility cannot be automatically toggled on the HIGHLIGHT layer
	because the highlight needs to be the bottom render layer.
	]]--
	button.OnEnter = OnButtonEnter;
	button.OnLeave = OnButtonLeave;

	--[[
	The button will not re-highlight if it is reinitialized while the cursor
	is already over the button.
	]]--
	if button:IsMouseMotionFocus() then
		ShowHighlight(button, description);
	end

	if description:ShouldPollEnabled() then
		button:NewTicker(KSLMenuConstants.ElementPollFrequencySeconds, function()
			button:SetEnabled(description:IsEnabled());
		end);
	end

	button:SetMotionScriptsWhileDisabled(true);
	button:SetScript("OnEnable", OnButtonEnable);
	button:SetScript("OnDisable", OnButtonDisable);
	button:SetScript("OnClick", OnButtonClick);
end

local function CreateButtonDescription(data)
	local elementDescription = CreateMenuElementDescription("Button", ButtonInitializer, data);
	elementDescription:SetFinalInitializer(ButtonFinalInitializer);
	return elementDescription;
end

function KSLMenuTemplates.RecurseSetupFontString(frame)
	--[[
	Applying the enabled state is deferred until all initializers are called so that any
	construction or initialization of any regions is finished before we attempt to traverse
	the hierarchy and apply new states.
	]]--

	--[[
	Cache our current and disabled color so we can switch between them as the button
	enabled state is changed. When a use case for changing the disabled color appears,
	add an API to return the desired color(s).
	]]--

	local function TrySetupFontString(region)
		if region:IsObjectType("FontString") then
			local fontString = region;
			local autoEnableTextColors =
			{
				[true] = CreateColor(fontString:GetTextColor()),
				[false] = DISABLED_FONT_COLOR,
			};

			-- Compositor replaces __index with a function. Also note that
			-- you cannot acquire the original function again once SetTextColor
			-- is assigned because the mt will return the assigned function instead.
			local originalSetTextColor;
			local mt = getmetatable(fontString);
			if type(mt.__index) == "function" then
				originalSetTextColor = mt.__index(fontString, "SetTextColor");
			elseif not fontString.autoEnableTextColors then
				originalSetTextColor = fontString.SetTextColor;
			end

			if originalSetTextColor then
				fontString.SetTextColor = function(self, r, g, b, a)
					-- The intention here is to update the cached color for 'enabled/true' so that it can be
					-- restored as the frame changes enabled state. This treats any color other than
					-- DISABLED_FONT_COLOR as an enabled color.
					if not IsRGBAEqualToColor(r, g, b, a, autoEnableTextColors[false]) then
						autoEnableTextColors[true] = CreateColor(r, g, b, a);
					end
					originalSetTextColor(self, r, g, b, a);
				end;
				fontString.autoEnableTextColors = autoEnableTextColors;
			end
		end
	end
	CallFunctionWithVarArgAsParam(TrySetupFontString, frame:GetRegions());
	CallFunctionWithVarArgAsParam(KSLMenuTemplates.RecurseSetupFontString, frame:GetChildren());
end

function KSLMenuTemplates.SetHierarchyEnabled(frame, enabled)
	local function Recurse(frame)
		if frame.noRecurseHierarchy then
			return;
		end

		local function SetAutoEnabled(region)
			if region.noRecurseHierarchy then
				return;
			end

			if frame.lockedEnabledState ~= nil then
				enabled = frame.lockedEnabledState;
			end

			if region:IsObjectType("FontString") and region.autoEnableTextColors then
				local fontString = region;
				local textColor = fontString.autoEnableTextColors[enabled];
				fontString:SetTextColor(textColor:GetRGBA());
			elseif region:IsObjectType("Texture") then
				region:SetDesaturation(enabled and 0 or 1);
			end
		end
		CallFunctionWithVarArgAsParam(SetAutoEnabled, frame:GetRegions());
		CallFunctionWithVarArgAsParam(Recurse, frame:GetChildren());
	end

	Recurse(frame);
end

function KSLMenuTemplates.CreateFrame(initializer, data)
	return CreateMenuElementDescription("Frame", initializer, data);
end

function KSLMenuTemplates.CreateTemplate(template, initializer, data)
	return CreateMenuElementDescription(template, initializer, data);
end

function KSLMenuTemplates.CreateTitle(text)
	local function Initializer(frame, description, menu)
		local fontString = KSLMenuVariants.CreateFontString(frame);
		frame.fontString = fontString;
		fontString:SetTextToFit(text);
	end

	return KSLMenuTemplates.CreateFrame(Initializer);
end

function KSLMenuTemplates.CreateButton(text, callback, data)
	local function Initializer(button, description, menu)
		local fontString = KSLMenuVariants.CreateFontString(button);
		button.fontString = fontString;
		fontString:SetTextToFit(text);
	end

	local elementDescription = CreateButtonDescription(data);
	elementDescription:SetSoundKit(GetButtonSoundKit);
	elementDescription:AddInitializer(Initializer);
	elementDescription:SetResponder(callback);
	return elementDescription;
end

--[[
Radio and checkbox textures both share a 2 texture setup where a second texture is created
only if the data is selected.
]]
function KSLMenuTemplates.CreateSelectionTextures(frame, isSelected, data, unselectedAtlas, selectedAtlas)
	local leftTexture1 = frame:AttachTexture();
	frame.leftTexture1 = leftTexture1;
	leftTexture1:SetAtlas(unselectedAtlas, TextureKitConstants.UseAtlasSize);

	-- Avoiding creating the second texture unnecessarily.
	local leftTexture2 = nil;
	if isSelected(data) then
		leftTexture2 = frame:AttachTexture();
		local layer, drawLevel = leftTexture1:GetDrawLayer();
		leftTexture2:SetDrawLayer(layer, drawLevel + 1);
		leftTexture2:SetAtlas(selectedAtlas, TextureKitConstants.UseAtlasSize);
	end

	frame.leftTexture2 = leftTexture2;
	return leftTexture1, leftTexture2;
end

function KSLMenuTemplates.CreateCheckbox(text, isSelected, onSelect, data)
	local function Initializer(button, description, menu)
		KSLMenuVariants.CreateCheckbox(text, button, isSelected, data);
	end

	local elementDescription = CreateButtonDescription(data);
	elementDescription:SetSoundKit(GetCheckboxSoundKit);
	elementDescription:AddInitializer(Initializer);
	elementDescription:SetIsSelected(isSelected);
	elementDescription:SetResponder(onSelect);
	elementDescription:SetResponse(KSLMenuResponse.Refresh);
	return elementDescription;
end

function KSLMenuTemplates.CreateRadio(text, isSelected, onSelect, data)
	local function Initializer(button, description, menu)
		KSLMenuVariants.CreateRadio(text, button, isSelected, data);
	end

	local elementDescription = CreateButtonDescription(data);
	elementDescription:SetSoundKit(GetButtonSoundKit);
	elementDescription:AddInitializer(Initializer);
	elementDescription:SetRadio(true);
	elementDescription:SetIsSelected(isSelected);
	elementDescription:SetResponder(onSelect);
	return elementDescription;
end

function KSLMenuTemplates.CreateHighlightRadio(text, isSelected, onSelect, data, onEnter)
	local optionDescription = CreateMenuElementDescription("KSLMenuDropdownHighlightRadioTemplate");

	local truncated = false;

	local function OnEnter(button)
		button.HighlightBGTex:SetAlpha(0.15);

		local description = button:GetElementDescription();
		if description:IsEnabled() and not description:IsSelected() then
			button.Text:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB());
		end

		if truncated then
			KSLMenuUtil.ShowTooltip(button, function(tooltip)
				GameTooltip_SetTitle(tooltip, text);
			end);
		end

		if onEnter then
			onEnter(data);
		end
	end

	local function OnLeave(button)
		button.HighlightBGTex:SetAlpha(0);

		local description = button:GetElementDescription();
		if description:IsEnabled() and not description:IsSelected() then
			button.Text:SetTextColor(VERY_LIGHT_GRAY_COLOR:GetRGB());
		end

		KSLMenuUtil.HideTooltip(button);
	end

	optionDescription:AddInitializer(function(button, description, menu)
		button:SetScript("OnClick", function(button, buttonName)
			description:Pick(KSLMenuInputContext.MouseButton, buttonName);
		end);

		-- This button template is modified in Languages.lua to hide the text and display
		-- a texture for each locale, so we need to redisplay the text. We don't have to worry
		-- about that texture here because it is managed by the compositor.
		button.Text:Show();
		button.Text:SetTextToFit(text);
		button.Text:SetWidth(button.Text:GetWidth() + 10);

		button.HighlightBGTex:SetAlpha(0);

		local fontColor = nil;
		if description:IsSelected() then
			button.Text:SetTextColor(NORMAL_FONT_COLOR:GetRGBA());
		elseif description:IsEnabled() then
			button.Text:SetTextColor(VERY_LIGHT_GRAY_COLOR:GetRGB());
		else
			button.Text:SetTextColor(DISABLED_FONT_COLOR:GetRGB());
		end

		truncated = button.Text:IsTruncated();

		button:Layout();
	end);

	optionDescription:SetIsSelected(isSelected);
	optionDescription:SetResponder(onSelect);
	optionDescription:SetOnEnter(OnEnter);
	optionDescription:SetOnLeave(OnLeave);
	optionDescription:SetRadio(true);
	optionDescription:SetData(data);

	return optionDescription;
end

function KSLMenuTemplates.CreateSpacer(extent)
	local function Initializer(frame, description, menu)
		frame:SetHeight(extent or 10);
	end

	return KSLMenuTemplates.CreateFrame(Initializer);
end

function KSLMenuTemplates.CreateDivider()
	local function Initializer(frame, description, menu)
		frame.divider = KSLMenuVariants.CreateDivider(frame);
	end

	return KSLMenuTemplates.CreateFrame(Initializer);
end

function KSLMenuTemplates.CreateColorSwatch(text, callback, colorInfo)
	local function Initializer(frame, description, menu)
		local fontString = KSLMenuVariants.CreateFontString(frame);
		frame.fontString = fontString;
		frame.fontString:SetTextToFit(text);

		local colorSwatch = frame:AttachTemplate("ColorSwatchTemplate");
		frame.colorSwatch = colorSwatch;
		colorSwatch:SetPoint("RIGHT");
		colorSwatch:SetSize(16, 16);
		colorSwatch:SetColorRGB(colorInfo.r, colorInfo.g, colorInfo.b);
	end

	local elementDescription = CreateButtonDescription(colorInfo);
	elementDescription:SetSoundKit(GetButtonSoundKit);
	elementDescription:AddInitializer(Initializer);
	elementDescription:SetResponder(callback);
	return elementDescription;
end

do
	local function OnAutoHideButtonLeave(button)
		KSLMenuUtil.HideTooltip(button);
	end

	function KSLMenuTemplates.AttachAutoHideButton(parent, textureName)
		local button = parent:AttachTemplate("KSLMenuAutoHideButtonTemplate");
		button:SetFrameStrata(parent:GetFrameStrata()); -- Machinery is broken.
		button:Hide();

		-- SetToDefaults wipes propagateMouseInput on pooled frames even though it was set by the template, so it needs to be set here every time.
		SetPropagateMouseMotionDelegate(button, true);

		button:SetScript("OnLeave", OnAutoHideButtonLeave);

		local texture = button.Texture;
		texture:SetTexture(textureName);

		local onEnter = parent.OnEnter or nop;
		parent.OnEnter = function(...)
			onEnter(parent, ...);
			button:Show();
			button.Texture:Show();
		end

		local onLeave = parent.OnLeave or nop;
		parent.OnLeave = function(...)
			onLeave(parent, ...);
			button:Hide();
		end
		return button;
	end
end

function KSLMenuTemplates.AttachBasicButton(parent, width, height)
	local button = parent:AttachFrame("Button");
	button:SetFrameStrata(parent:GetFrameStrata()); -- Machinery is broken.

	-- SetToDefaults wipes button state, desired states must be explicitly set now.
	button:Show();

	SetPropagateMouseMotionDelegate(button, true);

	button:SetMouseClickEnabled(true);
	button:SetMouseMotionEnabled(true);
	button:SetSize(width or 16, height or 16);

	return button;
end

function KSLMenuTemplates.AttachUtilityButton(parent, textureAsset, width, height)
	local button = KSLMenuTemplates.AttachAutoHideButton(parent, textureAsset);
	button:SetSize(width or 16, height or 16);
	return button;
end

function KSLMenuTemplates.SetUtilityButtonClickHandler(button, handler)
	button:SetScript("OnClick", function(_b, mouseButton, _isDown)
		if mouseButton == "LeftButton" then
			handler();
		end
	end);
end

function KSLMenuTemplates.SetUtilityButtonTooltipText(button, tooltipText)
	KSLMenuUtil.HookTooltipScripts(button, function(tooltip)
		GameTooltip_SetTitle(tooltip, tooltipText);
	end);
end

function KSLMenuTemplates.SetUtilityButtonLockedEnabledState(button, value)
	button.lockedEnabledState = value;
end

function KSLMenuTemplates.SetUtilityButtonAnchor(button, anchor, relativeTo)
	local point, _, relativePoint, x, y = anchor:Get();
	button:SetPoint(point, relativeTo, relativePoint, x, y);
end

function KSLMenuTemplates.AttachAutoHideGearButton(parent)
	return KSLMenuTemplates.AttachUtilityButton(parent, KSLMenuVariants.GearButtonTexture);
end

function KSLMenuTemplates.AttachAutoHideCancelButton(parent)
	return KSLMenuTemplates.AttachUtilityButton(parent, KSLMenuVariants.CancelButtonTexture);
end

function KSLMenuTemplates.AttachNewFeatureFrame(parent)
	local newFeatureFrame = parent:AttachTemplate("NewFeatureLabelTemplate");

	newFeatureFrame.noRecurseHierarchy = true;
	return newFeatureFrame;
end

function KSLMenuTemplates.AttachTexture(parent, textureOrAtlas, point, pointX, pointY)
	local iconTexture = parent:AttachTexture();
	iconTexture:SetPoint(point or "RIGHT", pointX or 0, pointY or 0);

	if C_Texture.GetAtlasInfo(textureOrAtlas) then
		local useAtlasSize = false;
		iconTexture:SetAtlas(textureOrAtlas, useAtlasSize);
	else
		iconTexture:SetTexture(textureOrAtlas);
	end

	return iconTexture;
end

KSLDropdownTextMixin = {};

function KSLDropdownTextMixin:OnLoad()
	if self.text then
		self:SetText(self.text);
	end
end

function KSLDropdownTextMixin:GetText()
	return self.text;
end

function KSLDropdownTextMixin:SetText(text)
	self.text = text;
	self:UpdateText();
end

function KSLDropdownTextMixin:GetUpdateText()
	return self.text;
end

function KSLDropdownTextMixin:UpdateText()
	self.Text:SetText(self:GetUpdateText());

	if self.resizeToText then
		local newWidth = self.Text:GetUnboundedStringWidth();

		if self.resizeToTextPadding then
			newWidth = newWidth + self.resizeToTextPadding;
		end

		if self.resizeToTextMaxWidth then
			newWidth = math.min(self.resizeToTextMaxWidth, newWidth);
		end

		if self.resizeToTextMinWidth then
			newWidth = math.max(self.resizeToTextMinWidth, newWidth);
		end

		self:SetWidth(newWidth);
	end
end

function KSLDropdownTextMixin:UpdateToMenuSelections(menuDescription, currentSelections)
	self:UpdateText();
end

--[[
An initializer wrapping KSLDropdownButtonMixin.SetupMenu is not provided because in the vast majority of cases
the displayed text will reflect at least 1 selected option. SetDefaultText() should be used to provide text
in the cases where no selection is possible.
]]--
KSLDropdownSelectionTextMixin = CreateFromMixins(KSLDropdownTextMixin);

local function DefaultSelectionTranslator(selection)
	return KSLMenuUtil.GetElementText(selection);
end

function KSLDropdownSelectionTextMixin:OnLoad()
	KSLDropdownTextMixin.OnLoad(self);

	self:SetSelectionTranslator(DefaultSelectionTranslator);
end

function KSLDropdownSelectionTextMixin:GetUpdateText()
	return self.text or self.defaultText;
end

function KSLDropdownSelectionTextMixin:GetDefaultText()
	return self.defaultText;
end

function KSLDropdownSelectionTextMixin:SetDefaultText(text)
	self.defaultText = text;
	self:UpdateText();
end

function KSLDropdownSelectionTextMixin:SetSelectionTranslator(translator)
	self.selectionTranslator = translator;
end

function KSLDropdownSelectionTextMixin:SetSelectionText(selectionFunc)
	self.selectionFunc = selectionFunc;
end

function KSLDropdownSelectionTextMixin:OverrideText(text)
	if not text then
		return;
	end

	self.disableSelectionText = true;
	self:SetText(text);
end

function KSLDropdownSelectionTextMixin:UpdateToMenuSelections(menuDescription, currentSelections)
	if self.disableSelectionText then
		return;
	end

	if not currentSelections and menuDescription then
		currentSelections = KSLMenuUtil.GetSelections(menuDescription);
	end

	local text = nil;

	if self.selectionFunc then
		text = self.selectionFunc(currentSelections);
	end

	if text == nil and currentSelections then
		local texts = {};

		for index, selection in ipairs(currentSelections) do
			if not selection:IsSelectionIgnored() then
				local translatedText = self.selectionTranslator(selection);
				table.insert(texts, translatedText);
			end
		end

		if #texts > 0 then
			if self.dontConcatenateText then
				text = texts[1];
			else
				text = table.concat(texts, LIST_DELIMITER);
			end
		end
	end

	self:SetText(text or self.defaultText);
end

function KSLDropdownSelectionTextMixin:OnShow()
	-- Will only cause a menu description to be generated if the generator was
	-- assigned prior to the OnShow() being called.
	self:GenerateMenu();
end

function KSLDropdownSelectionTextMixin:OnEnter()
	ButtonStateBehaviorMixin.OnEnter(self);

	if self:ShouldShowTooltip() then
		self:ShowTooltip();
	end
end

function KSLDropdownSelectionTextMixin:ShouldShowTooltip()
	return self.Text:IsTruncated() or self.tooltipFunc;
end

function KSLDropdownSelectionTextMixin:SetTooltip(tooltipFunc)
	self.tooltipFunc = tooltipFunc;
end

function KSLDropdownSelectionTextMixin:ShowTooltip()
	if self.tooltipFunc then
		KSLMenuUtil.ShowTooltip(self, self.tooltipFunc);
	else
		KSLMenuUtil.ShowTooltip(self, function(tooltip)
			GameTooltip_SetTitle(tooltip, self.Text:GetText());
		end);
	end
end

function KSLDropdownSelectionTextMixin:OnLeave()
	ButtonStateBehaviorMixin.OnLeave(self);

	KSLMenuUtil.HideTooltip(self);
end

-- Inherited by dropdown buttons that require the reset button behavior. The reset button
-- needs to be defined/created prior to the OnLoad call.
KSLDropdownFilterBehaviorMixin = {};

function KSLDropdownFilterBehaviorMixin:OnLoad()
	self.ResetButton:SetScript("OnClick", function(button, buttonName, down)
		if self.defaultCallback then
			 self.defaultCallback();
		end

		self.ResetButton:Hide();

		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	end);
end

function KSLDropdownFilterBehaviorMixin:OnShow()
	self:ValidateResetState();
end

-- Callback to set all filters to default state.
function KSLDropdownFilterBehaviorMixin:SetDefaultCallback(callback)
	self.defaultCallback = callback;
end

-- Callback to return if the filters are in their default state.
function KSLDropdownFilterBehaviorMixin:SetIsDefaultCallback(callback)
	self.isDefaultCallback = callback;
end

-- Called in response to any menu option change.
function KSLDropdownFilterBehaviorMixin:SetUpdateCallback(callback)
	self.notifyUpdateCallback = callback;
end

function KSLDropdownFilterBehaviorMixin:NotifyUpdate(description)
	if self.notifyUpdateCallback then
		self.notifyUpdateCallback(description);
	end
end

function KSLDropdownFilterBehaviorMixin:Reset()
	self.ResetButton:Hide();
end

function KSLDropdownFilterBehaviorMixin:ValidateResetState()
	if self.isDefaultCallback then
		self.ResetButton:SetShown(not self.isDefaultCallback());
	end
end

-- Call in derived
function KSLDropdownFilterBehaviorMixin:OnMenuResponse(menu, description)
	self:ValidateResetState();
	self:NotifyUpdate(description);
end

-- Call in derived
function KSLDropdownFilterBehaviorMixin:OnMenuAssigned()
	self:ValidateResetState();
end

KSLFilterButtonMixin = CreateFromMixins(KSLDropdownFilterBehaviorMixin);

function KSLFilterButtonMixin:OnMenuResponse(menu, description)
	KSLDropdownButtonMixin.OnMenuResponse(self, menu, description);
	KSLDropdownFilterBehaviorMixin.OnMenuResponse(self, menu, description);
end

function KSLFilterButtonMixin:OnMenuAssigned()
	KSLDropdownButtonMixin.OnMenuAssigned(self);
	KSLDropdownFilterBehaviorMixin.OnMenuAssigned(self);
end

KSLStyle1DropdownMixin = CreateFromMixins(ButtonStateBehaviorMixin, KSLDropdownSelectionTextMixin);

function KSLStyle1DropdownMixin:OnLoad()
	KSLValidateIsDropdownButtonIntrinsic(self);
	ButtonStateBehaviorMixin.OnLoad(self);
	KSLDropdownSelectionTextMixin.OnLoad(self);
end

function KSLStyle1DropdownMixin:OnButtonStateChanged()
	local enabled = self:IsEnabled();
	if enabled then
		self.Text:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB());
	else
		self.Text:SetTextColor(DISABLED_FONT_COLOR:GetRGB());
	end

	self.Arrow:SetAtlas(self:GetArrowAtlas(), TextureKitConstants.UseAtlasSize);
end

--[[
The standard "filter" dropdown style. Its text does not reflect the selected option(s) and
instead is generally initialized to fixed text.
]]--
KSLStyle1FilterDropdownMixin = CreateFromMixins(ButtonStateBehaviorMixin, KSLDropdownTextMixin, KSLFilterButtonMixin);

function KSLStyle1FilterDropdownMixin:OnLoad()
	KSLValidateIsDropdownButtonIntrinsic(self);
	ButtonStateBehaviorMixin.OnLoad(self);
	KSLDropdownTextMixin.OnLoad(self);
	KSLFilterButtonMixin.OnLoad(self);

	if self.baseFontObject then
		self.Text:SetFontObject(self.baseFontObject);
	else
		self.baseFontObject = self.Text:GetFontObject();
	end

	local x, y = 2, -1;
	self:SetDisplacedRegions(x, y, self.Text);
end

function KSLStyle1FilterDropdownMixin:GetBackgroundAtlas()
	if self:IsEnabled() then
		if self:IsDownOver() then
			return KSLStyle1FilterDropdownStateDownOver;
		elseif self:IsOver() then
			return KSLStyle1FilterDropdownStateOver;
		elseif self:IsDown() then
			return KSLStyle1FilterDropdownStateDown;
		elseif self:IsMenuOpen() then
			return KSLStyle1FilterDropdownStateOpen;
		else
			return KSLStyle1FilterDropdownStateEnabled;
		end
	end
	return KSLStyle1FilterDropdownStateDisabled;
end

function KSLStyle1FilterDropdownMixin:OnButtonStateChanged()
	self.Background:SetAtlas(self:GetBackgroundAtlas(), TextureKitConstants.UseAtlasSize);
end

function KSLStyle1FilterDropdownMixin:OnEnable()
	ButtonStateBehaviorMixin.OnEnable(self);

	self.Text:SetFontObject(self.baseFontObject);
end

function KSLStyle1FilterDropdownMixin:OnDisable()
	ButtonStateBehaviorMixin.OnDisable(self);

	self.Text:SetFontObject(self.disableFontObject);
end

--[[
A special style used in Settings and Character Creation/Customization. Note that complex
contents (color swatches, icons, etc.) are not defined here but are instead added as a child
within this template. See "KSLStyle2DropdownTemplate" in Blizzard_CharacterCustomize.xml.
]]--
KSLStyle2DropdownMixin = CreateFromMixins(ButtonStateBehaviorMixin, KSLDropdownSelectionTextMixin, KSLFilterButtonMixin);

function KSLStyle2DropdownMixin:OnLoad()
	ButtonStateBehaviorMixin.OnLoad(self);
	KSLDropdownSelectionTextMixin.OnLoad(self);
	KSLFilterButtonMixin.OnLoad(self);

	local x, y = 2, -1;
	self:SetDisplacedRegions(x, y, self.Text);
end

function KSLStyle2DropdownMixin:OnShow()
	KSLDropdownSelectionTextMixin.OnShow(self);
	KSLFilterButtonMixin.OnShow(self);
end

function KSLStyle2DropdownMixin:GetBackgroundAtlas()
	if self:IsEnabled() then
		if self:IsDownOver() then
			return "common-dropdown-c-button-pressedhover-1";
		elseif self:IsOver() then
			return "common-dropdown-c-button-hover-1";
		elseif self:IsDown() then
			return "common-dropdown-c-button-pressed-1";
		elseif self:IsMenuOpen() then
			return "common-dropdown-c-button-open";
		else
			return "common-dropdown-c-button";
		end
	end

	return "common-dropdown-c-button-disabled";
end

function KSLStyle2DropdownMixin:OnButtonStateChanged()
	local enabled = self:IsEnabled();
	if enabled then
		self.Text:SetTextColor(NORMAL_FONT_COLOR:GetRGB());
	else
		self.Text:SetTextColor(DISABLED_FONT_COLOR:GetRGB());
	end

	self.Arrow:SetShown(self:IsOver());
	self.Arrow:SetDesaturated(not enabled);

	self.Background:SetAtlas(self:GetBackgroundAtlas(), TextureKitConstants.UseAtlasSize);
end

function KSLStyle2DropdownMixin:OnMenuOpened(menu)
	KSLDropdownButtonMixin.OnMenuOpened(self, menu);

	self:OnButtonStateChanged();
end

function KSLStyle2DropdownMixin:OnMenuClosed(menu, closeReason)
	KSLDropdownButtonMixin.OnMenuClosed(self, menu, closeReason);

	self:OnButtonStateChanged();
end

KSLStyle1ArrowDropdownMixin = CreateFromMixins(ButtonStateBehaviorMixin);

function KSLStyle1ArrowDropdownMixin:OnLoad()
	KSLValidateIsDropdownButtonIntrinsic(self);
	ButtonStateBehaviorMixin.OnLoad(self);
	KSLDropdownButtonMixin.OnLoad(self);
end

KSLMenuStyleMixin = {};

function KSLMenuStyleMixin:Generate()
	local texture = self:AttachTexture();
	texture:SetAllPoints();

	local r, g, b = GREEN_FONT_COLOR:GetRGB();
	texture:SetColorTexture(r, g, b, .5);
end

do
	local inset =
	{
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
	};

	function KSLMenuStyleMixin:GetInset()
		return inset;
	end
end

do
	local padding =
	{
		width = 0,
		height = 0,
	};

	function KSLMenuStyleMixin:GetChildExtentPadding()
		return padding;
	end
end

-- Test purposes only.
KSLRandomColorStyleMenuMixin = CreateFromMixins(KSLMenuStyleMixin);

function KSLRandomColorStyleMenuMixin:Generate()
	local texture = self:AttachTexture();
	texture:SetAllPoints();

	local c = .5;
	local r, g, b = math.random() * c, math.random() * c, math.random() * c;
	texture:SetColorTexture(r, g, b, 1);
end

KSLBlackColorStyleMenuMixin = CreateFromMixins(KSLMenuStyleMixin);

function KSLBlackColorStyleMenuMixin:Generate()
	local texture = self:AttachTexture();
	texture:SetAllPoints();

	texture:SetColorTexture(0, 0, 0, 1);
end

KSLMenuStyle2Mixin = CreateFromMixins(KSLMenuStyleMixin);

function KSLMenuStyle2Mixin:Generate()
	local background = self:AttachTexture();
	background:SetAtlas("common-dropdown-c-bg");
	background:SetPoint("TOPLEFT", -17, 12);
	background:SetPoint("BOTTOMRIGHT", 17, -22);
end

do
	local inset =
	{
		left = 3,
		top = 6,
		right = 3,
		bottom = 7,
	};

	function KSLMenuStyle2Mixin:GetInset()
		return inset;
	end
end

-- Accompanies the style of WowStyle2Dropdown
KSLStyle2IconButtonMixin = CreateFromMixins(ButtonStateBehaviorMixin);

function KSLStyle2IconButtonMixin:OnLoad()
	self:OnButtonStateChanged();

	local x, y = 2, -1;
	self:SetDisplacedRegions(x, y, self.Icon);
end

function KSLStyle2IconButtonMixin:GetBackgroundAtlas()
	if self:IsEnabled() then
		if self:IsDownOver() then
			return "common-dropdown-c-button-pressedhover-2";
		elseif self:IsOver() then
			return "common-dropdown-c-button-hover-2";
		elseif self:IsDown() then
			return "common-dropdown-c-button-pressed-2";
		else
			return "common-dropdown-c-button";
		end
	end

	return "common-dropdown-c-button-disabled";
end

function KSLStyle2IconButtonMixin:OnButtonStateChanged()
	self.Background:SetAtlas(self:GetBackgroundAtlas(), TextureKitConstants.UseAtlasSize);

	local icon = self:IsEnabled() and self.normalAtlas or self.disabledAtlas;
	self.Icon:SetAtlas(icon, TextureKitConstants.UseAtlasSize);
end
