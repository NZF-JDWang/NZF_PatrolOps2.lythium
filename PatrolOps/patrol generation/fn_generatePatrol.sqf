/*
	Author: JD Wang

	Description:
		Initializes the patrol 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] spawn PatrolOps_fnc_generatePatrol;
*/
if (!isServer) exitWith {};
missionnamespace setvariable ["MissionClean", false];
// Count players 
private _playerTotal = count (allPlayers - entities "HeadlessClient_F");

// Select a random difficulty for the patrol (LOW/MEDIUM/HARD)
[] spawn PatrolOps_fnc_randomDifficulty;

//Set mission time 
[] call PatrolOps_fnc_setMissionTime;

// Get the patrol locations
private _routeData = [] call PatrolOps_fnc_generateLocations;
// Wait for locations to be generated 
waitUntil {sleep 0.1; !isNil "endFOB"};

_routeData params ["_startFOB","_firstPatrolLocData","_endFOB"];
_firstPatrolLocData params ["_locPosition","_locRadA","_locRadB","_locDir"];
_locName = missionnamespace getVariable "firstPatrolLocationName";

// Place a marker on the Objective town
private _firstLocMarker = createMarkerLocal ["firstLoc", _locPosition];
_firstLocMarker setMarkerTypeLocal "selector_selectedMission";
_firstLocMarker setMarkerColorLocal "ColorRed";
_firstLocMarker setMarkerSizeLocal [1.5, 1.5]; 
_firstLocMarker setMarkerAlpha 1;

// Grab the nearest roads
private _startFobRoad = [getMarkerPos _startFOB, 1000] call BIS_fnc_nearestRoad;
private _firstObjectiveRoad = [_locPosition, 1000] call BIS_fnc_nearestRoad;
private _endFobRoad = [getMarkerPos _endFOB, 1000] call BIS_fnc_nearestRoad;

// Wait for road retrieval
sleep 2;

// Spawn markers for the out-route and in-route
private _outRoute = ["ColorGreen", getPos _startFobRoad, getPos _firstObjectiveRoad, "outRoute"] spawn PatrolOps_fnc_generateRouteMarkers;
waitUntil {count (allMapMarkers select {_x find "outRoute" >= 0}) > 50};
sleep 1;
private _inRoute = ["ColorRed", getPos _firstObjectiveRoad, getPos _endFobRoad, "inRoute"] spawn PatrolOps_fnc_generateRouteMarkers;
waitUntil {count (allMapMarkers select {_x find "inRoute" >= 0}) > 50};
sleep 1;

// Rerun if the route is bad?
private _routeCheck = [] call PatrolOps_fnc_routeCheck;

if (_routeCheck) then {

    // Move all the players to the correct FOB 
    [] call PatrolOps_fnc_movePlayers;
    // Make all the route markers visible

    private _patrolMarkers = allMapMarkers select {_x find "routeMarker" >= 0};
    missionNamespace setVariable ["patrolOps_allRouteMarkers", _patrolMarkers, true];
    {_x setMarkerAlpha 1} forEach patrolOps_allRouteMarkers;

    // Find any locations the patrol route passes by 
    [
        {
        [] spawn PatrolOps_fnc_findSideLocations;
        }, 
        [], 
        3
    ] call CBA_fnc_waitAndExecute;
  

    // Spawn player vehicles
    [_playerTotal] call PatrolOps_fnc_playerVehicleSpawn;

    // Generate Objective
    [] call PatrolOps_fnc_generateObjective;

    // Generate potential POI locations to spawn IED's and clutter then spawn them
    [
        {
        [] call PatrolOps_fnc_findPOILocations;
        }, 
        [], 
        1
    ] call CBA_fnc_waitAndExecute;

        [
        {
        [] call PatrolOps_fnc_selectIEDs;
        }, 
        [], 
        2
    ] call CBA_fnc_waitAndExecute;
   

    missionNamespace setVariable ["regen", 0];
    // Fade back in 
    [1, "BLACK", 3, 1] remoteExec ["BIS_fnc_fadeEffect"];

    // Drop some information into the logs for debug purpose
    diag_log "*******************************************************************************";
    diag_log "[NZF PATROL OPS] - Patrol Route Created";
    diag_log format ["Leaving from %1, heading to %2, and then on to %3", _startFOB, _locName, _endFOB];
    diag_log "*******************************************************************************";

};


  






