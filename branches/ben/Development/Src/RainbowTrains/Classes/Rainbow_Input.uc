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
simulated exec function ConfirmTrackSelection(){
	local Rainbow_GameInfo game; 
    local GridNode gridNode;

	game = Rainbow_GameInfo(WorldInfo.Game);
	
	if (game.ghost != none){
        gridNode = game.grid.AtVector(game.grid.WorldToLocalVector(game.ghost.Location));
		
		gridNode.SetTrack(game.ghost.type, game.ghost.orientation);
	}
	
}

//right click 
simulated exec function SelectGhostTrack()
{
    // implement change ghost mesh , type later here. 
}

// R key 
simulated exec function SpawnTrack()
{
	//local Rainbow_GameInfo game;

	//game = Rainbow_GameInfo(WorldInfo.Game);
	//game.grid.WorldToLocal(Location).SetTrack(STRAIGHT, 0);
	//`log("Player Location="$Location);
	//`log("Spawn button clicked-"$game.grid.At(tileX, tileY, tileZ).track.Location);
}
