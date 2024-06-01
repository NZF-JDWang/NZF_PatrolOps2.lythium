/*
	Author: JD Wang

	Description:
		Resets the patrol 

	Parameter(s):
		NONE

	Returns:
		true

	Examples:
		[] call PatrolOps_fnc_patrolCleanUp;
*/
if (!isServer) exitwith {};
if (!secondPatrol) exitwith {true};

// Set all players back to default camouflageCoef (remove the bounty)
{_x setUnitTrait ["camouflageCoef", 1]} foreach allPlayers;

// Reset FOB's
missionNamespace setVariable ["startingFOB", nil, true];
missionNamespace setVariable ["endFOB", nil, true];

// Delete all route markers
if (count (missionNamespace getvariable "patrolOps_allRouteMarkers") > 0) then {

	{deleteMarker _x} foreach patrolOps_allRouteMarkers;
	missionnamespace setvariable ["patrolOps_allRouteMarkers", nil, true];
}; 

// Delete all Debug markers
private _debugMarkers = allMapMarkers select {_x find "debugMarker" >= 0};
{deleteMarker _x} foreach _debugMarkers;

// Delete and reset location markers 
missionnamespace setvariable ["firstPatrolLocationData", nil, true];
deleteMarker "firstLoc";

// Delete all player vehicles
{deletevehicle  _x} foreach patrolOps_playerInfantryVehicles;
{deletevehicle  _x} foreach patrolOps_playerEDOVehicles;
true;