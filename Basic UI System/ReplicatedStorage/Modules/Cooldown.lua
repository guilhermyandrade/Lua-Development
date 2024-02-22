local Cooldown = {}
Cooldown.__index = Cooldown

function Cooldown.new(Player)
	local self = setmetatable({}, Cooldown)
	self.Player = Player
	return self
end

function Cooldown:Add(Skill)
	self[Skill.Name] = self.Player.Name..Skill.Name
	wait(Skill.Cooldown)
	self[Skill.Name] = nil
end


function Cooldown:Check(Skill)
	return self[Skill.Name]
end
	
	
return Cooldown
