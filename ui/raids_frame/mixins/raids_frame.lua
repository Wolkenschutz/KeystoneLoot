local AddonName, KeystoneLoot = ...;

local DB = KeystoneLoot.DB;
local Query = KeystoneLoot.Query;

KeystoneLootRaidsFrameMixin = {};

function KeystoneLootRaidsFrameMixin:OnLoad()
    self.Inset.Bg:SetAlpha(0.75);
    self.Inset.Bg:SetAtlas("UI-Frame-Dragonflight-BackgroundTile");

    self.entryPool = CreateFramePool("Frame", self.Container, "KeystoneLootEntryFrameTemplate");
end

function KeystoneLootRaidsFrameMixin:RefreshSize()
    local Parent = self:GetParent();
    if (Parent.raidsTabId) then
        Parent:RefreshSize(Parent.raidsTabId);
    end
end

function KeystoneLootRaidsFrameMixin:Init()
    local raids = Query:GetRaids();
    self.DropdownButton:Init(raids);

    local function OnChanged()
        if (not self:IsShown()) then
            return;
        end

        self:SetRaid(self.currentRaid)
    end

    DB:AddObserver("filters.specId", OnChanged);
    DB:AddObserver("filters.slotId", OnChanged);
    DB:AddObserver("filters.raid.rank", OnChanged);
    DB:AddObserver("ui.selectedCharacterKey", OnChanged);
    DB:AddObserver("ui.selectedTab", OnChanged);
    DB:AddObserver("settings.highlighting.*", OnChanged);

    self:SetRaid(raids[1]);
end

function KeystoneLootRaidsFrameMixin:SetRaid(raid)
    self.currentRaid = raid;
    self.entryPool:ReleaseAll();

    local height = 0;
    height = height + 84; -- margin top
    height = height + 4;  -- padding top

    local numBosses = #raid.bossList;

    for index = 1, numBosses do
        local boss = raid.bossList[index];
        local isLastEntry = index == numBosses;
        local lootTable = Query:GetRaidItems(boss.bossId);

        height = height + (not isLastEntry and 54 or 53); -- entry height

        local Frame = self.entryPool:Acquire();
        Frame:Init(index, boss, lootTable, isLastEntry);
        Frame:Show();
    end

    height = height + 4;  -- padding bottom
    height = height + 24; -- margin bottom

    self:SetHeight(height);
    self.Container:Layout();
    self:RefreshSize();
end
