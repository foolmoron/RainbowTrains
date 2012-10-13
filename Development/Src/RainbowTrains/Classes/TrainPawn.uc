class TrainPawn extends InterpActor
    DependsOn(GridNode, Track);

var String TrainColor;
var int side;
var vector gridLocation;
var int originalRotation;
var AnimationType currentAnimation;
var bool ready;
var bool canAnimate;
var bool finished;

defaultproperties
{
    side=0;
    TrainColor="Blue"
	ready = true;
	canAnimate=false;
	finished = false;
   bStatic=FALSE
   bNoDelete=FALSE
    Begin Object Class=StaticMeshComponent Name=TrainMeshComponent
        StaticMesh=StaticMesh'Rainbow_Models.TrainBlue'
        Scale=0.175
    End Object
    CollisionComponent=TrainMeshComponent
    Components.Add(TrainMeshComponent)
}