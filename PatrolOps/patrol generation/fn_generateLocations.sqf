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

//Get world size

private _axis = worldSize/2;
private _center = [_axis, _axis , 0];
private _radius = sqrt (_axis^2 + _axis^2);

//Select starting Patrol base 
private _startFOB = selectrandom patrolOps_patrolBases;
missionNamespace setvariable ["startingFOB", _startFOB];

//Find the first patrol location
private _firstPatrolLoc = selectrandom (nearestLocations [getmarkerPos _startFOB, ["NameVillage","NameCity","NameCityCapital"], _radius]);
//Note Location radius is * 0.75 to encourage positions to not be right on the edge of the AO
private _firstPatrolLocData = [(text _firstPatrolLoc),locationPosition _firstPatrolLoc, (size _firstPatrolLoc select 0)* 0.75, (size _firstPatrolLoc select 1)* 0.75, direction _firstPatrolLoc];
_firstPatrolLocData params ["_locName","_locPosition","_locRadA","_locRadB","_locDir"];
//Save all the data into a public variable 
missionnamespace setvariable ["firstPatrolLocationData", _firstPatrolLocData];

//Select ending Patrol base
private _endFOB = [(patrolOps_patrolBases - [_startFOB]), _locPosition] call BIS_fnc_nearestPosition;
missionNamespace setvariable ["endFOB", _endFOB];

_return = [_startFOB,_firstPatrolLocData,_endFOB];
_return;