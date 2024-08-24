/*
    Author: JD Wang

    Description:
        Adds Debug Marker to the screen, checking for positional overlap and adjusting position if necessary.
           

    Parameter(s):
        0: Marker name      <STRING>
        1: Type of Marker   <STRING> 
        2: Location         <ARRAY> 
        3: Colour           <STRING> 
        4: Text             <STRING> 
        5: Marker Size      <NUMBER>

    Returns:
        Nothing

    Examples:
        [_prefix, _type, _location, _colour, _text, _size] call PatrolOps_fnc_debugMarkers;
*/

params [
    ["_prefix", "", [""]],
    ["_type", "", [""]],
    ["_location", [0,0,0], [[]]],
    ["_colour", "", [""]],
    ["_text", "", [""]],
    ["_size", 1, [0]]
];


private _offset = 0;
private _markerExists = true;
private _markerName = _prefix + str _location;

// Check if there's an existing marker at the same location
while {_markerExists} do {
    private _existingMarkers = allMapMarkers select {
        (getMarkerPos _x distance2D _location) < (_size * 2) // Assuming markers are circular
    };

    if (_existingMarkers isNotEqualTo []) then {
        // If markers exist within the proximity, increment the offset
        _offset = _offset + 0.5;
        _location = _location vectorAdd [0, -_offset, 0]; // Adjust location for next check
    } else {
        _markerExists = false;
    };
};

// Create a local marker with a unique name based on its location.
private _marker = createMarkerLocal [_markerName, _location];

// Set marker type, color, text, and size.
_marker setMarkerTypeLocal _type;
_marker setMarkerColorLocal _colour;
_marker setMarkerTextLocal _text;
_marker setMarkerSizeLocal [_size, _size];

// Check if debug mode is enabled.
if (PATROLOPS_DEBUG) then {

    _marker setMarkerAlpha 1;

} else {

    _marker setMarkerAlpha 0;
    
};    

// Log marker details for debugging
diag_log format ["%1 %2 %3 %4 %5 Offset: %6", _prefix, _type, _location, _colour, _text, _offset];

