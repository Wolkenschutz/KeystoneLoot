local AddonName, Addon = ...;

local Overview = {};
Addon.Overview = Overview;


local function Tab_OnClick(self)
	local OverviewFrame = Addon.Frames.Overview;
	local Tabs = OverviewFrame.Tabs;

	local tabID = self:GetID();

	for i=1, #Tabs do
		Tabs[i].TabFrame:SetShown(i == tabID);
	end

	PanelTemplates_SetTab(OverviewFrame, tabID);
	Addon.DropDownMenu:Close();
end

function Overview:RegisterTab(tabID, text)
	local OverviewFrame = Addon.Frames.Overview;

	local numTabs = #OverviewFrame.Tabs + 1;

	local TabFrame = CreateFrame('Frame', nil, OverviewFrame);
	TabFrame.ID = tabID;
	TabFrame:SetAllPoints();

	local TabButton = CreateFrame('Button', nil, OverviewFrame, 'PanelTabButtonTemplate');
	TabButton.TabFrame = TabFrame;
	TabButton:SetID(numTabs);
	TabButton:SetScript('OnClick', Tab_OnClick);
	TabButton:SetText(text);
    TabButton:SetPoint('TOPLEFT', OverviewFrame, 'BOTTOMLEFT', 11, 2);

	OverviewFrame.Tabs[numTabs] = TabButton;

	PanelTemplates_SetNumTabs(OverviewFrame, numTabs);
	PanelTemplates_SetTab(OverviewFrame, 1);

	return TabFrame;
end

function Overview:GetTab(tabID)
	for index, TabButton in next, Addon.Frames.Overview.Tabs do
		if (TabButton.TabFrame.ID == tabID) then
			return TabButton.TabFrame;
		end
	end
end

function Overview:SetHeight(height)
	Addon.Frames.Overview:SetHeight(height);
end