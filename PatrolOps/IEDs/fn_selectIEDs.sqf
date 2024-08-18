/*
	Author: JD Wang

	Description:
		Randomly selects potential IED locations along the route 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_selectIEDs;
*/

// Get patrol IED level 
private ["_numberOfOutIEDs", "_numberOfInIEDs"];

// Setup all possible locations into 2 arrays 
private _locationsOut = allMapMarkers select {_x find "debugPotentialIED_out" >= 0};
private _locationsIn = allMapMarkers select {_x find "debugPotentialIED_in" >= 0};

_numberOfOutIEDs = [] call PatrolOps_fnc_getNumberOfIEDs;
_numberOfInIEDs = [] call PatrolOps_fnc_getNumberOfIEDs;

[_locationsOut, _numberOfOutIEDs] call PatrolOps_fnc_processIEDLocations;
[_locationsIn, _numberOfInIEDs] call PatrolOps_fnc_processIEDLocations; 

