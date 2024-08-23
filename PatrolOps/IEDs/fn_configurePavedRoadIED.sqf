/*
    Author: JD Wang, Edited by Grok 2

    Description:
        Configures Paved Road IED with reduced risk of GIAR errors.

    Parameters:
        0: IED Type <STRING>
        1: Location <ARRAY>

    Returns:
        NONE

    Examples:
        ["CAR", [100,100,0]] call PatrolOps_fnc_configurePavedRoadIED;
*/

params ["_iedType", "_locationIED"];

switch (_iedType) do {
    case "CAR": {
        // Filter out specific car types that should not be used for IEDs
        private _allCars = parseSimpleArray grad_civs_cars_vehicles - ["UK3CB_TKC_C_YAVA","UK3CB_TKC_C_TT650"];
        
        // Find the nearest road within 50 meters of the specified location
        private _road = [_locationIED, 50] call BIS_fnc_nearestRoad;
        
        // Retrieve detailed information about the road
        private _roadInfo = [_road] call PatrolOps_fnc_getRoadInfo;
        _roadInfo params ["_roadType","_roadWidth","_roadDir", "_texture"];

        // Randomly select a car type and position it near the road
        private _wreckType = selectRandom _allCars;
        private _wreckPos = _road getRelPos [(_roadWidth/2) + (random 2) + 1, selectRandom [90,270]];
        private _wreck = createVehicle [_wreckType, _wreckPos, [], 0, "NONE"];
        _wreck setDir random 360;  // Set a random direction for the wreck
        patrolOps_miscCleanUp pushBack _wreck;  // Add to cleanup list

        // Randomly damage some wheels of the car
        private _wheels = ["wheel_1_1_steering", "wheel_1_2_steering", "wheel_2_1_steering", "wheel_2_2_steering"];
        _wheels resize ((ceil (random 2))+(floor (random 2)));  // Randomly select number of wheels to damage
        {_wreck setHit [_x, 1];} forEach _wheels;  // Set damage to 1 (fully destroyed)

        // Add a water spill effect near the wreck for realism
        private _water = createVehicle ["WaterSpill_01_Medium_Old_F", _wreck getRelPos [1, 180], [], 0, "CAN_COLLIDE"];
        _water setVectorUp surfaceNormal (getPosATL _water);  // Align water with terrain
        patrolOps_miscCleanUp pushBack _water;  // Add water spill to cleanup list

		// Add chance of garbage
		if (floor (random 4) > 1) then {
			_garbageType = selectrandom ["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];
			private _garbage = createVehicle [_garbageType, (getpos _water), [], ((random 1.5)+ 0.5), "CAN_COLLIDE"];
			_garbage setdir (random 360);
			_garbage setVectorUp surfaceNormal (getposATL _garbage);
			_garbage enableSimulationGlobal false;
			patrolOps_miscCleanUp pushback _garbage;
		};
    };

case "TRASHPILE": {
    // Parse the trash objects from patrolOpsRoadClutter
    private _allTrash = parseSimpleArray patrolOpsRoadClutter;
    
    // Filter trash by size, keeping only those with a size greater than 0
    private _trashTypes = _allTrash apply {[_x, _x call PatrolOps_fnc_getObjectSize]} select {_x # 1 > 0};
    _trashTypes sort false; // Sort trash by size in descending order

    private _centralPosition = _locationIED;
    private _numTrash = floor random 3 + 1; // Random number of trash piles between 1 and 3

    // Find the maximum size of trash for spacing calculations
    private _maxSize = 0;
    {
        if (_x # 1 > _maxSize) then {
            _maxSize = _x # 1;
        };
    } forEach _trashTypes;
    
    private _separationDistance = _maxSize * 1.1; // Spacing between trash piles

    private _positions = [];
    private _angleIncrement = 360 / _numTrash; // Angle between each trash pile
    for "_i" from 0 to (_numTrash - 1) do {
        private _angle = _angleIncrement * _i;
        private _distance = _separationDistance + (random 1); // Add slight randomness to distance
        private _pos = _centralPosition getPos [_distance, _angle];
        // Adjust position if it overlaps with existing positions
        while {[_pos, _trashTypes # _i # 1, _positions] call _checkOverlap} do {
            _angle = _angle + (random 10) - 5;
            _pos = _centralPosition getPos [_distance, _angle];
        };
        _positions pushBack _pos;
    };

    // Create trash piles with a delay
    for "_i" from 0 to (_numTrash - 1) do {
        [{
            params ["_trashType", "_position"];
            private _trashpile = createVehicle [_trashType, _position, [], 0, "CAN_COLLIDE"];
            _trashpile setDir random 360; // Random orientation
            _trashpile setVectorUp surfaceNormal (getPosATL _trashpile); // Align with terrain
            patrolOps_miscCleanUp pushBack _trashpile; // Add to cleanup array
            _trashpile enableSimulationGlobal false; // Disable simulation for performance
        }, [_trashTypes # _i # 0, _positions # _i], _i * 0.5] call CBA_fnc_waitAndExecute;
    };
};
};