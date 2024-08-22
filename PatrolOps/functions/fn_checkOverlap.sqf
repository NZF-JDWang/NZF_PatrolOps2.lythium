/*
    Author: JD Wang, Edited by Grok 2

    Description:
        Checks if a new position would overlap with any existing positions based on the given size.

    Parameters:
        0: _pos <ARRAY> - The position to check for overlap.
        1: _size <NUMBER> - The size (radius) of the object to be placed.
        2: _existingPositions <ARRAY> - An array of existing positions to check against.

    Returns:
        BOOLEAN - True if no overlap detected, False otherwise.

    Examples:
        _result = [[100,100,0], 5, [[101,101,0],[99,99,0]]] call PatrolOps_fnc_checkOverlap;
        // _result would be false due to overlap
*/

// Function to check if a new position would overlap with existing positions
PatrolOps_fnc_checkOverlap = {
    params ["_pos", "_size", "_existingPositions"];
    
    // Assume no overlap by default
    private _overlap = false;
    
    // Iterate through each existing position
    {
        // Check if the distance between the new position and an existing position is less than the object size
        if (_pos distance2D _x < _size) exitWith {
            // If overlap detected, set flag to true and exit loop
            _overlap = true;
        };
    } forEach _existingPositions;
    
    // Return the opposite of _overlap to indicate if the position is valid (no overlap)
    !_overlap
};