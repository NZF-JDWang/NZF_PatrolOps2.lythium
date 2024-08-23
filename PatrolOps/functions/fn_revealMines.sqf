/*
    Author: JD Wang

    Description:
        Reveals all mines to all AI units continuously. This function should be called in a loop or scheduled to run periodically.

    Parameter(s):
        NONE

    Returns:
        Nothing

    Examples:
        [] spawn PatrolOps_fnc_revealMines; 
*/


while {true} do {
	{Civilian revealMine _x} foreach patrolOps_allIEDs;
	{OPFOR revealMine _x} foreach patrolOps_allIEDs;
	sleep 5;
};