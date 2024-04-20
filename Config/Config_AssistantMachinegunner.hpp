/*
	Faction: Assistant Machinegunner
	Author: Dom
*/
class assistantMachinegunner {
	name = "Assistant Machinegunner";
	rank = "Private";
	description = "Carry extra ammo, spot for and support the squads machinegunner";
	traits[] = {

	};
	customVariables[] = {
		{"command","false",true};
		{"role", "PJ", false};
		{"ACE_isEngineer", 2, true}
	};
	icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";

	defaultLoadout[] = {
		{"rhs_weap_m4a1","","rhsusf_acc_anpeq15side_bk","rhsusf_acc_eotech_552",{"rhs_mag_30Rnd_556x45_M855A1_Stanag",30},{},""},
		{},
		{},
		{"rhs_uniform_cu_ocp",{{"ACE_CableTie",5},{"ACE_EarPlugs",1},{"nzf_headbag_inventory",1},{"ACRE_PRC343",1},{"ACE_microDAGR",1}}},
		{"rhsusf_iotv_ocp_Rifleman",{{"nzf_fak",1},{"rhs_mag_30Rnd_556x45_M855A1_Stanag",4,30},{"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",3,30},{"rhs_mag_m67",1,1},{"rhs_mag_mk84",1,1},{"rhs_mag_an_m8hc",2,1}}},
		{"pmc_MysteryASAP_mc",{{"rhsusf_ANPVS_14",1},{"rhsusf_200rnd_556x45_mixed_box",5,200},{"ACE_SpareBarrel",1,1},{"ACE_EntrenchingTool",1}}},
		"rhsusf_ach_helmet_ocp","",{"rhsusf_bino_m24_ARD"},
		{"ItemMap","","","ItemCompass","ATM_ALTIMETER",""}
	};

	arsenalWeapons[] = {
		"rhs_weap_m4a1",
		"rhs_weap_m4a1_mstock",
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
		"rhsusf_acc_T1_high",
		"ACE_SpareBarrel"
	};
	arsenalBackpacks[] = {
		"rhsusf_iotv_ocp_Rifleman",
		"pmc_MysteryASAP_mc",
		"pmc_MysteryCL_mc"
	};
};