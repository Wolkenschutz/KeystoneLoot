-- Shows the favorite tier icon on item buttons.
--
-- Blizzard:    bags, bank, character frame, inspect, equipment flyout, loot frame
-- Bag addons:  Bagnon, Bagnonium, Inventorian, ArkInventory, BetterBags,
--              Baggins, LiteBag (Commented out Baganator; see comment)

local AddonName, KeystoneLoot = ...;

local Favorites = KeystoneLoot.Favorites;
local Character = KeystoneLoot.Character;
local DB = KeystoneLoot.DB;

local ICON_SIZE = 18;

local ICON_ANCHOR = {
    TOPLEFT    = { 1, -1 },
    BOTTOMLEFT = { 1, 1 },
};

local trackedButtons = setmetatable({}, { __mode = "k" });

local function SetTier(Button, tier, point)
    if (not tier or tier == 0) then
        if (Button.KeystoneLootTierIcon) then
            Button.KeystoneLootTierIcon:Hide();
        end

        return;
    end

    if (not Button.KeystoneLootTierIcon) then
        point = point or "TOPLEFT";

        local Icon = Button:CreateTexture(nil, "OVERLAY", nil, 5);
        Icon:SetSize(ICON_SIZE, ICON_SIZE);
        Icon:SetPoint(point, unpack(ICON_ANCHOR[point]));

        Button.KeystoneLootTierIcon = Icon;
    end

    Button.KeystoneLootTierIcon:SetTexture(Favorites:GetTierIcon(tier));
    Button.KeystoneLootTierIcon:Show();
end

local function UpdateByItemId(Button, itemId, characterKey, point)
    if (characterKey == nil) then
        characterKey = Character:GetKey();
    end

    Button.KeystoneLootItemId = itemId;
    Button.KeystoneLootCharacterKey = characterKey;
    Button.KeystoneLootPoint = point;

    trackedButtons[Button] = itemId and true or nil;

    local tier = itemId and DB:Get("settings.favoriteIcon")
        and Favorites:GetAnyTierForKey(itemId, characterKey) or 0;

    SetTier(Button, tier, point);
end

local function UpdateByItemLink(Button, itemLink, characterKey, point)
    UpdateByItemId(Button, itemLink and tonumber(string.match(itemLink, "item:(%d+)")), characterKey, point);
end

local function UpdateByContainerSlot(Button, bagId, slotId, characterKey)
    UpdateByItemId(Button, bagId and slotId and C_Container.GetContainerItemID(bagId, slotId), characterKey);
end

local function UpdateContainer(Frame)
    for _, ItemButton in Frame:EnumerateValidItems() do
        UpdateByContainerSlot(ItemButton, ItemButton:GetBagID(), ItemButton:GetID());
    end
end

hooksecurefunc(ContainerFrameCombinedBags, "UpdateItems", UpdateContainer);

for _, Frame in ipairs(ContainerFrameContainer.ContainerFrames) do
    hooksecurefunc(Frame, "UpdateItems", UpdateContainer);
end

local function UpdateBank(Panel)
    local canUseBank = C_Bank.CanUseBank(Panel:GetActiveBankType());

    for ItemButton in Panel:EnumerateValidItems() do
        if (canUseBank) then
            UpdateByContainerSlot(ItemButton, ItemButton:GetBankTabID(), ItemButton:GetContainerSlotID());
        else
            SetTier(ItemButton, 0);
        end
    end
end

hooksecurefunc(BankPanel, "GenerateItemSlotsForSelectedTab", UpdateBank);
hooksecurefunc(BankPanel, "RefreshAllItemsForSelectedTab", UpdateBank);

local function UpdateEquippedSlot(Button, unit)
    local slotId = Button:GetID();

    if (slotId < INVSLOT_FIRST_EQUIPPED or slotId > INVSLOT_LAST_EQUIPPED) then
        return;
    end

    UpdateByItemId(Button, GetInventoryItemID(unit, slotId));
end

hooksecurefunc("PaperDollItemSlotButton_Update", function(Button)
    UpdateEquippedSlot(Button, "player");
end);

EventUtil.ContinueOnAddOnLoaded("Blizzard_InspectUI", function()
    hooksecurefunc("InspectPaperDollItemSlotButton_Update", function(Button)
        UpdateEquippedSlot(Button, InspectFrame.unit or "target");
    end);
end);

local function GetFlyoutItemId(Button)
    local location = Button.location;

    if (not location) then
        return nil;
    end

    if (type(location) == "table") then
        return C_Item.DoesItemExist(location) and C_Item.GetItemID(location) or nil;
    end

    if (location >= EQUIPMENTFLYOUT_FIRST_SPECIAL_LOCATION) then
        return nil;
    end

    local itemId = EquipmentManager_GetItemInfoByLocation(location);

    return itemId;
end

hooksecurefunc("EquipmentFlyout_UpdateItems", function()
    for _, Button in ipairs(EquipmentFlyoutFrame.buttons) do
        if (Button:IsShown()) then
            UpdateByItemId(Button, GetFlyoutItemId(Button));
        else
            SetTier(Button, 0);
        end
    end
end);

LootFrame.ScrollBox:RegisterCallback("OnUpdate", function()
    LootFrame.ScrollBox:ForEachFrame(function(Frame)
        if (not Frame.Item) then
            return;
        end

        local data = Frame:GetElementData();
        UpdateByItemLink(Frame.Item, data and data.slotIndex and GetLootSlotLink(data.slotIndex));
    end);
end);

local function GetOwnerKey(Button)
    local owner = Button.GetOwner and Button:GetOwner();

    if (not owner or owner.isguild) then
        return Character:GetKey();
    end

    return Character:FindKey(owner.name, owner.realm);
