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

for "_i" from 1 to _numberOfLocations do {
    private _variation = round (random [_min, _spacing, _max]);
    if (_i * _variation >= count _outRoute) then {
        _variation = (count _outRoute - 1) / _i; // Ensure last valid index
    };
    private _selectionMarker = _outRoute select floor _variation;
    private _selection = [getMarkerPos _selectionMarker, 100] call BIS_fnc_nearestRoad;

    private _marker = createMarkerLocal ["debugPotentialIED_out" + str _selection, _selection];
    _marker setMarkerTypeLocal "loc_destroy";
    _marker setMarkerColorLocal "colorWhite";
    if (PATROLOPS_DEBUG) then {
        _marker setMarkerAlphaLocal 0;
    } else {
        _marker setMarkerAlphaLocal 1;
    };
    _marker setMarkerSize [1, 1]; 
};

// Select random locations along the inRoute 
private _spacingIn = ((count _inRoute) / _numberOfLocations);
private _minIn = round (_spacingIn * 0.7);
private _maxIn = round (_spacingIn * 1.2);

for "_i" from 1 to _numberOfLocations do {
    private _variation = round (random [_minIn, _spacingIn, _maxIn]);
    if (_i * _variation >= count _inRoute) then {
        _variation = (count _inRoute - 1) / _i; // Ensure last valid index
    };
    private _selectionMarker = _inRoute select floor _variation;
    private _selection = [getMarkerPos _selectionMarker, 100] call BIS_fnc_nearestRoad;

    private _marker = createMarkerLocal ["debugPotentialIED_in" + str _selection, _selection];
    _marker setMarkerTypeLocal "loc_destroy";
    _marker setMarkerColorLocal "colorWhite";
    if (PATROLOPS_DEBUG) then {
        _marker setMarkerAlphaLocal 0;
    } else {
        _marker setMarkerAlphaLocal 1;
    };
    _marker setMarkerSize [1, 1]; 
};