local AddonName, KeystoneLoot = ...;


local TabFrame = KeystoneLoot:CreateTab('raids', 2, RAIDS);

local NoSeasonText = TabFrame:CreateFontString('ARTWORK', nil, 'GameFontHighlightLarge');
NoSeasonText:Hide();
NoSeasonText:SetPoint('TOPLEFT', 20, -80);
NoSeasonText:SetPoint('BOTTOMRIGHT', -20, 26);
NoSeasonText:SetText(FEATURE_NOT_YET_AVAILABLE);




do
	local firstTime = true;
	local function OnShow(self)
		if (firstTime) then
			firstTime = false;
			--TODO: Raids und so einmalig erstellen
		end

		-- TODO: Dropdown-Buttons Text einstellen
		-- Loot anzeigen

		NoSeasonText:Show();
    	self:SetSize(476, 230);
	end

	TabFrame:SetScript('OnShow', OnShow);
end