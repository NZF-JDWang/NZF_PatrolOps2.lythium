/*
	Author: JD Wang

	Description:
		Finds locations within 500m of the route 


	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_findSideLocations;
*/

// Retrieve all route markers stored in the mission namespace.
private _routeMarkers = missionNamespace getVariable "patrolOps_allRouteMarkers";

// Initialize an array to store on-route locations.
private _onRouteLocations = [];

// Iterate through each route marker.
{
    // Find the nearest location within a certain radius to the current route marker.
    private _testPoint = locationPosition ((nearestLocations [getMarkerPos _x, ["NameVillage", "NameCity", "NameCityCapital"], 500]) select 0);

    // Check if _testPoint is not empty and is not equal to the first patrol location data.
    if ((count _testPoint > 0) && !(_testPoint isEqualTo (firstPatrolLocationData select 1))) then {
        // Add the _testPoint to the list of on-route locations.
        _onRouteLocations pushBackUnique _testPoint;
        // Spawn a debug marker at _testPoint with specific parameters.
        ["selector_selectable", _testPoint, "ColorCIV", "", 1.5] spawn PatrolOps_fnc_debugMarkers;
    };
} forEach _routeMarkers; // End of foreach loop for route markers.


