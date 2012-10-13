class Rainbow_GameInfo extends FrameworkGame
    DependsOn(Track);

const TILESIZE = 250;
const MAXTRAINS = 10;
const UPDATEINTERVAL = 0.01f;
const NUMLEVEL = 10;

const R = "Red";
const B = "Blue";
const Y = "Yellow";

var Grid grid;
var Track ghost;
var vector centerOffset;
var bool running;
var bool levelComplete;
var array<TrainPawn> trains;
var int currentLevel;
var int trainCount;
var array<TrainLevel> levels;
var int blockIndex;
var bool aTrainCrashed;

//wait to be call 
function NextLevel(){
	local int level;
	if (running)
		StartStop();
	levelComplete = false;
	grid.CleanUp( );
	level = currentLevel + 1;
	if (level >= levels.length) {
		currentLevel = -1;
		NextLevel();
	}
	else {
		currentLevel = level;
		grid.LoadCurrentLevel();
	}
}

event InitGame(string Options, out string Error){
    super.InitGame(Options, Error);
	InitLevel();
    grid = new class'Grid';
    ghost = Spawn(class'RainbowTrains.Track');
	ghost.isGhost = true;
    ghost.setTypeAndOrientation(T_STRAIGHT, 0);
    grid.Initialize(self);	
    PlaySound(SoundCue'KismetGame_Assets.Sounds.Jazz_Intro_Cue');
}

//call by game init : hard code level data 
function InitLevel(){
	local TrainLevel l1;
	local TrainLevel l2;
	local TrainLevel l3;
    local TrainLevel l4;
    local TrainLevel l5;
    local TrainLevel l6;
    local TrainLevel l7;
    local TrainLevel l8;
    local TrainLevel l9;
    local TrainLevel l10;

    local int i,j;
	
	l1 = new class'TrainLevel';
	l1.Initialize(self);
	l1.addStart(4,4,0,0,R);
	l1.addEnd(8,4,0,0,R);
	levels.AddItem(l1);
	
	l2 = new class'TrainLevel';
	l2.Initialize(self);
	l2.addStart(4,4,0,0,R);
	l2.addEnd(8,8,0,3,R);
	levels.AddItem(l2);
		
	l3 = new class'TrainLevel';
	l3.Initialize(self);
    
    l3.addStart(4,4,0,0,R);
	l3.addEnd(8,4,0,0,R);
    l3.addBlock(6,4,0);
	levels.AddItem(l3);
    
    l4 = new class'TrainLevel';
	l4.Initialize(self);
    l4.addStart(4,4,0,0,R);
	l4.addEnd(8,4,0,0,R);
    for ( i =0 ; i<10; i++){
        l4.addBlock(6,i,0);
    }
	levels.AddItem(l4); 
    
    l5 = new class'TrainLevel';
	l5.Initialize(self);
    l5.addStart(1,4,0,0,R);
	l5.addEnd(7,4,0,0,R);
    for ( j=0; j<10; j++){
        for ( i =0 ; i<10; i++){
            if (i!=2 || j!=2) 
            l5.addBlock(4,i,j);
        }
    }
	levels.AddItem(l5); 
    
    l6 = new class'TrainLevel';
	l6.Initialize(self);
	l6.addStart(1,3,0,0,R);    
	l6.addStart(1,5,0,0,B);
	l6.addEnd(7,3,0,0,R);
	l6.addEnd(7,5,0,0,B);
	levels.AddItem(l6);
    
    
    l7 = new class'TrainLevel';
	l7.Initialize(self);
	l7.addStart(1,5,0,0,R);    
	l7.addStart(3,3,0,3,B);
	l7.addEnd(4,5,0,0,R);
	l7.addEnd(3,7,0,3,B);
	levels.AddItem(l7);
    
    l8 = new class'TrainLevel';
	l8.Initialize(self);
	l8.addStart(2,3,0,0,R);    
	l8.addStart(2,4,0,0,B);
	l8.addEnd(6,4,0,0,R);
	l8.addEnd(6,3,0,0,B);
     for ( i = 0 ; i<10; i++){
        l8.addBlock(i,2,0);
        l8.addBlock(i,5,0);
    }
	levels.AddItem(l8);
    
    l9 = new class'TrainLevel';
	l9.Initialize(self);
    l9.addStart(1,4,0,0,R);
	l9.addEnd(7,4,0,0,R);
    l9.addStart(1,5,0,0,B);
	l9.addEnd(7,5,0,0,B);
    for ( j=0; j<10; j++){
        for ( i =0 ; i<10; i++){
            if (i!=2 || (j!=2 && j!=3)) 
            l9.addBlock(4,i,j);
        }
    }
	levels.AddItem(l9); 
    
    l10 = new class'TrainLevel';
	l10.Initialize(self);
    l10.addStart(0,3,0,0,R);
	l10.addEnd(6,5,0,0,R);
    l10.addStart(0,4,0,0,B);
	l10.addEnd(5,4,2,1,B);
    l10.addStart(0,5,0,0,Y);
	l10.addEnd(5,4,1,2,Y);
 
    for ( j=3; j<8; j++){
        for ( i=0 ; i<3; i++){
            l10.addBlock(j,3,i);
            l10.addBlock(j,6,i);
            if (j==7){
                l10.addBlock(j,4,i);
                l10.addBlock(j,5,i);
                }

        }
    }
	levels.AddItem(l10); 
    
    
    
}


