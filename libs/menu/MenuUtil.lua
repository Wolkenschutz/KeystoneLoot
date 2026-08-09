local KSLMenuUtilPrivate = {};
local CreateDropdownMenuUsingInserter = nil;
local CreateContextMenuUsingInserter = nil;

do
	local function VariadicInsert(elementDescription, inserter, ...)
		local arg = ...;
		if arg == nil then
			return;
		end

		elementDescription:Insert(inserter(unpack(arg)));
		VariadicInsert(elementDescription, inserter, select(2, ...));
	end

	CreateDropdownMenuUsingInserter = function(dropdown, inserter, ...)
		local tbl = {...};

		dropdown:SetupMenu(function(dropdown, rootDescription)
			VariadicInsert(rootDescription, inserter, unpack(tbl));
		end);
	end

	CreateContextMenuUsingInserter = function(ownerRegion, inserter, ...)
		local tbl = {...};

		return KSLMenuUtil.CreateContextMenu(ownerRegion, function(ownerRegion, rootDescription)
			VariadicInsert(rootDescription, inserter, unpack(tbl));
		end);
	end
end


KSLMenuUtil = {};

local function TraverseMenu(elementDescription, op, condition)
	if (condition == nil) or condition(elementDescription) then
		local handled = op(elementDescription);
		if handled then
			return true;
		end
	end

	for index, desc in elementDescription:EnumerateElementDescriptions() do
		local handled = TraverseMenu(desc, op, condition);
		if handled then
			return true;
		end
	end

	return false;
end

function KSLMenuUtil.TraverseMenu(elementDescription, op, condition)
	for index, desc in elementDescription:EnumerateElementDescriptions() do
		local handled = TraverseMenu(desc, op, condition);
		if handled then
			return true;
		end
	end
	return false;
end

local function TraverseSelections(elementDescription, selections, condition)
	if ((condition == nil) or condition(elementDescription)) and (elementDescription:IsSelected()) then
		table.insert(selections, elementDescription);
	end
	
	for index, desc in elementDescription:EnumerateElementDescriptions() do
		TraverseSelections(desc, selections, condition);
	end

	return false;
end

function KSLMenuUtil.GetSelections(elementDescription, condition)
	local selections = {};
	for index, desc in elementDescription:EnumerateElementDescriptions() do
		TraverseSelections(desc, selections, condition);
	end
	return selections;
end

local function MergeFunctions(elementDescription)
	for key, inserter in pairs(KSLMenuUtilPrivate.GetInserters()) do
		elementDescription[key] = function(self, ...)
			return self:Insert(inserter(...));
		end;
	end

	for key, func in pairs(KSLMenuUtilPrivate.GetUtilities()) do
		elementDescription[key] = func;
	end

	return elementDescription;
end

function KSLMenuUtil.ShowTooltip(owner, func, ...)
	local tooltip = GetAppropriateTooltip();
	tooltip:SetOwner(owner, "ANCHOR_RIGHT");

	local window = owner:GetWindow();
	tooltip:SetWindow(window);

	func(tooltip, ...);
	tooltip:Show();
end

function KSLMenuUtil.HideTooltip(owner)
	local tooltip = GetAppropriateTooltip();
	if tooltip:GetOwner() == owner then
		tooltip:Hide();
	end
end

function KSLMenuUtil.HookTooltipScripts(owner, func)
	local tooltip = GetAppropriateTooltip();
	
	local oldOnEnter = owner:GetScript("OnEnter") or nop;
	owner:SetScript("OnEnter", function(...)
		tooltip:SetOwner(owner, "ANCHOR_RIGHT");
		oldOnEnter(...)
		func(tooltip);
		tooltip:Show();
	end);

	local oldOnLeave = owner:GetScript("OnLeave") or nop;
	owner:SetScript("OnLeave", function(...)
		oldOnLeave(...)
		func(tooltip);
		tooltip:Hide();
	end);
end

function KSLMenuUtil.CreateRootMenuDescription(menuMixin)
	local elementDescription = KSLMenu.CreateRootMenuDescription(menuMixin);
	MergeFunctions(elementDescription);
	return elementDescription;
end

--[[
Creates a context menu at the cursor. The region provided will inform the menu to close if it
becomes hidden. If no region is provided, then an explicit mouse press or ESC press will
be required to close it.
]]

local function SecureGetMenuMixin(ownerRegion)
	-- An addon may choose to override GetDefaultContextMenuMixin, though the implications that has on
	-- forbidden frames aren't clear yet.
	return ownerRegion.menuMixin or KSLMenuVariants.GetDefaultContextMenuMixin();
end

function KSLMenuUtil.CreateContextMenu(ownerRegion, generator, ...)
	if not ownerRegion then
		ownerRegion = GetAppropriateTopLevelParent();
	end

	local menuMixin = securecallfunction(SecureGetMenuMixin, ownerRegion);
	local elementDescription = KSLMenuUtil.CreateRootMenuDescription(menuMixin);

	KSLMenu.PopulateDescription(generator, ownerRegion, elementDescription, ...);

	local menu = KSLMenu.GetManager():OpenContextMenu(ownerRegion, elementDescription);
	if menu then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	end

	return menu;
