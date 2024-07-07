/*
	Author: JD Wang

	Description:
		Moves all the players to the appropriate Base 

	Parameter(s):
		Nothing

	Returns:
		If the route should be redone 

	Examples:
		[] call PatrolOps_fnc_routeCheck;
*/
hintSilent "";
private _markersArray1 = [];
private _markersArray2 = [];
_markersArray1 = allMapMarkers select {_x find "outRoute" >= 0};
_markersArray2 = allMapMarkers select {_x find "inRoute" >= 0};


// Initialize counters
_countWithinRange = 0;
_totalMarkers = count _markersArray1;

// Define the maximum distance (in meters)
_maxDistance = 20;

// Iterate through the markers in array 1
{
    _markerPos1 = getMarkerPos _x;
    _isWithinRange = false;

    // Check against each marker in array 2
    {
        _markerPos2 = getMarkerPos _x;
        _distance = _markerPos1 distance _markerPos2;

        if (_distance <= _maxDistance) then {
            _isWithinRange = true;
        };
    } forEach _markersArray2;

    // Count if any marker in array 1 is within range of any marker in array 2
    if (_isWithinRange) then {
        _countWithinRange = _countWithinRange + 1;
    };
} forEach _markersArray1;

// Calculate the percentage of markers within range
_percentageWithinRange = (_countWithinRange / _totalMarkers) * 100;

// Initialize fail variable
_fail = "no";

// Check if more than 20% of markers are within the specified distance
if (_percentageWithinRange > 20) then {
    _fail = "yes";
    missionnamespace setvariable ["routeSuccess", false];
	diag_log "[NZF PATROL OPS] - No suitable route found - Regenerating";
	diag_log format ["Markers within range: %1"+ endl +"Percentage: %2%"+ endl +"Fail: %3", _countWithinRange, _percentageWithinRange, _fail];
    missionnamespace setvariable ["MissionClean", false];
    _count = missionnamespace getVariable "regen";
    _count = _count + 1;
    missionNamespace setVariable ["regen", _count];
    [] spawn PatrolOps_fnc_initPatrol;
};

// Debug output
if (PATROLOPS_DEBUG) then {
	hint format ["Markers within range: %1\nPercentage: %2%\nFail: %3", _countWithinRange, _percentageWithinRange, _fail];
    
};
_return = missionNamespace getVariable "routeSuccess";
_return;