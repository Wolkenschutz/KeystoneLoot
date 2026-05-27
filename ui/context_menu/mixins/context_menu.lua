local AddonName, KeystoneLoot = ...;

local Favorites               = KeystoneLoot.Favorites;
local L                       = KeystoneLoot.L;
local Voidcore                = KeystoneLoot.Voidcore;

local HEIGHT_NO_REMOVE        = 139; -- top(8) + title(20) + 4 rows(96) + bottom(15)
local HEIGHT_REMOVE           = 176; -- + divider(13) + remove(24)
local HEIGHT_VOIDCORE         = 57; -- + divider(13) + voidcore title(20) + voidcore row(24)

local RADIO_WIDTH             = 22;
local CHECKBOX_WIDTH          = 22;
local INSET_LEFT              = 8;
local INSET_RIGHT             = 8;
local RADIO_SPACING           = 1;
local CHECK_SPACING           = 7;
local MIN_WIDTH               = 100;

local function HandlesGlobalMouse(self, buttonName, event)
    return event == "GLOBAL_MOUSE_DOWN" and buttonName == "LeftButton";
end

local function SetupButtonHighlight(Button)
    Button:SetScript("OnEnter", function(self) self.Highlight:Show(); end);
    Button:SetScript("OnLeave", function(self) self.Highlight:Hide(); end);
    Button.HandlesGlobalMouse = HandlesGlobalMouse;
end

KeystoneLootContextMenuMixin = {};

function KeystoneLootContextMenuMixin:OnLoad()
    self.Title:SetText(L["Set Favorite"]);
    self.VoidcoreTitle.Label:SetText(BONUS_LOOT_LABEL);
    self.VoidcoreCheck.Label:SetText(L["Voidcore used"]);

    self.TierNice.Label:SetText(Favorites.TIER_NAME[Favorites.TIER_NICE]);
    self.TierMust.Label:SetText(Favorites.TIER_NAME[Favorites.TIER_MUST]);
    self.TierBis.Label:SetText(Favorites.TIER_NAME[Favorites.TIER_BIS]);
    self.TierTransmog.Label:SetText(Favorites.TIER_NAME[Favorites.TIER_TRANSMOG]);

    SetupButtonHighlight(self.TierNice);
    SetupButtonHighlight(self.TierMust);
    SetupButtonHighlight(self.TierBis);
    SetupButtonHighlight(self.TierTransmog);
    SetupButtonHighlight(self.RemoveButton);
    SetupButtonHighlight(self.VoidcoreCheck);

    self.TierNice:SetScript("OnClick", function()
        self:OnTierClicked(Favorites.TIER_NICE);
    end);

    self.TierMust:SetScript("OnClick", function()
        self:OnTierClicked(Favorites.TIER_MUST);
    end);

    self.TierBis:SetScript("OnClick", function()
        self:OnTierClicked(Favorites.TIER_BIS);
    end);

    self.TierTransmog:SetScript("OnClick", function()
        self:OnTierClicked(Favorites.TIER_TRANSMOG);
    end);

    self.RemoveButton:SetScript("OnClick", function()
        self:OnRemoveClicked();
    end);

    self.VoidcoreCheck:SetScript("OnClick", function()
        self:OnVoidcoreClicked();
    end);

    local radioOffset = RADIO_WIDTH + RADIO_SPACING;
    local checkOffset = CHECKBOX_WIDTH + CHECK_SPACING;

    local maxWidth    = MIN_WIDTH;
    local function CheckWidth(label, iconOffset)
        local w = INSET_LEFT + (iconOffset or 0) + label:GetStringWidth() + INSET_RIGHT;
        if (w > maxWidth) then
            maxWidth = w;
        end
    end

    CheckWidth(self.TierNice.Label, radioOffset);
    CheckWidth(self.TierMust.Label, radioOffset);
    CheckWidth(self.TierBis.Label, radioOffset);
    CheckWidth(self.TierTransmog.Label, radioOffset);
    CheckWidth(self.RemoveButton.Label, 0);
    CheckWidth(self.VoidcoreTitle.Label, 0);
    CheckWidth(self.VoidcoreCheck.Label, checkOffset);

    self:SetWidth(maxWidth);

    table.insert(UISpecialFrames, self:GetName());
