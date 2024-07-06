/*
	Author: JD Wang

	Description:
		Sets a random time during the day for the mission to start

	Parameter(s):
		Nothing

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_setMissionTime;
*/

// Calculate the morning time by getting the sunrise time and subtracting 2 hours
private _morning = (date call BIS_fnc_sunriseSunsetTime select 0) - 2;

// Calculate the night time by getting the sunset time and subtracting 3 hours
private _night = (date call BIS_fnc_sunriseSunsetTime select 1) - 3;

// Calculate the total number of daytime hours by subtracting the morning time from the night time, then adding 1 hour
private _daytimeHours = (_night + 1) - _morning;

// Generate a random time within the daytime hours
_randomtime = random _daytimeHours;

// Calculate the mission time by adding the random time to the morning time
_missionTime = _morning + _randomtime;

// Set the date and time for the mission
// The date array contains: [year, month, day, hour, minute]
// The hour is set to the ceiling of the mission time
// The minute is set to a random value between 0 and 49
[[date select 0, date select 1, date select 2, (ceil _missionTime), (floor (random 50))]] remoteExec ["setDate", 0];
