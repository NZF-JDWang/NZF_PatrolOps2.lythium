/*
	Author: JD Wang

	Description:
		Spawn Dirt Road IED 

	Parameter(s):
		0: IED Type <CLASSNAME>

	Returns:
		NONE

	Examples:
		[_iedType, _locationIED] call PatrolOps_fnc_spawnDirtRoadIED;
*/

params ["_iedType", "_locationIED"];


// IED types can be "CAR", "TRASHPILE" or "BURIED"
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

		for "_i" from 1 to (floor random (3)+1) do {

			// Get trash objects 
			private _allTrash = parseSimpleArray patrolOpsRoadClutter;
			private _trashType = selectRandom _allTrash;

			//spawn the trashpile
			private _trashpile = createVehicle [_trashType, _locationIED, [], 0.25, "CAN_COLLIDE"];
			_trashpile setdir random 360;
			_trashpile setVectorUp surfaceNormal (getposATL _trashpile);
			patrolOps_miscCleanUp pushback _trashpile;

			_trashpile enableSimulationGlobal false;

		};
	};

	case "BURIED": {

		// Get dirt objects 
		private _allDirtObjects = parseSimpleArray patrolOpsDirtClutter;
		private _dirtType = selectRandom _allDirtObjects;

		//Get road information
		private _road = [_locationIED, 20] call BIS_fnc_nearestRoad;
		private _roadInfo = [_road] call PatrolOps_fnc_getRoadInfo;
		_roadInfo params ["_roadType","_roadWidth","_roadDir", "_texture"];

		//spawn the dirtObject
		private _dirtpile = createVehicle [_dirtType, (_road getRelPos [(random(_roadWidth/2)), selectRandom [90,270]]), [], 0, "NONE"];
		_dirtpile setdir _roadDir;
		_dirtpile setVectorUp surfaceNormal (getposATL _dirtpile);
		patrolOps_miscCleanUp pushback _dirtpile;


	};
};