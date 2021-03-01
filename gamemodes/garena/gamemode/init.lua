AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "fragger_class.lua" )

include( "shared.lua" )
include( "fragger_class.lua" )
include( "sv_frag.lua" )

RunConsoleCommand( "sv_defaultdeployspeed", "1" );

util.AddNetworkString( "nAddPopup" )

function GM:PlayerSpawn( pl )

	pl:UpdateNameColor()

	-- Stop observer mode
	pl:UnSpectate()

	-- Call item loadout function
	hook.Call( "PlayerLoadout", GAMEMODE, pl )

	-- Set player model
	hook.Call( "PlayerSetModel", GAMEMODE, pl )

	pl:SetupHands()

	-- Call class function
	pl:OnSpawn()

end