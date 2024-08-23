/*
    Author: JD Wang (Revised)

    Description:
        Decides what type of IED to spawn and where along the route to spawn it. 
        This function now ensures that configuration of IEDs completes before spawning.

    Parameters:
        _locations - Array of location markers
        _numberOfIEDs - Number of IEDs to spawn

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
    _iedAndRoadType params ["_iedType", "_roadType"];

    private _info = _iedAndRoadType joinString "-";
    // DEBUG 
    ["Debug_IED", "KIA", _locationIED, "colorBLUE", _info, 0.5] call PatrolOps_fnc_debugMarkers;

    // Generate the IED here based off the type of road it's on 
    if (_roadType in ["MAIN ROAD", "ROAD", "a3\roads_f\roads_ae\data\surf_roadconcrete_city_road_ca.paa"]) then {
        // Spawn configuration function and wait for it to finish
        private _configHandle = [_iedType, _locationIED] spawn PatrolOps_fnc_configurePavedRoadIED;
        waitUntil {scriptDone _configHandle};
        
        // Now spawn the IED after configuration is complete
        [_iedType, _locationIED] call PatrolOps_fnc_spawnPavedRoadIED;

    } else {
        // Spawn configuration function and wait for it to finish
        private _configHandle = [_iedType, _locationIED] spawn PatrolOps_fnc_configureDirtRoadIED;
        waitUntil {scriptDone _configHandle};
        
        // Now spawn the IED after configuration is complete
        [_iedType, _locationIED] call PatrolOps_fnc_spawnDirtRoadIED;
    };
};