local AddonName, KeystoneLoot = ...;

local DB = KeystoneLoot.DB;
local Favorites = KeystoneLoot.Favorites;
local Character = KeystoneLoot.Character;
local L = KeystoneLoot.L;
local Voidcore = KeystoneLoot.Voidcore;

local NORMAL_R, NORMAL_G, NORMAL_B = NORMAL_FONT_COLOR:GetRGB();

local HIGHLIGHTS = {
    { key = "settings.highlighting.crit",        label = ITEM_MOD_CRIT_RATING_SHORT },
    { key = "settings.highlighting.haste",       label = ITEM_MOD_HASTE_RATING_SHORT },
    { key = "settings.highlighting.mastery",     label = ITEM_MOD_MASTERY_RATING_SHORT },
    { key = "settings.highlighting.versatility", label = ITEM_MOD_VERSATILITY },
    { key = "settings.highlighting.noStats",     label = L["No stats"] },
};

local function GetColoredCharacterName()
    local info = Character:ParseKey(Character:GetSelectedKey());
    if (not info) then
        return "";
    end

    local classFile = Character:GetClassFile(info.classId);
    local classColor = C_ClassColor.GetClassColor(classFile);
    return classColor:WrapTextInColorCode(info.name);
end

local function GetColoredCharacterLabel(data)
    local classColor = C_ClassColor.GetClassColor(data.classFile);
    return classColor:WrapTextInColorCode(data.name);
end

local function SetTooltip(description, text)
    description:SetTooltip(function(Tooltip)
        Tooltip:AddLine(text, NORMAL_R, NORMAL_G, NORMAL_B, true);
    end);
end

local function CreateSettingCheckbox(description, label, key)
    return description:CreateCheckbox(
        label,
        function() return DB:Get(key); end,
        function() DB:Set(key, not DB:Get(key)); end
    );
end

local function HandleImportResult(success, result, skippedSpecs, overwrite, importedSpecId)
    if (skippedSpecs) then
        print(RED_FONT_COLOR:WrapTextInColorCode(L["Some specs were skipped - import string belongs to a different class."]));
    end

    if (success) then
        if (result > 0) then
            local suffix = overwrite and L[" (overwritten)"] or "";
            print(YELLOW_FONT_COLOR:WrapTextInColorCode(string.format(L["%d |4favorite:favorites; imported%s."], result, suffix)));

            local info = Character:ParseKey(Character:GetSelectedKey());
            if (info) then
                DB:Set("filters.classId", info.classId);
            end

            DB:Set("filters.specId", importedSpecId);
            DB:Set("filters.slotId", -1);
        else
            print(YELLOW_FONT_COLOR:WrapTextInColorCode(L["All items are already in your favorites."]));
        end
    else
        print(YELLOW_FONT_COLOR:WrapTextInColorCode(string.format(L["Import failed - %s"], tostring(result))));
    end
end

StaticPopupDialogs.KEYSTONELOOT_DELETE_CHARACTER = {
    text = L["Delete all data for %s?"],
    button1 = DELETE,
    button2 = CANCEL,
    OnAccept = function(self, data)
        local wasSelected = data.key == Character:GetSelectedKey();

        if (Character:Delete(data.key) and wasSelected) then
            local key = Character:GetKey();
            DB:Set("ui.selectedCharacterKey", key);

            local info = Character:ParseKey(key);
            if (info) then
                DB:Set("filters.classId", info.classId);
                DB:Set("filters.specId", 0);
            end
        end
    end,
    timeout = 0,
    exclusive = true,
    whileDead = true,
    hideOnEscape = true
};

StaticPopupDialogs.KEYSTONELOOT_RESET_CHARACTER = {
    text = L["Reset all favorites of %s?"],
    button1 = RESET,
    button2 = CANCEL,
    OnAccept = function(self, data)
        if (Favorites:Reset(data.key)) then
            KeystoneLoot.APIInternal.RefreshUI();
        end
    end,
    timeout = 0,
    exclusive = true,
    whileDead = true,
    hideOnEscape = true
};

StaticPopupDialogs.KEYSTONELOOT_EXPORT = {
    text = L["Export favorites of %s"],
    button1 = CLOSE,
    hasEditBox = 1,
    editBoxWidth = 450,
    maxLetters = 0,
    OnShow = function(self)
        self:GetEditBox():SetText(Favorites:Export());
        self:GetEditBox():HighlightText();
        self:GetEditBox():SetFocus();
    end,
    OnHide = function(self, data)
        ChatFrameUtil.FocusActiveWindow();
        self:GetEditBox():SetText("");
    end,
    timeout = 0,
    exclusive = true,
    whileDead = true,
    hideOnEscape = true
};

