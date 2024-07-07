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

//Delete all OPFOR 
{deletevehicle (vehicle _x)} foreach (units opfor);

// Delete misc Objects 
{deletevehicle  _x} foreach patrolOps_miscCleanUp;

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

patrolOps_playerEDOVehicles = [];
patrolOps_playerInfantryVehicles = [];
patrolOps_miscCleanUp = [];
patrolOps_Garrisons = [];
patrolOpsAll_Clutter = [];
patrolOpsAll_IEDs = [];

// Reset Mission Generation 
missionnamespace setvariable ["MissionClean", true];
missionnamespace setvariable ["routeSuccess", true];

