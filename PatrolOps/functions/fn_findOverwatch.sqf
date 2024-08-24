/*
* Author: jokoho482, Modified by Grok 2
* Returns Overwatch Positions with line of sight check using lineIntersects
*
* Warning:
* It is possible that this function does not generate any positions and Returns [0,0,0]!
*
* Arguments:
* 0: Target Position <ARRAY>
* 1: Maximum distance from Target in meters <NUMBER>
* 2: Minimum distance from Target in meters <NUMBER>
* 3: Minimum height in relation to Target in meters <NUMBER>
* 4: Position to start looking from <ARRAY>
*
* Return Value:
* Position of a Possible Overwatch Position or [0,0,0] if none found
*
* Example:
* [getPos bob, 10, 50, 8, getPos jonny] call PatrolOps_fnc_findOverwatch;
*
* Public: Yes
*/

params [
    ["_targetPos", [0, 0, 0], [[]]],
    ["_maxRange", 400, [0]],
    ["_minRange", 20, [0]],
    ["_minHeight", 4, [0]],
    ["_centerPos", [0,0,0], [[]]]
];

private _refObj = nearestObject [_targetPos, "All"];
private _result = [0,0,0];
private _selectedPositions = [];

private _fnc_selectResult = {
    // Found position(s)
    private _heightSorted = _selectedPositions apply {[(_refObj worldToModel _x) select 2, _x]};
    _heightSorted sort false;
    _result = (_heightSorted param [0]) param [1, _centerPos];
    _result breakOut "PatrolOps_findOverwatch";
};

for "_i" from 0 to 300 do {
    private _checkPos = [_centerPos, 0, _maxRange, 3, 0, 50, 0, [], []] call BIS_fnc_findSafePos;
    private _height = (_refObj worldToModel _checkPos) select 2;
    private _dis = _checkPos distance _targetPos;

    // Check for line of sight using lineIntersects
    private _hasLOS = lineIntersects [_checkPos, _targetPos, objNull, objNull, true, 1];

    if (_dis > _minRange) then {
        if (_result isEqualTo [0,0,0] && !_hasLOS) then {
            _result = _checkPos;
        };

        if (_height > _minHeight && !_hasLOS) then {
            _selectedPositions pushBack _checkPos;
        };
    };

    if (count _selectedPositions >= 5) then {
        call _fnc_selectResult;
    };
};

if (_selectedPositions isNotEqualTo []) then {
    call _fnc_selectResult;
};

_result