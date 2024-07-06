/*
	Author: JD Wang

	Description:
		Generates the main Objective 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_generateObjective;
*/

// Select a random mission objective
//private _missionNumbers = [1,2,3,4]; // Array containing possible mission objectives
//private _obj1 = selectrandom _missionNumbers; // Randomly select a mission objective
_obj1 = 3;
private _locationData = missionNamespace getvariable "firstPatrolLocationData"; // Retrieve patrol location data
private _locationName = missionNamespace getVariable "firstPatrolLocationName"; // Retrieve location name 

switch (_obj1) do { // Switch statement based on selected mission objective

	case 4 : { // Case for objective 4
				[_locationName, _locationData] spawn PatrolOps_fnc_manHunt; // Spawn function for capturing an HVI
				missionnamespace setvariable ["firstObjective","locate and capture an HVI", true]; // Set first objective as locating and capturing an HVI
			};

	case 3 : { // Case for objective 3
				[_locationName, _locationData] call PatrolOps_fnc_weaponsCache; // Call function for destroying an insurgent weapons cache
				missionnamespace setvariable ["firstObjective","locate and destroy an insurgent weapons cache", true]; // Set first objective as locating and destroying an insurgent weapons cache
			};

	case 2 : { // Case for objective 2
				[_locationName, _locationData] call PatrolOps_fnc_iedFactory; // Call function for destroying an IED factory
				missionnamespace setvariable ["firstObjective","locate and destroy an IED Factory", true]; // Set first objective as locating and destroying an IED factory
			};

	case 1 : { // Case for objective 1
				[_locationName, _locationData] call PatrolOps_fnc_vehicleRecovery; // Call function for recovering a damaged HMMWV
				missionnamespace setvariable ["firstObjective","recover a damaged HMMWV", true]; // Set first objective as recovering a damaged HMMWV
			};
};
