local Menu = {}
Menu.__index = Menu

local UserInterfaceEvent = game:GetService("ReplicatedStorage").Remotes.UserInterfaceEvent

function Menu.new(Player)
	
	local self = setmetatable({}, Menu)
	
	self.Player = Player
	self.MenuUI = Player.PlayerGui.Menu.Main
	
	-- // Updating values
	-- // Getting values from labels. Update this code for Data Store usage if needed
	self.MenuUI.Stats.StatPoints.Available.Text = (self.Player.Character:GetAttribute("Level") * 3) -
												  (self.MenuUI.Stats.StatPoints.Str.Text +
												   self.MenuUI.Stats.StatPoints.Agi.Text +
												   self.MenuUI.Stats.StatPoints.Int.Text)
	
	return self
end

function Menu.MenuHandler(self)
	
	self.MenuUI.Visible = not self.MenuUI.Visible
	
end

function Menu.DistributeStatPoints(self, Stat)
	
	local PointsToDistribute = self.MenuUI.Stats.PointsToDistribute == nil and self.MenuUI.Stats.PointsToDistribute or self.MenuUI.Stats.PointsToDistribute
	local StatPointsLabel = self.MenuUI.Stats.StatPoints[Stat]
	
	-- // Updating available points label
	self.MenuUI.Stats.StatPoints.Available.Text -= PointsToDistribute.Text

	local Counter = tonumber(PointsToDistribute.Text)
	
	-- // Adding points to label gradually
	while Counter > 0 do
		if Counter >= 100 then StatPointsLabel.Text += 25 Counter -= 25
		elseif Counter >= 50 then StatPointsLabel.Text += 20 Counter -= 20
		elseif Counter >= 20 then StatPointsLabel.Text += 10 Counter -= 10
		else StatPointsLabel.Text += 1 Counter -= 1 end wait()
	end
	
	local Args = {
		Update = {
			["Stat"] = Stat,
			["Value"] = tonumber(StatPointsLabel.Text)
		},
		Action = "Update Stat"
	}
	UserInterfaceEvent:FireServer(Args)
	
end


function Menu:AdjustPointsToDistribute()

	local PointsToDistribute = self.MenuUI.Stats.PointsToDistribute
	
	-- // Verifying if each value in PointsToDistribute label is a number
	local AllowedInputs = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}
	local LoopCount
	
	-- // For each string in label text
	for Char in string.gmatch(PointsToDistribute.Text, "(%w)") do
		
		-- // If it is the first loop, reset variable value to empty string
		if not LoopCount then PointsToDistribute.Text = "" LoopCount = true end
		
		-- // If Char is among AllowedInputs table elements, concatenate label text to char
		if table.find(AllowedInputs, Char) then
			PointsToDistribute.Text = PointsToDistribute.Text..Char
		end
	end
	
	-- // Resetting variable
	LoopCount = nil
	
	-- // If label text is empty, use placeholder text
	PointsToDistribute.Text = PointsToDistribute.Text == "" and PointsToDistribute.PlaceholderText or PointsToDistribute.Text

	-- // Getting the available points to distribute
	local AvailablePoints = self.MenuUI.Stats.StatPoints.Available.Text
	
	-- // Verifying if required points to distribute is in available points range 
	if AvailablePoints - PointsToDistribute.Text < 0  then
		PointsToDistribute.Text = AvailablePoints --PointsToDistribute.Text + (AvailablePoints - PointsToDistribute.Text)
	end	

end


return Menu
