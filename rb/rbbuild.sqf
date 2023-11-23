params ["_markerArray"];



_enableScript = true;
_playersInRange = [];
_obj = [];
_roadBlocksAtivos = [];
_pos = [];
_direction = [];

_objectsArray = [
					["RoadCone_F", [3.45947, -0.1698, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["RoadCone_F", [-4.56201, -0.172607, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["RoadCone_F", [3.45264, 3.86658, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_PortableLight_double_F", [4.94238, 1.55298, 0], 154.789, 1, 0, [0, -0], "", "", true, false],
					["RoadCone_F", [-4.56006, 3.81567, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["RoadCone_F", [3.52002, -6.10803, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_CampingTable_F", [6.77002, -3.15601, 0], 270, 1, 0, [0, 0], "", "", true, false],
					["RoadCone_F", [-4.58105, -6.12061, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_PaperBox_open_empty_F", [7.8208, 2.51733, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_CampingChair_V2_F", [7.85693, -2.79688, 0], 67.7096, 1, 0, [0, 0], "", "", true, false],
					["Land_CampingChair_V2_F", [7.87891, -3.77124, 0], 90.5561, 1, 0, [0, -0], "", "", true, false],
					["Land_PortableLight_double_F", [-7.86035, -4.21399, 0], 264.639, 1, 0, [0, 0], "", "", true, false],
					["Land_BagBunker_01_small_green_F", [-8.5293, -0.577515, 0], 269.269, 1, 0, [0, 0], "", "", true, false],
					["CamoNet_ghex_F", [9.27197, -1.02222, 0], 87.0908, 1, 0, [0, 0], "", "", true, false],
					["RoadCone_F", [3.53662, 9.80896, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_Portable_generator_F", [-9.78223, -3.93494, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_Razorwire_F", [6.11719, 7.15356, -2.38419e-006], 0, 1, 0, [0, 0], "", "", true, false],
					["RoadCone_F", [-4.55518, 9.80078, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_Razorwire_F", [-10.481, 7.0675, -2.38419e-006], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_BagFence_01_long_green_F", [-11.2192, 1.1897, -0.000999928], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_BagFence_01_long_green_F", [-11.2188, -2.43848, -0.000999928], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_Razorwire_F", [6.08496, -9.00049, -2.38419e-006], 0, 1, 0, [0, 0], "", "", true, false],
					["RoadCone_F", [3.45703, -12.1688, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_Razorwire_F", [-10.5132, -9.08655, -2.38419e-006], 0, 1, 0, [0, 0], "", "", true, false],
					["RoadCone_F", [-4.53076, -12.1653, 0], 0, 1, 0, [0, 0], "", "", true, false],
					["Land_PortableLight_double_F", [-12.6196, -4.11023, 0], 329.004, 1, 0, [0, 0], "", "", true, false],
					["Land_BagFence_01_long_green_F", [-14.2725, -0.586914, -0.000999928], 90, 1, 0, [0, -0], "", "", true, false]
				];

while { true } do {
	//if (!_enableScript) exitWith {};

	{
		_markerObj = _x;
		_counterArray = [count _markerObj];
		_markerPos = getMarkerPos _markerObj;
		_nearRoads = _markerPos nearRoads 10;

		{
			if (player distance _markerPos < 20) then {
				_playersInRange pushBack _x;
			}

		} forEach allPlayers;

		if (count _nearRoads > 0) then {
			_road = _nearRoads select 0;
			_roadConnectedTo = roadsConnectedTo _road;
			_connectedRoad = _roadConnectedTo select 0;
			_direction = [_road, _connectedRoad] call BIS_fnc_dirTo;
			_pos = (getPos _road);
		};

		
		if (count _playersInRange > 0 && count _roadBlocksAtivos == 0) then {
			{
				_roadBlock = _x;
				hint str _roadBlock;
				// Cria o roadblock
				_obj = [_pos, _direction, _objectsArray, 0] call BIS_fnc_objectsMapper;

				// Armazena o roadblock
                _roadBlocksAtivos pushBack _roadBlock;
;
				{
					_normal = surfaceNormal (position _x);
					_x setVectorUp _normal;
				} forEach _obj;
			} forEach _counterArray;
		};
		// Limpa array de jogadores que estão na distância fornecida...
		_playersInRange = [];

	} forEach _markerArray;
			hint "Final do loop";
	sleep 10;
};