function bool spawnTrain(vector spawnLocation, int spawnSide, string tColor, out TrainPawn train) {
	local Rotator newRotation;
	if (trains.length >= MAXTRAINS ){
		`log("Can't spawn train, already have "$trains.length);
		return false;
	}
	/*if (train != none){
		`log("Can only spawn using uninitialized TrainPawn");
		return false;
	}*/
	if (tColor == B)
		train = spawn(class'TrainBlue');
	else if (tColor == R)
		train = spawn(class'TrainRed');
	else if (tColor == Y)
		train = spawn(class'TrainYellow');
	else
		train = spawn(class'TrainPawn');
	switch(spawnSide){
	case 0: spawnLocation.X += 75; break;
	case 1: spawnLocation.Y -= 75; break;
	case 2: spawnLocation.X -= 75; break;
	case 3: spawnLocation.Y += 75; break;
	}
	train.side = spawnSide;
    train.SetLocation(spawnLocation);
	newRotation.yaw = -spawnSide*16384;
	train.SetRotation(newRotation);
	train.gridLocation = grid.WorldToLocalVector(spawnLocation);
	triggerAnimationEvent(trains.length, train);
    return true;
}


function destructTrain(TrainPawn train) {
    train.destroy();
}

function TrainPawn killTrain(TrainPawn train) {
    destructTrain(train);
    trains.RemoveItem(train);
    PlaySound(SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_RobotImpact_BodyExplosion_Cue');
    aTrainCrashed = true;
    return train;
}

function TrainTick() {
    local TrainPawn train;
	//local rotator newRotation;
    local vector movement;
    local vector current, belowNext;
	local GridNode currentGridNode;
    local GridNode nextGridNode;
	local AnimationType animation;
    local int nextSide, raised, dummySide;
	local int i;
    
	for (i = 0; i < trains.length; i++) {
		raised = 0;
		train = trains[i];
		if (!train.ready || train.finished){
			continue;
		}
        current = train.gridLocation;
		currentGridNode = grid.AtVector(current);
		if (currentGridNode.getType() == T_END){
			if (currentGridNode.track.stationColor == train.trainColor){
				`log("Train "$i$" finished!");
				train.finished = true;
                PlaySound(SoundCue'CastleAudio.UI.UI_MainMenu_Cue');
			} else {
				`log("Train of color "$train.trainColor$" died entering "$currentGridNode.track.stationColor$" station");
				killTrain(train);
				i--;
			}
			continue;
		}
		if (!currentGridNode.track.getNextSide(train.side, currentGridNode, nextSide, raised, animation)){
			`log("Current grid node next side FAILED");
			return;
		}
        movement = currentGridNode.track.getMovementVector(nextSide, raised);
		`log("train"$i$" movement1="$movement$" current side="$train.side$" currentnode="$currentGridNode.gridLocation$" currentNodeType="$currentGridNode.getType()$" raised="$raised);
        current = current + movement;
        if((current.x < 0 || current.x >= class'Grid'.const.XSIZE) ||
			(current.y < 0 || current.y >= class'Grid'.const.YSIZE) ||
			(current.z < 0 || current.z >= class'Grid'.const.ZSIZE)) {
			killTrain(train);
			i--;
			continue;
		}
        nextGridNode = grid.AtVector(current);
		`log("train"$i$" nextnode="$nextGridNode.gridLocation);
        if(nextGridNode.getType() == T_BLOWUP || nextGridNode.getType() == T_RAISED) {
`log("fail 2.1");
			belowNext = nextGridNode.gridLocation;
			belowNext.Z -= 1;
			if (nextGridNode.getType() == T_RAISED && (nextSide == nextGridNode.track.orientation)){
			}
			else if (belowNext.Z >= 0 && grid.AtVector(belowNext).getType() == T_RAISED && (nextSide == (grid.AtVector(belowNext).track.orientation+2)%4)){
`log("fail 2.2");
				nextGridNode = grid.AtVector(belowNext);
			}
			else {
				killTrain(train);
`log("fail 2.3");
				i--;
				continue;
			}
        }
		if (!nextGridNode.track.getNextSide(nextSide, nextGridNode, dummySide, raised, animation)){
			`log("fail 3.1 side="$nextSide);
			belowNext = nextGridNode.gridLocation;
			belowNext.Z -= 1;
			if (belowNext.Z >= 0 && grid.AtVector(belowNext).getType() == T_RAISED){
				nextGridNode = grid.AtVector(belowNext);
			}
			if (belowNext.Z < 0 || !nextGridNode.track.getNextSide(nextSide, nextGridNode, dummySide, raised, animation)){
				`log("fail 3.2 side="$nextSide);
				killTrain(train);
				i--;
				continue;
			}
		}
		train.side = nextSide;
		train.gridLocation = nextGridNode.gridLocation;
		train.currentAnimation = animation;
		train.ready = false;
		train.canAnimate = true;
		//train.SetLocation(grid.LocalToWorldVector(train.gridLocation));		//+centerOffset-movement*TILESIZE/2
		//newRotation.yaw = train.originalRotation-nextSide*16384;
		//train.SetRotation(newRotation);
		//triggerAnimationEvent(animation, train);
		`log("train"$i$" movement2="$movement$" current side="$train.side$" currenttrainnode="$train.gridLocation$" currentNodeType="$currentGridNode.getType());
    }
	i = 0;
	foreach trains(train){
		if (train == none)
			continue;
		else if (train.finished)
			i++;
	}
	levelComplete = (i == trainCount);
	if (levelComplete){
		`log("COMPLETE with "$trainCount$" trains!");
        PlaySound(SoundCue'KismetGame_Assets.Sounds.Jazz_Chatter_Happy_Cue');
		NextLevel();
	}
}

