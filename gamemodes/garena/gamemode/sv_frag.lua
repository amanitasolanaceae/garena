function GM:EntityTakeDamage( targ, dmg )

	if( targ:IsPlayer() ) then
	
		if( dmg:GetDamagePosition() != Vector( 0, 0, 0 ) and dmg:GetAttacker() and dmg:GetAttacker():IsPlayer() ) then
		
			net.Start( "nAddPopup" );
				net.WriteVector( dmg:GetDamagePosition() );
				net.WriteString( "-" .. dmg:GetDamage() );
				net.WriteFloat( math.max( 1, dmg:GetDamage() / 15 ) );
				net.WriteColor( Color( 200, 0, 0 ) );
			net.Send( dmg:GetAttacker() );
			
		end
		
	end

end