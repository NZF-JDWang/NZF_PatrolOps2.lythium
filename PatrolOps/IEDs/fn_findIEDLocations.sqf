/*
	Author: JD Wang

	Description:
		Randomly selects potential IED locations along the route 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] spawn PatrolOps_fnc_findIEDLocations;
*/
private _numberOfLocations = 15;
/*
// Get patrol IED level 
private _patrolDifficulty = missionNamespace getvariable "patrolDifficulty";

switch (_patrolDifficulty) do {

	case "LOW": {_numberOfIEDs = random [3,4,5]};

	case "MEDIUM": {_numberOfIEDs = random [4,6,7]};

	case "HIGH": {_numberOfIEDs = random [6,8,10]};
};
*/

// Get the outRoute markers and delete the first and last few to avoid IED at base and on target
// Then do the same for the inRoute
private _outRoute = allMapMarkers select {_x find "outRoute" >= 0};
private _inRoute = allMapMarkers select {_x find "inRoute" >= 0};
/*
_outRoute deleterange [0, 75];
_inRoute deleterange [0, 25];

private _lower = (count _outRoute) -10; 
_outRoute deleterange [_lower,10];

private _lower = (count _inRoute) -25; 
_inRoute deleterange [_lower,25];
*/
// Select random locations along the outRoute 
private _spacing = ((count _outRoute)/_numberOfLocations);
private _min = round (_spacing * 0.8);
private _max = round (_spacing * 1.2);

for "_i" from 1 to (_numberOfLocations -1) do {

	_variation = random [_min, _spacing, _max];
	_selection = _outRoute select (_i * _variation);

    _marker = createMarkerLocal ["debugMarkerContact" + str (getMarkerPos _selection), getMarkerPos _selection];
	_marker setMarkerTypeLocal "loc_destroy";
	_marker setMarkerColorLocal "colorWhite";
	_marker setMarkerSize [1, 1]; 
};

// Select random locations along the inRoute 
private _spacing = ((count _inRoute)/_numberOfLocations);
private _min = round (_spacing * 0.8);
private _max = round (_spacing * 1.2);

for "_i" from 1 to (_numberOfLocations -1) do {

	_variation = random [_min, _spacing, _max];
	_selection = _inRoute select (_i * _variation);

    _marker = createMarkerLocal ["debugMarkerContact" + str (getMarkerPos _selection), getMarkerPos _selection];
	_marker setMarkerTypeLocal "loc_destroy";
	_marker setMarkerColorLocal "colorBlack";
	_marker setMarkerSize [1, 1]; 
};