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
private ["_possibleLocations", "_minEncounters", "_midEncounters", "_maxEncounters", "_numberOfAmbushes", "_ambushTowns", "_selectedTown"];
private _difficulty = missionNamespace getVariable ["patrolDifficulty", "MEDIUM"]; // Default value if not set

// Filter map markers for ambush locations
_possibleLocations = allMapMarkers select {_x find "sideLocation" >= 0};

// Check if there are any possible locations
if (_possibleLocations isEqualTo []) exitWith {
    diag_log "No suitable locations for ambushes found.";
};
_minEncounters = round ((count _possibleLocations) * 0.10);
_midEncounters = round ((count _possibleLocations) * 0.40);
_maxEncounters = round ((count _possibleLocations) * 0.75);
 
// Determine number of ambushes based on difficulty
switch (_difficulty) do {
    case "LOW": {_numberOfAmbushes = round (random [_minEncounters,_minEncounters,_midEncounters]);};
    case "MEDIUM": {_numberOfAmbushes = round (random [_minEncounters,_midEncounters,_maxEncounters]);};
    case "HIGH": {_numberOfAmbushes = round (random [_midEncounters,_maxEncounters,_maxEncounters]);};
};

missionNamespace setVariable ["TownAmbushes",_numberOfAmbushes, true];
_ambushTowns = [];

for "_i" from 1 to _numberOfAmbushes do {
	_selectedTown = selectRandom _possibleLocations;
	_possibleLocations = _possibleLocations - [_selectedTown];
	_ambushTowns pushBack _selectedTown;

	// Debug marker for ambush location
    ["ambushTown", "mil_warning", getmarkerPos _selectedTown, "ColorRED", "AMBUSH", 1] call PatrolOps_fnc_debugMarkers;
};