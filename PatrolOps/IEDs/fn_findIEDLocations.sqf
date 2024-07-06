/*
	Author: JD Wang

	Description:
		Randomly selects potential IED locations along the route 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] spawn PatrolOps_fnc_findIEDLocations;
*/

//get the outRoute markers and delete the first and last few to avoid IED at base and on target
//then do the same for the inRoute
private _outRoute = allMapMarkers select {_x find "outRoute" >= 0};
private _inRoute = allMapMarkers select {_x find "inRoute" >= 0};

_outRoute deleterange [0, 75];
_inRoute deleterange [0, 50];

private _lower = (count _outRoute) -50; 
_outRoute deleterange [_lower,50];

private _lower = (count _inRoute) -75; 
_inRoute deleterange [_lower,75];

//now create 1 array off all the route markers left
private _patrolRouteMarkers = [];
_patrolRouteMarkers append _outRoute;
_patrolRouteMarkers append _inRoute;

//find the length of the route 
private _patrolLenght = count _patrolRouteMarkers;