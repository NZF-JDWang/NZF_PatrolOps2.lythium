/*
    Author: JD Wang

    Description:
        Adds Debug Marker to the screen
           

    Parameter(s):
        0: Type of Marker   <STRING> 
        1: Location         <POSITION> 
        2: Colour           <STRING> 
        3: Text             <STRING> 
        4: Marker Size      <NUMBER>

    Returns:
        Nothing

    Examples:
        [_type, _location, _colour, _text, _size] spawn PatrolOps_fnc_debugMarkers;
*/

params ["_type", "_location", "_colour", "_text", "_size"]; // Declare function parameters.

// Check if debug mode is enabled.
if (PATROLOPS_DEBUG) then {

    // Create a local marker with a unique name based on its location.
    private _marker = createMarkerLocal ["debugMarker" + str _location, _location];
    
    // Set marker type, color, text, and size.
    _marker setMarkerTypeLocal _type;
    _marker setMarkerColorLocal _colour;
    _marker setMarkerTextLocal _text;
    _marker setMarkerSizeLocal [_size, _size];
    _marker setMarkerAlpha 1;

};
