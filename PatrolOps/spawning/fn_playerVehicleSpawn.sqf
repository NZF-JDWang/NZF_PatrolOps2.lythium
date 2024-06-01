/*
	Author: JD Wang

	Description:
		Spawns player vehicles at the correct FOB

	Parameter(s):
		0: Number of players   <NUMBER>

	Returns:
		Nothing

	Examples:
		[_playerTotal] call PatrolOps_fnc_playerVehicleSpawn;
*/
params ["_playerTotal"];

// get the active FOB
private _startingFOB = getmarkerPos (missionNamespace getVariable "startingFOB");

// find spawn location and direction
private _vehSpawn = (nearestObjects [ _startingFOB, ["SignAd_Sponsor_F"],150]) select 0;
private _spawnDir = 180 +(getdir _vehSpawn);

// spawn the EOD vehicle
private _veh = createVehicle [selectrandom (parseSimpleArray patrolOps_EODVehicles), (_vehSpawn getRelPos [3, 90]), [], 0, "NONE"];
patrolOps_playerEDOVehicles pushback _veh;
_veh setdir _spawnDir;
_playerTotal = (_playerTotal - 4);

[_veh,"EOD"] call PatrolOps_fnc_vehicleInventory;


// now randomly pick the type of infatry vehicle and spawn enough to carry all players
switch (floor random 6) do 
{
	// multiple cases with the same options to weight the chances towards med vehicles, then light, then heavy
	// light Vehicles 
	case 1: {
		_numberVehicles = ceil (_playerTotal/3);
		for "_i" from 1 to _numberVehicles do {
			private _veh = createVehicle [selectRandom (parseSimpleArray patrolOps_lightVehicles), (_vehSpawn getRelPos [(3* _i), 270]), [], 0, "NONE"];
			patrolOps_playerInfantryVehicles pushback _veh;
			_veh setdir _spawnDir;
			[_veh,"Infantry"] call PatrolOps_fnc_vehicleInventory;
		};
	};
	// light Vehicles
	case 2: {
		_numberVehicles = ceil (_playerTotal/3);
		for "_i" from 1 to _numberVehicles do {
			private _veh = createVehicle [selectRandom (parseSimpleArray patrolOps_lightVehicles), (_vehSpawn getRelPos [(3* _i), 270]), [], 0, "NONE"];
			patrolOps_playerInfantryVehicles pushback _veh;
			_veh setdir _spawnDir;
			[_veh,"Infantry"] call PatrolOps_fnc_vehicleInventory;
		};
	};
	// medium Vehicles
	case 3: {
		_numberVehicles = ceil (_playerTotal/3);
		for "_i" from 1 to _numberVehicles do {
			private _veh = createVehicle [selectRandom (parseSimpleArray patrolOps_medVehicles), (_vehSpawn getRelPos [(3* _i), 270]), [], 0, "NONE"];
			patrolOps_playerInfantryVehicles pushback _veh;
			_veh setdir _spawnDir;
			[_veh,"Infantry"] call PatrolOps_fnc_vehicleInventory;
		};
	};
	// medium Vehicles
	case 4: {
		_numberVehicles = ceil (_playerTotal/3);
		for "_i" from 1 to _numberVehicles do {
			private _veh = createVehicle [selectRandom (parseSimpleArray patrolOps_medVehicles), (_vehSpawn getRelPos [(3* _i), 270]), [], 0, "NONE"];
			patrolOps_playerInfantryVehicles pushback _veh;
			_veh setdir _spawnDir;
			[_veh,"Infantry"] call PatrolOps_fnc_vehicleInventory;
		};
	};
	// medium Vehicles
	case 5: {
		_numberVehicles = ceil (_playerTotal/3);
		for "_i" from 1 to _numberVehicles do {
			private _veh = createVehicle [selectRandom (parseSimpleArray patrolOps_medVehicles), (_vehSpawn getRelPos [(3* _i), 270]), [], 0, "NONE"];
			patrolOps_playerInfantryVehicles pushback _veh;
			_veh setdir _spawnDir;
			[_veh,"Infantry"] call PatrolOps_fnc_vehicleInventory;
		};
	};
	// heavy vehicles 
	default {
		_numberVehicles = ceil (_playerTotal/8);
		for "_i" from 1 to _numberVehicles do {
			private _veh = createVehicle [selectRandom (parseSimpleArray patrolOps_heavyVehicles), (_vehSpawn getRelPos [(3* _i), 270]), [], 0, "NONE"];
			patrolOps_playerInfantryVehicles pushback _veh;
			_veh setdir _spawnDir;
			[_veh,"Infantry"] call PatrolOps_fnc_vehicleInventory;
		};

	};
};
