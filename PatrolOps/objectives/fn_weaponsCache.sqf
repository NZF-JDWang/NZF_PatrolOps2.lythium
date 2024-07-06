/*
	Author: JD Wang

	Description:
		Generates the Weapons Cache Objective 

	Parameter(s):
		0: Name <STRING>
		1: Position <ARRAY>

	Returns:
		Nothing

	Examples:
		[_locationName, _locationData] call PatrolOps_fnc_weaponsCache;
*/
params ["_locationName", "_locationData"];
private _location = _locationData select 0;

["loc_Rifle",_location] call PatrolOps_fnc_createObjectiveMarker;

// Find building for cache
_weaponsCacheBuilding = [_locationData] call PatrolOps_fnc_findRandomBuilding;

// Spawn cache box
private _box = selectRandom (parseSimpleArray patrolOps_WeaponCacheBoxes);
private _weaponsCache = createvehicle [_box, _weaponsCacheBuilding, [] , 0, "CAN_COLLIDE"];

// Empty box and fill it with rifles and RPG's
clearWeaponCargoGlobal _weaponsCache;
clearMagazineCargoGlobal _weaponsCache;
clearItemCargoGlobal _weaponsCache;
clearBackpackCargoGlobal _weaponsCache;

_weapon = selectRandom (parseSimpleArray patrolOps_InsurgentRifles);
_weaponsCache addWeaponCargoGlobal [_weapon,8];
_weapMagTypes = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
_weaponsCache addMagazineCargoGlobal [_weapMagTypes select 0,20];

_weapon = selectRandom (parseSimpleArray patrolOps_InsurgentMachineGuns);
_weaponsCache addWeaponCargoGlobal [_weapon,1];
_weapMagTypes = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
_weaponsCache addMagazineCargoGlobal [_weapMagTypes select 0,6];

_weaponsCache addWeaponCargoGlobal ["rhs_weap_rpg7",2];
_weaponsCache addMagazineCargoGlobal ["rhs_rpg7_PG7V_mag",6];

// Add eventhandler to cache so I know when it's destroyed 
_weaponsCache addEventHandler ["Explosion", {
	params ["_vehicle", "_damage", "_source"];
	_vehicle setDamage 1;
	[getpos _vehicle, _vehicle] call PatrolOps_fnc_explosionEffects;
	[{call BIS_fnc_showNotification},["TaskSucceeded", ["", "Weapons Cache Destroyed"]],3] call CBA_fnc_waitAndExecute;
	
}];

//Make box draggable
[_weaponsCache, true, [0, 2, 0], 0, true] call ace_dragging_fnc_setDraggable;
patrolOps_miscCleanUp pushback _weaponsCache;

["loc_Rifle", (getpos _weaponsCache), "ColorOPFOR", "Weapon Cache", 0.5] spawn PatrolOps_fnc_debugMarkers;