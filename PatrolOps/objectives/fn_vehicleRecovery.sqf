/*
	Author: JD Wang

	Description:
		Generates the Vehicle Recovery Objective 

	Parameter(s):
		0: Name <STRING>
		1: Position <ARRAY>

	Returns:
		Nothing

	Examples:
		[_locationName, _locationData] call PatrolOps_fnc_vehicleRecovery;
*/

params ["_locationName","_locationData"];
private _location = _locationData select 0;

// Find an open space to spawn the damaged vehicle;
private _pos = [(_location), 75, 250, 10, 0, 0.25, 0] call BIS_fnc_findSafePos;

["loc_repair",_location] call PatrolOps_fnc_createObjectiveMarker;

private _wreckVehicle = selectRandom parseSimpleArray patrolOps_RecoveryWreck;
private _vehicleWreck = createvehicle [_wreckVehicle, _pos, [] , 0, "NONE"];
_vehicleWreck setdir (random 360);
_vehicleWreck lock true;
[_vehicleWreck] call PatrolOps_fnc_clearVehicleCargo;
patrolOps_miscCleanUp pushback _vehicleWreck;

//Mark location of the wreck
_marker = createMarkerLocal ["Objective_markerRecoveryVehicle", getpos _vehicleWreck];
_marker setMarkerTypeLocal "loc_car";
_marker setMarkerColorLocal "ColorBlack";
_marker setMarkerTextLocal "HMMWV Wreck";
_marker setMarkerShadowLocal false;
_marker setMarkerSize [1, 1];

// Damage vehicle
_vehicleWreck setHitPointDamage ["hitEngine", 0.8, false];
_vehicleWreck setHitPointDamage ["hithull", 0.6, false];
_vehicleWreck setHitPointDamage ["hitfuel", 1.0, false];

{
	_vehicleWreck setHitPointDamage [_x, (random 1)];

} foreach ["hitglass1","hitglass2","hitglass3","hitglass4","hitglass5","hitglass6","hitturret","hitgun"];

private _wheels = ["wheel_1_1_steering", "wheel_1_2_steering", "wheel_2_1_steering", "wheel_2_2_steering"];
_wheels resize (ceil (random 3));

{_vehicleWreck sethit [_x, 1];} foreach _wheels;

// ASLToATLdd crate texture under vehicle
private _vehicleCrater = createvehicle ["Crater", _pos, [] , 0, "CAN_COLLIDE"];
patrolOps_miscCleanUp pushback _vehicleCrater;

// Spawn recoveryVehicle 
private _recoveryVehicleClass = (parseSimpleArray patrolOps_RecoveryVehicle) select 0;


// Get the active FOB
private _startingFOB = getmarkerPos (missionNamespace getVariable "startingFOB");

// Find spawn location and direction
private _vehSpawn = (nearestObjects [ _startingFOB, ["VR_Area_01_square_4x4_yellow_F"],150]) select 0;
private _spawnDir = 180 +(getdir _vehSpawn);

// Spawn the recovery Vehicle
_recoveryVehicle = createvehicle [_recoveryVehicleClass, getpos _vehSpawn, [] , 0, "CAN_COLLIDE"];
_recoveryVehicle setDir _spawnDir;

patrolOps_miscCleanUp pushback _recoveryVehicle;
[_recoveryVehicle, 6] call ace_cargo_fnc_setSpace;

for "_i" from 1 to 6 do { 
	["ACE_Wheel", _recoveryVehicle] call ace_cargo_fnc_loadItem;
};

if ((floor random 10) > 3) then {

	missionnamespace setvariable ["boobyTrappedRecoveryVehicle", true, true];
	// Add possible IED around wreck 
	private _iedtype = selectRandom ["ACE_IEDLandBig_Range_Ammo","ACE_IEDLandBig_Range_Ammo","ACE_IEDLandSmall_Range_Ammo"];
	_ied = createVehicle [_iedtype, _pos, [], 2, "CAN_COLLIDE"];
	_ied setVectorUp surfaceNormal (getpos _ied);
	patrolOps_allIEDs pushback _ied;

	// Add eventhandler to increase IED explosion effects 
	/*
	_ied addMPEventHandler ["MPHit", {
		params ["_unit", "_causedBy", "_damage", "_instigator"];
		[(getpos _unit)] call PatrolOps_fnc_boom;
		"boom" remoteExec ["hint", 0];
	}];
	*/
	_ied setPos [getPos _ied select 0, getPos _ied select 1, (getPos _ied select 2) -0.2];
	[_ied, false] call ace_explosives_fnc_allowDefuse;

	_iedCover = createVehicle ["Land_Decal_roads_oil_stain_01_F", getpos _ied, [], 0, "CAN_COLLIDE"];
	_iedCover setVectorUp surfaceNormal (getposATL _iedCover);
	patrolOps_allClutter pushBack _iedCover;

	_coverHelper = createVehicle ["Sign_Sphere10cm_F", getpos _iedCover, [], 0, "CAN_COLLIDE"];
	_coverHelper setObjectTextureGlobal [0, "#(argb,8,8,3)color(0,0,0,0,CA)"];
	patrolOps_miscCleanUp pushBack _coverHelper;

};
// Now add a small group patrolling around the wreck
_ambushSquad = createGroup east; 
_ambushSquadAttack = [(random [3,4,6]), _ambushSquad, (_vehicleWreck getRelPos [50, (random 360)])] call PatrolOps_fnc_createInsurgentSquad;
[_ambushSquadAttack, _vehicleWreck, 100, 4, [], true] call lambs_wp_fnc_taskPatrol;
_ambushSquadAttack setVariable ["lambs_danger_enableGroupReinforce", false, true];
