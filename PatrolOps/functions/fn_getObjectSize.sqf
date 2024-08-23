/*
    Author: Grok 2, Optimized

    Description:
        Calculates the size of an object based on its bounding box using config data.

    Parameters:
        0: OBJECT TYPE <STRING> - The class name of the object.

    Returns:
        NUMBER - The largest dimension of the object.

    Example:
        _size = ["B_supplyCrate_F"] call PatrolOps_fnc_getObjectSize;
*/

PatrolOps_fnc_getObjectSize = {
    params ["_objectType"];

    // Check if the result is already cached
    if (isNil "PatrolOps_objectSizeCache") then {
        PatrolOps_objectSizeCache = [];
    };
    private _cachedSize = PatrolOps_objectSizeCache getVariable [_objectType, nil];
    if (!isNil "_cachedSize") exitWith {_cachedSize};

    // Get bounding box dimensions from config
    private _config = configFile >> "CfgVehicles" >> _objectType;
    if (isClass _config) then {
        private _boundingBox = getArray (_config >> "boundingBox");
        if (count _boundingBox == 6) then {
            private _min = [_boundingBox # 0, _boundingBox # 1, _boundingBox # 2];
            private _max = [_boundingBox # 3, _boundingBox # 4, _boundingBox # 5];
            private _size = _max vectorDiff _min;
            private _largestDimension = abs (_size # 0) max abs (_size # 1) max abs (_size # 2);
            
            // Cache the result
            PatrolOps_objectSizeCache setVariable [_objectType, _largestDimension];
            
            _largestDimension
        } else {
            // If boundingBox is not in the expected format, use a default or fallback method
            0
        };
    } else {
        // If the class doesn't exist, return 0 or handle as appropriate
        0
    };
};