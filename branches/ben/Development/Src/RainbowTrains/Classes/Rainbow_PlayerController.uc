class Rainbow_PlayerController extends GamePlayerController;

/**
 * Draw a crosshair. This function is called by the Engine.HUD class.
 */
function DrawHUD( HUD H )
{
	local float CrosshairSize;
	super.DrawHUD(H);

	H.Canvas.SetDrawColor(0,255,0,255);

	CrosshairSize = 4;

	H.Canvas.SetPos(H.CenterX - CrosshairSize, H.CenterY);
	H.Canvas.DrawRect(2*CrosshairSize + 1, 1);

	H.Canvas.SetPos(H.CenterX, H.CenterY - CrosshairSize);
	H.Canvas.DrawRect(1, 2*CrosshairSize + 1);
}

event PlayerTick( float DeltaTime )
{
	
	local Rainbow_GameInfo game;
	local vector cursorLocation;
    local vector xAxisLooking, yAxisLooking, zAxisLooking;
	local vector gridLocation; 
	
	super.PlayerTick(DeltaTime);
	
	game = Rainbow_GameInfo(WorldInfo.Game);
	//compute trace pointer location
    GetAxes(Rotation, xAxisLooking, yAxisLooking, zAxisLooking);
    
	cursorLocation = Location + normal(xAxisLooking) * 250;

    cursorLocation.x = cursorLocation.x + 125;
    cursorLocation.y = cursorLocation.y + 125;
    cursorLocation.z = cursorLocation.z + 60;

	gridLocation = game.grid.WorldToLocalVector(cursorLocation);
	
    game.ghost.UpdateLocation(gridLocation);
    //ClientMessage("Ghost now at position: "$game.grid.LocalToWorld(node.x, node.y ,node.z));
}

defaultproperties
{
	InputClass=class'RainbowTrains.Rainbow_Input'
}
