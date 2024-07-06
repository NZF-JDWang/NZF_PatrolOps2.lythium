/* ----------------------------------------------------------------------------
Function: btc_deaf_fnc_earringing

Description:
    Create earringing to all player in a radius of 100m.

Parameters:
    _pos - Sound position source. [Array]

Returns:

Examples:
    (begin example)
        [_pos] call PatrolOps_fnc_earRinging;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]]
];

private _players_close = allPlayers inAreaArray [_pos, 100, 100];
[12] remoteExecCall ["ace_hearing_fnc_earRinging", _players_close];

_tinitus = random [30, 40, 45];

sleep _tinitus;

[2] remoteExecCall ["ace_hearing_fnc_earRinging", _players_close];
