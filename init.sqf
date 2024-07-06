enableSentences false;

//Add eventhandler to civilians to count number of civ deaths
["UK3CB_TKC_C_CIV", "init", {
params ["_unit"];
_unit addMPEventHandler ["MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if (_killer in allPlayers) then {
		_kills = missionNamespace getvariable "patrolOps_CivilianKills";
		_kills = _kills + 1; 
		missionnamespace setvariable ["patrolOps_CivilianKills", _kills, true];
	};
}];

}] call CBA_fnc_addClassEventHandler;

//*************************************************************** 