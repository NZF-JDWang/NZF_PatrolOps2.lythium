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

// Set all players back to default camouflageCoef (remove the bounty)
{_x setUnitTrait ["camouflageCoef", 1]} foreach allPlayers;

// Delete all mission markers
private _allMissionMarkers = allMapMarkers - patrolOps_patrolBases;
{deleteMarker _x} foreach _allMissionMarkers;

// Delete all player vehicles
{deletevehicle  _x} foreach patrolOps_playerInfantryVehicles;
{deletevehicle  _x} foreach patrolOps_playerEDOVehicles;

// Delete all OPFOR units and their vehicles
{
    if (side _x == EAST) then { 
        deleteVehicle (vehicle _x); 
    };
} forEach allUnits;

// Delete misc Objects and IED's
{deletevehicle  _x} foreach patrolOps_miscCleanUp;
{deletevehicle  _x} foreach patrolOps_allClutter;
{deletevehicle  _x} foreach patrolOps_allIEDs;

// Reset number of kills 
missionnamespace setvariable ["patrolOps_EnemyKills", 0, true];

// Reset all global variables 
missionNamespace setvariable ["patrolDifficulty", "MEDIUM", true];
missionnamespace setvariable ["firstPatrolLocationData", nil, true];
missionNamespace setVariable ["startingFOB", nil, true];
missionNamespace setVariable ["endFOB", nil, true];
missionnamespace setVariable ["RDFOpen", false, true];
missionnamespace setvariable ["patrolOps_NZFCasualties", 0, true];
missionnamespace setvariable ["patrolOps_allRouteMarkers", nil, true];
missionnamespace setvariable ["patrolLength", nil, true];

// Clear arrays
missionNamespace setVariable ["patrolOps_playerEDOVehicles", [], true];
missionNamespace setVariable ["patrolOps_playerInfantryVehicles", [], true];
missionNamespace setVariable ["patrolOps_miscCleanUp", [], true];
missionNamespace setVariable ["patrolOps_Garrisons", [], true];
missionNamespace setVariable ["patrolOps_allClutter", [], true];
missionNamespace setVariable ["patrolOps_allIEDs", [], true];
missionNamespace setVariable ["patrolOps_IEDHelpers", [], true];
missionNamespace setVariable ["patrolOps_allTriggers", [], true];

// Reset Mission Generation 
missionnamespace setvariable ["MissionClean", true];
missionnamespace setvariable ["routeSuccess", true];

