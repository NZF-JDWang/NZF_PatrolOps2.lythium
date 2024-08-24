/*
    Author: JD Wang (Revised)

    Description:
        Decides what type of IED to spawn and where along the route to spawn it. 
        This function now ensures that configuration of IEDs completes before spawning and includes error handling.

    Parameters:
        _locations - Array of location markers
        _numberOfIEDs - Number of IEDs to spawn

    Returns:
        Nothing

    Examples:
        [] call PatrolOps_fnc_processIEDLocations;
*/

params [
    ["_locations", [], [[]]],
    ["_numberOfIEDs", 0, [0]]
];

// Exit if no IEDs to spawn or no locations provided
if (_numberOfIEDs == 0 || {count _locations == 0}) exitWith {
    diag_log "No IEDs to spawn or no locations provided.";
};

private _repeat = count _locations;
// Work out the spacing
private _spacing = round (_repeat / _numberOfIEDs);

for "_i" from 0 to _repeat step _spacing do {
    // Check if the index is within bounds
    if (_i >= count _locations) exitWith {
        diag_log format ["Index out of bounds for locations array at iteration %1", _i];
    };

    // Get next location
    private _locationIED = getMarkerPos (_locations select _i);
    
    // Check if the marker exists
    if (_locationIED isEqualTo [0,0,0]) then {
        diag_log format ["Marker %1 does not exist or is not positioned.", _locations select _i];
        continue;
    };

    // Get the type of IED to spawn 
    private _iedAndRoadType = [_locationIED] call patrolOps_fnc_selectIEDtype;

    // Error handling for _iedAndRoadType
    if (isNil "_iedAndRoadType" || {count _iedAndRoadType != 2}) then {
        diag_log format ["Error: Invalid IED type or road type at location %1", _locationIED];
        continue;
    };

    _iedAndRoadType params  ["_iedType", "_roadtype"];

    private _info = _iedAndRoadType joinString "-";
    // DEBUG 
    ["Debug_IED", "KIA", _locationIED, "colorBLUE", _info, 0.5, format ["Iteration: %1", _i]] call PatrolOps_fnc_debugMarkers;

    // Generate the IED here based off the type of road it's on 
    if (_roadtype in ["MAIN ROAD", "ROAD", "a3\roads_f\roads_ae\data\surf_roadconcrete_city_road_ca.paa"]) then {

        // Spawn configuration function and wait for it to finish
        private _configHandle = [_iedType, _locationIED] spawn PatrolOps_fnc_configurePavedRoadIED;
        waitUntil {scriptDone _configHandle};
        [_iedType, _locationIED] call PatrolOps_fnc_spawnPavedRoadIED;

    } else {

        // Spawn configuration function and wait for it to finish
        private _configHandle = [_iedType, _locationIED] spawn PatrolOps_fnc_configureDirtRoadIED;
        waitUntil {scriptDone _configHandle};
        [_iedType, _locationIED] call PatrolOps_fnc_spawnDirtRoadIED;
    };
};