
--Scan the tooltip for the artifact power amount of the item
local function ArtifactPowerScan(self)

--Get points spent in equipped artifact
local points = select(6, C_ArtifactUI.GetEquippedArtifactInfo())
local tier = select(13, C_ArtifactUI.GetEquippedArtifactInfo())
local maxpower = C_ArtifactUI.GetCostForPointsAtRank(points,tier)
local appower
local appercent

	--Loop through the tooltip
	for i=1, self:NumLines() do
		--Check for the Artifact Power line
		if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ARTIFACT_POWER"])) then
			--If found loop again to find the amount
			for i=1 self:NumLines() do
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["USE"])) then
					appower = string.match("%s?(%d+%,?%.?%s?%d*)%s?");
					break
				end
			end
				
		end
	end

appercent = appower / maxpower

GameTooltip:SetOwner(TargetFrame, "ANCHOR_RIGHT")
GameTooltip:AddLine("appercent .. %")
GameTooltip:Show()	
end

GameTooltip:HookScript("OnTooltipSetItem", ArtifactPowerScan);
