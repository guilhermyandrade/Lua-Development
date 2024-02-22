local Profile = {}
Profile.__index = Profile

function Profile.new(Player)
	
	local self = setmetatable({}, Profile)
	
	self.Player = Player
	self.ProfileUI = Player.PlayerGui.Profile.Main
	self.MenuUI = Player.PlayerGui.Menu.Main
	
	self.Inputs = {
		["M"] = {Name="Stats Menu", Toggleable=true, Cooldown=0.2},
		["I"] = {Name="Inventory", Toggleable=true, Cooldown=0.1},
		["P"] = {Name="Party", Toggleable=true, Cooldown=0.1}
	}
	
	-- // Getting the player profile image
	local Content, _ = self.Player.Parent:GetUserThumbnailAsync(
		self.Player.UserId,
		Enum.ThumbnailType.HeadShot,
		Enum.ThumbnailSize.Size420x420
	)

	-- // Getting the frames
	self.ProfileUI.ProfileImage.Image.Image = Content
	self.ProfileUI.PlayerInfo.Nickname.Text = self.Player.DisplayName
	self.ProfileUI.PlayerInfo.Level.Text = "Lvl. "..tostring(self.Player.Character:GetAttribute("Level"))
	
	return self
end


function Profile:Invoke(Action)

	if Action.Name == "Stats Menu" then
		
		print(Action.Name, Action)
		self.MenuHandler(self)
		
	end
end


function Profile.MenuHandler(self)
	
	self.MenuUI.Visible = not self.MenuUI.Visible
	
end

return Profile
