/*
	Author: JD Wang

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

// Get the outRoute markers and delete the first and last few to avoid IED at base and on target
// Then do the same for the inRoute
private _outRoute = allMapMarkers select {_x find "outRoute" >= 0};
private _inRoute = allMapMarkers select {_x find "inRoute" >= 0};

//Delete markers close to FOBs
_outRoute deleterange [0, 50];
private _lower = (count _inRoute) -50;
_inRoute deleterange [_lower,50];


// Select random locations along the outRoute 
private _spacing = ((count _outRoute)/_numberOfLocations);
private _min = round (_spacing * 0.8);
private _max = round (_spacing * 1.2);

for "_i" from 1 to (_numberOfLocations -1) do {

	_variation = round (random [_min, _spacing, _max]);
	_selection = _outRoute select (_i * _variation);

    _marker = createMarkerLocal ["debugPotentialIED_out" + str (getMarkerPos _selection), getMarkerPos _selection];
	_marker setMarkerTypeLocal "loc_destroy";
	_marker setMarkerColorLocal "colorWhite";
	_marker setMarkerSize [1, 1]; 
};

// Select random locations along the inRoute 
private _spacingIn = ((count _inRoute)/_numberOfLocations);
private _min = round (_spacingIn * 0.7);
private _max = round (_spacingIn * 1.2);

for "_i" from 1 to (_numberOfLocations -1) do {

	_variation = round (random [_min, _spacingIn, _max]);
	_selection = _inRoute select (_i * _variation);

    _marker = createMarkerLocal ["debugPotentialIED_in" + str (getMarkerPos _selection), getMarkerPos _selection];
	_marker setMarkerTypeLocal "loc_destroy";
	_marker setMarkerColorLocal "colorWhite";
	_marker setMarkerSize [1, 1]; 
};