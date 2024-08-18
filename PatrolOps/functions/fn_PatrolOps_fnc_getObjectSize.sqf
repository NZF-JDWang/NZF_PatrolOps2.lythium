/*
    Author: Grok 2

    Description:
        Calculates the size of an object based on its bounding box.

    Parameters:
        0: OBJECT TYPE <STRING> - The class name of the object.

    Returns:
        NUMBER - The largest dimension of the object.

    Example:
        _size = ["B_supplyCrate_F"] call PatrolOps_fnc_getObjectSize;
*/

PatrolOps_fnc_getObjectSize = {
    params ["_objectType"];

    // Create a dummy object to get its size
    private _dummyObject = createVehicle [_objectType, [0, 0, 0], [], 0, "NONE"];
    private _boundingBox = boundingBoxReal _dummyObject;
    private _boundingBoxSize = _boundingBox # 1 vectorDiff (_boundingBox # 0);

    // Calculate the largest dimension
    private _largestDimension = (abs (_boundingBoxSize # 0) max abs (_boundingBoxSize # 1) max abs (_boundingBoxSize # 2));

    // Delete the dummy object
    deleteVehicle _dummyObject;

    _largestDimension
};