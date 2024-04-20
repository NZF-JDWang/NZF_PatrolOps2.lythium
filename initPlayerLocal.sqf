//Initialize player groups (U - menu) 
["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups; 

_diaryEntries = ["Diary","Units","Players","cba_help_docs"];
{player removeDiarySubject _x} foreach _diaryEntries;

//Whitelist PJ's (Use steam UID)
private _PJs = [
                "76561198060533591", //Old Mate 
                "76561198089268255", //Kev
                "76561198215981868", //Mitchell
				"76561198113862876"  //Fox
                ];

//Check PJ slots 
if ((player getvariable "role" isEqualTo "PJ") AND (getPlayerUID player in _PJs isEqualTo false)) then {endMission "NOT_PJ";};

//Make sure players come into the mission with only what we have the set as in the editor
private _defaultUniform = selectRandom [
	"rhs_uniform_cu_ocp"
];

player forceAddUniform _defaultUniform; removeGoggles player;
[player, ""] call BIS_fnc_setUnitInsignia;
//Now check if they're in the Unit and if so give them a NZF beret
removeHeadgear player;
if (squadParams player select 0 select 0 == "NZF") then {player addHeadgear "nzf_beret_black_silver"} else {player addHeadgear ""};
if (player in _PJs) then {removeHeadgear player; player addHeadgear "nzf_beret_PJ"};

//*************************************************************************************
//EventHandlers for respawn
params ["_unit"];

_unit addEventHandler ["Killed", {
    params ["_unit"];
    Mission_loadout = [getUnitLoadout _unit] call acre_api_fnc_filterUnitLoadout;
	_deaths = missionNamespace getvariable "patrolOps_NZFCasualties";
	_deaths = _deaths + 1; 
	missionnamespace setvariable ["patrolOps_NZFCasualties", _deaths, true];
}];

_unit addEventHandler ["Respawn", {
    params ["_unit"];
    if (!isNil "Mission_loadout") then {_unit setUnitLoadout Mission_loadout;};
    [_unit, ""] call BIS_fnc_setUnitInsignia;
	_unit setVariable ["Joined", false, true];
	[grad_gpsTracker_fnc_closeTitle,[],0] call CBA_fnc_waitAndExecute;
}];

//Only allow PJ's to access blood crates
Fn_IsRestrictedBoxForPlayerAccess = { 
	params ["_unt", "_box"]; 
    !(player getvariable "role" == "PJ") && typeOf _box == "nzf_NZBloodbox";
    };

player addEventHandler ["InventoryOpened", Fn_IsRestrictedBoxForPlayerAccess];

player setVariable ["command", false, true];
player setVariable ["Joined", true, true];

[player] call PatrolOps_fnc_unconscious;
//*************************************************************************************
//Add ACE interaction to dig up IEDs
_action = ["digIED","Dig For IED","",{_player remoteExec ["PatrolOps_fnc_dig",0,true];},{"ACE_EntrenchingTool" in (items _player)},{},[],[],0.5] call ace_interact_menu_fnc_createAction;   
["Sign_Sphere10cm_F", 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

//Group Menu
//*************************************************************************************
/*
	File: initPlayerLocal.sqf
	Author: Dom
	Requires: Start us up
*/

DT_isACEEnabled = isClass (configFile >> "CfgPatches" >> "ace_common");
DT_arsenalBoxes = [arsenal_1,arsenal_2,arsenal_3,arsenal_4,arsenal_5,arsenal_6,arsenal_7];

player addEventHandler ["Respawn",DT_fnc_onRespawn];

if (DT_isACEEnabled) then {
	private _groupCategory = [
		"groupCategory",
		"Group Menu",
		"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\meet_ca.paa",
		{[] call DT_fnc_initGroupMenu},
		{
			isNull objectParent player &&
			{(DT_arsenalBoxes findIf {(player distance _x) < 50}) isNotEqualTo -1}
		}
	] call ace_interact_menu_fnc_createAction;
	[player,1,["ACE_SelfActions"],_groupCategory] call ace_interact_menu_fnc_addActionToObject;

	private _arsenalCategory = [
		"arsenalCategory",
		"Arsenal",
		"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\armor_ca.paa",
		{[player,player,false] call ace_arsenal_fnc_openBox},
		{
			isNull objectParent player &&
			{player getVariable ["ace_arsenal_virtualItems",[]] isNotEqualTo [] && 
			{(DT_arsenalBoxes findIf {(player distance _x) < 50}) isNotEqualTo -1}}
		}
	] call ace_interact_menu_fnc_createAction;
	[player,1,["ACE_SelfActions"],_arsenalCategory] call ace_interact_menu_fnc_addActionToObject;

	["ace_arsenal_displayClosed",{
		DT_savedLoadout = getUnitLoadout player;
	}] call CBA_fnc_addEventHandler;
} else {
	{
		_x addAction ["Open Group Menu",DT_fnc_initGroupMenu];
	} forEach DT_arsenalBoxes;

	[missionNamespace,"arsenalClosed",{
		DT_savedLoadout = getUnitLoadout player;
	}] call BIS_fnc_addScriptedEventHandler;
};

//*************************************************************************************
//ACE interactions for tracking device
_conditionCanOpen = {
    ("UMI_Land_Tablet_F" in items player) && (!(missionnamespace getVariable "RDFOpen"));
};
_statement1 = {
    missionnamespace setVariable ["RDFOpen", true]; [HVT,0.5,1,1.2,1,{params ["_unit","_target","_updateInterval"];private _reception = 1 - (_unit distance2D _target)/200;_reception}] call grad_gpsTracker_fnc_openTitle;

};
_action1 = ["OpenTracker","Open Tracker","",_statement1,_conditionCanOpen] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action1] call ace_interact_menu_fnc_addActionToObject;

_conditionAlreadyOpen = {
   ("UMI_Land_Tablet_F" in items player) && (missionnamespace getVariable "RDFOpen");
};
_statement2 = {
    missionnamespace setVariable ["RDFOpen", false]; [grad_gpsTracker_fnc_closeTitle,[],0] call CBA_fnc_waitAndExecute;
};
_action2 = ["CloseTracker","Close Tracker","",_statement2,_conditionAlreadyOpen] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action2] call ace_interact_menu_fnc_addActionToObject;