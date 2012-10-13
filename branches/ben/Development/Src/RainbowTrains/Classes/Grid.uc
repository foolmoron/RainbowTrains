class Grid extends Object 
    DependsOn(Track, GridNode);

const XSIZE = 10;
const YSIZE = 10;
const ZSIZE = 10;
const TOTALNODES = 1000; // XSIZE * YSIZE * ZSIZE

var Rainbow_GameInfo game;
var GridNode nodes[TOTALNODES];

function Initialize(Rainbow_GameInfo argGame)
{
	local int x, y, z;
	game = argGame;
	for (x = 0; x < XSIZE; x++)
	{
		for (y = 0; y < YSIZE; y++)
		{
			for (z = 0; z < ZSIZE; z++)
			{
				nodes[z * (YSIZE * XSIZE) + y * (XSIZE) + x] = game.spawn(class 'GridNode');
				AtCoordinates(x,y,z).Initialize(x, y, z, game, self);
			}
		}
	}
    
    // TODO: Load Level
    AtCoordinates(1, 1, 1).SetTrack(T_STATION, 0);
    AtCoordinates(0, 2, 0).SetTrack(T_STATION, 0);
	
    `log("Grid Initialized");
}

function array<GridNode> FindStations() {
    local int x, y, z;
    local array<GridNode> stations;
	for (x = 0; x < XSIZE; x++)
	{
		for (y = 0; y < YSIZE; y++)
		{
			for (z = 0; z < ZSIZE; z++)
			{
				if(AtCoordinates(x,y,z).getType() == T_STATION) {
                    `log("STation at "$x$" "$y$" "$z);
                    stations.AddItem(AtCoordinates(x,y,z));
                }
			}
		}
	}
    return stations;
}

function GridNode AtCoordinates(int localX, int localY, int localZ)
{
	return nodes[localZ * (YSIZE * XSIZE) + localY * (XSIZE) + localX];
}

function GridNode AtVector(vector local)
{
	return AtCoordinates(local.x, local.y, local.z);
}

function vector LocalToWorldCoordinates(int localX, int localY, int localZ)
{
	local vector worldLocation;
	worldLocation.x = localX * class'Rainbow_GameInfo'.const.TILESIZE;
	worldLocation.y = localY * class'Rainbow_GameInfo'.const.TILESIZE;
	worldLocation.z = localZ * (class'Rainbow_GameInfo'.const.TILESIZE / 2);
	return worldLocation;
}

function vector LocalToWorldVector(vector local)
{
	return LocalToWorldCoordinates(local.x, local.y, local.z);
}
 
function vector WorldToLocalCoordinates(int worldX, int worldY, int worldZ){
    local vector localLocation;
    
    
	localLocation.x = worldX / class'Rainbow_GameInfo'.const.TILESIZE;
	if (localLocation.x < 0) {
		localLocation.x = 0;
    } else if(localLocation.x >= XSIZE) {
        localLocation.x = XSIZE - 1;
    }
    
	localLocation.y = worldY / class'Rainbow_GameInfo'.const.TILESIZE;
	if (localLocation.y < 0) {
		localLocation.y = 0;
    } else if(localLocation.y >= YSIZE) {
        localLocation.y = YSIZE - 1;
    }
    
	localLocation.z = worldZ / (class'Rainbow_GameInfo'.const.TILESIZE / 2);
	if (localLocation.z < 0) {
		localLocation.z = 0;
    } else if(localLocation.z >= ZSIZE) {
        localLocation.z = ZSIZE - 1;
    }
    
    return localLocation;
}

function vector WorldToLocalVector(vector world) {
    return WorldToLocalCoordinates(world.x, world.y, world.z);
}

defaultproperties{
}