StaticPopupDialogs.KEYSTONELOOT_IMPORT = {
    text = L["Import favorites for %s\nPaste import string here:"] .. "\n\n" .. L["Merge keeps your existing favorites and only adds new items. Overwrite replaces all of them."],
    button1 = L["Merge"],
    button2 = L["Overwrite"],
    button3 = CANCEL,
    hasEditBox = 1,
    editBoxWidth = 450,
    maxLetters = 0,
    OnAccept = function(self)
        local text = self:GetEditBox():GetText();
        local success, result, skippedSpecs, importedSpecId = Favorites:Import(text, false);
        HandleImportResult(success, result, skippedSpecs, false, importedSpecId);
    end,
    OnCancel = function(self)
        local text = self:GetEditBox():GetText();
        local success, result, skippedSpecs, importedSpecId = Favorites:Import(text, true);
        HandleImportResult(success, result, skippedSpecs, true, importedSpecId);
    end,
    OnHide = function(self, data)
        ChatFrameUtil.FocusActiveWindow();
        self:GetEditBox():SetText("");
    end,
    timeout = 0,
    exclusive = true,
    whileDead = true,
    hideOnEscape = true
};

StaticPopupDialogs.KEYSTONELOOT_WHISPER_MESSAGE = {
    text = L["Whisper message\n{item} will be replaced with the item link."],
    button1 = SAVE,
    button2 = CANCEL,
    hasEditBox = 1,
    editBoxWidth = 350,
    OnShow = function(self)
        self:GetEditBox():SetText(DB:Get("settings.lootReminder.whisperMessage"));
        self:GetEditBox():HighlightText();
        self:GetEditBox():SetFocus();
    end,
    OnAccept = function(self)
        local text = self:GetEditBox():GetText();
        if (text and text ~= "") then
            DB:Set("settings.lootReminder.whisperMessage", text);
        end
    end,
    OnHide = function(self)
        ChatFrameUtil.FocusActiveWindow();
        self:GetEditBox():SetText("");
    end,
    timeout = 0,
    exclusive = true,
    whileDead = true,
    hideOnEscape = true
};

KeystoneLootSettingsDropdownMixin = CreateFromMixins(KSLDropdownButtonMixin);

