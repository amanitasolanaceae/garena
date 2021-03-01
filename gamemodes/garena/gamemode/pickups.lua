
function RespawningItem(ply, item)
	if SERVER then
	if item:CreatedByMap() or item:GetNWBool("CreatedByScript") then
	local itempos = item:GetPos()
	local itemangles = item:GetAngles()
	local itemclass = item:GetClass()
	local itemowner = item:GetOwner()
	timer.Simple(30, function()
		if !IsValid(item) then
		local newitem = ents.Create(itemclass)
		newitem:SetPos(itempos)
		newitem:SetAngles(itemangles)
		newitem:Spawn()
		newitem:EmitSound("AlyxEMP.Discharge")
		newitem:SetNWBool("CreatedByScript", true)
		end
	end)
	return true
	end
	end
end

hook.Add("PlayerCanPickupItem", "ItemRespawnHook", RespawningItem)

function RespawningWeapon(ply, wep)
	if SERVER then
	if wep:CreatedByMap() or wep:GetNWBool("CreatedByScript") then
	local weppos = wep:GetPos()
	local wepangles = wep:GetAngles()
	local wepclass = wep:GetClass()
	local wepowner = wep:GetOwner()
	timer.Simple(30, function()
		if !IsValid(wep) then
		local newwep = ents.Create(wepclass)
		newwep:SetPos(weppos)
		newwep:SetAngles(wepangles)
		newwep:Spawn()
		newwep:EmitSound("AlyxEMP.Discharge")
		newwep:SetNWBool("CreatedByScript", true)
		end
	end)
	return true
	end
	end
end

hook.Add("PlayerCanPickupWeapon", "WeaponRespawnHook", RespawningWeapon)