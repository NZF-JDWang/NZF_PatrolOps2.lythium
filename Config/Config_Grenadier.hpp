/*
	Faction: Grenadier
	Author: Dom
*/
class Genadier {
	name = "Grenadier";
	rank = "Private";
	description = "Squads Grenadier... foomp!";
	traits[] = {

	};
	customVariables[] = {
		{"command","false",true};
		{"role", "PJ", false};
		{"ACE_isEngineer", 2, true}
	};
	icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";

	defaultLoadout[] = {
		{"rhs_weap_m4a1_m203","","rhsusf_acc_anpeq15side_bk","rhsusf_acc_ACOG",{"rhs_mag_30Rnd_556x45_M855A1_Stanag",30},{},""},
		{},
		{},
		{"rhs_uniform_cu_ocp",{{"ACE_CableTie",5},{"ACE_EarPlugs",1},{"nzf_headbag_inventory",1},{"ACRE_PRC343",1},{"ACE_microDAGR",1}}},
		{"rhsusf_iotv_ocp_Grenadier",{{"nzf_fak",1},{"rhs_mag_m67",1,1},{"rhs_mag_mk84",1,1},{"rhs_mag_an_m8hc",2,1},{"rhs_mag_30Rnd_556x45_M855A1_Stanag",4,30},{"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",3,30}}},
		{"rhsusf_falconii_mc",{{"rhsusf_ANPVS_14",1},{"rhs_mag_M433_HEDP",15,1},{"rhs_mag_m713_Red",5,1},{"rhs_mag_m714_White",5,1}}},
		"rhsusf_ach_helmet_ocp","",{},
		{"ItemMap","","","ItemCompass","ATM_ALTIMETER",""}
	};

	arsenalWeapons[] = {
		"rhs_weap_m4a1_m203",
		"rhs_weap_m4a1_m203s",
		"rhs_weap_M136",
		"rhs_weap_M136_hedp",
		"rhs_weap_M136_hp",
		"rhs_weap_m72a7"
	};
	arsenalMagazines[] = {
		
	};
	arsenalItems[] = {
		"rhsusf_acc_ACOG",
		"rhsusf_acc_ACOG2",
		"rhsusf_acc_ACOG3",
		"rhsusf_acc_eotech_552",
		"rhsusf_acc_compm4",
		"rhsusf_acc_eotech_xps3",
		"rhsusf_acc_T1_high"
	};
	arsenalBackpacks[] = {
		"rhsusf_iotv_ocp_Grenadier",
		"rhsusf_falconii_mc"
	};
};