/*
	Author: JD Wang

	Description:
		Spawns markers along the patrol route 

	Parameter(s):

	Returns:
		Nothing

	Examples:
		["_colour","_startLoc","_finishLoc"] call PatrolOps_fnc_generatePatrolRoute;
*/
if (!isServer) exitwith {};

params ["_colour","_startLoc","_finishLoc"];

private _agent = calculatePath ["wheeled_APC", "careless", _startLoc, _finishLoc];
_agent setVariable ["pathColour", _colour];
_agent addEventHandler ["PathCalculated", {

    private _agent = _this select 0;
    private _colour = _agent getVariable "pathColour";

    {
        private _marker = createMarkerLocal ["routemarker" + str (count patrolOps_allRouteMarkers), _x, 0];
        _marker setMarkerTypeLocal "mil_dot";
        _marker setMarkerColorLocal _colour;
        _marker setMarkerSizeLocal [.5, .5];
        _marker setMarkerAlphaLocal 0;
        _marker setMarkerShadowLocal false;
         
        patrolOps_allRouteMarkers pushback _marker;

    } forEach (_this select 1);
    _agent removeEventHandler ["PathCalculated",_thisEventHandler];
}];
