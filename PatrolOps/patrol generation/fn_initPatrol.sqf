/*
	Author: JD Wang

	Description:
		Initializes the patrol 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_initPatrol;
*/
private _routeData = [] call PatrolOps_fnc_generateLocations;
_routeData params ["_startFOB","_firstPatrolLocData","_endFOB"];
_firstPatrolLocData params ["_locName","_locPosition","_locRadA","_locRadB","_locDir"];

["colourGREEN","_startFOB","_locPosition"] call PatrolOps_fnc_generatePatrolRoute;

["colourRED","_locPosition","_endFOB"] call PatrolOps_fnc_generatePatrolRoute;

{_x setMarkerAlpha 1 } foreach patrolOps_allRouteMarkers;