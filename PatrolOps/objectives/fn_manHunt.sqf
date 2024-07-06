/*
	Author: JD Wang

	Description:
		Generates the ManHunt Objective 

	Parameter(s):
		0: Name <STRING>
		1: Position <ARRAY>

	Returns:
		Nothing

	Examples:
		[_locationName, _locationData] spawn PatrolOps_fnc_manHunt; 
*/

params ["_locationName","_locationData"];
private _locPosition = _locationData select 0;
private ["_marker", "_target","_groupTarget","_targetHome","_targetDescription","_nextBuilding"];
//Add objective Marker 
["loc_meet",(_locPosition)] call PatrolOps_fnc_createObjectiveMarker;

//find targets home 
_targetHome = [_locationData] call PatrolOps_fnc_findRandomBuilding;

//create Target Unit to be hunted 
_groupTarget = createGroup east;
_target = _groupTarget createUnit ["O_Soldier_unarmed_F", _targetHome, [], 0, "FORM"];
_target disableAI "AUTOCOMBAT";
_target disableAI "AUTOTARGET";
_target disableAI "TARGET";
_target setBehaviour "SAFE";
_target setVariable ["lambs_danger_disableAI", true];
[_target, "civ"] call PatrolOps_fnc_unitRedress;

//make sure unit has some facewear for easy ID 
private _civFacewear = ((parseSimpleArray grad_civs_loadout_goggles) select { _x != "" });
removeGoggles _target;
_target addGoggles selectRandom _civFacewear;
	
// Handle surrendering and handcuffing
["ace_captiveStatusChanged", {
    params ["_unit", "_state"];
	if (_state && alive _unit) then {
		[{call BIS_fnc_showNotification},["TaskSucceeded", ["", "HVT Captured"]],3] call CBA_fnc_waitAndExecute;
	};	
				
}] call CBA_fnc_addEventHandler;

//give him some suspicious items in his Inventory

private _items = ["ACRE_BF888S","UMI_Land_Camera_F","UMI_Land_MobilePhone_Old_F","UMI_Money","UMI_Land_MobilePhone_Old_F","UMI_Money"];
_target addItemToUniform selectRandom _items;

//Work out details for the description 
//first get his name
private _targetName = name _target;
//now what he's wearing
private _glasses = ["Bear_RoundGlasses","Bear_RoundGlasses_blk","Bear_RoundGlasses_gold","G_Spectacles","G_Spectacles_Tinted","G_Squares"];
private _smokes = ["murshun_cigs_cig0"];
private _beard = ["USP_BEARD_CH_CP_BLK","USP_BEARD_CH_CP_BLK5","USP_BEARD_CH_CP_BRN","USP_BEARD_CH_CP_BRN8","USP_BEARD_CH_CP_GRY","USP_BEARD2_CH_CP_BLK","USP_BEARD2_CH_CP_BLK5","USP_BEARD2_CH_CP_BRN","USP_BEARD2_CH_CP_BRN8"];
private _headgear = ["headwrap_b_2_1","headwrap_b_2_2","headwrap_b_2_3","bcap_b_4","bcap_b_5","turban_b_2_1","turban_b_2_2","turban_b_2_3","turban_b_2_4","turban_b_2_5","turban_b_2_6","turban_b_2_7"];


//now use those deatils to but a string containing the description
private _features = " unfortunately we have no real description of what he's wearing at this time";
private _description = false;

private _featuresGlasses = "";
private _featuresSmokes = "";
private _featuresBeard = "";

if ((goggles _target) in _glasses) then {_featuresGlasses = " wears glasses"; _description = true};
if ((goggles _target) in _smokes) then {_featuresSmokes = " is known to smoke"; _description = true};
if (((goggles _target) in _beard) OR ((headgear _target) in _headgear)) then {_featuresBeard = " was last seen with a full beard"; _description = true};

if (_description) then {
	_targetDescription = format ["You are looking for a man in %1 named %2"+ endl +" "+ endl +"%2%3%4%5, and is know to be working closely with the insurgents",_locationName,_targetName,_featuresGlasses,_featuresSmokes,_featuresBeard];
} else {
	_targetDescription = format ["You are looking for a man in %1 named %2%3, but he is known to be working closely with the insurgents",_locationName,_targetName,_features];
};
//save the description and the unit to a global variable so we can access it everywhere
missionnamespace setvariable ["HVT", _target, true];
missionnamespace setvariable ["targetName", _targetName, true];
missionnamespace setvariable ["targetFeatures", _targetDescription, true];

//now find random houses in the AO and make him move there
while {alive _target} do {
	// give him a random chance of returning home
	if (random 10 >= 2 ) then {
		_nextBuilding = _targetHome
		} else {
		_nextBuilding = [_locationData] call PatrolOps_fnc_findRandomBuilding;
		};	

	_target doMove _nextBuilding;
	_groupTarget setSpeedMode "LIMITED";
	_time = time;
	waitUntil {moveToCompleted _target || time - _time > 180};

	sleep (random [30,60,120]); 
};