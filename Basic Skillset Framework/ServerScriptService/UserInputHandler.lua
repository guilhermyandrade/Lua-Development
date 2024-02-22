local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerStorage")
local ReplicationEvent = RS.Remotes.ReplicationEvent
local SkillsetFunction = RS.Remotes.SkillsetFunction

-- // Replication Event Handler
ReplicationEvent.OnServerEvent:Connect(function(Player, Args)
	
	Args.Character = Player.Character
	
	-- // Verificação anti-cheat
	--AntiCheat.Verify(Args)
	
	-- // Firing all clients. This is still not the best way to do it tho.
	ReplicationEvent:FireAllClients(Args)
	
	-- // If server action is required
	if Args.ServerActionRequired then
		
		-- // Adding ReplicationEvent to Args table
		Args.ReplicationEvent = ReplicationEvent
		
		-- // Calling action function
		require(SS.Modules.Skillset[Args.Module])[Args.Action](Args)
	end
	
end)


-- // Skillset Function Handler
SkillsetFunction.OnServerInvoke = function(_, Module)
	return require(SS.Modules.Skillset.Features)[Module]
end