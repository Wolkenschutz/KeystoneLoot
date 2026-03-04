local AddonName, KeystoneLoot = ...;

local DB = KeystoneLoot.DB;
local Character = KeystoneLoot.Character;

KeystoneLootCharacterDropdownMixin = {};

function KeystoneLootCharacterDropdownMixin:Init()
    self:Refresh();

    local name = UnitName("player");
    local realm = GetRealmName();

    self:SetupMenu(function(dropdown, rootDescription)
        rootDescription:SetTag("MENU_KEYSTONELOOT_CHARACTER_DROPDOWN");

        local function IsSelected(data)
            return data.key == Character:GetSelectedKey();
        end

        local function SetSelected(data)
            DB:Set("ui.selectedCharacterKey", data.key);

            local info = Character:ParseKey(data.key);
            if (info) then
                DB:Set("filters.classId", info.classId);
                DB:Set("filters.specId", 0);
            end
        end

        for _, data in ipairs(Character:GetAllCharacters()) do
            local classColor = C_ClassColor.GetClassColor(data.classFile);

            local radio = rootDescription:CreateRadio(
                string.format(LFG_LIST_TOOLTIP_CLASS_ROLE, classColor:WrapTextInColorCode(data.name), data.realm),
                IsSelected, SetSelected, data
            );
        end
    end);

    DB:AddObserver("ui.selectedCharacterKey", function() self:Refresh(); end);
end

function KeystoneLootCharacterDropdownMixin:OnMouseDown()
    self:GetNormalTexture():AdjustPointsOffset(1, -1);
    self:GetHighlightTexture():AdjustPointsOffset(1, -1);
    self.Indicator:AdjustPointsOffset(1, -1);
end

function KeystoneLootCharacterDropdownMixin:OnMouseUp()
    self:GetNormalTexture():AdjustPointsOffset(-1, 1);
    self:GetHighlightTexture():AdjustPointsOffset(-1, 1);
    self.Indicator:AdjustPointsOffset(-1, 1);
end

function KeystoneLootCharacterDropdownMixin:Refresh()
    local info = Character:ParseKey(Character:GetSelectedKey());
    if (not info) then
        return;
    end

    local classInfo = C_CreatureInfo.GetClassInfo(info.classId);
    local classColor = C_ClassColor.GetClassColor(classInfo.classFile);
    self.Indicator:SetVertexColor(classColor.r, classColor.g, classColor.b);
end
