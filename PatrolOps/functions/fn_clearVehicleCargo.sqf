/*
	Author: JD Wang

	Description:
		Empties the vehicle cargo

	Parameter(s):
		0: Vehicle   <OBJECT>

	Returns:
		Nothing

	Examples:
		[vehicle] call PatrolOps_fnc_playerVehicleSpawn;
*/

params ["_vehicle"];

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;