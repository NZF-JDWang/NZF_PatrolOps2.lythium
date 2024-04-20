/*
	Faction: Team Leader
	Author: Dom
*/
class teamlead {
	name = "Team Leader";
	rank = "Sergeant";
	description = "The Team Leader is responsible for running his fireteam. Often second in command";
	traits[] = {

	};
	customVariables[] = {
		{"command","false",true};
		{"role", "PJ", false};
		{"ACE_isEngineer", 2, true}
	};
	icon = "a3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa";

	defaultLoadout[] = {
		{"rhs_weap_m4a1","","rhsusf_acc_anpeq15side_bk","rhsusf_acc_ACOG_3d",{"rhs_mag_30Rnd_556x45_M855A1_Stanag",30},{},""},
		{},
		{},
		{"rhs_uniform_cu_ocp",{{"ACE_CableTie",5},{"ACE_EarPlugs",1},{"nzf_headbag_inventory",1},{"ACRE_PRC343",1},{"ACRE_PRC152",1},{"ACE_microDAGR",1}}},
		{"rhsusf_iotv_ocp_Teamleader",{{"nzf_fak",1},{"rhs_mag_30Rnd_556x45_M855A1_Stanag",4,30},{"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",3,30},{"rhs_mag_m67",2,1},{"rhs_mag_mk84",1,1},{"rhs_mag_an_m8hc",2,1}}},
		{"rhsusf_falconii_mc",{{"rhsusf_ANPVS_14",1},{"ACE_SpareBarrel",1,1},{"rhsusf_m112_mag",1,1},{"rhs_mag_m18_yellow",1,1},{"rhs_mag_m18_red",1,1},{"rhs_mag_m18_green",1,1}}},
		"rhsusf_ach_helmet_headset_ocp","",{"rhsusf_bino_m24_ARD"},
		{"ItemMap","","","ItemCompass","ATM_ALTIMETER",""}
	};

	arsenalWeapons[] = {
		"rhs_weap_m4a1",
		"rhs_weap_m4a1_mstock"
	};
	arsenalMagazines[] = {
		
	};
	arsenalItems[] = {
		"rhsusf_bino_m24_ARD",
		"rhsusf_acc_ACOG",
		"rhsusf_acc_ACOG2",
		"rhsusf_acc_ACOG3",
		"rhsusf_acc_eotech_552",
		"rhsusf_acc_compm4",
		"rhsusf_acc_eotech_xps3",
		"rhsusf_acc_T1_high"
	};
	arsenalBackpacks[] = {
		"rhsusf_iotv_ocp_Teamleader",
		"rhsusf_falconii_mc"
	};
};