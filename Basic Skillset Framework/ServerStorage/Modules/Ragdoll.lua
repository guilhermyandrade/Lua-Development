local Ragdoll = {}

local DS = game:GetService("Debris")

function Ragdoll.Knockback(Character, Target)
	
	Target:SetAttribute("Stunned", true)
	
	local Direction =  (Target.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Unit
	
	local Attachment = Instance.new("Attachment", Target.HumanoidRootPart) Attachment.Name = "Knockback"
	
	local VectorForce = Instance.new("VectorForce", Attachment)
	VectorForce.Force = (Direction + Vector3.new(0, 1, 0)).Unit * 3000
	VectorForce.Attachment0 = Attachment
	VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
	
	Target.Humanoid.PlatformStand = true
	
	--local Rotation = Instance.new("AngularVelocity", Attachment)
	--Rotation.Attachment0 = Attachment
	--Rotation.AngularVelocity = Vector3.new(1, 1, 1) * 5
	--Rotation.MaxTorque = math.huge
	--Rotation.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
	
	DS:AddItem(Attachment, .2)
	wait(1)
	Target.Humanoid.PlatformStand = false
	wait(1)
	Target:SetAttribute("Stunned", false)
	
end

return Ragdoll