end

--[[ Accessors so the implementation can change. Avoid grabbing .text off a description unless you're
prepared to fixup broken references when it moves or changes.
]]--
function KSLMenuUtil.SetElementText(elementDescription, text)
	elementDescription.text = text;
end

function KSLMenuUtil.GetElementText(elementDescription)
	return elementDescription.text;
end

function KSLMenuUtil.CreateFrame()
	local elementDescription = KSLMenuTemplates.CreateFrame();
	MergeFunctions(elementDescription);
	return elementDescription;
end

function KSLMenuUtil.CreateTemplate(template)
	local elementDescription = KSLMenuTemplates.CreateTemplate(template);
	MergeFunctions(elementDescription);
	return elementDescription;
end

local function ConfigureTextButton(text, elementDescription)
	MergeFunctions(elementDescription);
	KSLMenuUtil.SetElementText(elementDescription, text);
	return elementDescription;
end

function KSLMenuUtil.CreateTitle(text, color)
	local elementDescription = KSLMenuTemplates.CreateTitle(text);
	ConfigureTextButton(text, elementDescription);

	local useColor = color or NORMAL_FONT_COLOR;
	elementDescription:AddInitializer(function(frame, description, menu)
		frame.fontString:SetTextColor(useColor:GetRGBA());
	end);
	return elementDescription;
end

function KSLMenuUtil.CreateButton(text, callback, data)
	--assert(type(text) == "string");
	--assert((callback == nil) or type(callback) == "function");
	local elementDescription = KSLMenuTemplates.CreateButton(text, callback, data);
	return ConfigureTextButton(text, elementDescription);
end

function KSLMenuUtil.CreateCheckbox(text, isSelected, setSelected, data)
	--assert(type(text) == "string");
	--assert(type(isSelected) == "function");
	--assert(type(setSelected) == "function");
	local elementDescription = KSLMenuTemplates.CreateCheckbox(text, isSelected, setSelected, data);
	return ConfigureTextButton(text, elementDescription);
end

function KSLMenuUtil.CreateRadio(text, isSelected, setSelected, data)
	--assert(type(text) == "string");
	--assert(type(isSelected) == "function");
	--assert(type(setSelected) == "function");
	local elementDescription = KSLMenuTemplates.CreateRadio(text, isSelected, setSelected, data);
	return ConfigureTextButton(text, elementDescription);
end

-- looks good with KSLStyle2DropdownTemplate, immitates the Settings menu
function KSLMenuUtil.CreateHighlightRadio(text, isSelected, setSelected, data, onEnter)
	--assert(type(text) == "string");
	--assert(type(isSelected) == "function");
	--assert(type(setSelected) == "function");
	local elementDescription = KSLMenuTemplates.CreateHighlightRadio(text, isSelected, setSelected, data, onEnter);
	return ConfigureTextButton(text, elementDescription);
end

function KSLMenuUtil.CreateColorSwatch(text, callback, colorInfo)
	--assert(type(text) == "string");
	--assert(type(callback) == "function");
	--assert(type(colorInfo) == "table");
	local elementDescription = KSLMenuTemplates.CreateColorSwatch(text, callback, colorInfo);
	return ConfigureTextButton(text, elementDescription);
end

--[[
Wrappers for convenience since all other create functions are in KSLMenuUtil. Note that these
are not accompanied by any additional utilities or inserters.
]]--
KSLMenuUtil.CreateDivider = KSLMenuTemplates.CreateDivider;
KSLMenuUtil.CreateSpacer = KSLMenuTemplates.CreateSpacer;

KSLMenuUtilPrivate.Inserters =
{
	CreateFrame = KSLMenuUtil.CreateFrame,
	CreateTemplate = KSLMenuUtil.CreateTemplate,
	CreateButton = KSLMenuUtil.CreateButton,
	CreateTitle = KSLMenuUtil.CreateTitle,
	CreateCheckbox = KSLMenuUtil.CreateCheckbox,
	CreateRadio = KSLMenuUtil.CreateRadio,
	CreateHighlightRadio = KSLMenuUtil.CreateHighlightRadio,
	CreateDivider = KSLMenuUtil.CreateDivider,
	CreateSpacer = KSLMenuUtil.CreateSpacer,
	CreateColorSwatch = KSLMenuUtil.CreateColorSwatch,
};

function KSLMenuUtilPrivate.GetInserters()
	return KSLMenuUtilPrivate.Inserters;
end

local function DefaultTooltipInitializer(tooltip, elementDescription)
	local titleText = KSLMenuUtil.GetElementText(elementDescription);
	GameTooltip_SetTitle(tooltip, titleText);
end

local function SetTooltip(elementDescription, initializer)
	elementDescription:SetOnEnter(function(frame)
		KSLMenuUtil.ShowTooltip(frame, initializer or DefaultTooltipInitializer, elementDescription);
	end);
