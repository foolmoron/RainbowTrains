class TrainPawn extends DynamicSMActor_Spawnable
    DependsOn(GridNode, Track);

var String TrainColor;
var Track.Sides side;

defaultproperties
{
    side=S_NONE;
    TrainColor="Blue"
    Begin Object Class=StaticMeshComponent Name=TrainMeshComponent
        StaticMesh=StaticMesh'Rainbow_Models.TrainBlue'
        Scale=0.35
    End Object
    CollisionComponent=TrainMeshComponent
    Components.Add(TrainMeshComponent)
}