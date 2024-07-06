/*
	Author: JD Wang

	Description:
		Generates the Objective Marker

	Parameter(s):
		
		0: Marker Type <STRING>
		1: Marker Location <ARRAY>

	Returns:
		Nothing

	Examples:
		[_markerType, _markerlocation] call PatrolOps_fnc_createObjectiveMarker;
*/

params ["_markerType", "_location"];

_marker = createMarkerLocal [("Objective" + str _location), _location];
_marker setMarkerTypeLocal _markerType;
_marker setMarkerColorLocal "ColorBlack";
_marker setMarkerSize [1.5, 1.5];

