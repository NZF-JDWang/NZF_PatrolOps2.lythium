if (!isServer) exitwith {};
//Get base locations
patrolOps_patrolBases = allMapMarkers select {_x find "patrolBase" >= 0};

//Setup all the global variables
missionnamespace setvariable ["firstPatrolLocationData", nil];
missionnamespace setVariable ["RDFOpen", false];
missionnamespace setvariable ["patrolOps_NZFCasualties", 0];
missionnamespace setvariable ["patrolOps_allRouteMarkers", nil];