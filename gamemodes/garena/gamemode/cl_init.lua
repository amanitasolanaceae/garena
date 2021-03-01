include( "shared.lua" )
include( "fragger_class.lua" )

function GM:HUDPaint()

	self:DrawScreenPopups();
	self:HUDDrawTargetID();

end

function GM:DrawScreenPopups()
	
	for k, v in pairs( self.ScreenPopups ) do
		
		local alpha = math.Clamp( ( 255 / v.Duration ) * ( v.EndTime - CurTime() ), 0, 255 );
		
		if ( alpha > 0 ) then
		
			local pos = v.Pos + Vector( 0, math.sin( CurTime() * 4 + v.Boost ) * 4, 24 * ( alpha / 255 ) );
			--print( alpha / 255 );
			--local wpos = pos:ToScreen();
			local ang = EyeAngles();
		
			ang:RotateAroundAxis( ang:Forward(), 90 + ( 10 * math.sin( CurTime() * 0.7 ) ) );
			ang:RotateAroundAxis( ang:Right(), 90 + ( 30 * math.sin( CurTime() * 0.4 ) ) ); 
			
			cam.Start3D2D( pos, ang, 0.1 )
				-- Get the size of the text we are about to draw
				local text = v.Text;
				surface.SetFont( "TargetID" );
		
				local tW, tH = surface.GetTextSize( text );
		
				-- Draw some text
				draw.SimpleText( text, "TargetID", -6 + -tW / 2, 6, Color( v.Color.r + ( 23 * math.sin( CurTime() ) ), v.Color.g - ( 23 * math.sin( CurTime() ) ), v.Color.b - ( 23 * math.sin( CurTime() ) ), alpha * 255 ) );
			cam.End3D2D()
			
		else
		
			table.remove( self.ScreenPopups, k );
			
		end
		
	end
	
end

function GM:HUDDrawTargetID()

	local tr = util.GetPlayerTrace( LocalPlayer() )
	local trace = util.TraceLine( tr )
	if ( !trace.Hit ) then return end
	if ( !trace.HitNonWorld ) then return end
	
	local text = "ERROR"
	local font = "TargetID"
	
	if ( trace.Entity:IsPlayer() ) then
		text = trace.Entity:Nick()
	else
		return
		--text = trace.Entity:GetClass()
	end
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	
	local MouseX, MouseY = gui.MousePos()
	
	if ( MouseX == 0 && MouseY == 0 ) then
	
		MouseX = ScrW() / 2
		MouseY = ScrH() / 2
	
	end
	
	local x = MouseX
	local y = MouseY
	
	x = x - w / 2
	y = y + 30
	
	-- The fonts internal drop shadow looks lousy with AA on
	draw.SimpleText( text, font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
	draw.SimpleText( text, font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )
	
	y = y + h + 5
	
	local text = "Bodycount: " .. trace.Entity:Frags()
	local font = "TargetIDSmall"
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	local x = MouseX - w / 2
	
	draw.SimpleText( text, font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
	draw.SimpleText( text, font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )
	
	y = y + h + 5
	
	text = "Deaths: " .. trace.Entity:Deaths()
	font = "TargetIDSmall"
	
	surface.SetFont( font )
	w, h = surface.GetTextSize( text )
	x = MouseX - w / 2
	
	draw.SimpleText( text, font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
	draw.SimpleText( text, font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )

end

function nAddPopup( len )
	
	local pos = net.ReadVector();
	local str = net.ReadString();
	local dur = net.ReadFloat() or 3;
	local col = net.ReadColor() or Color( 200, 200, 0 );
	GAMEMODE:AddPopup( pos, str, dur, col );
	
end
net.Receive( "nAddPopup", nAddPopup );

GM.ScreenPopups = { };

function GM:AddPopup( pos, name, dur, col )

	if ( !dur ) then
	
		dur = 3;
		
	end
	
	if ( !col ) then
	
		col = Color( 200, 200, 200 );
		
	end
	
	local notify = {
		Duration = dur,
		EndTime = CurTime() + dur,
		Text = name,
		Pos = pos + ( Vector() * math.random(-5, 5) ),
		Color = col,
		Boost = math.Rand( -1.5, 1.5 ),
	};
	
	table.insert( self.ScreenPopups, notify );
	
end

function GM:InitPostEntity()

	if ( GAMEMODE.TeamBased ) then 
		GAMEMODE:ShowTeam();
	end
	
	--GAMEMODE:ShowSplash();

end