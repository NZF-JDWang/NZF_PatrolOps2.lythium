/*
	Author: JD Wang

	Description:
		Spawns IEDD

	Parameter(s):
		0: IED Type <STRING>
		1: Location <ARRAY>

	Returns:
		NONE

	Examples:
		[_iedType, _locationIED] call PatrolOps_fnc_spawnPavedRoadIED;
*/
// Extract parameters for IED type and location
params ["_iedType","_locationIED"];

// Exit if not running on the server
if (!isServer) exitwith {};

// Define private variables
private ["_difficultyLevel","_ied","_bombObj"];
private _patrolDifficulty = missionnamespace getVariable "patrolDifficulty";

_difficultyLevel = 75;

// Random chance to skip IED placement based on difficulty
if (random 100 > _difficultyLevel) exitwith {

	["IED", "loc_destroy", _locationIED, "ColorBlack", "NO IED Spawned", 0.5] call PatrolOps_fnc_debugMarkers;

};

if (_iedType == "CAR") then {
    // For under vehicle IED's 
    private _water = getposATL nearestObject [_locationIED, "WaterSpill_01_Medium_Old_F"];
    _bombObj = createVehicle ["iedd_ied_Cinder", _water, [], 0.25, "CAN_COLLIDE"];
    _bombObj enableSimulationGlobal false;
    _bombObj setVectorDirAndUp [[0,1,0],[1,0,0]];
    _bombObj setVariable ["iedd_ied_variation",5]; // Random variation
    _bombObj setVariable ["iedd_ied_decals",false]; // No decals
    _bombObj setVariable ["iedd_ied_dir",false]; // Fixed direction
    _bombObj setVariable ["iedd_ied_dud",2]; // 2% chance to dud
    _bombObj setVariable ["iedd_ied_size",4]; // Large explosion size
    
    patrolOps_allIEDs pushback _bombObj;

    _bombObj enableSimulationGlobal true;

	// Marker for debug 
	["IED", "loc_destroy", (getpos _bombObj), "ColorRed", "IED", 1] call PatrolOps_fnc_debugMarkers;

} else {

    // Select random IED class
    _iedClass = selectRandom ["iedd_ied_CanisterPlastic","iedd_ied_CanisterFuel","iedd_ied_Cardboard","iedd_ied_Cinder","iedd_ied_Metal","iedd_ied_Barrel"];

    // Special case for metal IEDs
    if (_iedClass isEqualTo "iedd_ied_Metal") then {
        _iedClass = selectRandom ["iedd_ied_Metal","iedd_ied_Metal_English"];
    };

    // Special case for barrel IEDs
    if (_iedClass isEqualTo "iedd_ied_Barrel") then {
        _iedClass = selectRandom ["iedd_ied_Barrel","iedd_ied_Barrel_Grey"];
    };

    // Create the IED
    _ied = createVehicle [_iedClass, _locationIED, [], 0.25, "CAN_COLLIDE"];
    _ied setVectorUp surfaceNormal (getpos _ied);
    _ied enableSimulationGlobal false;
    patrolOps_allIEDs pushback _ied;

    // Add event handler for IED explosion
    _ied addMPEventHandler ["MPKilled", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        [(getpos _unit)] call PatrolOps_fnc_explosionEffects;
        if (PATROLOPS_DEBUG) then {"boom" remoteExec ["hint", 0]};
    }];

    // Special case for fuel canister IED
    if (_iedType isEqualTo "iedd_ied_CanisterFuel") then {
        _ied setVariable ["iedd_ied_color","random"];
    }; 

    // Set IED properties
    _ied setVariable ["iedd_ied_variation",5]; // Random variation
    _ied setVariable ["iedd_ied_decals",false]; // No decals
    _ied setVariable ["iedd_ied_dir",true]; // Random direction
    _ied setVariable ["iedd_ied_dud",2]; // 2% chance to dud
    _iedSize = (floor random [0,2.7,4]);
    _ied setVariable ["iedd_ied_size",_iedSize]; // Random explosion size

	// Marker for debug 
	["IED", "loc_destroy", (getpos _ied), "ColorRed", "IED", 1] call PatrolOps_fnc_debugMarkers;


    _ied enableSimulationGlobal true;


};


