class GridNode extends Actor 
    DependsOn(Track);

var vector gridLocation;
var Track track;
var Rainbow_GameInfo game;
var Grid grid;

function NodeCleanUp(){
	if (track!=none){
		track.Destroy();
		track = none;
	}
}

function Track.TrackType getType() {
    if(track == none) {
        return T_BLOWUP;
    }
    return track.type;
}

function Initialize(int argX, int argY, int argZ, Rainbow_GameInfo argGame, Grid argGrid)
{
	gridLocation.x = argX;
	gridLocation.y = argY;
	gridLocation.z = argZ;
	game = argGame;
	grid = argGrid;
}

function SetGameAndGrid(Rainbow_GameInfo argGame, Grid argGrid)
{
	game = argGame;
	grid = argGrid;
}


function SetTrack(Track.TrackType argtype, int orientation, optional string tColor, optional bool onClick = false)
{	
	if (track != none) {
		if (track.type != T_START && track.type != T_END && track.type != T_BLOCK){
			track.Destroy();
			track = none;
		
			if(argtype != T_BLOWUP) {
                track = game.Spawn(class'RainbowTrains.Track',,,grid.LocalToWorldVector(gridLocation));
                track.SetTypeAndOrientation(argtype, orientation, tColor);
                game.PlaySound(SoundCue'A_Interface.menu.UT3MenuArmorChangeCue');
			} else {
                game.PlaySound(SoundCue'UDKFrontEnd.Sound.UT3MenuBackCue');
            }
		}
		else {
            PlaySound(SoundCue'KismetGame_Assets.Sounds.Jazz_Death_Cue');
            `log("You can't replace the station! ");
		}

	} else {
        if(argtype != T_BLOWUP) {
            track = game.Spawn(class'RainbowTrains.Track',,,grid.LocalToWorldVector(gridLocation));
            track.SetTypeAndOrientation(argtype, orientation, tColor);
            game.PlaySound(SoundCue'A_Interface.menu.UT3MenuArmorChangeCue');
        } else {
            game.PlaySound(SoundCue'UDKFrontEnd.Sound.UT3MenuBackCue');
        }
		
	}
}

defaultproperties{
}