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
private ["_firstPatrolLoc"];

// Select starting Patrol base
if (secondPatrol) then {

	private _start = selectRandom patrolOps_patrolBases;
	missionNamespace setVariable ["startingFOB", _start, true];

};

private _startFOB = missionNamespace getVariable "startingFOB";
// Find the first patrol location
// First get a list of options that are further than 1000m from the FOB
private _firstPatrolLocShort = nearestLocations [getMarkerPos _startFOB, ["NameVillage", "NameCity", "NameCityCapital"], 2000];
private _firstPatrolLocLong = nearestLocations [getMarkerPos _startFOB, ["NameVillage", "NameCity", "NameCityCapital"], _radius / 2];
private _firstPatrolOptions = _firstPatrolLocLong - _firstPatrolLocShort;
//If there's no options then just grab any location
if (count _firstPatrolOptions < 1) then {

	_firstPatrolLoc = selectRandom (nearestLocations [getMarkerPos _startFOB, ["NameVillage", "NameCity", "NameCityCapital"], _radius / 2]);

} else {

	_firstPatrolLoc = selectrandom _firstPatrolOptions;

};

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
missionNamespace setVariable ["firstPatrolLocationData", _firstPatrolLocData, true];

// Select ending Patrol base
private _nearestfobMarker = [allMapMarkers, _locPosition] call BIS_fnc_nearestPosition;
private _endFOB = [(patrolOps_patrolBases - [_startFOB,_nearestfobMarker]), _locPosition] call BIS_fnc_nearestPosition;
missionNamespace setVariable ["endFOB", _endFOB, true];

_return = [_startFOB, _firstPatrolLocData, _endFOB];
_return;