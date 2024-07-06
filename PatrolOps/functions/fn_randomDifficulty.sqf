/*
	Author: JD Wang

	Description:
		Randomly selects patrol difficulty  

	Parameter(s):
		NONE

	Returns:
		NONE

	Examples:
		[] spawn PatrolOps_fnc_randomDifficulty;
*/

// Define the probabilities for each difficulty level

private _probabilityLow = 0.2;   // 20% chance for "low"
private _probabilityMedium = 0.5; // 50% chance for "medium"
private _probabilityHigh = 0.3;   // 30% chance for "high"

// Generate a random number between 0 and 1
private _randomNumber = random 1;


if (_randomNumber <= _probabilityLow) then {
	//Low difficulty
	missionNamespace setvariable ["patrolDifficulty", "LOW", true];

} else {

	if ((_randomNumber > _probabilityLow) AND (_randomNumber < _probabilityMedium)) then {
		//Medium difficulty
		missionNamespace setvariable ["patrolDifficulty", "MEDIUM", true];

	} else {
		//High difficulty
		missionNamespace setvariable ["patrolDifficulty", "HIGH", true];

	};
};