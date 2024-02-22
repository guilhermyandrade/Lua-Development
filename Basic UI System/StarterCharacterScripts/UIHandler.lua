wait(0.5)
-- // Getting the player and other services
local Player = game:GetService("Players").LocalPlayer
local CS = game:GetService("CollectionService")
local RS = game:GetService("ReplicatedStorage").Modules

-- // Importing the UI modules and instanitating them
local Profile = require(RS.UserInterface.Profile).new(Player)
local Menu = require(RS.UserInterface.Menu).new(Player)

-- // Action when profile menu button is clicked
Profile.ProfileUI.Options.MenuButton.MouseButton1Down:Connect(function() Profile.MenuHandler(Profile) end)

-- // Setting SFX for buttons
local CollectionService = game:GetService("CollectionService")
for _, Object in pairs(CollectionService:GetTagged("BUTTON")) do
	
	Object.MouseEnter:Connect(function()
		local HoverSoundInstance = Instance.new("Sound", RS)
		HoverSoundInstance.SoundId = "rbxassetid://9119713951"
		HoverSoundInstance:Play()
	end)

	Object.MouseButton1Click:Connect(function()
		local ClickSoundInstance = Instance.new("Sound", RS)
		ClickSoundInstance.SoundId = "rbxassetid://8617766509"
		ClickSoundInstance:Play()
	end)
end


-- // Stats UI features
Menu.MenuUI.Stats.PointsToDistribute.FocusLost:Connect(function() Menu:AdjustPointsToDistribute() end)

for _, Object in pairs(CollectionService:GetTagged("STATBUTTON"))  do

	Object.MouseButton1Click:Connect(function()
		-- // Insuring that points to distribute will be adjusted
		Menu:AdjustPointsToDistribute()
		
		-- // Points distribution
		Menu.DistributeStatPoints(Menu, Object.Name)
	end)
end