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
private ["_overwatchLocation", "_nearestRoad"];

private _nearestRoad = [(missionnamespace getvariable "patrolOps_allRouteMarkers"), _location] call BIS_fnc_nearestPosition;
private _target = getMarkerpos _nearestRoad;
// Select a random static weapon type
private _weapon = selectRandom parseSimpleArray patrolOps_directStatics;

// Attempt to find an overwatch location
_overwatchPosition = [_target, 400, 25, 2, _target] call lambs_main_fnc_findOverwatch;

missionnamespace setvariable ["OVERWATCH",_overwatchPosition,true];

if (_overwatchPosition  isNotEqualTo [0,0,0]) then { 
    ["overWatch", "loc_move", _overwatchPosition, "ColorRED", "Overwatch", 1] call PatrolOps_fnc_debugMarkers;
    ["overWatchRoad", "mil_objective_noShadow", _target, "ColorWhite", "Overwatch", 1] call PatrolOps_fnc_debugMarkers;
};

if (_overwatchPosition distance _target < 25) then {

    [_target] call PatrolOps_fnc_roadblock;

} else {

    // Now spawn the gunpit
    private _pit = createvehicle ["Land_ShellCrater_02_small_F", _overwatchPosition, [] , 0, "NONE"];
    private _dir = _pit getDir _target;
    _pit setVectorUp surfaceNormal _overwatchPosition;
    _pit setdir _dir + 235;
    _pit setPos [getPosATL _pit select 0, getPosATL _pit select 1, (getPosATL _pit select 2) -0.5];
    patrolOps_miscCleanUp pushback _pit;

    // Spawn the gun 
    private _static = createvehicle [_weapon, _pit getRelPos [0.1, 320] , [] , 0, "CAN_COLLIDE"];
    _static setdir _dir;
    _static setVectorUp surfaceNormal _overwatchPosition;

    // Spawn the gunner 
    _staticGunner = createGroup east;
    [1, _staticGunner, _overwatchPosition] call PatrolOps_fnc_createInsurgentSquad;
    (leader _staticGunner) assignAsGunner _static;
    (leader _staticGunner) moveInGunner _static;
    (leader _staticGunner) setVariable ["lambs_danger_dangerRadio", true];

};
