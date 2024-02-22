-- // Services
local RS  = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

local ReplicationEvent = RS.Remotes.ReplicationEvent
RS = RS.Modules  -- // Updating RS variable to Modules folder

wait(1)  -- Waiting some time before loading the player
local Player    = game:GetService("Players").LocalPlayer
local Character = Player.Character
local Cooldown  = require(RS:WaitForChild("Cooldown")).new(Player)

-- Modules that player will use to interact with skills or UI via keyboard or mouse inputs
local AvailableModules = {
	["Combat"] = require(RS.Skillset.Combat).new(Player)
	,["Profile"] = require(RS.UserInterface.Profile).new(Player)
}

-- // Input dealing function
local function InputHanlder(UserInput, GameProcessedEvent)
	if GameProcessedEvent or UserInput.UserInputType == Enum.UserInputType.MouseMovement or Character:GetAttribute("Stunned") then return end
	
	-- // Verifying if input state is "Begin" or "End"
	local InputState = (UserInput.UserInputState == Enum.UserInputState.Begin) and "Begin" or "End"	
	
	-- // If the input is MouseButton1 or MouseButton2, then the variable receives "M1" and "M2" respectively
	-- // If not, variable receives the key name
	UserInput = 
		(UserInput.UserInputType == Enum.UserInputType.MouseButton1) and "M1" or
		(UserInput.UserInputType == Enum.UserInputType.MouseButton2) and "M2" or 
		UserInput.KeyCode.Name
	
	for _, Mod in pairs(AvailableModules) do
		local Action = Mod.Inputs and Mod.Inputs[UserInput]
		
		-- // If the UserInput exists in the module and the Action is not in cooldown
		if Action and not Cooldown:Check(Action) then
			
			-- // Verifying if Action exists in SkillInUse table
			local SkillInUse = Mod.SkillInUse and Mod.SkillInUse[Action.Name]
			
			-- // If Skill is not in use or if Action is Toggleable
			if (not SkillInUse or Action.Toggleable) and InputState == "Begin" then
				
				Mod:Invoke(Action, UIS, Cooldown)  -- // Calling action function
				
				if not Action.Holdable then  -- // Adding skill to cooldown if it's not holdable
					Cooldown:Add(Action)
				end
				
			-- // If input state is "End", Action is holdable and skill is in SkillInUse table
			elseif InputState == "End" and Action.Holdable and SkillInUse then
				
				Mod:Invoke(Action, UIS, Cooldown)  -- // Calling action function again
				
				Cooldown:Add(Action)  -- // Adding skill to cooldown
			end
			break  -- // Break the loops if the required action was found
		end
	end
end

-- // Connecting function to UIS service
UIS.InputBegan:Connect(InputHanlder)
UIS.InputEnded:Connect(InputHanlder)

-- // Simple replication
ReplicationEvent.OnClientEvent:Connect(function(Args)
	if Args.Action then  -- // If Action is not nil
		require(RS.Skillset[Args.Module])[Args.Action](Args)
	end	
end)