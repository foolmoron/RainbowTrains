class GridNode extends Actor 
    DependsOn(Track);

var int x, y, z;
var Track track;
var Rainbow_GameInfo game;
var Grid grid;

function Track.TrackType getType() {
    if(track == none) {
        return T_BLOWUP;
    }
    return track.type;
}

function vector getMovementVector(Track.Sides start) {
    local vector zerovector;
    zerovector.x = 0;
    zerovector.y = 0;
    zerovector.z = 0;
    if(track == none) {
        return zerovector;
    }
    return track.getMovementVector(start);
}

function Initialize(int argX, int argY, int argZ, Rainbow_GameInfo argGame, Grid argGrid)
{
	x = argX;
	y = argY;
	z = argZ;
	game = argGame;
	grid = argGrid;
}

function SetTrack(Track.TrackType type, int orientation)
{	
	if (track != none) {
		track.Destroy();
	}
    if(type != T_BLOWUP) {
        track = game.Spawn(class'RainbowTrains.Track',,,grid.LocalToWorldCoordinates(x,y,z));
        track.SetTypeAndOrientation(type, orientation);
    }
}

defaultproperties{
}