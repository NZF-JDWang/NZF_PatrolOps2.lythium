/*
	Author: JD Wang

	Description:
		Generates the IED Factory Objective 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[_locationName, _locationData] call PatrolOps_fnc_iedFactory;
*/

params ["_locationName", "_locationData"];
private _location = _locationData select 0;

["loc_destroy",_location] call PatrolOps_fnc_createObjectiveMarker;

// Find buildging for cache
private _iedBuilding = [_locationData] call PatrolOps_fnc_findRandomBuilding;
private _dir = getdir (nearestBuilding _iedBuilding);
//private _factorySpawnPoint = [_iedBuilding, 0, 2, 0.25] call BIS_fnc_findSafePos;

//Spawn bench 
private _workbench = createvehicle ["Land_RattanTable_01_F", _iedBuilding, [] , 0, "CAN_COLLIDE"];
[_workbench, true, [0, 2, 0], 0, true] call ace_dragging_fnc_setDraggable;
_workbench enableSimulation false;
_workbench setVectorUp surfaceNormal (getposATL _workbench);
_workbench setdir _dir;
patrolOps_miscCleanUp pushback _workbench;

//Spawn plastic jug and attach to the bench 
private _jug = createvehicle ["Land_CanisterPlastic_F", [0,0,0], [] , 0, "CAN_COLLIDE"];
_jug attachTo [_workbench, [0.15, 0, .75]];
_jug setdir _dir +90;
_jug enableSimulation false;
[_jug, _jug] call ace_common_fnc_claim;
patrolOps_miscCleanUp pushback _jug;

private _explosive1 = createvehicle ["rhs_ec200_sand", [0,0,0], [] , 0, "CAN_COLLIDE"];
_explosive1 attachTo [_workbench, [-0.2, 0.25, 0.42]];
_explosive1 enableSimulation false;
_explosive1 setdir random 360;
_explosive1 setPosWorld getPosWorld _explosive1;
patrolOps_miscCleanUp pushback _explosive1;

private _explosive2 = createvehicle ["rhs_ec200_sand", [0,0,0], [] , 0, "CAN_COLLIDE"];
_explosive2 attachTo [_workbench, [-0.2, 0.0, 0.42]];
_explosive2 enableSimulation false;
_explosive2 setdir random 360;
_explosive2 setPosWorld getPosWorld _explosive2;
patrolOps_miscCleanUp pushback _explosive2;

private _tape = createvehicle ["Land_DuctTape_F", [0,0,0], [] , 0, "CAN_COLLIDE"];
_tape attachTo [_workbench, [-0.25, -0.2, 0.42]];
_tape enableSimulation false;
patrolOps_miscCleanUp pushback _tape;

//Finally a box of explosives
private _box = createvehicle ["UK3CB_Uzi_Equipbox_Blufor", _iedBuilding, [] , 1, "NONE"];
_box setVectorUp surfaceNormal (getposATL _box);
patrolOps_miscCleanUp pushback _box;

//Make box draggable
[_box, true, [0, 2, 0], 0, true] call ace_dragging_fnc_setDraggable;
_workbench enableSimulation true;

//clear Inventory 
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

_box addItemCargoGlobal ["rhs_ec200_sand_mag",2];
_box addItemCargoGlobal ["rhs_charge_M2tet_x2_mag",4];
_box addItemCargoGlobal ["rhsusf_m112_mag",6];
_box addItemCargoGlobal ["ACE_DefusalKit",1];

//add eventhandler to cache so I know when it's destroyed 
_box addEventHandler ["Explosion", {
	params ["_vehicle", "_damage", "_source"];
	_vehicle setDamage 1;
	[{call BIS_fnc_showNotification},["TaskSucceeded", ["", "Weapons Cache Destroyed"]],3] call CBA_fnc_waitAndExecute;
		
}];

_workbench addEventHandler ["Explosion", {
	params ["_vehicle", "_damage", "_source"];
	_vehicle setDamage 1;
	
}];


// Debug
["loc_destroy", (getpos _box), "ColorOPFOR", "IED Factory", 0.5] spawn PatrolOps_fnc_debugMarkers;