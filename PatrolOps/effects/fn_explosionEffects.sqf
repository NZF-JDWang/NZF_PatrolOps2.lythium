/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_effects

Description:
    Create effects on player (smoke, rock, shock wave ...).

Parameters:
    _pos - Position of the IED. [Array]
    _caller - Player. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_ied_fnc_effects;
    (end)

Author:
    1kuemmel1

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_caller", player, [objNull]]
];

[_pos, _caller] spawn patrolOps_fnc_blurEffects;
[_pos] spawn patrolOps_fnc_smokeEffects;
[_pos] spawn patrolOps_fnc_rockEffects;
[_pos] spawn patrolOps_fnc_shockWaveEffects;
[_pos] spawn PatrolOps_fnc_earRinging;