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

    local entData = 
            {
                --{"entity_name", "model", "chance to drop"}
                {"m9k_pkm","models/weapons/w_mach_russ_pkm.mdl", 15},
                {"m9k_amd65",  "models/weapons/w_amd_65.mdl", 5},
                {"m9k_coltpython", "models/weapons/w_colt_python.mdl", 65},
                {"m9k_colt1911", "models/weapons/s_dmgf_co1911.mdl", 35},
                {"m9k_hk45", "models/weapons/w_hk45c.mdl", 45},
                {"m9k_luger", "models/weapons/w_luger_p08.mdl", 25},
                {"shield_battery", "none", 50},
                {"health_kit", "none", 50}
            }

    function GetWeightedKey( table )
        local sum = 0

        for _, chance in pairs( table ) do
            sum = sum + chance[3]
        end

        local select = math.random() * sum

        for key, chance in pairs( table ) do
            select = select - chance[3]
            if select < 0 then return key end
        end
    end

    for i=1,3 do
        random = GetWeightedKey( entData )

        if(i == 1) then
            item1 = ents.Create(entData[random][1])
            if (entData[random][2] != "none") then
                item1:SetModel(entData[random][2])
            end
        elseif(i == 2) then
            item2 = ents.Create(entData[random][1])
            if (entData[random][2] != "none") then
                item2:SetModel(entData[random][2])
            end
        else
            item3 = ents.Create(entData[random][1])
            if (entData[random][2] != "none") then
                item3:SetModel(entData[random][2])
            end
        end
    end



    ------------
    -- ITEM 1 --
    ------------ 
    if(!IsValid(item1)) then return end
    item1:SetPos(self:GetPos() + Vector(50, 0, 50))
    item1:Spawn()

    local item1phys = item1:GetPhysicsObject()
    item1phys:SetVelocity(Vector(25, 0, 150)) 

    ------------
    -- ITEM 2 --
    ------------ 
    if(!IsValid(item1)) then return end
    item2:SetPos(self:GetPos() + Vector(-50, 0, 50) )
    item2:Spawn()

    local item2phys = item2:GetPhysicsObject()
    item2phys:SetVelocity(Vector(-25, 0, 150))

    ------------
    -- ITEM 3 --
    ------------ 
    if(!IsValid(item3)) then return end
    item3:SetPos(self:GetPos() + Vector(0, 0, 50))
    item3:Spawn()

    local item3phys = item3:GetPhysicsObject()
    item3phys:SetVelocity(Vector(0, 50, 150)) 

end
