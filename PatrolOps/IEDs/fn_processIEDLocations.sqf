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

if (_numberOfIEDs <= 0 || {count _locations == 0}) exitWith {
    systemChat "Error: Invalid parameters for IED placement.";
};

private _repeat = count _locations;
private _spacing = round (_repeat / _numberOfIEDs);

for "_i" from 0 to _repeat step _spacing do {
    // Check if index is within bounds
    if (_i >= count _locations) exitWith {
        systemChat format ["Warning: Reached end of locations array at index %1.", _i];
    };

    private _locationMarker = _locations select _i;
    private _locationIED = getMarkerPos _locationMarker;

    // Check if the marker exists and has a valid position
    if (isNil "_locationIED" || {count _locationIED != 3}) then {
        systemChat format ["Error: Invalid marker position for %1.", _locationMarker];
        continue;
    };

    // Get the type of IED to spawn 
    private _iedAndRoadType = [_locationIED] call patrolOps_fnc_selectIEDtype;
    if (count _iedAndRoadType != 2) then {
        systemChat format ["Error: Invalid return from selectIEDtype for marker %1.", _locationMarker];
        continue;
    };

    _iedAndRoadType params ["_iedType", "_roadType"];

    private _info = _iedAndRoadType joinString "-";
    // DEBUG 
    ["Debug_IED", "KIA", _locationIED, "colorBLUE", _info, 0.5] call PatrolOps_fnc_debugMarkers;

    // Generate the IED based on road type
    private _configFunction = {
        if (_roadType in ["MAIN ROAD", "ROAD", "a3\roads_f\roads_ae\data\surf_roadconcrete_city_road_ca.paa"]) then {
            [_iedType, _locationIED] spawn PatrolOps_fnc_configurePavedRoadIED;
        } else {
            [_iedType, _locationIED] spawn PatrolOps_fnc_configureDirtRoadIED;
        };
    };

    private _spawnFunction = {
        if (_roadType in ["MAIN ROAD", "ROAD", "a3\roads_f\roads_ae\data\surf_roadconcrete_city_road_ca.paa"]) then {
            [_iedType, _locationIED] call PatrolOps_fnc_spawnPavedRoadIED;
        } else {
            [_iedType, _locationIED] call PatrolOps_fnc_spawnDirtRoadIED;
        };
    };

    // Spawn configuration and wait for it to finish
    private _configHandle = call _configFunction;
    waitUntil {scriptDone _configHandle};

    // Spawn IED after configuration
    call _spawnFunction;
};