class GhostTrack extends Track;

function UpdateLocation(vector local) {
    local Rainbow_GameInfo game;
    game = Rainbow_GameInfo(WorldInfo.Game);
    
    if(game.grid.WorldToLocalVector(Location) != local) {
        SetLocation(game.grid.LocalToWorldVector(local));
        SetHidden(false);
    }
}

defaultproperties
{
    Begin Object Name=TrainMeshComponent
        StaticMesh=StaticMesh'Rainbow_Models.wfTrackStraight'
        Scale=0.14
    End Object
    CollisionComponent=TrainMeshComponent
    Components.Add(TrainMeshComponent)
}