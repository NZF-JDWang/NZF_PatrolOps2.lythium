execVM "PatrolOps\scripts\patrolOps_config.sqf";

// Get base locations
private _patrolBases = allMapMarkers select {_x find "patrolBase" >= 0};

// Pick the starting FOB for the night
private _startFOB = selectRandom _patrolBases;
missionNamespace setVariable ["startingFOB", _startFOB, true];

/*
	File: initServer.sqf
	Author: Dom
	Requires: Start the server up
*/
DT_dynamicGroups = getArray(missionConfigFile >> "Dynamic_Groups" >> "group_setup");
{
	_x params ["","_roles"];
	_x pushBack grpNull;

	private _roleCount = count _roles;
	private _playerArray = [];
	for "_i" from 1 to _roleCount do {
		_playerArray pushBack objNull;
	};
	_x pushBack _playerArray;
} forEach DT_dynamicGroups;

[DT_dynamicGroups] remoteExecCall ["DT_fnc_updateGroups",-2,"DT_DG_JIP"];

addMissionEventHandler ["HandleDisconnect",DT_fnc_handleDisconnect];