/*
    Author: JD Wang

    Description:
    Spawns a randomly selected type of roadblock based on road characteristics at the given location,
    and adds all spawned objects to patrolOps_miscCleanUp for cleanup.

    Parameter(s):
    _location - Position where to check for road and spawn roadblock.

    Returns:
    Array containing the spawned roadblock objects.

    Examples:
    [_target] call PatrolOps_fnc_roadblock;
*/

params ["_location"];

// Define roadblock types
private _trashRoadblock = ["Land_Barricade_01_10m_F"];
private _trenchRoadBlock = ["GRAD_envelope_giant"];
private _carRoadBlock = ["Land_Wreck_Skodovka_F", "Land_Wreck_Truck_F", "Land_Wreck_Offroad_F", "Land_Wreck_Ural_F", "Land_Wreck_Truck_dropside_F"];

// Get road info for the location 
private _road = [_location, 50] call BIS_fnc_nearestRoad;
private _roadInfo = [_road] call PatrolOps_fnc_getRoadInfo;
_roadInfo params ["_roadType","_roadWidth","_roadDir", "_texture"];

// Determine if the road is paved
private _isPavedRoad = _roadType isEqualTo "MAIN ROAD" || _roadType isEqualTo "ROAD" || _texture isEqualTo "a3\roads_f\roads_ae\data\surf_roadconcrete_city_road_ca.paa";

// Determine which roadblock types can spawn based on road surface
private _eligibleRoadblocks = if (_isPavedRoad) then {
    // For paved roads, include trash and car roadblocks
    [_trashRoadblock, _carRoadBlock]
} else {
    // For unpaved roads, include trench and car roadblocks
    [_trenchRoadBlock, _carRoadBlock]
};

// Randomly select a roadblock type
private _selectedRoadblockType = selectRandom _eligibleRoadblocks;

// Spawn roadblock
private _spawnedObjects = [];

if (_selectedRoadblockType isEqualTo _trashRoadblock || _selectedRoadblockType isEqualTo _trenchRoadBlock) then {
    // Spawn single object roadblock (trash or trench)
    private _object = selectRandom _selectedRoadblockType;
    private _roadblock = createVehicle [_object, _road, [], 0, "CAN_COLLIDE"];
    _roadblock setDir _roadDir;
    _spawnedObjects pushBack _roadblock;
    patrolOps_miscCleanUp pushBack _roadblock;
} else {
    // Spawn car roadblock
    if (count _carRoadBlock > 0) then {
        private _leftCar = selectRandom _carRoadBlock;
        private _rightCar = selectRandom (_carRoadBlock - [_leftCar]); // Ensure different cars on each side

        private _leftPos = _road getPos [(_roadWidth / 2) + 2, (_roadDir + 270) % 360];
        private _rightPos = _road getPos [(_roadWidth / 2) + 2, (_roadDir + 90) % 360];

        private _leftCarObj = createVehicle [_leftCar, _leftPos, [], 0, "CAN_COLLIDE"];
        private _rightCarObj = createVehicle [_rightCar, _rightPos, [], 0, "CAN_COLLIDE"];

        _leftCarObj setDir (_roadDir + 90 + random [-15, 0, 15]);
        _rightCarObj setDir (_roadDir + 270 + random [-15, 0, 15]);

        _spawnedObjects pushBack _leftCarObj;
        _spawnedObjects pushBack _rightCarObj;
        
        // Add both cars to cleanup array
        patrolOps_miscCleanUp pushBack _leftCarObj;
        patrolOps_miscCleanUp pushBack _rightCarObj;
    };
};
