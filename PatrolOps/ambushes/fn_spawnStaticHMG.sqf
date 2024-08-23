/*
    Author: JD Wang (Reviewed)

    Description:
        Attempts to find an overwatch location for a static weapon near a given location. 
        If an overwatch position isn't found or is unsafe, it sets up a roadblock instead.

    Parameters:
        _location - The initial location around which to search for an overwatch position.

    Returns:
        NONE

    Examples:
        [_location] call PatrolOps_fnc_spawnStaticHMG;
*/

params ["_location"];
private ["_overwatchLocation", "_noSafePos", "_staticLocation", "_hasLOS"];

// Initialize variables
_noSafePos = false;
_staticLocation = [];

// Select a random static weapon type
private _weapon = selectRandom parseSimpleArray patrolOps_directStatics;

// Find the nearest road within 500 meters
private _nearestRoad = [_location, 500] call BIS_fnc_nearestRoad;

// Attempt to find an overwatch location
_overwatchLocation = [getpos _nearestRoad, 400, 25, 15, _location] call lambs_main_fnc_findOverwatch;

if (count _overwatchLocation > 0) then {
    // Check if a safe position exists near the overwatch location
    private _safePos = [_overwatchLocation, 0, 20, 1, 0, 0.25] call BIS_fnc_findSafePos;
    
    if (_safePos isEqualTo [0,0,0]) then {
        _noSafePos = true;
        "No safe position found for initial overwatch location." call BIS_fnc_error;
    } else {
        
        if ([_safePos, getpos _nearestRoad] call PatrolOps_fnc_checkLineOfSight) then {

        _staticLocation = _safePos;
        format ["Initial safe overwatch position found at: %1", _safePos] call BIS_fnc_log;

        }; 
    };
};

if (count _overwatchLocation < 1 || _noSafePos) then {
    // If no overwatch or safe position was found, try again with less strict parameters
    _overwatchLocation = [_nearestRoad, 400, 25, 8, _location] call lambs_main_fnc_findOverwatch;
    private _safePos = [_overwatchLocation, 0, 20, 1, 0, 0.25] call BIS_fnc_findSafePos;
    if (_safePos isEqualTo [0,0,0]) then {
        _noSafePos = true;
        "No safe position found for secondary overwatch location." call BIS_fnc_error;
    } else {
        if ([_safePos, getpos _nearestRoad] call PatrolOps_fnc_checkLineOfSight) then {

        _staticLocation = _safePos;
        format ["Initial safe overwatch position found at: %1", _safePos] call BIS_fnc_log;

        };
    };

    // If still no safe position, set up a roadblock
    if (_noSafePos) then {
        [_nearestRoad] call PatrolOps_fnc_roadblock;
        "Roadblock set up due to no safe overwatch position found." call BIS_fnc_log;
    };
};

// Log or debug message for successful overwatch position
if (!_noSafePos) then {
    format ["Final overwatch position: %1", _staticLocation] call BIS_fnc_log;
};

["static", "loc_Attack", _staticLocation, "ColorRED", "STATIC", 0.5] call PatrolOps_fnc_debugMarkers;

// Now spawn the gunpit
private _pit = createvehicle ["Land_ShellCrater_02_small_F", _staticLocation, [] , 0, "NONE"];
private _dir = _pit getDir _nearestRoad;
_pit setVectorUp surfaceNormal _staticLocation;
_pit setdir _dir + 235;
_pit setPos [getPosATL _pit select 0, getPosATL _pit select 1, (getPosATL _pit select 2) -0.5];
patrolOps_miscCleanUp pushback _pit;

// Spawn the gun 
private _static = createvehicle [_weapon, _pit getRelPos [0.5, 320] , [] , 0, "CAN_COLLIDE"];
_static setdir _dir;
_static setVectorUp surfaceNormal _staticLocation;

// Spawn the gunner 
_staticGunner = createGroup east;
[1, _staticGunner, _staticLocation] call PatrolOps_fnc_createInsurgentSquad;
(leader _staticGunner) assignAsGunner _static;
(leader _staticGunner) moveInGunner _static;
(leader _staticGunner) setVariable ["lambs_danger_dangerRadio", true];