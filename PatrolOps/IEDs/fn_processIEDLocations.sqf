 /*
	Author: JD Wang

	Description:
		Decided what type of IED to spawn and where along the route to spawn it 

	Parameter(s):
		NONE

	Returns:
		Nothing

	Examples:
		[] call PatrolOps_fnc_processIEDLocations;
*/
 
params ["_locations", "_numberOfIEDs"];
private ["_locationIED"];

private _repeat = count _locations;
// Work out the spacing
private _spacing = round (_repeat / _numberOfIEDs);

for "_i" from 0 to _repeat step _spacing do {
    // Get next location
    _locationIED = getMarkerPos (_locations select _i);
    // Get the type of IED to spawn 
    private _iedAndRoadType = [_locationIED] call patrolOps_fnc_selectIEDtype;
    _iedAndRoadType params  ["_iedType", "_roadtype"];

    private _info = _iedAndRoadType joinString "-";
    // DEBUG 
    ["Debug_IED", "KIA", _locationIED, "colorBLUE", _info, 0.5] call PatrolOps_fnc_debugMarkers;

    // Generate the IED here based off the type of road it's on 
    if (_roadtype isEqualTo "MAIN ROAD" || _roadtype isEqualTo "ROAD" || _roadtype isEqualTo "a3\roads_f\roads_ae\data\surf_roadconcrete_city_road_ca.paa") then {

        [_iedType, _locationIED] call PatrolOps_fnc_configurePavedRoadIED;
        [_iedType, _locationIED] call PatrolOps_fnc_spawnPavedRoadIED;

    } else {

        [_iedType, _locationIED] call PatrolOps_fnc_configureDirtRoadIED;
        [_iedType, _locationIED] call PatrolOps_fnc_spawnDirtRoadIED;

    };
};

 