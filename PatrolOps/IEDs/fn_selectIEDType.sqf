/*
	Author: JD Wang

	Description:
		Randomly selects potential IED locations along the route 

	Parameter(s):
		0: Marker location <ARRAY>

	Returns:
		Nothing

	Examples:
		[_location] call patrolOps_fnc_selectIEDtype;
*/

params ["_location"];

// Get road info for the location 
private _road = [_location, 25] call BIS_fnc_nearestRoad;
private _roadInfo = [_road] call PatrolOps_fnc_getRoadInfo;
_roadInfo params ["_roadType","_roadWidth","_roadDir", "_texture"];


private ["_typeIED"];
if (_roadType isEqualTo "MAIN ROAD" || _roadType isEqualTo "ROAD" || _texture isEqualTo "a3\roads_f\roads_ae\data\surf_roadconcrete_city_road_ca.paa") then {

	// If the road is paved then IED's can be either under cars or in a trash pile
	// NOTHING - some sort of clutter 
	_selection = floor (random 10) +1;

	if (_selection == 1) then {
		// 10% Chance 
		_typeIED = "NOTHING";
	}; 
	if (_selection > 1 && _selection < 6) then {
		// 40% Chance
		_typeIED = "CAR";
	};
		if (_selection > 5) then {
		// 50% Chance
		_typeIED = "TRASHPILE";
	};

} else {

	// If it's a dirt road then the IED's can be either under cars in trash piles or buried 
	// NOTHING - some sort of clutter 
	_selection = floor (random 10) +1;
	if (_selection == 1) then {
		// 10% Chance 
		_typeIED = "NOTHING";
	}; 
	if (_selection > 1 && _selection < 4) then {
		// 20% Chance
		_typeIED = "CAR";
	};
	if (_selection > 3 && _selection < 6) then {
		// 20% Chance
		_typeIED = "TRASHPILE";
	};
	if (_selection > 5) then {
		// 50% Chance
		_typeIED = "BURIED";
	};

};
_return = [_typeIED, _roadType];
_return;