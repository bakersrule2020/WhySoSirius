
-- Sirius Boosts
-- sirius.menu/privacy | sirius.menu/terms

-- Request
local request = (http and http.request) or http_request or request or HttpPost

-- Services
local httpService = game:GetService('HttpService')
local players = game:GetService('Players')
local coreGui = game:GetService('RunService'):IsStudio() and script.Parent or game:GetService('CoreGui')
local userInputService = game:GetService("UserInputService")

-- GET Boosts
local response

if not request then 
	response = httpService:GetAsync('https://sync.sirius.menu/v1/u') 
else
	response = request({
		Url = 'https://sync.sirius.menu/v1/u',
		Method = "GET",
	}).Body
end

local success, boosts = pcall(function() return httpService:JSONDecode(response) end)

local function getBooster(userId)
	userId = tostring(userId) -- ensure string to match json
	local properties
	
	for id, prop in pairs(boosts) do
		if id == userId then
			properties = prop
			break
		end
	end

	if properties then
		local booster = {}

		if properties.color and not (properties.color[1] > 255 or properties.color[2] > 255 or properties.color[3] > 255) then -- Color higher than 255 means default color value (no changes made)
			booster.color = Color3.fromRGB(properties.color[1], properties.color[2], properties.color[3])
		end

		booster.icon = properties.icon ~= 0 and properties.icon or nil -- Icon 0 means default icon (no changes made)
		
		return booster
	else
		return false
	end
end

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
	local target = coreGui:FindFirstChild("p_" .. tostring(userId), true) or coreGui:FindFirstChild("Player_" .. tostring(userId), true)
	if not target or not booster then return end

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
	local booster = getBooster(player.UserId)
	display(player.UserId, booster)
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
