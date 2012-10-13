class SeqAct_SpawnOnSelf extends SequenceAction;

var() Actor A;
var Actor Spawned;

/**
 * Called when the Kismet node receives an impulse from another Kismet node.
 *
 * @network			Server and client
 */
event Activated()
{
	Spawned = A.Spawn(class'RainbowTrains.TrainRed');
	Spawned.SetLocation(A.Location);
	OutputLinks[0].bHasImpulse = true;
}

defaultproperties
{
	// Name of the Kismet node to display within the Kismet desktop and the menu
	ObjName="Spawn On Self"
	// Name of the menu category that the Kismet node is in within the right click context menu
	ObjCategory="Misc"
	// Name of the input node on the Kismet node
	InputLinks(0)=(LinkDesc="In")
	// Name of the output node on the Kismet node
	OutputLinks(0)=(LinkDesc="Out")
	// Clear the parent variable links
	VariableLinks.Empty
	VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Player",PropertyName=A)
}