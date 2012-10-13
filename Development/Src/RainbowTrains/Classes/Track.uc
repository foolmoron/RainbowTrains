class Track extends DynamicSMActor_Spawnable;

enum TrackType {
    T_BLOWUP,
    T_STRAIGHT,
    T_START,
	T_END,
	T_BLOCK,
	T_CURVED,
	T_RAISED
};

enum AnimationType {
	A_STRAIGHT,
	A_LEFT,
	A_RIGHT,
	A_LEAVE,
	A_ENTER,
	A_UP,
	A_DOWN,
	A_NONE
};

var int orientation;
var TrackType type;
var bool isGhost;
var string stationColor;
var int blockIndex;

function bool getNextSide(int inputSide, GridNode trackNode, out int nextSide, out int raised, out AnimationType anim) {
	switch (type){
	case T_START:
		if (inputSide == orientation){
			nextSide = inputSide;
			anim = A_STRAIGHT;
			return true;
		}
		return false;
	case T_END:
		`log("in="$inputSide$" or="$orientation);
		if (inputSide == orientation){
			nextSide = inputSide;
			anim = A_ENTER;
			return true;
		}
		return false;
	case T_RAISED:
		if (inputSide == orientation){
			raised = 1;
			anim = A_UP;
			nextSide = inputSide;
			return true;
		} else if (inputSide == (orientation+2)%4){
			raised = 0;
			anim = A_DOWN;
			nextSide = inputSide;
			return true;
		}
		return false;
	case T_STRAIGHT:
		anim = A_STRAIGHT;
		nextSide = inputSide;
		return (inputSide%2) == (orientation%2);
	case T_CURVED:
		if (inputSide == orientation){
			nextSide = (inputSide + 3) % 4;
			anim = A_RIGHT;
		} else if (inputSide == (orientation+1) % 4){
			nextSide = (inputSide + 1) % 4;
			anim = A_LEFT;
		} else return false;
		return true;
	}
	return false;
}



function vector getMovementVector(int nextSide, int raised) {
    local vector movement;
    movement.x = 0;
    movement.y = 0;
    movement.z = raised;
    `log("movetype="$type);
    switch(nextSide){
	case 0: movement.x = 1; break;
	case 1: movement.y = -1; break;
	case 2: movement.x = -1; break;
	case 3: movement.y = 1; break;
    }
    
    return movement;
}

function SetTypeAndOrientation(TrackType t, int r, optional string tColor = "Blue") {
    local vector scale;
    local rotator newRotation;
		local Rainbow_GameInfo game;
    type = t;
    orientation = r;
	newRotation.yaw = -orientation*16384;
	stationColor = "none";
    switch(type)
    {
    case T_STRAIGHT:
		`log("track straight");
        scale.x = 0.14f;
        scale.y = 0.14f;
        scale.z = 0.14f;
        SetStaticMesh(isGhost ? StaticMesh'Rainbow_Models.wfTrackStraight' :  StaticMesh'Rainbow_Models.TrackStraight',,newRotation,scale); 
        //could change mesh but don't know how to scale it here
        break;
    case T_CURVED:
		`log("track curved");
        scale.x = 0.14f;
        scale.y = 0.14f;
        scale.z = 0.14f;
        SetStaticMesh(isGhost ? StaticMesh'Rainbow_Models.wfTrackCurved' :  StaticMesh'Rainbow_Models.TrackCurved',,newRotation,scale); 
        //could change mesh but don't know how to scale it here
        break;
    case T_RAISED:
		`log("track raised");
        scale.x = 0.14f;
        scale.y = 0.14f;
        scale.z = 0.14f;
        SetStaticMesh(isGhost ? StaticMesh'Rainbow_Models.wfTrackRaised' :  StaticMesh'Rainbow_Models.TrackRaised',,newRotation,scale); 
        //could change mesh but don't know how to scale it here
        break;
	case T_START:
		`log("track start - "$tColor);
        scale.x = 0.14f;
        scale.y = 0.14f;
        scale.z = 0.14f;
		stationColor = tColor;
		if (tColor == "Red")
			SetStaticMesh(StaticMesh'Rainbow_Models.startstationRed',,newRotation,scale); 
		else if (tColor == "Blue")
			SetStaticMesh(StaticMesh'Rainbow_Models.startstationBlue',,newRotation,scale); 
		else if (tColor == "Yellow")
			SetStaticMesh(StaticMesh'Rainbow_Models.startstationYellow',,newRotation,scale); 
		else			
			SetStaticMesh(StaticMesh'Rainbow_Models.startstationBlue',,newRotation,scale); 
        //could change mesh but don't know how to scale it here
        break;
    case T_END:
		`log("track end - "$tColor);
        scale.x = 0.14f;
        scale.y = 0.14f;
        scale.z = 0.14f;
		stationColor = tColor;
		if (tColor == "Red")
			SetStaticMesh(StaticMesh'Rainbow_Models.endstationRed',,newRotation,scale); 
		else if (tColor == "Blue")
			SetStaticMesh(StaticMesh'Rainbow_Models.endstationBlue',,newRotation,scale); 
		else if (tColor == "Yellow")
			SetStaticMesh(StaticMesh'Rainbow_Models.endstationYellow',,newRotation,scale); 
		else			
			SetStaticMesh(StaticMesh'Rainbow_Models.endstationBlue',,newRotation,scale); 
		`log("b-"$(tColor=="Blue"));
        //could change mesh but don't know how to scale it here
        break;
	case T_BLOCK:
		`log("track block");
		game = Rainbow_GameInfo(WorldInfo.Game);
        scale.x = 5.0f;
        scale.y = 5.5f;
        scale.z = 5.7f;
		switch(game.blockIndex%4){
		case 0: SetStaticMesh(StaticMesh'Rainbow_Models.block1',,,scale); break;
		case 1: SetStaticMesh(StaticMesh'Rainbow_Models.block2',,,scale); break;
		case 2: SetStaticMesh(StaticMesh'Rainbow_Models.block3',,,scale); break;
		case 3: SetStaticMesh(StaticMesh'Rainbow_Models.block4',,,scale); break;
		default:SetStaticMesh(StaticMesh'Rainbow_Models.block1',,,scale); break;
		}
		game.blockIndex++;
    default:
        break;
    }
}

function UpdateLocation(vector local) {
    local Rainbow_GameInfo game;
    game = Rainbow_GameInfo(WorldInfo.Game);
    
    if(game.grid.WorldToLocalVector(Location) != local && isGhost) {
        SetLocation(game.grid.LocalToWorldVector(local));
        SetHidden(false);
    }
}

defaultproperties
{
    //type=T_BLOWUP; 
    orientation=0;
	isGhost=false;
}