if (!isServer) exitwith {};
// Debug on or off 
missionnamespace setvariable ["PATROLOPS_DEBUG", true];

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