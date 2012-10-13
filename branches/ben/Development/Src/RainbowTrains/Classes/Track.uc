class Track extends DynamicSMActor_Spawnable;

enum TrackType {
    T_BLOWUP,
    T_STRAIGHT,
    T_STATION
};

enum Sides {
    S_NONE,
    S_YNEG,
    S_XPOS,
    S_YPOS,
    S_XNEG
};

var int orientation;
var TrackType type;

function Sides getOpposite(Track.Sides s) {
    switch(s) {
        case S_XNEG: return S_XPOS; break;
        case S_XPOS: return S_XNEG; break;
        case S_YNEG: return S_YPOS; break;
        case S_YPOS: return S_YNEG; break;
    }
    return S_NONE;
}

function vector getMovementVector(Sides start) {
    local vector movement;
    movement.x = 0;
    movement.y = 0;
    movement.z = 0;
    
    switch(type)
    {
    case T_STATION:
        if(start == S_YNEG) {
            movement.x = 0;
            movement.y = 1;
            movement.z = 0;
        }
        break;
    case T_STRAIGHT:
        if(start == S_YNEG || start == S_YPOS) {
            movement.x = 0;
            movement.y = start == S_YNEG ? 1 : -1;
            movement.z = 0;
        }
        break;
    }
    
    return movement;
}

function SetTypeAndOrientation(TrackType t, int r) {
    local vector scale;
    type = t;
    orientation = r;
    switch(type)
    {
    case T_STRAIGHT:
        scale.x = 0.14f;
        scale.y = 0.14f;
        scale.z = 0.14f;
        SetStaticMesh(StaticMesh'Rainbow_Models.TrackStraight',,,scale); 
        //could change mesh but don't know how to scale it here
        break;
    case T_STATION:
        scale.x = 0.35f;
        scale.y = 0.35f;
        scale.z = 0.35f;
        SetStaticMesh(StaticMesh'Rainbow_Models.TrainBlue',,,scale); 
        //could change mesh but don't know how to scale it here
        break;
    default:
        break;
    }
}

defaultproperties
{
    type=T_BLOWUP; 
    orientation=0;
    Begin Object Class=StaticMeshComponent Name=TrainMeshComponent
        StaticMesh=StaticMesh'Rainbow_Models.TrackStraight'
        Scale=0.14
    End Object
    
    CollisionComponent=TrainMeshComponent;
    Components.Add(TrainMeshComponent);
}