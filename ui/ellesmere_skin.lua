local AddonName, KeystoneLoot = ...;

if (not EllesmereUI or not EllesmereUI.RegisterSkin) then
    return;
end

local skin;

local function SkinMainFrame(Frame)
    skin.Shell(Frame);
    skin.CloseButton(Frame.CloseButton);
    skin.FadeRegions(Frame.PortraitContainer);

    for _, Tab in ipairs(Frame.TabSystem.tabs) do
        skin.Tab(Tab);
    end

    skin.Dropdown(Frame.ClassDropdown);
    skin.Dropdown(Frame.SlotDropdown);
    skin.Dropdown(Frame.ItemLevelDropdown);

    skin.Font(Frame.FooterText);
end

local function SkinSidePanel(Panel)
    skin.Panel(Panel);
    skin.FadeRegions(Panel.Border);
end

local function SkinPopupFrame(Frame)
    skin.Shell(Frame);
    skin.CloseButton(Frame.CloseButton);
end

local function SkinMenu(Menu)
    if (Menu:IsForbidden()) then
        return;
    end

    skin.Panel(Menu, { noBg = true });

    local r, g, b, a = skin.GetPanelColor();

    for _, Region in ipairs({ Menu:GetRegions() }) do
        if (Region:IsObjectType("Texture")) then
            Region:SetColorTexture(r, g, b, 1);
            Region:SetAlpha(a);
            Region:ClearAllPoints();
            Region:SetPoint("TOPLEFT", Menu, "TOPLEFT", 1, -1);
            Region:SetPoint("BOTTOMRIGHT", Menu, "BOTTOMRIGHT", -1, 1);
        end
    end
end

local function SkinRaidBlocks(Frame)
    for Block in Frame.blockPool:EnumerateActive() do
        skin.Inset(Block.Inset);
        skin.FadeRegions(Block.BorderFrame);
    end
end

local function SkinIconHolder(Holder)
    skin.SquareIcon(Holder.Icon, Holder);

    Holder.IconBorder:SetAlpha(0);

    for _, key in ipairs({ "FavoriteIcon", "VoidcoreIcon", "OwnedIcon" }) do
        if (Holder[key]) then
            Holder[key]:SetDrawLayer("OVERLAY", 1);
        end
    end
end

local function SkinWidgets(Frame)
    for _, Child in ipairs({ Frame:GetChildren() }) do
        if (Child.Icon and Child.IconBorder) then
            SkinIconHolder(Child);
        else
            if (Child.LootSpecButton) then
                skin.Button(Child.LootSpecButton);
            end

            SkinWidgets(Child);
        end
    end
end

local function Apply()
    SkinMainFrame(KeystoneLootFrame);
    SkinSidePanel(KeystoneLootFrame.CatalystFrame);
    SkinSidePanel(KeystoneLootFrame.CustomItemFrame);

    skin.Inset(KeystoneLootFrame.DungeonsFrame.Inset);
    skin.FadeRegions(KeystoneLootFrame.DungeonsFrame.BorderFrame);
    skin.Dropdown(KeystoneLootFrame.RaidsFrame.DropdownButton);

    hooksecurefunc(KeystoneLootFrame.RaidsFrame, "Refresh", SkinRaidBlocks);
    SkinRaidBlocks(KeystoneLootFrame.RaidsFrame);

    for _, Frame in ipairs({ KeystoneLootFrame.DungeonsFrame, KeystoneLootFrame.RaidsFrame,
        KeystoneLootFrame.CatalystFrame, KeystoneLootFrame.CustomItemFrame,
        KeystoneLootDropNotificationFrame }) do
        hooksecurefunc(Frame, "Refresh", SkinWidgets);
        SkinWidgets(Frame);
    end

    hooksecurefunc(KeystoneLootReminderFrame, "Open", SkinWidgets);
    SkinWidgets(KeystoneLootMythicPlusNotificationFrame);

    hooksecurefunc(KSLMenuStyle1Mixin, "Generate", function(Menu)
        RunNextFrame(function()
            SkinMenu(Menu);
        end);
    end);

    SkinPopupFrame(KeystoneLootReminderFrame);
    SkinPopupFrame(KeystoneLootDropNotificationFrame);
    SkinPopupFrame(KeystoneLootMythicPlusNotificationFrame);
end

EllesmereUI.RegisterSkin(AddonName, function(S)
    skin = S;

    KeystoneLoot.API:RegisterCallback("READY", Apply, AddonName);
end);
