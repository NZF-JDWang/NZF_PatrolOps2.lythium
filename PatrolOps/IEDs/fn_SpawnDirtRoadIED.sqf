/*
    Author: JD Wang, Modified by Grok

    Description:
        Spawns ACE IEDs on a road with improved spacing and positioning, ensuring one IED is near the specified location.

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
if (!isServer) exitWith {};

// Define private variables
private ["_difficultyLevel","_iedClass","_ied"];
private _patrolDifficulty = missionNamespace getVariable "patrolDifficulty";

// Determine difficulty level based on patrol difficulty
_difficultyLevel = 75;

// Random chance to skip IED placement based on difficulty
if (random 100 > _difficultyLevel) then {

    ["IED", "loc_destroy", _locationIED, "ColorBlack", "NO IED Spawned", 0.5] call PatrolOps_fnc_debugMarkers;
    
} else {

    // Get road information near the location
    private _road = [_locationIED, 50] call BIS_fnc_nearestRoad;
    private _roadInfo = [_road] call PatrolOps_fnc_getRoadInfo;
    _roadInfo params ["_roadType", "_roadWidth", "_roadDir", "_texture"];

    // Define road properties
    private _roadCenter = getPos _road;
    private _roadLength = 10; // Assuming a 20m segment of road for placement
    private _numIEDs = round (random [1, 1.7, 3]);
    private _spacing = _roadLength / (_numIEDs + 1);

    // Flag to ensure one IED is placed near _locationIED
    private _nearLocationPlaced = false;

    // Loop to place IEDs
    for "_i" from 1 to _numIEDs do {
        // Select random IED class
        _iedClass = selectRandom ["ACE_IEDLandBig_Range_Ammo","ACE_IEDLandBig_Range_Ammo","ACE_IEDLandSmall_Range_Ammo"];

        // Create the IED
        _ied = createVehicle [_iedClass, _road, [], 0, "NONE"];
        _ied enableSimulationGlobal false;

        // If this is the first IED or if we haven't placed one near _locationIED yet
        if (!_nearLocationPlaced) then {
            // Calculate position near _locationIED
            private _iedPos = _locationIED getPos [(1+(random 1)), random 360];
            _ied setPos _iedPos;
            _nearLocationPlaced = true;
        } else {
            // Calculate placement distance for other IEDs
            private _placementDistance = _i * _spacing;
            private _iedPos = _roadCenter getPos [_placementDistance, _roadDir];
            private _offsetDirection = selectRandom [_roadDir + 90, _roadDir - 90];
            private _offsetDistance = (_roadWidth / 2) - random 0.5;
            _iedPos = _iedPos getPos [_offsetDistance, _offsetDirection];

            // Set position with slight randomization
            _ied setPos [(_iedPos select 0) + (random 1 - 0.5), (_iedPos select 1) + (random 1 - 0.5), _iedPos select 2];
        };

        // Ensure IED is on the road
        private _roadCheck = [(getpos _ied), 50] call BIS_fnc_nearestRoad;
        if (isNull _roadCheck) then {
            _ied setPos getPos _roadCheck;
        };

        _ied setVectorUp surfaceNormal (getPos _ied);
        patrolOps_allIEDs pushBack _ied;

        // Create helper for digging up
        _iedHelper = createVehicle ["Sign_Sphere10cm_F", [getPos _ied select 0, getPos _ied select 1, 0], [], 0, "CAN_COLLIDE"];
        _iedHelper setObjectTextureGlobal [0, "#(argb,8,8,3)color(0,0,0,0,CA)"];
        _iedHelper setVectorUp surfaceNormal (getPos _iedHelper);
        patrolOps_miscCleanUp pushBack _iedHelper;
        _iedHelper setVariable ["attachedIED", _ied];

        // Marker for debug 
        ["IED", "loc_destroy", (getPos _ied), "ColorRed", "Buried IED", 1] call PatrolOps_fnc_debugMarkers;

        // Bury the IED slightly below ground
        _ied setPos [getPos _ied select 0, getPos _ied select 1, (getPos _ied select 2) - 0.2];
        [_ied, false] call ace_explosives_fnc_allowDefuse;

        // Add event handler for IED explosion effects
        _ied addMPEventHandler ["MPKilled", {
            params ["_unit", "_killer", "_instigator", "_useEffects"];
            [(getPos _unit)] call PatrolOps_fnc_explosionEffects;
        }];

        _ied enableSimulationGlobal true;

        if (PATROLOPS_DEBUG) then {
            _helper = createVehicle ["Sign_Arrow_F", getPos _ied, [], 0, "CAN_COLLIDE"];
            _helper setVectorUp surfaceNormal (getPos _helper);
            patrolOps_miscCleanUp pushBack _helper
        };
    };

};