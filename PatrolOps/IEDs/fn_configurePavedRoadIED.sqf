/*
	Author: JD Wang

	Description:
		Spawn Paved Road IED 

	Parameter(s):
		0: IED Type <CLASSNAME>

	Returns:
		NONE

	Examples:
		[_iedType, _locationIED] call PatrolOps_fnc_spawnPavedRoadIED;
*/

params ["_iedType", "_locationIED"];

// IED types can be "CAR", or "TRASHPILE"
switch (_iedType) do {


	case "CAR": {
		// Get list of cars
		private _allCars = parseSimpleArray grad_civs_cars_vehicles;
		_allCars = _allCars - ["UK3CB_TKC_C_YAVA","UK3CB_TKC_C_TT650"];

		//Get road information
		private _road = [_locationIED, 20] call BIS_fnc_nearestRoad;
		private _roadInfo = [_road] call PatrolOps_fnc_getRoadInfo;
		_roadInfo params ["_roadType","_roadWidth","_roadDir", "_texture"];

		//spawn the wreck
		private _wreckType = selectrandom _allCars;
		private _wreck = createVehicle [_wreckType, (_road getRelPos [((_roadWidth/2) + (random 2) + 1), selectRandom [90,270]]), [], 0, "NONE"];
		_wreck setdir random 360;
		patrolOps_miscCleanUp pushback _wreck;

		//damage random wheels on the vehicle
		private _wheels = ["wheel_1_1_steering", "wheel_1_2_steering", "wheel_2_1_steering", "wheel_2_2_steering"];
		_wheels resize ((ceil (random 2))+(floor (random 2)));
		{_wreck sethit [_x, 1];} foreach _wheels;

		//now add some water to the ground 
		private _water = createVehicle ["WaterSpill_01_Medium_Old_F", (_wreck getRelPos [1, 180]), [], 0, "CAN_COLLIDE"];
		_water setVectorUp surfaceNormal (getposATL _water);
		patrolOps_miscCleanUp pushback _water;

	};

	case "TRASHPILE": {
		// Get list of trash objects
		private _allTrash = parseSimpleArray patrolOpsRoadClutter;
		private _trashTypes = _allTrash apply {[_x, _x call PatrolOps_fnc_getObjectSize]};
		_trashTypes = _trashTypes select {_x # 1 > 0}; // Filter out objects with zero or negative size

		// Sort trash by size for better placement
		_trashTypes sort false; // Sort in descending order

		// Define the central position
		private _centralPosition = _locationIED;

		// Calculate the number of trash items (1 to 3)
		private _numTrash = floor random 3 + 1;

		// Calculate positions for trash items
		private _positions = [];
		private _angleIncrement = 360 / _numTrash;
		private _maxSize = _trashTypes # 0 # 1; // Largest trash item size
		private _separationDistance = _maxSize * 1.1; // 10% extra to ensure no touching

		for "_i" from 0 to (_numTrash - 1) do {
			private _angle = _angleIncrement * _i;
			private _position = _centralPosition getPos [_separationDistance, _angle];
			_positions pushBack _position;
		};

		// Spawn the trash items
		for "_i" from 0 to (_numTrash - 1) do {
			private _trashType = _trashTypes # _i # 0;
			private _trashpile = createVehicle [_trashType, _positions # _i, [], 0, "CAN_COLLIDE"];
			_trashpile setDir random 360;
			_trashpile setVectorUp surfaceNormal (getPosATL _trashpile);
			patrolOps_miscCleanUp pushBack _trashpile;
			_trashpile enableSimulationGlobal false;
		};
	};
};