local Combat = {}
Combat.__index = Combat

local RS = game:GetService("ReplicatedStorage")

local ReplicationEvent = RS.Remotes.ReplicationEvent
local SkillsetFunction = RS.Remotes.SkillsetFunction

-- // Requires statement
local Tools = require(RS.Modules.Tools)

function Combat.new(Player)

	local self = setmetatable({}, Combat)

	self.Player = Player
	self.Character = self.Player.Character
	self.Animator = self.Character.Humanoid:WaitForChild("Animator")

	self.AnimationTrack = nil
	self.Attacking = nil
	self.Blocking = nil

	self.Inputs = SkillsetFunction:InvokeServer("Combat")

	-- // All skills in use
	self.SkillInUse = {}

	-- // All animations in combo order
	self.Animations = {
		-- // Animation 1,
		-- // Animation 2 ...
	}

	return self

end

function Combat:Invoke(Action, UIS, Cooldown)

	if
		Action.Name == "M1" and not (
			self.Blocking or
			self.Character:GetAttribute("Attacking") or 
			self.Character:GetAttribute("Stunned")
		)

	then
		
		print("Client-side - Invoking M1")
		
		self.SkillInUse[Action.Name] = true
		self.Attacking = true

		-- // Configuring args
		local Args = {
			State="Begin",
			Action="M1",
			Module="Combat",
			ServerActionRequired=true
		}

		ReplicationEvent:FireServer(Args)  -- // Firing the server to replicate vfx

		self.SkillInUse[Action.Name] = nil
		self.Attacking = nil

	elseif
		Action.Name == "Block" and not (
			self.Attacking or
				self.Character:GetAttribute("Attacking") or
				self.Character:GetAttribute("Stunned")
		)
	then
		
		print("Client-side - Invoking Block")
		
		if (not self.Blocking) and UIS:IsKeyDown(Enum.KeyCode.F) then

			self.SkillInUse[Action.Name] = true
			self.Blocking = true

			-- // Configuring args
			local Args = {
				State="Begin",
				Action="Block",
				Module="Combat",
				ServerActionRequired=true
			}
			ReplicationEvent:FireServer(Args)

		else
			-- // Cleanning tables and variables
			self.SkillInUse[Action.Name] = nil
			self.Blocking = nil

			-- // Speed and jump power adjustment to normal
			self.Character.Humanoid.WalkSpeed = 16
			self.Character.Humanoid.JumpHeight = 7.2

			-- // Configuring args
			local Args = {
				State="End",
				Action="Block",
				Module="Combat",
				ServerActionRequired=true
			}
			ReplicationEvent:FireServer(Args)

		end

	end
end

function Combat.M1(Args)
	print("M1 replicated.", Args)
end

function Combat.Block(Args)

	if Args.State == "Begin" then
		print("Block replicated. Input: Begin", Args)
	else
		print("Block replicated. Input: End", Args)
	end

end



function Combat.HitboxVFX(Args)
	
	-- // Replication when somebody gets hit by M1 skill
	print("Hitbox VFX/SFX replicated")

end

function Combat.BlockVFX(Args)
	
	-- // Replication when somebody gets hit while block skill is activated
	print("Block VFX/SFX replicated")

end

return Combat
