/*
	Author: JD Wang

	Description:
		Moves all the players to the appropriate Base 

	Parameter(s):
		Nothing

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_movePlayers;
*/

// Move player to starting Patrol Base 
private _startingFOB = getMarkerPos startingFOB;
private _nearestRespawn = nearestObjects [_startingFOB, ["Sign_Sphere100cm_Geometry_F"],100];

{_x setpos (getpos (_nearestRespawn select 0))} foreach allPlayers;