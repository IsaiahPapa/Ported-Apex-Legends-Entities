AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/shield_battery/shield_battery.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys =  self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

end

-- Currently just a base so I can get an idea of how to set these bad boys up again.
-- This is one that I may turn into a single use weapon that gives 50 armor.

function ENT:Use( activator, caller )
    if IsValid( activator ) and activator:IsPlayer() then
        
        plyarmor = caller:Armor()
        
        if (plyarmor < 100) then 
            caller:SetArmor(plyarmor + 50)
            self:Remove()
        else
            return
        end
    end
end