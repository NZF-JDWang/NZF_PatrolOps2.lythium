/*
	Author: JD Wang

	Description:
		Spawns ACE IEDs

	Parameter(s):
		0: IED Type <STRING>
		1: Location <ARRAY>

	Returns:
		NONE

	Examples:
		[_iedType, _locationIED] call PatrolOps_fnc_spawnDirtRoadIED;
*/
// Extract parameters for IED type and location
params ["_iedType","_locationIED"];

// Exit if not running on the server
if (!isServer) exitwith {};

// Define private variables
private ["_difficultyLevel","_iedClass","_ied"];
private _patrolDifficulty = missionnamespace getVariable "patrolDifficulty";

// Determine difficulty level based on patrol difficulty
switch (_patrolDifficulty) do {
    case "LOW": {_difficultyLevel = 75}; 
    case "MEDIUM": {_difficultyLevel = 85}; 
    case "HIGH": {_difficultyLevel = 95}; 
};

// Random chance to skip IED placement based on difficulty
if (random 100 > _difficultyLevel) exitwith {

	["IED", "loc_destroy", _locationIED, "ColorBlack", "NO IED Spawned", 0.5] call PatrolOps_fnc_debugMarkers;

};

// Loop to place 1 to 3 IEDs buried on the road near the object
for "_i" from 1 to (floor random (3)+1) do {

    // Select random IED class
    _iedClass = selectRandom ["ACE_IEDLandBig_Range_Ammo","ACE_IEDLandBig_Range_Ammo","ACE_IEDLandSmall_Range_Ammo"];

    // Get road information near the location
    private _road = [_locationIED, 20] call BIS_fnc_nearestRoad;
    private _roadInfo = [_road] call PatrolOps_fnc_getRoadInfo;
    _roadInfo params ["_roadType","_roadWidth","_roadDir", "_texture"];

	// Create the IED
    _ied = createVehicle [_iedClass, _road, [], 0, "CAN_COLLIDE"];
	_ied enableSimulationGlobal false;
    
    // Calculate random offset positions for IED placement and move the IED
    private _offsetDistance = 3 + random 5;
    private _offsetDirection = selectRandom [_roadDir,(_roadDir + 180)];
    private _iedOffset = _road getRelPos [_offsetDistance,_offsetDirection];
	_ied setpos _iedOffset;
    private _offsetDistance2 = ((_roadWidth/2) -1);
    private _offsetDirection2 = selectRandom [(_roadDir + 90),(_roadDir + 270)];
    private _iedPos = _ied getRelPos [(random _offsetDistance2),_offsetDirection2];
	_ied setpos _iedPos;
    
    _ied setVectorUp surfaceNormal (getpos _ied);
    patrolOpsAll_IEDs pushback _ied;

	// Marker for debug 
	["IED", "loc_destroy", (getpos _ied), "ColorRed", "Burried IED", 1] call PatrolOps_fnc_debugMarkers;

    // Bury the IED slightly below ground
    _ied setPos [getPos _ied select 0, getPos _ied select 1, (getPos _ied select 2) -0.2];
    [_ied, false] call ace_explosives_fnc_allowDefuse;

    // Add event handler for IED explosion effects
    _ied addMPEventHandler ["MPKilled", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        [(getpos _unit)] call PatrolOps_fnc_explosionEffects;
    }];

	// Add dig up action to ied 
	_action = ["digIED","Dig For IED","",{[_player,_ied] remoteExec ["PatrolOps_fnc_dig",0];},{("ACE_EntrenchingTool" in (items _player))&&((getPosATL _ied) < 0)},{},[],[0,0,0.22],0.5,1] call ace_interact_menu_fnc_createAction;   
	[_ied, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

    _ied enableSimulationGlobal true;

	if (PATROLOPS_DEBUG) then {

		_helper = createVehicle ["Sign_Arrow_F", getpos _ied, [], 0, "CAN_COLLIDE"];
		_helper setVectorUp surfaceNormal (getpos _helper);

	};

};





/*
    // Create a helper object for visualization (invisible sphere)
    _iedHelper = createVehicle ["Sign_Sphere10cm_F", [getpos _ied select 0, getpos _ied select 1,0], [], 0, "CAN_COLLIDE"];
    _iedHelper setObjectTextureGlobal [0, "#(argb,8,8,3)color(0,0,0,0,CA)"];
    _iedHelper setVectorUp surfaceNormal (getpos _iedHelper);

	_iedHelper setVariable ["ied", _ied];
	_action = ["digIED","Dig For IED","",{[_player,_iedHelper] remoteExec ["PatrolOps_fnc_dig",0];},{"ACE_EntrenchingTool" in (items _player)},{},[],[],0.5] call ace_interact_menu_fnc_createAction;   
	[_iedHelper, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;


    patrolOps_IEDHelpers pushBack _iedHelper;