class Rainbow_GameInfo extends FrameworkGame
    DependsOn(Track);

const TILESIZE = 250;

var Grid grid;
var GhostTrack ghost;

var bool running;
var array<TrainPawn> trains;

function TrainPawn spawnTrain(vector spawnLocation, Track.Sides spawnSide) {
    local TrainPawn train;
    train = spawn(class'TrainPawn');
    train.SetLocation(spawnLocation);
    train.side = spawnSide;
    return train;
}

function TrainPawn killTrain(TrainPawn train, optional bool remove = true) {
    train.destroy();
    if(remove) {
        trains.RemoveItem(train);
    }
    return train;
}

function TrainTick() {
    local TrainPawn train;
    local vector movement;
    local vector current;
    local GridNode nextGridNode;
    local Track.Sides nextSide;
    foreach trains(train) {
        current = grid.WorldToLocalVector(train.Location);
        movement = grid.AtVector(current).track.getMovementVector(train.side);
        if(movement.x == 0 && movement.y == 0 && movement.z == 0) {
            killTrain(train);
        } else {
            current = current + movement;
            if((current.x < 0 || current.x >= class'Grid'.const.XSIZE) ||
                (current.y < 0 || current.y >= class'Grid'.const.YSIZE) ||
                (current.z < 0 || current.z >= class'Grid'.const.ZSIZE)) {
                killTrain(train);
            } else {
                nextGridNode = grid.AtVector(current);
                if(nextGridNode.getType() == T_BLOWUP) {
                    killTrain(train);
                } else {
                    nextSide = nextGridNode.track.getOpposite(train.side);
                    movement = nextGridNode.track.getMovementVector(nextSide);
                    if(movement.x == 0 && movement.y == 0 && movement.z == 0) {
                        killTrain(train);
                    } else {
                        train.SetLocation(grid.LocalToWorldVector(current));
                        train.side = nextSide;
                    }
                }
            }
        }
    }
}

function StartStop() {
    local TrainPawn train;
    local array<GridNode> stations;
    local GridNode station;
    if(!running) {
        `log("StartStop - Start");
        SetTimer(1.0f, true, 'TrainTick');
        running = true;
        stations = grid.FindStations();
        foreach stations(station) {
            `log("Spawning at "$station.Location);
            trains.AddItem(spawnTrain(station.track.Location, S_YNEG));
        }
    } else {
        `log("StartStop - Stop");
        SetTimer(0.0f, false, 'TrainTick');
        running = false;
        foreach trains(train) {
            killTrain(train, false);
        }
        trains.length = 0;
    }
}

event InitGame(string Options, out string Error){
    super.InitGame(Options, Error);
    grid = new class'Grid';
    ghost = Spawn(class'RainbowTrains.GhostTrack');
    grid.Initialize(self);
}

event PostLogin( PlayerController NewPlayer )
{
    super.PostLogin(NewPlayer);
    NewPlayer.ClientMessage("Welcome to the grid "$NewPlayer.PlayerReplicationInfo.PlayerName);
    NewPlayer.ClientMessage("Point at an object and press the left mouse button to retrieve the target's information");
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
   running=false;
}