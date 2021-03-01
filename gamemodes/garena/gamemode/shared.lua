DeriveGamemode( "fretta13" )

GM.Name = "gArena"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

GM.TeamBased = false
GM.AllowAutoTeam = false
GM.SecondsBetweenTeamSwitches = 10
GM.GameLength = 30
GM.RoundLimit = -1
GM.VotingDelay = 10

GM.NoPlayerTeamDamage = false

GM.RoundEndsWhenOneTeamAlive = false

GM.RealisticFallDamage = true

GM.SelectColor = true

GM.EnableFreezeCam = true

GM.RoundBased = true
GM.RoundLength = 300

GM.AllowSpectating = false

GM.AllowedPlayermodels = {
	"alyx",
	"barney",
	"breen",
	"corpse",
	"combine",
	"combineprison",
	"combineelite",
	"eli",
	"gman",
	"kleiner",
	"monk",
	"mossman",
	"mossmanarctic",
	"odessa",
	"police",
	"policefem",
	"magnusson",
	"stripped",
	"female01",
	"female02",
	"female03",
	"female04",
	"female05",
	"female06",
	"female07",
	"female08",
	"female09",
	"female10",
	"female11",
	"female12",
	"male01",
	"male02",
	"male03",
	"male04",
	"male05",
	"male06",
	"male07",
	"male08",
	"male09",
	"male10",
	"male11",
	"male12",
	"male13",
	"male14",
	"male15",
	"male16",
	"male17",
	"male18",
	"medic01",
	"medic02",
	"medic03",
	"medic04",
	"medic05",
	"medic06",
	"medic07",
	"medic08",
	"medic09",
	"medic10",
	"medic11",
	"medic12",
	"medic13",
	"medic14",
	"medic15",
	"refugee01",
	"refugee02",
	"refugee03",
	"refugee04",
	"hostage01",
	"hostage02",
	"hostage03",
	"hostage04",
	"css_arctic",
	"css_gasmask",
	"css_guerilla",
	"css_leet",
	"css_phoenix",
	"css_riot",
	"css_swat",
	"css_urban",
};

GM.WeaponClassTable = {
	["weapon_pistol"] = { "tdm_glock" },
	["weapon_ar2"] = { "tdm_ak47" },
};

GM.WeaponClasses = {
};

TEAM_FRAG = 1;

function GM:CreateTeams()

	team.SetUp( TEAM_FRAG, "Fraggers", Color( 255, 80, 80 ) )
	team.SetSpawnPoint( TEAM_FRAG, "info_player_start", true )
	team.SetClass( TEAM_FRAG, { "fragger" } )

	team.SetUp( TEAM_SPECTATOR, "Spectators", Color( 200, 200, 200 ), true )
	team.SetSpawnPoint( TEAM_SPECTATOR, "info_player_start" )
	team.SetClass( TEAM_SPECTATOR, { "Spectator" } )

end

function GM:PlayerInitialSpawn( pl )

	timer.Simple( 1, function()
		pl:SetTeam( TEAM_FRAG )
		pl:SetPlayerClass( "fragger" );
	end );
	pl.m_bFirstSpawn = true
	pl:UpdateNameColor()

	GAMEMODE:CheckPlayerReconnected( pl )

end

function GM:OnRoundStart()

	UTIL_UnFreezeAllPlayers();
	
	for k, v in pairs( self.WeaponClassTable ) do
	
		self.WeaponClasses[k] = table.Random( v );
		
		for p, q in pairs( ents.FindByClass( k ) ) do
		
			local new = ents.Create( self.WeaponClasses[k] )
			new:SetPos( q:GetPos() )
			new:SetAngles( q:GetAngles() )
			new:Spawn()
			new:EmitSound( "AlyxEMP.Discharge" )
			new:SetNWBool( "CreatedByScript", true )
			
			q:Remove();
			
		end
	
	end

	for k, v in pairs( player.GetAll() ) do
	
		v:SetFrags( 0 );
	
	end
	
end