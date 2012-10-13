class SeqAct_ChooseTrainMatinee extends SequenceAction;

var() TrainPawn train;
var bool isReady;
var bool canAnimate;
var int matineeIndex;

/**
 * Called when the Kismet node receives an impulse from another Kismet node.
 *
 * @network			Server and client
 */
event Activated()
{
	matineeIndex = -1;
	if (train == none){
		canAnimate = false;
		return;
	}
	canAnimate = train.canAnimate;
	if (canAnimate){
		switch (train.currentAnimation){
		case A_STRAIGHT: matineeIndex = 0; break;
		case A_LEFT: matineeIndex = 1; break;
		case A_RIGHT: matineeIndex = 2; break;
		case A_UP: matineeIndex = 3; break;
		case A_DOWN: matineeIndex = 4; break;
		case A_ENTER: matineeIndex = 5; break;
		}
		`log("Animating "$train.currentAnimation$" on "$train);
		train.canAnimate = false;
	}
	OutputLinks[0].bHasImpulse = true;
}

defaultproperties
{
	// Name of the Kismet node to display within the Kismet desktop and the menu
	ObjName="Get Matinee Index For Train"
	// Name of the menu category that the Kismet node is in within the right click context menu
	ObjCategory="Train"
	// Name of the input node on the Kismet node
	InputLinks(0)=(LinkDesc="In")
	// Name of the output node on the Kismet node
	OutputLinks(0)=(LinkDesc="Out")
	// Clear the parent variable links
	VariableLinks.Empty
	VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Train",PropertyName=train)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Can Animate",bWriteable=true,PropertyName=canAnimate)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Matinee Index",bWriteable=true,PropertyName=matineeIndex)
}