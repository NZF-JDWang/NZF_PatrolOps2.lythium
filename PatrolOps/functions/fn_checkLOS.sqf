/*
    Author: Grok 2

    Description:
        Checks if there is a clear line of sight between two positions.

    Parameters:
        0: POSITION - Starting position (ASL)
        1: POSITION - Ending position (ASL)
        2: OBJECT (optional, default: objNull) - The object from which the LOS is checked. Useful for considering the object's model.

    Returns:
        BOOL - True if there's a clear line of sight, false otherwise.

    Example:
        _hasLOS = [[0,0,10], [100,100,5]] call PatrolOps_fnc_checkLineOfSight;
*/


params [
	["_startPos", [], [[]]],
	["_endPos", [], [[]]]
];

// Ensure positions are in ASL format
if (_startPos isEqualType []) then {
	_startPos = ASLToAGL _startPos;
};
if (_endPos isEqualType []) then {
	_endPos = ASLToAGL _endPos;
};

// Check for line of sight
private _intersections = lineIntersectsSurfaces [_startPos, _endPos, objNull, objNull, true, 1, "GEOM", "NONE"];

// If there are no intersections, there's a clear line of sight
count _intersections == 0;
