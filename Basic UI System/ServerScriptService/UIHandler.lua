local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerStorage")
local UserInterfaceEvent = RS.Remotes.UserInterfaceEvent

-- // Replication Event Handler
UserInterfaceEvent.OnServerEvent:Connect(function(Player, Args)

	if Args.Action == "Update Stat" then
		-- // Verificação anti-cheat
		--AntiCheat.StatVerify(Args)
		
		print(Args)
		Player.Character:SetAttribute(Args.Update.Stat, Args.Update.Value)
		print(Player.Character:GetAttribute(Args.Update.Stat))
		
	end

end)