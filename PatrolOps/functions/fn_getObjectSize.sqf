/*
    Author: Grok 2, Optimized

    Description:
        Calculates the size of an object based on its bounding box or defaults to a known size if not calculable.

    Parameters:
        0: OBJECT or STRING - Either the object itself or its class name.

    Returns:
        NUMBER - The largest dimension of the object, or a default size if not calculable.

    Example:
        _size = ["B_supplyCrate_F"] call PatrolOps_fnc_getObjectSize;
        // or with an object
        _size = [player] call PatrolOps_fnc_getObjectSize;
*/

params [["_object", objNull, [objNull, ""]]];

// If a string (class name) is provided, we'll attempt to create a temporary object for measurement
if (_object isEqualType "") then {
    // Create a temporary object for size calculation
    private _tempObject = createVehicle [_object, [0,0,0], [], 0, "CAN_COLLIDE"];
    private _boundingBox = boundingBoxReal _tempObject;
    deleteVehicle _tempObject; // Clean up temporary object
    
    if (count _boundingBox != 2) exitWith { 2 }; // Default size if bounding box can't be determined

    // Extract the dimensions from the bounding box
    private _length = (_boundingBox select 1 select 0) - (_boundingBox select 0 select 0);
    private _width = (_boundingBox select 1 select 1) - (_boundingBox select 0 select 1);
    private _height = (_boundingBox select 1 select 2) - (_boundingBox select 0 select 2);

    // Return the largest dimension
    [_length, _width, _height] call BIS_fnc_greatestNum;
} else {
    // For objects, proceed as before
    private _boundingBox = boundingBoxReal _object;
    
    if (count _boundingBox != 2) exitWith { 2 }; // Default size if bounding box can't be determined

    // Extract the dimensions from the bounding box
    private _length = (_boundingBox select 1 select 0) - (_boundingBox select 0 select 0);
    private _width = (_boundingBox select 1 select 1) - (_boundingBox select 0 select 1);
    private _height = (_boundingBox select 1 select 2) - (_boundingBox select 0 select 2);

    // Return the largest dimension
    [_length, _width, _height] call BIS_fnc_greatestNum;
};