end

function KeystoneLootContextMenuMixin:OnShow()
    self:RegisterEvent("GLOBAL_MOUSE_DOWN");
end

function KeystoneLootContextMenuMixin:OnHide()
    self:UnregisterEvent("GLOBAL_MOUSE_DOWN");
end

function KeystoneLootContextMenuMixin:OnEvent(event, buttonName)
    local foci = GetMouseFoci();
    local focus = foci and foci[1];
    if (not focus or not (focus.HandlesGlobalMouse and focus:HandlesGlobalMouse(buttonName, event))) then
        self:Close();
    end
end

function KeystoneLootContextMenuMixin:HandlesGlobalMouse(buttonName, event)
    return event == "GLOBAL_MOUSE_DOWN" and buttonName == "LeftButton";
end

function KeystoneLootContextMenuMixin:Open(AnchorFrame, data)
    self.data = data;

    GameTooltip:Hide();

    self:UpdateContent();
    self:ClearAllPoints();
    self:SetPoint("TOPLEFT", AnchorFrame, "BOTTOMRIGHT", 0, 10);

    self:Show();
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

function KeystoneLootContextMenuMixin:Close()
    self:Hide();
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
end

function KeystoneLootContextMenuMixin:UpdateContent()
    local data = self.data;
    local currentTier = data.currentTier;
    local hasRemove = currentTier > 0;

    self.TierNice.RadioTick:SetShown(currentTier == Favorites.TIER_NICE);
    self.TierMust.RadioTick:SetShown(currentTier == Favorites.TIER_MUST);
    self.TierBis.RadioTick:SetShown(currentTier == Favorites.TIER_BIS);
    self.TierTransmog.RadioTick:SetShown(currentTier == Favorites.TIER_TRANSMOG);

    self.Divider1:SetShown(hasRemove);
    self.RemoveButton:SetShown(hasRemove);

    local hasVoidcore = Voidcore:IsEligible(data.itemId);
    self.Divider2:SetShown(hasVoidcore);
    self.VoidcoreTitle:SetShown(hasVoidcore);
    self.VoidcoreCheck:SetShown(hasVoidcore);

    if (hasVoidcore) then
        self.VoidcoreCheck.CheckTick:SetShown(Voidcore:IsUsed(data.itemId));

        self.Divider2:ClearAllPoints();
        if (hasRemove) then
            self.Divider2:SetPoint("TOPLEFT", self.RemoveButton, "BOTTOMLEFT", 8, 0);
        else
            self.Divider2:SetPoint("TOPLEFT", self.TierTransmog, "BOTTOMLEFT");
        end
        self.Divider2:SetPoint("RIGHT", self, "RIGHT");
    end

    local baseHeight = hasRemove and HEIGHT_REMOVE or HEIGHT_NO_REMOVE;
    self:SetHeight(baseHeight + (hasVoidcore and HEIGHT_VOIDCORE or 0));
end

function KeystoneLootContextMenuMixin:OnTierClicked(tier)
    local data = self.data;

    if (data.currentTier > 0) then
        Favorites:SetTier(data.itemId, data.specId, tier);
    else
        Favorites:Add(data.sourceId, data.specId, data.itemId, data.icon, tier);
    end

    data.currentTier = tier;
    data.Button:UpdateFavoriteIcon();

    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
    self:Close();
end

function KeystoneLootContextMenuMixin:OnRemoveClicked()
    local data = self.data;

    Favorites:Remove(data.itemId, data.specId);
    data.currentTier = 0;
    data.Button:UpdateFavoriteIcon();

    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
    self:Close();
end

function KeystoneLootContextMenuMixin:OnVoidcoreClicked()
    local data = self.data;
    local nowUsed = not Voidcore:IsUsed(data.itemId);

    Voidcore:SetUsed(data.itemId, nowUsed);
    self.VoidcoreCheck.CheckTick:SetShown(nowUsed);
    data.Button:UpdateVoidcoreIcon();

    PlaySound(nowUsed and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
end
