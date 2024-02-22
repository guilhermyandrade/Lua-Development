-- // Skillset features. Add all skillsets in this table.

local Features = {
	
	["Combat"] = {		
		-- // Keys
		["M1"] = {Name="M1", Cooldown=0.1},
		["F"]  = {Name="Block", Cooldown=0.05, Holdable=true}
	}
	
	-- // Example of skillset
	--,["Movement"] = {
	--	-- // Keys
	--	["Q"] = {Name="Dash", Cooldown=0.5},
	--	["LShift"] = {Name="Sprint", Toggleable=true, Cooldown=0.1}
	--}
}

return Features
