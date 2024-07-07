/*
    Author: JD Wang

    Description:
        Adds Debug Marker to the screen
           

    Parameter(s):
        0: Marker name      <STRING>
        1: Type of Marker   <STRING> 
        2: Location         <POSITION> 
        3: Colour           <STRING> 
        4: Text             <STRING> 
        5: Marker Size      <NUMBER>

    Returns:
        Nothing

    Examples:
        [_prefix, _type, _location, _colour, _text, _size] call PatrolOps_fnc_debugMarkers;
*/

params ["_prefix", "_type", "_location", "_colour", "_text", "_size"]; // Declare function parameters.

// Check if debug mode is enabled.
if (PATROLOPS_DEBUG) then {

    // Create a local marker with a unique name based on its location.
    private _marker = createMarkerLocal [_prefix + str _location, _location];
    
    // Set marker type, color, text, and size.
    _marker setMarkerTypeLocal _type;
    _marker setMarkerColorLocal _colour;
    _marker setMarkerTextLocal _text;
    _marker setMarkerSizeLocal [_size, _size];
    _marker setMarkerAlpha 1;

    diag_log format ["%1 %2 %3 %4 %5 %6", _prefix, _type, _location, _colour, _text, _size];

};
