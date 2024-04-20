/*
	Faction: Medic
	Author: Dom
*/
class medic {
	name = "Medic";
	rank = "Corporal";
	description = "It's your job to keep the squad alive";
	traits[] = {
		{"Medic",true}
	};
	customVariables[] = {
		{"command","false",true};
		{"ace_medical_medicClass",2,true};
		{"role", "PJ", true};
		{"ACE_isEngineer", 2, true}
	};
	icon = "a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa";

	defaultLoadout[] = {
		{"rhs_weap_m4a1","","rhsusf_acc_anpeq15side_bk","rhsusf_acc_eotech_552",{"rhs_mag_30Rnd_556x45_M855A1_Stanag",30},{},""},
		{},
		{},
		{"rhs_uniform_cu_ocp",{{"ACE_CableTie",5},{"ACE_EarPlugs",1},{"nzf_headbag_inventory",1},{"ACRE_PRC343",1},{"ACE_microDAGR",1}}},
		{"rhsusf_iotv_ocp_Medic",{{"rhs_mag_30Rnd_556x45_M855A1_Stanag",4,30},{"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",3,30},{"rhs_mag_an_m8hc",5,1}}},
		{"nsw_walk",{{"nzf_medikit",1},{"vtx_stretcher_item",1},{"rhsusf_ANPVS_14",1}}},
		"rhsusf_ach_helmet_ocp","rhs_googles_clear",{},
		{"ItemMap","","","ItemCompass","ATM_ALTIMETER",""}
	};

	arsenalWeapons[] = {

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
		"nzf_Medikit",
		"ACE_elasticBandage",
		"ACE_packingBandage",
		"ACE_quikclot",
		"ACE_morphine",
		"ACE_adenosine",
		"ACE_epinephrine",
		"kat_norepinephrine",
		"kat_nitroglycerin",
		"kat_phenylephrine",
		"kat_PainkillerItem",
		"kat_CarbonateItem",
		"kat_TXA",
		"kat_fentanyl",
		"kat_amiodarone",
		"kat_atropine",
		"kat_naloxone",
		"kat_aatKit",
		"kat_ncdKit",
		"kat_chestSeal",
		"kat_guedel",
		"kat_larynx",
		"KAT_Empty_bloodIV_250",
		"KAT_Empty_bloodIV_500",
		"ACE_surgicalKit",
		"kat_IV_16",
		"kat_IO_FAST",
		"kat_AED",
		"kat_X_AED",
		"kat_stethoscope",
		"kat_accuvac",
		"kat_BVM",
		"kat_Pulseoximeter",
		"vtx_stretcher_item",
		"ACE_suture"
	};
	arsenalBackpacks[] = {
		"rhsusf_iotv_ocp_Medic",
		"nsw_rats",
		"nsw_walk"
	};
};