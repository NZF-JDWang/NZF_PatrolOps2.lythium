/*
	Author: JD Wang

	Description:
		Randomly selects the number of IED's for each route 

	Parameter(s):
		NONE

	Returns:
		Number of IED's to spawn

	Examples:
		[] call PatrolOps_fnc_getNumberOfIEDs;
*/
private ["_numberOfIEDs"];
private _patrolDifficulty = missionNamespace getvariable "patrolDifficulty";
switch (_patrolDifficulty) do {

	case "LOW": {_numberOfIEDs = random [2,2,3]};

	case "MEDIUM": {_numberOfIEDs = random [3,3,4]};

	case "HIGH": {_numberOfIEDs = random [4,5,6]};
};

_numberOfIEDs;