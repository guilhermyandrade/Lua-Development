local Combat = {}

local Ragdoll = require(game:GetService("ServerStorage").Modules.Ragdoll)

function Combat.M1(Args)
	
	print("Server-side - Action: M1.")
	
	local Position = (Args.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)).Position
	
	-- // Filtering who fired the skill
	local Params = OverlapParams.new()
	Params.FilterDescendantsInstances = {Args.Character}--, Hitbox}
	
	local HitboxCharacters = workspace:GetPartBoundsInRadius(Position, 2, Params)
	Params:AddToFilter(HitboxCharacters)
	
	-- // Get characters hit
	local TargetCharacters = {}
	
	for _, HitPart: BasePart in HitboxCharacters do
		local TargetChar = HitPart:FindFirstAncestorOfClass("Model")

		-- // If there's no model, it's not a character or it's already in the table
		if  not TargetChar or
			not TargetChar:FindFirstChildOfClass("Humanoid") or
			table.find(TargetCharacters, TargetChar)
		then continue end
		
		-- // Adding character to TargetCharacters
		table.insert(TargetCharacters, TargetChar)
	end
	
	for _, Character in TargetCharacters do
		
		-- // If target health is more than 0 
		if Character.Humanoid.Health > 0 then
			
			if Character:GetAttribute("Blocking") then
				
				-- // Replicating block vfx if target is blocking
				Args.TargetCharacter = Character
				Args.Action = "BlockVFX"
				Args.ReplicationEvent:FireAllClients(Args)
				
			else	
				
				-- // Taking damage and replicating hitbox vfx if target is not blocking
				Character.Humanoid:TakeDamage(10)
				
				Args.TargetCharacter = Character
				Args.Action = "HitboxVFX"
				
				Args.ReplicationEvent:FireAllClients(Args)
				
				-- // Stunning character for a while
				Character:SetAttribute("Stunned", true)
				Character:SetAttribute("LastTimeFired", os.clock())
				Character.Humanoid.WalkSpeed = 0
				Character.Humanoid.JumpHeight = 0
				
				-- // Ragdolling character if hit combo is equal to 4
				if Args.Combo == 4 then
					Ragdoll.Knockback(Args.Character, Args.TargetCharacter)
				end
				
				-- // Getting target character back to normal after some miliseconds
				while true do
					if (os.clock() - Character:GetAttribute("LastTimeFired")) >= 0.8 then
						Character:SetAttribute("Stunned", false)
						Character.Humanoid.WalkSpeed = 16
						Character.Humanoid.JumpHeight = 7.2
						break	
					end
					wait()	
				end
			end
		end
	end
end


function Combat.Block(Args)
	print("Server-side - Action: Block.")
	Args.Character:SetAttribute("Blocking", not Args.Character:GetAttribute("Blocking"))
end


return Combat
