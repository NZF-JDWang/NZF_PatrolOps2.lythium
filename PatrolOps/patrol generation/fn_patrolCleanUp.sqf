/*
	Author: JD Wang

	Description:
		Resets the patrol 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_patrolCleanUp;
*/
// Set all players back to default camouflageCoef (remove the bounty)
{_x setUnitTrait ["camouflageCoef", 1]} foreach allPlayers;

// Hide all patrolbase markers and reset FOB's
{_x setMarkerAlpha 0} foreach patrolOps_patrolBases;
missionNamespace setVariable ["startingFOB", nil, true];
missionNamespace setVariable ["endFOB", nil, true];

// Delete all route markers
if (count (missionNamespace getvariable "patrolOps_allRouteMarkers") > 0) then {

	{deleteMarker _x} foreach patrolOps_allRouteMarkers;
	missionnamespace setvariable ["patrolOps_allRouteMarkers", nil, true];
}; 


// Delete and reset location markers 
missionnamespace setvariable ["firstPatrolLocationData", nil, true];
deleteMarker "firstLoc";



true;