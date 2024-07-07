/*
	Author: JD Wang

	Description:
		Initializes the patrol 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_initPatrol;
*/
if (!isServer) exitWith {};

if ((missionnamespace getVariable "regen" > 3)) exitwith {
	_txt = "Failed to find a good route please try again";
	[[_txt, "BLACK IN",0]] remoteExec ["cutText"];

	};

if (MissionClean && (missionnamespace getVariable "regen" == 0)) then {

    [["Generating Patrol...", "BLACK OUT",1]] remoteExec ["cutText"];
	[] spawn PatrolOps_fnc_generatePatrol;
    
};

if ((!MissionClean) && (missionnamespace getVariable "regen" == 0)) then {

	[] call PatrolOps_fnc_patrolCleanUp;
	waituntil {MissionClean}; 
    [["Generating Patrol...", "BLACK OUT",1]] remoteExec ["cutText"];
	[] spawn PatrolOps_fnc_generatePatrol;
    
}; 

if ((!MissionClean) && (missionnamespace getVariable "regen" > 0)) then {

    _count = missionnamespace getVariable "regen";
    _txt = format ["Bad Route Regenerating... %1",_count];
    [[_txt, "BLACK OUT",0]] remoteExec ["cutText"];
    [] call PatrolOps_fnc_patrolCleanUp;
	waituntil {MissionClean}; 

    [] spawn PatrolOps_fnc_generatePatrol;

};