function KeystoneLootSettingsDropdownMixin:Init()
    self:SetupMenu(function(dropdown, rootDescription)
        rootDescription:SetTag("MENU_KEYSTONELOOT_SETTINGS_DROPDOWN");

        local generalMenu = rootDescription:CreateButton(GENERAL);

        local LDBIcon = LibStub and LibStub('LibDBIcon-1.0', true);
        if (LDBIcon) then
            generalMenu:CreateCheckbox(
                L["Minimap button"],
                function() return not DB:Get("settings.minimap.hide"); end,
                function()
                    DB:Set("settings.minimap.hide", not DB:Get("settings.minimap.hide"));

                    if (not DB:Get("settings.minimap.hide")) then
                        LDBIcon:Show(AddonName);
                    else
                        LDBIcon:Hide(AddonName);
                    end
                end
            );
        else
            CreateSettingCheckbox(generalMenu, L["Minimap button"], "settings.minimap.enabled");
        end

        generalMenu:CreateDivider();
        CreateSettingCheckbox(generalMenu, L["Item level in keystone tooltip"], "settings.keystoneTooltip");
        CreateSettingCheckbox(generalMenu, L["Favorite in item tooltip"], "settings.favoriteTooltip");
        CreateSettingCheckbox(generalMenu, L["Favorite on item icons"], "settings.favoriteIcon");
        CreateSettingCheckbox(generalMenu, L["Slot name on item icons"], "settings.slotName");

        generalMenu:CreateDivider();
        CreateSettingCheckbox(generalMenu, L['Hide "Other" in All Slots'], "settings.hideOtherItems");
        CreateSettingCheckbox(generalMenu, L["Multiple slot filtering"], "settings.multiSlotFilter");
        CreateSettingCheckbox(generalMenu, L["Wide mode"], "settings.wideMode");

        generalMenu:CreateDivider();
        local rescanButton = generalMenu:CreateButton(L["Rescan bonus rolls"], function()
            Voidcore:CheckAll(true);
        end);
        rescanButton:SetEnabled(UnitLevel("player") == 90);

        local notificationMenu = rootDescription:CreateButton(COMMUNITIES_NOTIFICATION_SETTINGS);

        local lootReminderMenu = notificationMenu:CreateButton(L["Loot reminder (dungeons)"]);

        local ownReminderCheckbox = CreateSettingCheckbox(lootReminderMenu, L["Own favorites"], "settings.lootReminder.dungeons");
        SetTooltip(ownReminderCheckbox, L["Reminds you on dungeon entry if your loot spec doesn't match your favorites, or if switching it could increase your chances of getting them."]);

        local partyReminderCheckbox = CreateSettingCheckbox(lootReminderMenu, L["Group favorites"], "settings.lootReminder.party");
        SetTooltip(partyReminderCheckbox, L["If you have no favorites in a dungeon, shows you the loot spec that lets items drop for you which your group members have marked as favorites. Only works if other group members also have this addon."]);

        local mythicPlusNotificationCheckbox = CreateSettingCheckbox(notificationMenu, L["Mythic+ notification"], "settings.mythicPlusNotification");
        SetTooltip(mythicPlusNotificationCheckbox, L["Shows the dungeon and your role with a teleport button when you join a Mythic+ group or the group becomes full."]);

        local dropAlertCheckbox = CreateSettingCheckbox(notificationMenu, L["Drop notification (favorites)"], "settings.lootReminder.dropAlert");
        SetTooltip(dropAlertCheckbox, L["Shows a notification when another player loots an item you have marked as a favorite."]);

        notificationMenu:CreateButton(L["Whisper message..."], function()
            StaticPopup_Show("KEYSTONELOOT_WHISPER_MESSAGE");
        end);

        local responseButton = rootDescription:CreateButton(L["Auto Keystone response"]);
        SetTooltip(responseButton, L["Automatically responds with your current Mythic+ keystone when someone types \"!keys\" in the selected chat channels. Only works if other group members also have this addon."]);

        responseButton:CreateCheckbox(
            L["Enable party chat"],
            function() return DB:Get("settings.keyCommand.CHAT_MSG_PARTY"); end,
            function()
                local responseToggle = not DB:Get("settings.keyCommand.CHAT_MSG_PARTY");
                DB:Set("settings.keyCommand.CHAT_MSG_PARTY", responseToggle);
                DB:Set("settings.keyCommand.CHAT_MSG_PARTY_LEADER", responseToggle);
            end
        );
        CreateSettingCheckbox(responseButton, L["Enable guild chat"], "settings.keyCommand.CHAT_MSG_GUILD");

        local manageButton = rootDescription:CreateButton(L["Manage characters"]);
        local extent = 20;
        local maxCharacters = 18;
        local maxScrollExtent = extent * maxCharacters;
        manageButton:SetScrollMode(maxScrollExtent);

        for _, data in ipairs(Character:GetAllCharacters(true)) do
            local isLoggedInChar = data.key == Character:GetKey();
            local charLabel;
            if (data.isHidden) then
                charLabel = DISABLED_FONT_COLOR:WrapTextInColorCode(string.format(LFG_LIST_TOOLTIP_CLASS_ROLE, data.name, data.realm));
            else
                charLabel = string.format(LFG_LIST_TOOLTIP_CLASS_ROLE, GetColoredCharacterLabel(data), data.realm);
            end

            local charSubmenu = manageButton:CreateButton(charLabel);

            charSubmenu:CreateCheckbox(
                L["Hidden"],
                function() return Character:IsHidden(data.key); end,
                function()
                    local nowHidden = not Character:IsHidden(data.key);
                    Character:SetHidden(data.key, nowHidden);

                    if (nowHidden and data.key == Character:GetSelectedKey()) then
                        DB:Set("ui.selectedCharacterKey", Character:GetKey());
                    end
                end
            );

            local deleteButton = charSubmenu:CreateButton(L["Delete..."], function()
                StaticPopup_Show("KEYSTONELOOT_DELETE_CHARACTER", GetColoredCharacterLabel(data), nil, data);
            end);

            if (isLoggedInChar) then
                deleteButton:SetEnabled(false);
                SetTooltip(deleteButton, L["Cannot delete the currently logged in character."]);
            else
                SetTooltip(deleteButton, L["Removes the selected character and all of its data."]);
            end
        end

        rootDescription:CreateDivider();

        rootDescription:CreateTitle(L["Highlighting"]);
        for _, entry in ipairs(HIGHLIGHTS) do
            local checkbox = CreateSettingCheckbox(rootDescription, entry.label, entry.key);

            if (entry.key == "settings.highlighting.noStats") then
                checkbox:SetEnabled(not DB:Get("settings.highlighting.comboMode"));
            end
        end

        local comboModeCheckbox = rootDescription:CreateCheckbox(
            L["Combination mode"],
            function() return DB:Get("settings.highlighting.comboMode"); end,
            function()
                DB:Set("settings.highlighting.comboMode", not DB:Get("settings.highlighting.comboMode"));
                self:GenerateMenu();
            end
        );
        SetTooltip(comboModeCheckbox, L["Highlights an item only if its stats match a combination of your selection. Otherwise one matching stat is enough."]);

        rootDescription:CreateTitle(FAVORITES);
        rootDescription:CreateButton(L["Export..."], function()
            StaticPopup_Show("KEYSTONELOOT_EXPORT", GetColoredCharacterName());
        end);
        rootDescription:CreateButton(L["Import..."], function()
            StaticPopup_Show("KEYSTONELOOT_IMPORT", GetColoredCharacterName());
        end);

        local resetButton = rootDescription:CreateButton(L["Reset..."], function()
            StaticPopup_Show("KEYSTONELOOT_RESET_CHARACTER", GetColoredCharacterName(), nil, { key = Character:GetSelectedKey() });
        end);
        SetTooltip(resetButton, L["Removes all favorites of the selected character."]);
    end);
end
