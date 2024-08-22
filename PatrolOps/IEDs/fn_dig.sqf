/*
	Author: JD Wang

	Description:
		Allows players with e-tool to dig up IED's

	Parameter(s):
		0: Player

	Returns:
		NONE

	Examples:
		[_player] call PatrolOps_fnc_dig;
*/

params ["_player","_helper"];

_ied = _helper getVariable "attachedIED";

_digtime = 10;
deleteVehicle _helper;

for "_i" from 1 to (_digtime-1) do {
	_ied setpos [getPos _ied select 0, getPos _ied select 1, (getPos _ied select 2) + 0.04];
	[_ied, _player] call grad_trenches_functions_fnc_playSound;
	sleep 1;
};
_ied setVectorUp surfaceNormal (getpos _ied);
[_ied, true] call ace_explosives_fnc_allowDefuse;