end

local function UpdateBagBrotherButton(Button, info)
    info = info or Button.info;

    UpdateByItemId(Button, info and info.itemID, GetOwnerKey(Button));
end

for _, addon in ipairs({ "Bagnon", "Bagnonium" }) do
    EventUtil.ContinueOnAddOnLoaded(addon, function()
        hooksecurefunc(_G[addon].Item, "Update", UpdateBagBrotherButton);
    end);
end

EventUtil.ContinueOnAddOnLoaded("Baggins", function()
    hooksecurefunc(Baggins, "UpdateItemButton", function(_, _, Button, bag)
        UpdateByContainerSlot(Button, bag, Button:GetID());
    end);
end);

EventUtil.ContinueOnAddOnLoaded("LiteBag", function()
    LiteBag_RegisterHook("LiteBagItemButton_Update", function(Button)
        UpdateByContainerSlot(Button, Button:GetParent():GetID(), Button:GetID());
    end);
end);

EventUtil.ContinueOnAddOnLoaded("Inventorian", function()
    local inventorian = LibStub("AceAddon-3.0", true):GetAddon("Inventorian", true);

    if (not inventorian) then
        return;
    end

    local function ToIndex(bag, slot)
        return (bag < 0 and bag * 100 - slot) or (bag * 100 + slot);
    end

    local function GetCharacterKey(Container)
        local Frame = Container:GetParent();
        local playerName = Frame and Frame.GetPlayerName and Frame:GetPlayerName();

        if (not playerName) then
            return Character:GetKey();
        end

        local name, realm = string.match(playerName, "^(.+) %- (.+)$");

        return Character:FindKey(name or playerName, realm);
    end

    local function UpdateSlot(Container, bag, slot)
        local Button = Container.items[ToIndex(bag, slot)];

        if (not Button) then
            return;
        end

        local _, _, _, _, _, _, link = Button:GetInfo();

        UpdateByItemLink(Button, link, GetCharacterKey(Container));
    end

    local function Hook()
        hooksecurefunc(inventorian.bag.itemContainer, "UpdateSlot", UpdateSlot);
        hooksecurefunc(inventorian.bank.itemContainer, "UpdateSlot", UpdateSlot);
    end

    if (inventorian.bag) then
        Hook();
    else
        hooksecurefunc(inventorian, "OnEnable", Hook);
    end
end);

EventUtil.ContinueOnAddOnLoaded("ArkInventory", function()
    local function GetCharacterKey(locId, bagId)
        local map = ArkInventory.Util.MapGetWindow(locId, bagId);
        local storage = map and ArkInventory.Codex.GetStorage(nil, map.loc_id_storage);
        local playerId = storage and storage.data and storage.data.info and storage.data.info.player_id;

        if (not playerId) then
            return Character:GetKey();
        end

        local name, realm = string.match(playerId, "^(.+) %- (.+)$");

        return Character:FindKey(name or playerId, realm);
    end

    hooksecurefunc(ArkInventory.API, "ItemFrameUpdated", function(Frame, locId, bagId)
        local item = ArkInventory.API.ItemFrameItemTableGet(Frame);

        UpdateByItemLink(Frame, item and item.h, GetCharacterKey(locId, bagId), "BOTTOMLEFT");
    end);
end);

EventUtil.ContinueOnAddOnLoaded("Baganator", function()
    local function GetViewCharacterKey(CornerFrame)
        local Frame = CornerFrame;

        while (Frame) do
            if (Frame.lastCharacter) then
                local name, realm = string.match(Frame.lastCharacter, "^(.-)%-(.+)$");
                return Character:FindKey(name, realm);
            end

            Frame = Frame:GetParent();
        end

        return Character:GetKey();
    end

    Baganator.API.RegisterCornerWidget(
        AddonName,
        "keystoneloot-favorite",
        function(CornerFrame, details)
            local itemId = details.itemLink
                and (tonumber(string.match(details.itemLink, "item:(%d+)")) or tonumber(details.itemLink));
            local tier = itemId and DB:Get("settings.favoriteIcon")
                and Favorites:GetAnyTierForKey(itemId, GetViewCharacterKey(CornerFrame)) or 0;

            if (tier == 0) then
                return false;
            end

            CornerFrame:SetTexture(Favorites:GetTierIcon(tier));

            return true;
        end,
        function(ItemButton)
            local Texture = ItemButton:CreateTexture(nil, "ARTWORK");
            Texture:SetSize(ICON_SIZE, ICON_SIZE);

            return Texture;
        end,
        { corner = "top_left", priority = 1 }
    );
end);

EventUtil.ContinueOnAddOnLoaded("BetterBags", function()
    local betterBags = LibStub("AceAddon-3.0", true):GetAddon("BetterBags", true);

    if (not betterBags) then
        return;
    end

    betterBags:GetModule("Events"):RegisterMessage("bag/Rendered", function(_, Bag)
        if (not Bag or not Bag.currentView) then
            return;
        end

        for _, item in pairs(Bag.currentView:GetItemsByBagAndSlot()) do
            local data = item:GetItemData();
            local itemLink = data and not data.isItemEmpty and data.itemInfo and data.itemInfo.itemLink;

            UpdateByItemLink(item.button, itemLink or nil);
        end
    end);
end);

local function RefreshTrackedButtons()
    for Button in pairs(trackedButtons) do
        if (Button:IsVisible()) then
            UpdateByItemId(Button, Button.KeystoneLootItemId, Button.KeystoneLootCharacterKey, Button.KeystoneLootPoint);
        end
    end
end

KeystoneLoot.API:RegisterCallback("FAVORITES_CHANGED", RefreshTrackedButtons, AddonName);
