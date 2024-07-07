/*
	Author: JD Wang

	Description:
		Randomly selects potential IED locations along the route 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_selectIEDs;
*/

// Get patrol IED level 
private ["_numberOfIEDs"];
private _patrolDifficulty = missionNamespace getvariable "patrolDifficulty";

switch (_patrolDifficulty) do {

	case "LOW": {_numberOfIEDs = random [2,3,3]};

	case "MEDIUM": {_numberOfIEDs = random [4,4,5]};

	case "HIGH": {_numberOfIEDs = random [5,6,7]};
};

// Setup all possible locations into 2 arrays 
private _locationsOut = allMapMarkers select {_x find "debugPotentialIED_out" >= 0};
private _locationsIn = allMapMarkers select {_x find "debugPotentialIED_in" >= 0};

[_locationsOut, _numberOfIEDs] call PatrolOps_fnc_processIEDLocations;
[_locationsIn, _numberOfIEDs] call PatrolOps_fnc_processIEDLocations;

