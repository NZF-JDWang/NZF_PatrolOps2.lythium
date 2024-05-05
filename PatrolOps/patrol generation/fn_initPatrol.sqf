/*
	Author: JD Wang

	Description:
		Initializes the patrol 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] spawn PatrolOps_fnc_initPatrol;
*/
if (!isServer) exitWith {};

// Clean up and previous patrols 

private _cleanUp = [] call PatrolOps_fnc_patrolCleanUp;
waitUntil {sleep 0.1; _cleanUp};

// Get the patrol locations
private _routeData = [] call PatrolOps_fnc_generateLocations;
// Wait for locations to be generated 
waitUntil {sleep 0.1; !isNil "endFOB"};

_routeData params ["_startFOB","_firstPatrolLocData","_endFOB"];
_firstPatrolLocData params ["_locName","_locPosition","_locRadA","_locRadB","_locDir"];

// Place a marker on the Objective town
private _firstLocMarker = createMarkerLocal ["firstLoc", _locPosition];
_firstLocMarker setMarkerTypeLocal "selector_selectedMission";
_firstLocMarker setMarkerColorLocal "ColorRed";
_firstLocMarker setMarkerSizeLocal [1.5, 1.5]; 
_firstLocMarker setMarkerAlpha 1;

// Grab the nearest roads
_startFobRoad = [getMarkerPos _startFOB, 1000] call BIS_fnc_nearestRoad;
_firstObjectiveRoad = [_locPosition, 1000] call BIS_fnc_nearestRoad;
_endFobRoad = [getMarkerPos _endFOB, 1000] call BIS_fnc_nearestRoad;

// Wait for road retrieval
sleep 2;

// Spawn markers for the out-route and in-route
_outRoute = ["ColorGreen", getPos _startFobRoad, getPos _firstObjectiveRoad, "outRoute"] spawn PatrolOps_fnc_generateRouteMarkers;
waitUntil {scriptDone _outRoute};

_inRoute = ["ColorRed", getPos _firstObjectiveRoad, getPos _endFobRoad, "inRoute"] spawn PatrolOps_fnc_generateRouteMarkers;
waitUntil {scriptDone _inRoute};

// Make all the markers visible
[
    {
        private _patrolMarkers = allMapMarkers select {_x find "routeMarker" >= 0};
        missionNamespace setVariable ["patrolOps_allRouteMarkers", _patrolMarkers, true];
        {_x setMarkerAlpha 1} forEach patrolOps_allRouteMarkers;
    }, 
    [], 
    2
] call CBA_fnc_waitAndExecute;

// find any locations the patrol route passes by 
[
    {
       [] call PatrolOps_fnc_findSideLocations;
    }, 
    [], 
    2
] call CBA_fnc_waitAndExecute;

//save some data 
missionnamespace setvariable ["secondPatrol", true, true];