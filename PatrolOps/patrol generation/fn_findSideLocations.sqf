/*
    Author: JD Wang, Modified by Grok 2

    Description:
        Finds locations within 500m of the route, excluding those within 500m of the start or end FOB locations.

    Parameter(s):
        NONE

    Returns:
        Nothing

    Examples:
        [] call PatrolOps_fnc_findSideLocations;
*/
private ["_testPoint", "_routeMarkers", "_onRouteLocations", "_startFOBLocation", "_endFOBLocation"];

// Retrieve all route markers stored in the mission namespace.
_routeMarkers = missionNamespace getVariable ["patrolOps_allRouteMarkers", []];
_startFOBLocation = getMarkerPos (missionNamespace getVariable "startingFOB");
_endFOBLocation = getMarkerPos (missionNamespace getVariable "endFOB");

// Initialize an array to store on-route locations.
_onRouteLocations = [];

// Iterate through each route marker.
{
    // Find the nearest location within a certain radius to the current route marker.
    private _nearestLocations = nearestLocations [getMarkerPos _x, ["NameVillage", "NameCity", "NameCityCapital"], 500];

    // Check if _nearestLocations is not empty to avoid errors.
    if (count _nearestLocations > 0) then {
        _testPoint = locationPosition (_nearestLocations select 0);

        // Check if _testPoint is not empty and is not equal to the first patrol location data.
        if ((count _testPoint > 0) && !(_testPoint isEqualTo (firstPatrolLocationData select 0))) then {
            // Check if _testPoint is not within 500m of _startFOBLocation or _endFOBLocation
            if (_testPoint distance2D _startFOBLocation > 500 && _testPoint distance2D _endFOBLocation > 500) then {
                // Add the _testPoint to the list of on-route locations.
                _onRouteLocations pushBackUnique _testPoint;

                // Spawn a debug marker at _testPoint with specific parameters.
                ["sideLocation", "selector_selectable", _testPoint, "ColorCIV", "", 1.5] spawn PatrolOps_fnc_debugMarkers;
            };
        };
    };
} forEach _routeMarkers; // End of foreach loop for route markers.

true;