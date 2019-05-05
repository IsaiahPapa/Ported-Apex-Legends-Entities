AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/tick_loot/tick_loot.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    
	local phys =  self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

end


function ENT:OnTakeDamage(dmginfo)
    local explosion = ents.Create("env_explosion")       
    explosion:SetPos(self:GetPos())
    explosion:SetKeyValue("iMagnitude", "0")
    explosion:Spawn()
    explosion:Activate()
    explosion:Fire("Explode", 0, 0)
    self:Remove()

    --Put an array here containing the entity names with a loop to randomize the 3 items chosen from array.

    local item1 = ents.Create("shield_battery")
    if(!IsValid(item1)) then return end
    --loot:SetModel(loot:GetModel())
     -- adding a vector for each item so they don't all spawn in eachother
    item1:SetPos(self:GetPos() + Vector(50, 0, 50))
    item1:Spawn()
    print("Spawned 1")
    local item1phys = item1:GetPhysicsObject()
    item1phys:SetVelocity(Vector(25, 0, 150)) 


    local item2 = ents.Create("shield_battery")
    if(!IsValid(item1)) then return end
    --loot:SetModel(loot:GetModel())
    item2:SetPos(self:GetPos() + Vector(-50, 0, 50) )
    item2:Spawn()
    print("Spawned 2")
    local item2phys = item2:GetPhysicsObject()
    item2phys:SetVelocity(Vector(-25, 0, 150))

    local item3 = ents.Create("shield_battery")
    if(!IsValid(item3)) then return end
    --loot:SetModel(loot:GetModel())
    item3:SetPos(self:GetPos() + Vector(0, 0, 50))
    item3:Spawn()
    print("Spawned 3")
    local item3phys = item3:GetPhysicsObject()
    item3phys:SetVelocity(Vector(0, 50, 150)) 

end
