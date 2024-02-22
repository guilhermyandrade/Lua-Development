-- // Setting initial character attributes

game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAppearanceLoaded:Connect(function(Character)
		
		Character:SetAttribute("Stunned", false)
		Character:SetAttribute("Attacking", false)
		Character:SetAttribute("Level", 30)
		
		Character:SetAttribute("Str", 1)
		Character:SetAttribute("Agi", 1)
		Character:SetAttribute("Int", 1)
		
	end)
end)