/*
    Author: JD Wang, Modified by Grok 2

    Description:
        Randomly selects potential IED locations along the route 

    Parameter(s):
        NONE

    Returns:
        Nothing

    Examples:
        [] call PatrolOps_fnc_findPOILocations;
*/
private _numberOfLocations = 15;
if (_numberOfLocations <= 0) exitWith {
    if (PATROLOPS_DEBUG) then {
        systemChat "Error: Number of locations must be greater than 0.";
    };
};

private ["_marker"];
// Get the outRoute markers and delete the first and last few to avoid IED at base and on target
// Then do the same for the inRoute
private _outRoute = allMapMarkers select {_x find "outRoute" >= 0};
private _inRoute = allMapMarkers select {_x find "inRoute" >= 0};

// Delete markers at the start and end of both routes
_outRoute deleteRange [0, 50];  // Delete first 50 markers
_outRoute deleteRange [count _outRoute - 75, 75];  // Delete last 75 markers

_inRoute deleteRange [0, 50];  // Delete first 50 markers
_inRoute deleteRange [count _inRoute - 75, 75];  // Delete last 75 markers

// Select random locations along the outRoute 
private _spacing = ((count _outRoute) / _numberOfLocations);
private _min = round (_spacing * 0.8);
private _max = round (_spacing * 1.2);

for "_i" from 1 to (_numberOfLocations - 1) do {
    _variation = round (random [_min, _spacing, _max]);
    if (_i * _variation < count _outRoute) then {
        _selectionMarker = _outRoute select (_i * _variation);
        _selection = [getMarkerPos _selectionMarker, 100] call BIS_fnc_nearestRoad;

        _marker = createMarkerLocal ["debugPotentialIED_out" + str _selection, _selection];
        _marker setMarkerTypeLocal "loc_destroy";
        _marker setMarkerColorLocal "colorWhite";
        if (PATROLOPS_DEBUG) then {_marker setMarkerAlphaLocal 0} else {_marker setMarkerAlphaLocal 1};
        _marker setMarkerSize [1, 1]; 
    } else {
        if (PATROLOPS_DEBUG) then {
            systemChat format ["Warning: Out of bounds for outRoute at index %1", _i];
        };
    };
};

// Select random locations along the inRoute 
private _spacingIn = ((count _inRoute) / _numberOfLocations);
private _min = round (_spacingIn * 0.7);
private _max = round (_spacingIn * 1.2);

for "_i" from 1 to (_numberOfLocations - 1) do {
    _variation = round (random [_min, _spacingIn, _max]);
    if (_i * _variation < count _inRoute) then {
        _selectionMarker = _inRoute select (_i * _variation);
        _selection = [getMarkerPos _selectionMarker, 100] call BIS_fnc_nearestRoad;

        _marker = createMarkerLocal ["debugPotentialIED_in" + str _selection, _selection];
        _marker setMarkerTypeLocal "loc_destroy";
        _marker setMarkerColorLocal "colorWhite";
        if (PATROLOPS_DEBUG) then {_marker setMarkerAlphaLocal 0} else {_marker setMarkerAlphaLocal 1};
        _marker setMarkerSize [1, 1]; 
    } else {
        if (PATROLOPS_DEBUG) then {
            systemChat format ["Warning: Out of bounds for inRoute at index %1", _i];
        };
    };
};