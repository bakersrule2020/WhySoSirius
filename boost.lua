
-- Boosters
local boosts = {
	-- Example: [304343782] = {icon = 1, color = Color3.fromRGB(255, 255, 255)},
  -- Example 2: 304343782,
  
	304343782,
}




-- Code
local players = game:GetService('Players')
local coreGui = game:GetService('CoreGui')
local userInputService = game:GetService("UserInputService")

local function findOverlayFrame(target)
	if not target then return nil end
	local frame = target:FindFirstChild("ChildrenFrame")
	
	if frame then
		local nameFrame = frame:FindFirstChild("NameFrame")
		
		if nameFrame then
			if userInputService.TouchEnabled then
				return nameFrame
			else
				local bgFrame = nameFrame:FindFirstChild("BGFrame")
				
				if bgFrame then
					return bgFrame:FindFirstChild("OverlayFrame")
				end
			end
		end
	end	
	return nil
end

local function display(userId, booster)
	local target = coreGui:FindFirstChild("p_" .. userId, true) or coreGui:FindFirstChild("Player_" .. userId, true)
	if not target then return end

	local overlayFrame = findOverlayFrame(target)

	if overlayFrame then
		overlayFrame.PlayerIcon.Image = 'rbxassetid://' .. (booster and booster.icon or 128645553269928)
		overlayFrame.PlayerIcon.ImageRectOffset = Vector2.zero
		overlayFrame.PlayerIcon.ImageRectSize = Vector2.zero
		if userInputService.TouchEnabled then
			overlayFrame.PlayerName.TextColor3 = booster and booster.color or Color3.fromRGB(255, 138, 250)
		else
			overlayFrame.PlayerName.PlayerName.TextColor3 = booster and booster.color or Color3.fromRGB(255, 138, 250)
		end
		
	end
end

local function processPlayer(player)
	local booster = boosts[player.UserId]
	
	if booster then
		display(player.UserId, typeof(booster) == "table" and booster or nil)
	else
		for _, id in pairs(boosts) do
			if id == player.UserId then
				display(player.UserId, nil)
				break
			end
		end
	end
end

local function processAllPlayers()
	for _, player in ipairs(players:GetPlayers()) do
		processPlayer(player)
	end
end

processAllPlayers()

players.PlayerAdded:Connect(processPlayer)

if userInputService.TouchEnabled then
	local leaderboardContainer = coreGui:FindFirstChild("RoactAppExperimentProvider")
		and coreGui.RoactAppExperimentProvider:FindFirstChild("Children")
		and coreGui.RoactAppExperimentProvider.Children:FindFirstChild("BodyBackground")
		and coreGui.RoactAppExperimentProvider.Children.BodyBackground:FindFirstChild("ContentFrame")

	if leaderboardContainer then
		leaderboardContainer.ChildAdded:Connect(function(child)
			processAllPlayers()
		end)
	end
end