function StopTrains() {
    local TrainPawn train;
    
    SetTimer(0.0f, false, 'TrainTick');
    running = false;
    foreach trains(train) {
        destructTrain(train);
    }
    trains.length = 0;
}

function StartStop() {
    local TrainPawn train;
    local array<GridNode> stations;
    local GridNode station;
    if(!running) {
        `log("StartStop - Start");
        running = true;
        stations = grid.FindStartStations();
        foreach stations(station) {
            `log("Spawning at "$station.Location);
			if (spawnTrain(station.track.Location, station.track.orientation, station.track.stationColor, train)){
				trains.AddItem(train);
			}
        }
        aTrainCrashed = false;
        SetTimer(UPDATEINTERVAL, true, 'TrainTick');
    } else {
        `log("StartStop - Stop");
        StopTrains();
    }
}

function triggerAnimationEvent(int index, TrainPawn train)
{
	local array<SequenceObject> AllSeqEvents;
	local Sequence GameSeq;
	local int i;
	local name eventName;

	switch(index){
	case 0: eventName = 'Play0'; break;
	case 1: eventName = 'Play1'; break;
	case 2: eventName = 'Play2'; break;
	case 3: eventName = 'Play3'; break;
	case 4: eventName = 'Play4'; break;
	case 5: eventName = 'Play5'; break;
	case 6: eventName = 'Play6'; break;
	case 7: eventName = 'Play7'; break;
	case 8: eventName = 'Play8'; break;
	case 9: eventName = 'Play9'; break;
	}

	GameSeq = WorldInfo.GetGameSequence();
	if (GameSeq != None)
	{
		// reset the game sequence
		GameSeq.Reset();

		// find any Level Reset events that exist
		GameSeq.FindSeqObjectsByClass(class'SeqEvent_RemoteEvent', true, AllSeqEvents);
		`log("Searching events for "$eventName);
		// activate them
		for (i = 0; i < AllSeqEvents.Length; i++)
		{
			if(SeqEvent_RemoteEvent(AllSeqEvents[i]).EventName == eventName){
				`log("Played event:"$eventName);
				SeqEvent_RemoteEvent(AllSeqEvents[i]).CheckActivate(WorldInfo, train);
			}
		}
	}
}

event PostLogin( PlayerController NewPlayer )
{
    super.PostLogin(NewPlayer);
    NewPlayer.ClientMessage("Welcome to the game "$NewPlayer.PlayerReplicationInfo.PlayerName);
    NewPlayer.ClientMessage("Start building your tracks !");
}

event PlayerController Login(string Portal, string Options, const UniqueNetID UniqueID, out string ErrorMessage)
{
    local PlayerController PC;
    PC = super.Login(Portal, Options, UniqueID, ErrorMessage);
    ChangeName(PC, "Nyan", true);
    return PC;
}

defaultproperties
{
    PlayerControllerClass=class'RainbowTrains.Rainbow_PlayerController'
    currentlevel = 0
    blockIndex = 0;
    running = false
}