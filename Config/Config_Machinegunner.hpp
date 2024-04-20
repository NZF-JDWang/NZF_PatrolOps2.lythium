/*
	Faction: Machinegunner
	Author: Dom
*/
class machinegunner {
	name = "Machinegunner";
	rank = "Private";
	description = "The machinegunner role to to provide fire support for the rest of the squad";
	traits[] = {

	};
	customVariables[] = {
		{"command","false",true};
		{"role", "PJ", false};
		{"ACE_isEngineer", 2, true}
	};
	icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";

	defaultLoadout[] = {
		{"rhs_weap_m249_pip_ris","","","rhsusf_acc_ELCAN_ard",{"rhsusf_200rnd_556x45_mixed_box",200},{},"rhsusf_acc_saw_bipod"},{},
		{"rhsusf_weap_m9","","","",{"rhsusf_mag_15Rnd_9x19_JHP",15},{},""},
		{"rhs_uniform_cu_ocp",{{"ACE_CableTie",5},{"ACE_EarPlugs",1},{"nzf_headbag_inventory",1},{"ACRE_PRC343",1},{"ACE_microDAGR",1}}},
		{"rhsusf_iotv_ocp_SAW",{{"nzf_fak",1},{"rhsusf_mag_15Rnd_9x19_JHP",4,15},{"rhs_mag_an_m8hc",3,1},{"rhs_mag_m67",2,1}}},
		{"pmc_MysteryCL_mc",{{"rhsusf_ANPVS_14",1},{"rhsusf_200rnd_556x45_mixed_box",6,200}}},
		"rhsusf_ach_helmet_ESS_ocp","",{},
		{"ItemMap","","","ItemCompass","ATM_ALTIMETER",""}
	};

	arsenalWeapons[] = {
		"rhs_weap_m249_pip_ris",
		"rhs_weap_m249_light_L",
		"rhs_weap_m249_pip_L",
		"rhsusf_weap_m9"
	};
	arsenalMagazines[] = {
		"rhsusf_mag_15Rnd_9x19_JHP"
	};
	arsenalItems[] = {
		"rhsusf_acc_ELCAN",
		"rhsusf_acc_ELCAN_ard",
		"rhsusf_acc_ACOG_MDO"
	};
	arsenalBackpacks[] = {
		"rhsusf_iotv_ocp_SAW",
		"pmc_MysteryASAP_mc",
		"pmc_MysteryCL_mc"
	};
};