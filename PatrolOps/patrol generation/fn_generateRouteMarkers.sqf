/*
	Author: JD Wang

	Description:
		Spawns markers along the patrol route 

	Parameter(s):

	Returns:
		Nothing

	Examples:
		["_colour","_startLoc","_finishLoc"] call PatrolOps_fnc_generateRouteMarkers;
*/
// Check if running on server, exit if not
if (!isServer) exitWith {};

// Define script parameters
params ["_colour","_startLoc","_finishLoc","_routeName"];

// Make sure we grab an actual road location
private _startRoad = getpos ((nearestTerrainObjects [_startLoc, ["MAIN ROAD","ROAD","TRACK"], 2000]) select 0);
private _finishRoad = getpos ((nearestTerrainObjects [_finishLoc, ["MAIN ROAD","ROAD","TRACK"], 2000]) select 0);
// Calculate path using a wheeled APC
private _pathAgent = calculatePath ["wheeled_APC", "careless", _startRoad, _finishRoad];
_pathAgent setVariable ["pathColour", _colour];
_pathAgent setVariable ["_routeName", _routeName];

// Add event handler for when path is calculated
_pathAgent addEventHandler ["PathCalculated", {
    private _agent = _this select 0;
    private _colour = _agent getVariable "pathColour";
    private _routeName = _agent getVariable "_routeName";
    
    // Create markers along the path
    {
        private _marker = createMarkerLocal ["routeMarker" + str _forEachIndex + _routeName, _x, 0];
        _marker setMarkerTypeLocal "mil_dot";
        _marker setMarkerColorLocal _colour;
        _marker setMarkerSizeLocal [.5, .5];
        _marker setMarkerAlphaLocal 0;
        _marker setMarkerShadowLocal false;

        if (_routeName isEqualTo "outRoute") then {_marker setMarkerPosLocal  [getMarkerPos _marker select 0, (getMarkerPos _marker select 1)+3]};
        if (_routeName isEqualTo "inRoute") then {_marker setMarkerPosLocal  [getMarkerPos _marker select 0, (getMarkerPos _marker select 1)-3]};

        

    } forEach (_this select 1);
    
    // Remove event handler after execution
    _agent removeEventHandler ["PathCalculated", _thisEventHandler];
}];

true;