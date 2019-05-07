AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/health_kit/health_kit.mdl")
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
        
        plyhealth = caller:Health()
        
        if (plyhealth < 100) then 
            caller:SetHealth(plyhealth + 50)
            self:Remove()
        else
            return
        end
    end
end