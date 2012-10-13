class SeqAct_ChooseTrainMatinee extends SequenceAction;

var() TrainPawn Train;
var int MatineeIndex;

/**
 * Called when the Kismet node receives an impulse from another Kismet node.
 *
 * @network			Server and client
 */
event Activated()
{
	local float x;
	local int tileX;
	x = Train.Location.X;
	tileX = x/100;
	if (tileX < 0)
		MatineeIndex = 0;
	else MatineeIndex = 1;
	OutputLinks[0].bHasImpulse = true;
}

defaultproperties
{
	// Name of the Kismet node to display within the Kismet desktop and the menu
	ObjName="Get Matinee Index For Train"
	// Name of the menu category that the Kismet node is in within the right click context menu
	ObjCategory="Misc"
	// Name of the input node on the Kismet node
	InputLinks(0)=(LinkDesc="In")
	// Name of the output node on the Kismet node
	OutputLinks(0)=(LinkDesc="Out")
	// Clear the parent variable links
	VariableLinks.Empty
	VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Train",PropertyName=Train)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Matinee Index",bWriteable=true,PropertyName=MatineeIndex)
}