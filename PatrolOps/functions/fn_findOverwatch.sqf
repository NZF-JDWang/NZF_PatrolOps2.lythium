/*
    Author: JD Wang 

    Description:
        Searches for an overwatch position for an object near a specified location. 
        This function makes two attempts to find a suitable position:
        - First attempt with a higher maximum gradient (15 degrees).
        - Second attempt with a reduced maximum gradient (5 degrees) if the first fails.
        Each attempt checks for a safe position and line of sight from the object to the target location.

    Parameters:
        _location - ARRAY - The target location around which to search for an overwatch position.
        _object - OBJECT - The object from which the overwatch is being sought.

    Returns:
        ARRAY - The coordinates of the overwatch location if found, otherwise it returns [0,0,0].

    Examples:
        _overwatchPos = [_targetLocation, player] call PatrolOps_fnc_findOverwatch;

    Notes:
        - The function uses `lambs_main_fnc_findOverwatch` for finding potential overwatch positions.
        - Safe positions are checked using `BIS_fnc_findSafePos`.
        - Line of sight is verified using `PatrolOps_fnc_checkLineOfSight`.
        - If no overwatch position meets the criteria, [0,0,0] is returned.
*/

params ["_location", "_object"];
private ["_noSafePos", "_hasLOS", "_return", "_firstCheckAttempt", "_secondCheckAttempt"];

_return = [0,0,0];
_noSafePos = false;  // Initialize _noSafePos
_hasLOS = false;     // Initialize _hasLOS

// First attempt
_firstCheckAttempt = [getpos _object, 400, 25, 15, _location] call lambs_main_fnc_findOverwatch;
if (count _firstCheckAttempt > 0) then {

	private _safePos = [_firstCheckAttempt, 0, 20, 1, 0, 0.25] call BIS_fnc_findSafePos;
	if (_safePos isEqualTo [0,0,0]) then {
			_noSafePos = true;
	} else {
			_hasLOS = [getpos _object, _location] call PatrolOps_fnc_checkLineOfSight;
	};

};

if (_hasLOS && !_noSafePos) then {

	_return = _firstCheckAttempt;

};
// Second attempt reduce the height
if (count _firstCheckAttempt < 1) then {

	_secondCheckAttempt = [getpos _object, 400, 25, 5, _location] call lambs_main_fnc_findOverwatch;
	if (count _secondCheckAttempt > 0) then {

		private _safePos = [_secondCheckAttempt, 0, 20, 1, 0, 0.25] call BIS_fnc_findSafePos;
		if (_safePos isEqualTo [0,0,0]) then {
				_noSafePos = true;
		} else {
				_hasLOS = [getpos _object, _location] call PatrolOps_fnc_checkLineOfSight;
		};

	};
	if (_hasLOS && !_noSafePos) then {

	_return = _secondCheckAttempt;

	};

};

_return;