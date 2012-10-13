class Rainbow_Input extends PlayerInput within GamePlayerController DependsOn(Track);
var vector ghostLocation;

function setGhost(vector arg){
	ghostLocation = arg;
}

function vector getGhost(){
	return ghostLocation;
}

exec function StartStop() {
    Rainbow_GameInfo(WorldInfo.Game).StartStop();
}

//left click 
simulated exec function SpawnTrack(){
	local Rainbow_GameInfo game; 
    local GridNode gridNode;
    
	game = Rainbow_GameInfo(WorldInfo.Game);
	
    if(!game.running) {
        if (game.ghost != none){
            gridNode = game.grid.AtVector(game.grid.WorldToLocalVector(game.ghost.Location));
            
            gridNode.SetTrack(game.ghost.type, game.ghost.orientation);
        }
    }
	
}


simulated exec function SelectStraightTrack()
{
	local Rainbow_GameInfo game; 
	game = Rainbow_GameInfo(WorldInfo.Game);
    game.ghost.setTypeAndOrientation(T_STRAIGHT, 0);
}

simulated exec function SelectCurvedTrack()
{
	local Rainbow_GameInfo game; 
	game = Rainbow_GameInfo(WorldInfo.Game);
    game.ghost.setTypeAndOrientation(T_CURVED, 0);
}

simulated exec function SelectRaisedTrack()
{
	local Rainbow_GameInfo game; 
	game = Rainbow_GameInfo(WorldInfo.Game);
    game.ghost.setTypeAndOrientation(T_RAISED, 0);
}

simulated exec function DeleteTrack()
{
	local Rainbow_GameInfo game;
    local GridNode gridNode;
    
	game = Rainbow_GameInfo(WorldInfo.Game);
    
    if(!game.running) {
        gridNode = game.grid.AtVector(game.grid.WorldToLocalVector(game.ghost.Location));
        gridNode.setTrack(T_BLOWUP, 0);
    }
}

// R key 
simulated exec function RotateTrack()
{
	local Rainbow_GameInfo game;
	`log("RotateTrack");
	game = Rainbow_GameInfo(WorldInfo.Game);
	game.ghost.setTypeAndOrientation(game.ghost.type, (game.ghost.orientation+1)%4);
}

// L key
simulated exec function DebugNextLevel(){
	local Rainbow_GameInfo game;
	game = Rainbow_GameInfo(WorldInfo.Game);
	game.NextLevel();
}

