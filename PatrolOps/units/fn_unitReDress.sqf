/*
	Author: JD Wang

	Description:
		Redresses vanilla units  

	Parameter(s):
		0: Unit <OBJECT>
		1: Type <STRING>

	Returns:
		Nothing

	Examples:
		[_unit, _style] spawn PatrolOps_fnc_unitRedress;
*/

params ["_unit","_style"];

//Get the time of day 
private _morning = (date call BIS_fnc_sunriseSunsetTime select 0);
private _night = (date call BIS_fnc_sunriseSunsetTime select 1);

sleep 0.2;

// Remove all gear from the unit
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

//Add some facewear
_unit addGoggles selectRandom parseSimpleArray grad_civs_loadout_goggles;

//Here's a good place to add eventhandlers to the OPFOR units 
_unit addMPEventHandler ["MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if (_killer in allPlayers) then {
		_kills = missionNamespace getvariable "patrolOps_EnemyKills";
		_kills = _kills + 1; 
		missionnamespace setvariable ["patrolOps_EnemyKills", _kills, true];
	};
}];

switch (_style) do {

	case "civ": {
		//Dress unit as an unarmed civilian
		_unit forceAddUniform selectRandom parseSimpleArray grad_civs_loadout_clothes;
		_unit unlinkItem "ItemCompass";
		[_unit, (selectrandom parseSimpleArray grad_civs_loadout_faces)] remoteExec ["setFace", 0, _unit];
		_unit addHeadgear selectRandom parseSimpleArray grad_civs_loadout_headgear;
	};

	case "leader": {
		//Dress Team Leaders 
		_InsurgentUniform = parseSimpleArray grad_civs_loadout_clothes;
		_InsurgentUniform = _InsurgentUniform + (parseSimpleArray patrolOps_InsurgentUniforms);
		_unit forceAddUniform selectRandom _InsurgentUniform;
		[_unit, (selectrandom parseSimpleArray grad_civs_loadout_faces)] remoteExec ["setFace", 0];

		_unitHeadgear = (parseSimpleArray grad_civs_loadout_headgear) + (parseSimpleArray patrolOps_InsurgentHeadgear);
		_unit addHeadgear selectRandom _unitHeadgear;
		_unit addVest selectRandom (parseSimpleArray patrolOps_InsurgentVests);
		_unit additem "itemMap";
		_unit linkItem "itemMap";
		
		_unit addWeapon "rhs_weap_ak74";
		_weapMagTypes = getArray (configFile >> "CfgWeapons" >> (primaryWeapon _unit) >> "magazines");
		_unit addPrimaryWeaponItem (_weapMagTypes select 0);
		_unit addPrimaryWeaponItem "rhs_acc_2dpZenit";

		if ((daytime < (date call BIS_fnc_sunriseSunsetTime select 0)) OR (daytime > (date call BIS_fnc_sunriseSunsetTime select 1))) then {
				_unit enableGunLights "forceOn";
			} else {
				_unit enableGunLights "ForceOff";
			};
		
		_unit addItemToUniform "kat_PainkillerItem";
		_unit addItemToUniform "ACRE_BF888S";
		_unit addItemToUniform "ACE_tourniquet";

		for "_i" from 1 to 12 do {_unit addItemToUniform "ACE_elasticBandage"};
		for "_i" from 1 to 6 do {_unit addItemToVest (_weapMagTypes select 0);};

		//Add intel to the teamleader
		[_unit] spawn PatrolOps_fnc_unitIntel;

	};

	case "MachineGunner": {
		//Dress unit as a MachineGunner
		_InsurgentUniform = parseSimpleArray grad_civs_loadout_clothes;
		_InsurgentUniform = _InsurgentUniform + (parseSimpleArray patrolOps_InsurgentUniforms);
		_unit forceAddUniform selectRandom _InsurgentUniform;

		[_unit, (selectrandom parseSimpleArray grad_civs_loadout_faces)] remoteExec ["setFace", 0];
		_unitHeadgear = (parseSimpleArray grad_civs_loadout_headgear) + (parseSimpleArray patrolOps_InsurgentHeadgear);
		_unit addHeadgear selectRandom _unitHeadgear;
		_unit addVest selectRandom (parseSimpleArray patrolOps_InsurgentVests);
		
		_unit addWeapon selectRandom (parseSimpleArray patrolOps_InsurgentMachineGuns);
		_weapMagTypes = getArray (configFile >> "CfgWeapons" >> (primaryWeapon _unit) >> "magazines");
		_unit addPrimaryWeaponItem (_weapMagTypes select 0);
		_unit addItemToUniform "ACE_tourniquet";

		_unit addBackpack "UK3CB_CHC_C_B_HIKER";

		for "_i" from 1 to 12 do {_unit addItemToUniform "ACE_elasticBandage"};
		for "_i" from 1 to 6 do {_unit addItemToBackpack (_weapMagTypes select 0);};

	};

	default {
		//Default to just a normal insurgent
		_InsurgentUniform = parseSimpleArray grad_civs_loadout_clothes;
		_InsurgentUniform = _InsurgentUniform + (parseSimpleArray patrolOps_InsurgentUniforms);
		_unit forceAddUniform selectRandom _InsurgentUniform;

		[_unit, (selectrandom parseSimpleArray grad_civs_loadout_faces)] remoteExec ["setFace", 0];
		_unitHeadgear = (parseSimpleArray grad_civs_loadout_headgear) + (parseSimpleArray patrolOps_InsurgentHeadgear);
		_unit addHeadgear selectRandom _unitHeadgear;
		_unit addVest selectRandom (parseSimpleArray patrolOps_InsurgentVests);
		
		_unit addWeapon selectRandom (parseSimpleArray patrolOps_InsurgentRifles);
		_weapMagTypes = getArray (configFile >> "CfgWeapons" >> (primaryWeapon _unit) >> "magazines");
		_unit addPrimaryWeaponItem (_weapMagTypes select 0);
		_unit addItemToUniform "ACE_tourniquet";

		for "_i" from 1 to 12 do {_unit addItemToUniform "ACE_elasticBandage"};
		for "_i" from 1 to 6 do {_unit addItemToVest (_weapMagTypes select 0);};

		//This should give approx 9% of insurgents an RPG
		if ((floor random [0,10,0]) < 5) then {
			_unit addBackpack "rhs_rpg_empty";
			_unit addWeapon "rhs_weap_rpg7";
			for "_i" from 1 to 3 do {_unit addItemToBackpack "rhs_rpg7_PG7V_mag"};
		};
	};
};