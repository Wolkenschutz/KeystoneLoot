-- !keys Chat-Befehl: postet den eigenen Keystone in den Party-Chat

local function GetMyKeystoneLink()
    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local link = C_Container.GetContainerItemLink(bag, slot)
            if link and link:find("Hkeystone:", 1, true) then
                return link
            end
        end
    end
    return nil
end

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_PARTY")
f:RegisterEvent("CHAT_MSG_PARTY_LEADER")

f:SetScript("OnEvent", function(self, event, msg)
    if msg:lower():match("^!keys%s*$") then
        local link = GetMyKeystoneLink()
        C_Timer.After(math.random() * 1.5, function()
            if link then
                SendChatMessage("[KeystoneLoot]: " .. link, "PARTY")
            else
                SendChatMessage("Ich habe aktuell keinen Keystone.", "PARTY")
            end
        end)
    end
end)