/*
	Author: JD Wang

	Description:
		Find info about a road segment 

	Parameter(s):
		0: Position <ARRAY>

	Returns:
		Array of road information 
		0:Type of road
		1:Distance from center of road to the outside
		2:Direction road faces 
		3:Texture of the road object

	Examples:
		[_road] call PatrolOps_fnc_getRoadInfo;
*/
params ["_road"];

private _info = getRoadInfo _road;
_info params ["_mapType", "_width", "_isPedestrian", "_texture", "_textureEnd", "_material", "_begPos", "_endPos", "_isBridge"];
private _dir = _begPos getDir _endPos;

_return = [_mapType, (_width/2) ,_dir, _texture];

_return;