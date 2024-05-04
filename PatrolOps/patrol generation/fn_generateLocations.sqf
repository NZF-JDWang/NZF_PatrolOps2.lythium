/*
	Author: JD Wang

	Description:
		Spawns markers along the patrol route 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_generateLocations;
*/

// Constants
private _axis = worldSize/2;
private _center = [_axis, _axis, 0];
private _radius = sqrt(_axis^2 + _axis^2);
private _radiusMultiplier = 0.75;

// Select starting Patrol base
private _startFOB = selectRandom patrolOps_patrolBases;
missionNamespace setVariable ["startingFOB", _startFOB];

// Show startFOB Marker
private _startFOBMarker = [patrolOps_patrolBases, _startFOB] call BIS_fnc_nearestPosition;
_startFOBMarker setMarkerAlpha 1;

// Find the first patrol location
private _firstPatrolLoc = selectRandom (nearestLocations [getMarkerPos _startFOB, ["NameVillage", "NameCity", "NameCityCapital"], _radius / 2]);

// Encourage positions not to be on the edge of the AO
private _firstPatrolLocData = [
    (text _firstPatrolLoc),
    locationPosition _firstPatrolLoc,
    (size _firstPatrolLoc select 0) * _radiusMultiplier,
    (size _firstPatrolLoc select 1) * _radiusMultiplier,
    direction _firstPatrolLoc
];

_firstPatrolLocData params ["_locName","_locPosition","_locRadA","_locRadB","_locDir"];

// Save all the data into a public variable
missionNamespace setVariable ["firstPatrolLocationData", _firstPatrolLocData];

// Select ending Patrol base
private _endFOB = [(patrolOps_patrolBases - [_startFOB]), _locPosition] call BIS_fnc_nearestPosition;
missionNamespace setVariable ["endFOB", _endFOB];

// Show endFOB Marker
private _endFOBMarker = [patrolOps_patrolBases, _endFOB] call BIS_fnc_nearestPosition;
_endFOBMarker setMarkerAlpha 1;

_return = [_startFOB, _firstPatrolLocData, _endFOB];
_return;