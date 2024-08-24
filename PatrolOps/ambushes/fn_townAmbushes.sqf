/*
    Author: JD Wang

    Description:
    - Sets up ambushes based on mission difficulty at locations marked with "sideLocation".
    - Spawns insurgent squads to perform ambushes.
    - Adjusts the number of squads based on difficulty.

    Parameter(s):
    - NONE

    Returns:
    - Nothing

    Examples:
    [] call PatrolOps_fnc_townAmbushes
*/

if (!isServer) exitWith {}; // Ensure the script only runs on the server
private ["_possibleLocations", "_minEncounters", "_midEncounters", "_maxEncounters", "_numberOfAmbushes", "_selectedTown", "_townLocation"];
private _difficulty = missionNamespace getVariable ["patrolDifficulty", "MEDIUM"]; // Default value if not set

// Filter map markers for ambush locations
_possibleLocations = allMapMarkers select {_x find "sideLocation" >= 0};

_minEncounters = round ((count _possibleLocations) * 0.10);
_midEncounters = round ((count _possibleLocations) * 0.40);
_maxEncounters = round ((count _possibleLocations) * 0.75);

if (_minEncounters isEqualTo 0) then {_minEncounters = 1};
 
// Determine number of ambushes based on difficulty
switch (_difficulty) do {
    case "LOW": {_numberOfAmbushes = round (random [_minEncounters,_minEncounters,_midEncounters]);};
    case "MEDIUM": {_numberOfAmbushes = round (random [_minEncounters,_midEncounters,_maxEncounters]);};
    case "HIGH": {_numberOfAmbushes = round (random [_midEncounters,_maxEncounters,_maxEncounters]);};
};

_ambushTowns = [];

// Now spawn a static MG in overwatch 
for "_i" from 1 to _numberOfAmbushes do {

	_selectedTown = selectRandom _possibleLocations;
	_possibleLocations = _possibleLocations - [_selectedTown];
    _townLocation = getMarkerPos _selectedTown;
	[_townLocation] spawn PatrolOps_fnc_spawnStaticHMG;
    _ambushTowns pushback _selectedTown;

	// Debug marker for ambush location
    ["ambushTown", "mil_warning", _townLocation, "ColorRED", "AMBUSH", 1] call PatrolOps_fnc_debugMarkers;

    // And now spawn insurgents

};