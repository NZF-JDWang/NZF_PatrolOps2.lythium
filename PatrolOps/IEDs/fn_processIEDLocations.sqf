    params ["_locations", "_numberOfIEDs"];
    
    private _repeat = count _locations;
    // Work out the spacing
    private _spacing = round (_repeat / _numberOfIEDs);

    for "_i" from 0 to (_repeat - 1) step _spacing do {
        // Get next location
        private _locationIED = getMarkerPos (_locations select _i);
        // Get the type of IED to spawn 
        private _iedAndRoadType = [_locationIED] call patrolOps_fnc_selectIEDtype;
		params _iedAndRoadType ["_iedType", "_roadtype"];
        
		// Generate the IED here 
		if (_roadtype isEqualTo "MAIN ROAD" || _roadtype isEqualTo "ROAD" || _roadtype isEqualTo "a3\roads_f\roads_ae\data\surf_roadconcrete_city_road_ca.paa") then {

			[_iedType] call PatrolOps_fnc_spawnPavedRoadIED;

		} else {

			[_iedType] call PatrolOps_fnc_spawnDritRoadIED;

		};

		private _info = _iedAndRoadType joinString "-";
        // DEBUG 
        ["Debug_IED", "KIA", _locationIED, "colorRed", _info, 0.5] call PatrolOps_fnc_debugMarkers;
    };
