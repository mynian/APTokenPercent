--Scan the tooltip for the artifact power amount of the item
local function ArtifactPowerScan(self)

--Get points spent in equipped artifact
local points = select(6, C_ArtifactUI.GetEquippedArtifactInfo())
local tier = select(13, C_ArtifactUI.GetEquippedArtifactInfo())
local maxpower = C_ArtifactUI.GetCostForPointAtRank(points,tier)
local appower = 0
local appercent = 0

	--Loop through the tooltip
	for i=1, self:NumLines() do
		--Check for the Artifact Power line
		if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ARTIFACT_POWER"])) then
			--If found loop again to find the amount
			for i=1, self:NumLines() do
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["USE"])) then
					appower = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
					appower = string.gsub(string.gsub(appower, "%,", ""), "%.", "");
					break
				end
			end
				
		end
	end

	--Check to see if we found an amount
	if appower ~= 0 then
		
		--Determine the progress amount
		appercent = appower / maxpower
		
		--Add that shit to the tooltip
		GameTooltip:AddLine("Artifact Power Percent: " .. string.format("%3.5f", appercent) .. "%",1,1,1)
		
	end

	
end

--Hook it, hook it real good
GameTooltip:HookScript("OnTooltipSetItem", ArtifactPowerScan);
