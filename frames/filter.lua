local AddonName, Addon = ...;


local FilterBg = Addon.Frames.Overview:CreateTexture(nil, 'BACKGROUND');
FilterBg:SetSize(340, 34);
FilterBg:SetPoint('TOP', 0, -30);
FilterBg:SetTexture('Interface\\QuestFrame\\UI-QuestLogTitleHighlight');
FilterBg:SetBlendMode('ADD');
FilterBg:SetVertexColor(0.1, 0.1, 0.1, 1);