if (!isServer) exitwith {};
// Debug on or off 
missionnamespace setvariable ["PATROLOPS_DEBUG", true];
missionnamespace setvariable ["regenerating", false];

patrolOps_patrolBases = allMapMarkers select {_x find "patrolBase" >= 0};

//Setup all the global variables
missionnamespace setvariable ["secondPatrol", false, true];
missionnamespace setvariable ["firstPatrolLocationData", nil, true];
missionNamespace setVariable ["endFOB", nil, true];
missionnamespace setVariable ["RDFOpen", false, true];
missionnamespace setvariable ["patrolOps_NZFCasualties", 0, true];
missionnamespace setvariable ["patrolOps_allRouteMarkers", nil, true];
missionnamespace setvariable ["patrolLength", nil, true];

patrolOps_playerEDOVehicles = [];
patrolOps_playerInfantryVehicles = [];
patrolOps_miscCleanUp = [];
patrolOps_Garrisons = [];

patrolOpsBadBuildings = [
"Land_Metal_Shed_F","Land_Jbad_Cargo1_int","Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_i_Garage_V1_F","Land_i_Garage_V2_F", "Land_FuelStation_Shed_F", "Land_Jbad_Ind_Garage01","Land_jbad_house_8_old_ruins", "jbad_house_1_old_ruins","jbad_house_3_old_ruins","jbad_house_4_old_ruins","jbad_house_6_old_ruins","jbad_house_7_old_ruins","jbad_house_9_old_ruins","jbad_house2_basehide_ruins","jbad_house3_ruins","jbad_house5_ruins","jbad_house6_ruins","jbad_house7_ruins","jbad_house8_ruins", "Jbad_Cargo1_int","Jbad_Cargo2_int","Jbad_Cargo3_int","Jbad_Cargo4_int","Jbad_Cargo6_int","Jbad_Cargo7_int"
];