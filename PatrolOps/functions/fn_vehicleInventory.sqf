/*
	Author: JD Wang

	Description:
		Clear vehicle inventory and loads a better loadout

	Parameter(s):
		0: Vehicle   		<OBJECT>
		1: Type of vehicle 	<CLASSNAME>

	Returns:
		Nothing

	Examples:
		[_veh,_type] call PatrolOps_fnc_playerVehicleSpawn;
*/

params ["_veh","_type"];

//clear Inventory 
[_veh] call PatrolOps_fnc_clearVehicleCargo;

//Set ACE cargo and fill with 4 wheels
[_veh, 4] call ace_cargo_fnc_setSpace;

for "_i" from 1 to 4 do { 
	["ACE_Wheel", _veh] call ace_cargo_fnc_loadItem;
};

//Fill inventory based on vehicle type
switch (_type) do {

	case "EOD" : {
		_veh addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag",10];
		_veh addMagazineCargoGlobal ["rhsusf_m112x4_mag",10];
		_veh addItemCargoGlobal ["ACE_EarPlugs",2];
		_veh addItemCargoGlobal ["iedd_item_notebook",2];
		_veh addItemCargoGlobal ["ACE_DefusalKit",2];
		_veh addItemCargoGlobal ["ACE_EntrenchingTool",2];
		_veh addItemCargoGlobal ["nzf_fak",2];
		_veh addItemCargoGlobal ["ACRE_PRC343",2];
		_veh addItemCargoGlobal ["ToolKit",1];
		_veh addItemCargoGlobal ["ACE_SpraypaintGreen",1];
	};

	case "Infantry" : {
		_veh addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag",10];
		_veh addMagazineCargoGlobal ["rhsusf_200rnd_556x45_mixed_box",2];
		_veh addMagazineCargoGlobal ["rhs_mag_M433_HEDP",8];
		_veh addItemCargoGlobal ["ACE_EarPlugs",2];
		_veh addItemCargoGlobal ["nzf_fak",2];
		_veh addItemCargoGlobal ["ACRE_PRC343",1];
		_veh addItemCargoGlobal ["ToolKit",1];
		_veh addWeaponCargoGlobal ["rhs_weap_M136",1];
		_veh addWeaponCargoGlobal ["ACE_salineIV_500",5];
	};

};
