params ["_markerArray"];

_enableScript = true;
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
	["Land_BagFence_Round_F", [5.77002, -3.15601, 0], 120, 1, 0, [0, 0], "", "", true, false],
	["RHS_M2StaticMG_D", [7.85693, -2.79688, 0], -120, 1, 0, [0, 0], "", "", true, false],
	["RoadCone_F", [-4.58105, -6.12061, 0], 0, 1, 0, [0, 0], "", "", true, false],
	["Land_PaperBox_open_empty_F", [7.8208, 2.51733, 0], 0, 1, 0, [0, 0], "", "", true, false],
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
	["RHS_TOW_TriPod_USMC_D", [-14.2725, -0.586914, -0.000999928], 90, 1, 0, [0, -0], "", "", true, false]
];

while { true } do {
	// if (!_enableScript) exitWith {};

	{
		_markerObj = _x;
		//hint format ["Marcador do forEach principal: %1", _markerObj];
		//sleep 3;

		_markerName = _markerObj;
		//hint format ["Hint do _markerName: %1", _markerName];
		//sleep 3;

		_counterArray = [count _markerObj];
		_markerPos = getMarkerPos _markerName;
		_nearRoads = _markerPos nearRoads 10;


		if (count _nearRoads > 0) then {
			_road = _nearRoads select 0;
			_roadConnectedTo = roadsConnectedTo _road;
			_connectedRoad = _roadConnectedTo select 0;
			_direction = [_road, _connectedRoad] call BIS_fnc_dirTo;
			_pos = (getPos _road);
		};

		if (player distance _markerPos < 400) then {
			// _playersInRange pushBackUnique name player;
			// hint format ["PlayersInRange : %1", _playersInRange];

			_alreadyExists = false;

			{
				if (_markerName == (_x select 0)) then {
					_alreadyExists = true;
				};
			} forEach _roadBlocksAtivos;

			if (!_alreadyExists) then {
				_obj = [_pos, _direction, _objectsArray, 0] call BIS_fnc_objectsMapper;

				_grupoSoldadosObjeto = [_markerPos, WEST, ["rhsgref_cdf_b_reg_grenadier_rpg",
					"rhsgref_cdf_b_reg_machinegunner", "rhsgref_cdf_b_reg_grenadier_rpg", "rhsgref_cdf_b_reg_grenadier_rpg",
					"rhsgref_cdf_b_reg_grenadier_rpg", "rhsgref_cdf_b_reg_grenadier_rpg", "rhsgref_cdf_b_reg_specialist_aa",
				"rhsgref_cdf_b_reg_specialist_aa"], [], [], [], [], [], 0] call BIS_fnc_spawnGroup;

				sleep 3;
				[_grupoSoldadosObjeto, _markerPos] call BIS_fnc_taskDefend;

				{
					{
						_object = _x;

						    // Verifica se o objeto é do tipo RHS_TOW_TriPod_USMC_D
						if (typeOf _object isEqualTo "RHS_TOW_TriPod_USMC_D") then {
							// Se for, deixe enableSimulation true
							_object enableSimulation true;
							_normal = surfaceNormal (position _object);
							_object setVectorUp _normal;
						} else {
							// Se não for, deixe enableSimulation false
							_object enableSimulation false;

							        // Além disso, ajuste a orientação do objeto
							_normal = surfaceNormal (position _object);
							_object setVectorUp _normal;
						}
					} forEach _obj;

					_roadBlocksAtivos pushBackUnique [_markerName, _grupoSoldadosObjeto, _obj];
					//hint format ["Debug --- Array com 2 valores: %1", _roadBlocksAtivos];
					//sleep 3;
				} forEach allPlayers;
			};
		};

		

		{
			_roadBlockInfo = _x;
			_markerNameForDelete = _roadBlockInfo select 0;
			_grupoSoldadosForVerify = _roadBlockInfo select 1;
			_objectForDelete = _roadBlockInfo select 2;

			{
				_soldierForVerify = _x;
				if (!alive _soldierForVerify) then {
					deleteGroup _grupoSoldadosForVerify;
					deleteMarker _markerNameForDelete;
					{
						_objectInfo = _x;
						deleteVehicle _objectInfo;
					} forEach _objectForDelete;
					_roadBlocksAtivos = _roadBlocksAtivos - [_roadBlockInfo];
				};
			} forEach units _grupoSoldadosForVerify;
		} forEach _roadBlocksAtivos;

		//hint format ["Nome do RoadBlockAtivo: %1", _roadBlocksAtivos];

		        // Limpa array de jogadores que estão na distância fornecida...
	} forEach _markerArray;

	sleep 3;
};