/*
	Faction: EOD
	Author: Dom
*/
class eod {
	name = "EOD Specialist";
	rank = "Corporal";
	description = "Explosives Ordinance Disposal Expert - You make things go boom, some times even on purpose";
	traits[] = {
		{"ExplosiveSpecialist",true};
	};
	customVariables[] = {
		{"command","false",true};
		{"ACE_isEngineer", 2, true};
		{"role", "PJ", false}
	};
	icon = "a3\ui_f\data\map\vehicleicons\iconManExplosive_ca.paa";

	defaultLoadout[] = {
		{"rhs_weap_m4a1","","rhsusf_acc_anpeq15side_bk","rhsusf_acc_eotech_552",{"rhs_mag_30Rnd_556x45_M855A1_Stanag",30},{},""},
		{},
		{"ACE_VMM3","","","",{},{},""},
		{"rhs_uniform_cu_ocp",{{"ACE_CableTie",5},{"ACE_EarPlugs",1},{"ACE_SpraypaintRed",1},{"iedd_item_notebook",1},{"ACRE_PRC343",1},{"ACE_microDAGR",1}}},
		{"rhsusf_iotv_ocp_Repair",{{"nzf_fak",1},{"rhs_mag_30Rnd_556x45_M855A1_Stanag",4,30},{"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",3,30},{"rhs_mag_m67",1,1},{"rhs_mag_mk84",1,1},{"rhs_mag_an_m8hc",2,1}}},
		{"rhsusf_falconii_mc",{{"rhsusf_ANPVS_14",1},{"ACE_DefusalKit",1},{"ACE_Clacker",1},{"ACE_EntrenchingTool",1},{"rhsusf_m112x4_mag",1,1},{"rhsusf_m112_mag",5,1}}},
		"rhsusf_ach_helmet_ocp","rhsusf_oakley_goggles_clr",{},
		{"ItemMap","","","ItemCompass","ATM_ALTIMETER",""}
	};

	arsenalWeapons[] = {
		"rhs_weap_m4a1",
		"rhs_weap_m4a1_mstock",
		"ACE_VMM3"
	};
	arsenalMagazines[] = {	
		"rhsusf_m112_mag",
		"rhsusf_m112x4_mag"
	};
	arsenalItems[] = {
		"rhsusf_acc_ACOG",
		"rhsusf_acc_ACOG2",
		"rhsusf_acc_ACOG3",
		"rhsusf_acc_eotech_552",
		"rhsusf_acc_compm4",
		"rhsusf_acc_eotech_xps3",
		"rhsusf_acc_T1_high",
		"ACE_DefusalKit",
		"ACE_Clacker",
		"ACE_M26_Clacker",
		"iedd_item_notebook"
	};
	arsenalBackpacks[] = {
		"rhsusf_iotv_ocp_Repair",
		"rhsusf_falconii_mc"
	};
};



