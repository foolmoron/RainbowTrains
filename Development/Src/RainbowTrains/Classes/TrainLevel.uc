class TrainLevel extends Object 
    DependsOn(Track, GridNode, TrainLevelNode);

var Rainbow_GameInfo game;
var array<TrainLevelNode> nodes;

function Initialize(Rainbow_GameInfo argGame){
	game = argGame;
}

function add(int argX, int argY, int argZ, Track.TrackType t, optional string argColor = "", optional int argOrientation = 0) {
    local TrainLevelNode n;
    n = new class'TrainLevelNode';
    n.Initialize(argX, argY, argZ, t, argColor, argOrientation);
    nodes.AddItem(n);
}

function addStart(int argX, int argY, int argZ, int argOrientation, string argColor) {
    add(argX, argY, argZ, T_START, argColor, argOrientation);
}

function addEnd(int argX, int argY, int argZ, int argOrientation, string argColor) {
    add(argX, argY, argZ, T_END, argColor, argOrientation);
}

function addBlock(int argX, int argY, int argZ){
    add(argX, argY, argZ, T_BLOCK);
}

defaultproperties{
}