class TrainLevelNode extends Object
    DependsOn(Track);

var vector position;
var int orientation;
var string stationColor;
var Track.TrackType type;

function Initialize(int argX, int argY, int argZ, Track.TrackType argType, optional string argColor = "", optional int argOrientation = 0) {
    position.x = argX;
    position.y = argY;
    position.z = argZ;
    type = argType;
    stationColor = argColor;
    orientation = argOrientation;
}

defaultproperties {
}