end

local function TitleAndTextTooltipInitializer(tooltip, tooltipTitle, tooltipText)
	GameTooltip_SetTitle(tooltip, tooltipTitle);
	GameTooltip_AddNormalLine(tooltip, tooltipText, true);
end

local function SetTitleAndTextTooltip(elementDescription, tooltipTitle, tooltipText)
	elementDescription:SetOnEnter(function(frame)
		KSLMenuUtil.ShowTooltip(frame, TitleAndTextTooltipInitializer, tooltipTitle, tooltipText);
	end);
end

local function QueueDescription(description, queueDescription, clearQueue)
	if clearQueue then
		description:ClearQueuedDescriptions();
	end
	description:AddQueuedDescription(queueDescription);
end

local function QueueTitle(description, text, color, clearQueue)
	QueueDescription(description, KSLMenuUtil.CreateTitle(text, color), clearQueue);
end

local function QueueDivider(description, clearQueue)
	QueueDescription(description, KSLMenuUtil.CreateDivider(), clearQueue);
end

local function QueueSpacer(description, extent, clearQueue)
	QueueDescription(description, KSLMenuUtil.CreateSpacer(extent), clearQueue);
end

KSLMenuUtilPrivate.Utilities =
{
	SetTooltip = SetTooltip,
	SetTitleAndTextTooltip = SetTitleAndTextTooltip,
	QueueTitle = QueueTitle,
	QueueDivider = QueueDivider,
	QueueSpacer = QueueSpacer,
};

function KSLMenuUtilPrivate.GetUtilities()
	return KSLMenuUtilPrivate.Utilities;
end

--Variadic menu functions

--[[
... is a variadic array of non-associative tables, whose values match the Inserter function below.
The 'data' argument is optional.
]]
function KSLMenuUtil.CreateButtonMenu(dropdown, ...)
	local function Inserter(text, onClick, data)
		return KSLMenuUtil.CreateButton(text, onClick, data);
	end

	return CreateDropdownMenuUsingInserter(dropdown, Inserter, ...);
end

function KSLMenuUtil.CreateButtonContextMenu(ownerRegion, ...)
	local function Inserter(text, onClick, data)
		return KSLMenuUtil.CreateButton(text, onClick, data);
	end
	return CreateContextMenuUsingInserter(ownerRegion, Inserter, ...);
end

--[[
... is a variadic array of non-associative tables, whose values match the Inserter function below.
The 'data' argument is optional.
]]
function KSLMenuUtil.CreateCheckboxMenu(dropdown, isSelected, setSelected, ...)
	local function Inserter(text, data)
		return KSLMenuUtil.CreateCheckbox(text, isSelected, setSelected, data);
	end

	return CreateDropdownMenuUsingInserter(dropdown, Inserter, ...);
end

function KSLMenuUtil.CreateCheckboxContextMenu(ownerRegion, isSelected, setSelected, ...)
	local function Inserter(text, data)
		return KSLMenuUtil.CreateCheckbox(text, isSelected, setSelected, data);
	end
	return CreateContextMenuUsingInserter(ownerRegion, Inserter, ...);
end

--[[
... is a variadic array of non-associative tables, whose values match the Inserter function below.
The 'data' argument is optional.
]]
function KSLMenuUtil.CreateRadioMenu(dropdown, isSelected, setSelected, ...)
	local function Inserter(text, data)
		return KSLMenuUtil.CreateRadio(text, isSelected, setSelected, data);
	end
	return CreateDropdownMenuUsingInserter(dropdown, Inserter, ...);
end

function KSLMenuUtil.CreateRadioContextMenu(ownerRegion, isSelected, setSelected, ...)
	local function Inserter(text, data)
		return KSLMenuUtil.CreateRadio(text, isSelected, setSelected, data);
	end
	return CreateContextMenuUsingInserter(ownerRegion, Inserter, ...);
end

local function CreateEnumTables(enum, enumTranslator, orderTbl)
	local enumTbls = {};

	for enumKey, enumValue in pairs(enum) do
		table.insert(enumTbls, { enumTranslator(enumValue), enumValue });
	end

	if orderTbl then
		table.sort(enumTbls, function(lhs, rhs)
			return orderTbl[lhs[2]] < orderTbl[rhs[2]];
		end);
	else
		table.sort(enumTbls, function(lhs, rhs)
			return lhs[2] < rhs[2];
		end);
	end

	return enumTbls;
end

function KSLMenuUtil.CreateEnumRadioMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl)
	local enumTbls = CreateEnumTables(enum, enumTranslator, orderTbl);
	return KSLMenuUtil.CreateRadioMenu(dropdown, isSelected, setSelected, unpack(enumTbls));
end

function KSLMenuUtil.CreateEnumRadioContextMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl)
	local enumTbls = CreateEnumTables(enum, enumTranslator, orderTbl);
	return KSLMenuUtil.CreateRadioContextMenu(dropdown, isSelected, setSelected, unpack(enumTbls));
end
