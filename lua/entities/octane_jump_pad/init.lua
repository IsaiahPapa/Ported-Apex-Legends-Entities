AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/octane_jump_pad/octane_jump_pad.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    
	local phys =  self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

    cooldown = false

end

-- Having issues working with this jump pad
-- doesn't work when the item is frozen by a physgun & acts wonky when welded.
-- Note: I could try and force a weld to the world
--       --> set a timer.simple so that once a player is not touching it again it will freeze?


function ENT:PhysicsCollide( data, phys )

    if(cooldown == false) then
        if(data.HitObject:GetName() == "player_stand") then
            --data.HitObject:SetPos(data.HitObject:GetPos() + Vector(0,0,50))
            print(data.HitObject:GetInvInertia())
            data.HitObject:SetVelocity(Vector(0,0,150))
            data.HitObject:AddAngleVelocity(Vector(0,250,250))
            
            cooldown = true
            timer.Simple(1,function()
                cooldown = false
                print("true") 
            end)
        end
    end
end

