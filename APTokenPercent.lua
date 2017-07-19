--Scan the tooltip for the artifact power amount of the item
local function ArtifactPowerScan(self)

local HasArtifactEquip = HasArtifactEquipped()
    
    if not (HasArtifactEquip) then
        return
    end

--Get points spent in equipped artifact
local points = select(6, C_ArtifactUI.GetEquippedArtifactInfo())
local tier = select(13, C_ArtifactUI.GetEquippedArtifactInfo())
local maxpower = C_ArtifactUI.GetCostForPointAtRank(points,tier)
local appower = 0
local appercent = 0
local puncheck

	--Loop through the tooltip
	for i=1, self:NumLines() do
		--Check for the Artifact Power line
		if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["ARTIFACT_POWER"])) then
			--If found loop again to find the amount
			for i=1, self:NumLines() do
				if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["USE"])) then
					--Check for "million"
					if(string.find(_G[self:GetName().."TextLeft"..i]:GetText(), _G["SECOND_NUMBER"])) then
						appower = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
						puncheck = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%p$");
						--[[DEBUG
						print(appower .. " first")						
						print(puncheck)]]
						appower = string.gsub(string.gsub(appower, "%,", ""), "%.", "");
						--[[DEBUG
						print(appower .. " second")]]
						appower = tonumber(appower)
						--[[DEBUG
						print(appower .. " third")]]
							if appower >= 100 then
								if puncheck == "." then
									appower = appower * 100000
									--[[DEBUG
									print(appower .. " fourth")]]
									break
								else
									appower = appower * 1000000
									--[[DEBUG
									print(appower .. " fifth")]]
									puncheck = nil
									break
								end
							else 
								appower = appower * 1000000
								--[[DEBUG
								print(appower .. " sixth")]]
								break
							end
					else
						appower = string.match(_G[self:GetName().."TextLeft"..i]:GetText(), "%d+%,?%.?%s?%d*");
						--[[DEBUG
						print(appower .. " seventh")]]
						appower = string.gsub(string.gsub(appower, "%,", ""), "%.", "");
						--[[DEBUG
						print(appower .. "eighth")]]
						break
					end
				end
			end
				
		end
	end

	--Check to see if we found an amount
	if appower ~= 0 then
		
		--Determine the progress amount
		appercent = appower / maxpower
		appercent = appercent * 100
		
		--Add that shit to the tooltip
		GameTooltip:AddLine("Artifact Power Percent: " .. string.format("%3.5f", appercent) .. "%",1,1,1)
		--[[DEBUG
		print(appower .. " final")]]		
	end


	
end

--Hook it, hook it real good
GameTooltip:HookScript("OnTooltipSetItem", ArtifactPowerScan);
