/*
    Author: JD Wang

    Description:
    - Sets up ambushes based on mission difficulty at locations marked with "Debug_IED".
    - Creates triggers and spawns insurgent squads to perform ambushes.
    - Adjusts the number of squads based on difficulty.

    Parameter(s):
    - NONE

    Returns:
    - Nothing

    Examples:
    [] call PatrolOps_fnc_iedAmbush
*/

if (!isServer) exitWith {}; // Ensure the script only runs on the server

private ["_possibleLocations", "_numberOfAmbushes", "_statement", "_selectedLocation"];
private _difficulty = missionNamespace getVariable ["patrolDifficulty", "MEDIUM"]; // Default value if not set

// Filter map markers for ambush locations
_possibleLocations = allMapMarkers select {_x find "Debug_IED" >= 0};

// Check if there are any possible locations
if (_possibleLocations isEqualTo []) exitWith {
    diag_log "No suitable locations for ambushes found.";
};

// Determine number of ambushes based on difficulty
switch (_difficulty) do {
    case "LOW": {_numberOfAmbushes = selectRandom [1,2]};
    case "MEDIUM": {_numberOfAmbushes = selectRandom [2,2,3]};
    case "HIGH": {_numberOfAmbushes = selectRandom [3,3,4]};
};

private _ambushLocations = [];
private _lastIndex = -1; // Initialize last index to an invalid value

for "_i" from 1 to _numberOfAmbushes do {
    if (_possibleLocations isEqualTo []) exitWith {
        diag_log "No more locations available for ambushes.";
    };
    
    _currentIndex = -1;
    _attempts = 0; // To prevent infinite loops
    _maxAttempts = 20; // Adjust as needed for max attempts
    
    while {_currentIndex == -1 && _attempts < _maxAttempts} do {
        _attempts = _attempts + 1;
        _randomIndex = floor random count _possibleLocations;
        
        // Check if the new index is not adjacent to the last one
        if (_randomIndex != _lastIndex && 
            (_randomIndex - 1 != _lastIndex || _randomIndex == 0) && 
            (_randomIndex + 1 != _lastIndex || _randomIndex == count _possibleLocations - 1)) then {
            _currentIndex = _randomIndex;
        };
    };
    
    // If we couldn't find a non-sequential location after many attempts, relax the condition
    if (_currentIndex == -1) then {
        _currentIndex = floor random count _possibleLocations;
        diag_log format ["Relaxed sequential condition for attempt %1", _i];
    };
    
    _selectedLocation = getMarkerPos (_possibleLocations select _currentIndex);
    _ambushLocations pushBack _selectedLocation;
    _possibleLocations deleteAt _currentIndex; // Remove the selected location from possibilities
    _lastIndex = _currentIndex; // Update the last selected index
};

// If after all attempts you still need more locations, you might want to adjust the logic or increase the number of possible locations
if (count _ambushLocations < _numberOfAmbushes) then {
    diag_log "Could not find enough locations for all ambushes even after relaxing sequential conditions.";
};

{
    // Create ambush trigger
    _ambushTrigger = createTrigger ["EmptyDetector", _x];
    _ambushTrigger setTriggerArea [50, 50, 0, false]; // 50m radius circular area
    _ambushTrigger setTriggerActivation ["WEST", "PRESENT", true]; // Triggers when WEST units are present
    _ambushTrigger setTriggerTimeout [3,10,7,false]; // Activation delay

    _squads = 1 + (floor (random 3)); // Random number of squads between 1 and 3

    // Dynamic squad creation
    _statement = format ["
        for '_i' from 1 to %1 do {
            _ambushGroup = createGroup east;
            _ambushSquad = [(random [4,6,8]), _ambushGroup, (thistrigger getRelPos [500, (random 360)])] call PatrolOps_fnc_createInsurgentSquad;
            _ambushSquad setVariable ['lambs_danger_dangerFormation', 'WEDGE'];
            [_ambushSquad, 750, 15, [], getpos thistrigger, true] spawn lambs_wp_fnc_taskRush;       
            _ambushSquad setSpeedMode 'FULL';
        };
    ", _squads];

    // Set the trigger statements
    _ambushTrigger setTriggerStatements ["this", _statement, ""];
    patrolOps_allTriggers pushback _ambushTrigger;

    // Debug marker for ambush location
    ["ambush", "mil_warning", _x, "ColorRED", "AMBUSH", 1] call PatrolOps_fnc_debugMarkers;
    
} forEach _ambushLocations;
