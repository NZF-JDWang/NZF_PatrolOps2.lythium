/*
	Author: JD Wang

	Description:
		Create OPFOR quad

	Parameter(s):
		0: NUMBER - Size of squad
		1: STRING - Name of the squad
		2: POSITION - Location to spawn squad

	Returns:
		Squad

	Examples:
		[_squadSize, _squad, _position] call PatrolOps_fnc_createInsurgentSquad;
*/
params ["_squadSize","_insurgentSquad","_pos"];

_position = [_pos select 0, _pos select 1, 0];

//Create TL
private _insurgent = _insurgentSquad createUnit ["O_Soldier_F", _position, [], 10, "NONE"];
_insurgentSquad selectLeader _insurgent;
[_insurgent, "Leader"] spawn PatrolOps_fnc_unitRedress;
patrolOps_Garrisons pushback _insurgentSquad;

//Add a machinegunner if the squad is over 6 men 
if (_squadSize > 6) then {
	_insurgent = _insurgentSquad createUnit ["O_Soldier_F", _position, [], 10, "NONE"];
	[_insurgent, "MachineGunner"] spawn PatrolOps_fnc_unitRedress;
	patrolOps_Garrisons pushback _insurgentSquad;
};

//Now the rest of the squad 
for "_i" from 2 to _squadSize do {

	_insurgent = _insurgentSquad createUnit ["O_Soldier_F", _position, [], 10, "NONE"];
	[_insurgent, "Insurgent"] spawn PatrolOps_fnc_unitRedress;
	patrolOps_Garrisons pushback _insurgentSquad;

};

_insurgentSquad;