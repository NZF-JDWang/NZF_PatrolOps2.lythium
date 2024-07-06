/*
	Author: JD Wang

	Description:
		Finds a randon building location in the AO  

	Parameter(s):
		0: Location <ARRAY>
		
	Returns:
		Nothing

	Examples:
		[_locationData] call PatrolOps_fnc_findRandomBuilding;
*/

params ["_locationData"];

//Find random spot in the AO 
_position = [_locationData] call CBA_fnc_randPosArea;

//Now find the nearest building to that location and get all it's indoor building positions
_range =  (_locationData select 1) min (_locationData select 2);
_buildingPositions = [_position, _range, true, true] call PatrolOps_fnc_findBuildingPos;
_spawnPos = selectRandom _buildingPositions;

//Returns a building location
_spawnPos;