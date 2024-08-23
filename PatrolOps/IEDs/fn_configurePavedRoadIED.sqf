/*
    Author: JD Wang, Edited by Grok 2

    Description:
        Configures Paved Road IED with reduced risk of GIAR errors.

    Parameters:
        0: IED Type <STRING>
        1: Location <ARRAY>

    Returns:
        NONE

    Examples:
        ["CAR", [100,100,0]] call PatrolOps_fnc_configurePavedRoadIED;
*/

params ["_iedType", "_locationIED"];

switch (_iedType) do {
    case "CAR": {
        // ... (Keep the existing code for CAR case as it's relatively lightweight)
    };

    case "TRASHPILE": {
        // Parse the trash objects from patrolOpsRoadClutter
        private _allTrash = parseSimpleArray patrolOpsRoadClutter;
        
        // Filter trash by size, keeping only those with a size greater than 0
        private _trashTypes = [];
        {
            private _size = [_x] call PatrolOps_fnc_getObjectSize;
            if (_size > 0) then {
                _trashTypes pushBack [_x, _size];
            };
        } forEach _allTrash;
        
        _trashTypes sort false; // Sort trash by size in descending order

        private _centralPosition = _locationIED;
        private _numTrash = floor random 3 + 1; // Random number of trash piles between 1 and 3

        // Find the maximum size of trash for spacing calculations
        private _maxSize = 0;
        {
            if ((_x # 1) > _maxSize) then {
                _maxSize = _x # 1;
            };
        } forEach _trashTypes;
        
        private _separationDistance = _maxSize * 1.1; // Spacing between trash piles

        private _positions = [];
        private _angleIncrement = 360 / _numTrash; // Angle between each trash pile
        for "_i" from 0 to (_numTrash - 1) do {
            private _angle = _angleIncrement * _i;
            private _distance = _separationDistance + (random 1); // Add slight randomness to distance
            private _pos = _centralPosition getPos [_distance, _angle];
            // Adjust position if it overlaps with existing positions
            while {[_pos, _trashTypes # _i # 1, _positions] call _checkOverlap} do {
                _angle = _angle + (random 10) - 5;
                _pos = _centralPosition getPos [_distance, _angle];
            };
            _positions pushBack _pos;
        };

        // Create trash piles with a delay
        for "_i" from 0 to (_numTrash - 1) do {
            [{
                params ["_trashType", "_position"];
                private _trashpile = createVehicle [_trashType, _position, [], 0, "CAN_COLLIDE"];
                _trashpile setDir random 360; // Random orientation
                _trashpile setVectorUp surfaceNormal (getPosATL _trashpile); // Align with terrain
                patrolOps_miscCleanUp pushBack _trashpile; // Add to cleanup array
                _trashpile enableSimulationGlobal false; // Disable simulation for performance
            }, [_trashTypes # _i # 0, _positions # _i], _i * 0.5] call CBA_fnc_waitAndExecute;
        };
    };
};