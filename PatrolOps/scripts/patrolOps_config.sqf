if (!isServer) exitwith {};

//Get base locations
patrolOps_patrolBases = allMapMarkers select {_x find "patrolBase" >= 0};
//Hide all FOB Markers 
{_x setMarkerAlpha 0} foreach patrolOps_patrolBases;

//Setup all the global variables
missionnamespace setvariable ["firstPatrolLocationData", nil, true];
missionnamespace setVariable ["RDFOpen", false, true];
missionnamespace setvariable ["patrolOps_NZFCasualties", 0, true];
missionnamespace setvariable ["patrolOps_allRouteMarkers", nil, true];