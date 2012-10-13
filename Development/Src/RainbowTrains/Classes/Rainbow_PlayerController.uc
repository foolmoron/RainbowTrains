class Rainbow_PlayerController extends GamePlayerController DependsOn(Track);


/**
 * Draw a crosshair. This function is called by the Engine.HUD class.
 */
function DrawHUD( HUD H )
{
	local Rainbow_GameInfo game;
    local string trainStatus;
    local string spaceStatus;
    local vector place;
    local string levelText;
    
    
	super.DrawHUD(H);
    
	game = Rainbow_GameInfo(WorldInfo.Game);
    
    H.Canvas.Font = class'Engine'.static.GetLargeFont();
    H.Canvas.SetDrawColor(255,255,255,200);
    
    place.x = 10;
    place.y = 10;
    
    H.Canvas.SetPos(place.x, place.y);
    H.Canvas.DrawText("1: Select Straight Track",true);
    
    place.y = place.y + H.Canvas.Font.GetMaxCharHeight();
    H.Canvas.SetPos(place.x, place.y);
    H.Canvas.DrawText("2: Select Curved Track",true);
    
    place.y = place.y + H.Canvas.Font.GetMaxCharHeight();
    H.Canvas.SetPos(place.x, place.y);
    H.Canvas.DrawText("3: Select Up/Down Track",true);
    
    place.y = place.y + H.Canvas.Font.GetMaxCharHeight();
    H.Canvas.SetPos(place.x, place.y);
    H.Canvas.DrawText("R: Rotate Track",true);
    
    place.y = place.y + H.Canvas.Font.GetMaxCharHeight();
    H.Canvas.SetPos(place.x, place.y);
    H.Canvas.DrawText("Click: Place Track",true);
    
    place.y = place.y + H.Canvas.Font.GetMaxCharHeight();
    H.Canvas.SetPos(place.x, place.y);
    H.Canvas.DrawText("Right Click: Remove Track",true);
    
    if(game.running) {
        if(game.aTrainCrashed) {
            trainStatus = "CRASHED!";
        } else {
            trainStatus = "Running";
        }
        spaceStatus = "Reset Trains";
    } else {
        trainStatus = "Waiting to Go";
        spaceStatus = "Start Trains";
    }
    
    place.y = place.y + H.Canvas.Font.GetMaxCharHeight();
    H.Canvas.SetPos(place.x, place.y);
    H.Canvas.DrawText("Space: "$spaceStatus,true);
    
    place.y = H.CenterY;
    
    H.Canvas.SetPos(place.x, place.y);
    H.Canvas.DrawText("Status: "$trainStatus,true);
    
    levelText = "You are on Level "$(game.currentLevel+1);
    
    place.x = H.CenterX;
    place.y = 10;
    
    H.Canvas.SetPos(place.x, place.y);
    H.Canvas.DrawText(levelText, true);

//	H.Canvas.SetDrawColor(0,255,0,255);
//
//	CrosshairSize = 4;
//
//	H.Canvas.SetPos(H.CenterX - CrosshairSize, H.CenterY);
//	H.Canvas.DrawRect(2*CrosshairSize + 1, 1);
//
//	H.Canvas.SetPos(H.CenterX, H.CenterY - CrosshairSize);
//	H.Canvas.DrawRect(1, 2*CrosshairSize + 1);
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
	
	//game.ghost.SetTypeAndOrientation(game.ghost.type, game.ghost.orientation);
    game.ghost.UpdateLocation(gridLocation);
    //ClientMessage("Ghost now at position: "$game.grid.LocalToWorld(node.x, node.y ,node.z));
}

defaultproperties
{
	InputClass=class'RainbowTrains.Rainbow_Input'
}
