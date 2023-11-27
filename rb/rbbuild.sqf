params ["_markerArray"];

_enableScript = true;
_obj = [];
_roadBlocksAtivos = [];
_pos = [];
_direction = [];
_triggerData = [];


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

{
	_markerObj = _x;
	_markerName = _markerObj;
	_markerPos = getMarkerPos _markerName;

	_trgRoadBlock = createTrigger ["EmptyDetector", _markerPos];
	_trgRoadBlock setTriggerArea [100, 100, 0, false];
	_trgRoadBlock setTriggerActivation ["ANY", "PRESENT", false];
	_trgRoadBlock setTriggerStatements ["this", "hint 'trigger on'", "hint 'trigger off'"];

	_triggerData pushBack [_markerName, _trgRoadBlock];
} forEach _markerArray;

while { true } do {
	{
		_markerObj = _x;
		_markerName = _markerObj;
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

		hint format ["marName é: %1 e markerObj é: %2", _markerName, _markerObj];

		{
			_triggerDataEntry = _x;
			_markerObjTrigger = _triggerDataEntry select 0;
			_trgRoadBlock = _triggerDataEntry select 1;

			if (_markerName == _markerObjTrigger && triggerActivated _trgRoadBlock) then {
				hint "Trigger ativado!";
				sleep 3;

				_obj = [_pos, _direction, _objectsArray, 0] call BIS_fnc_objectsMapper;

				_grupoSoldadosObjeto = [_markerPos, WEST, ["rhsgref_cdf_b_reg_grenadier_rpg",
					"rhsgref_cdf_b_reg_machinegunner", "rhsgref_cdf_b_reg_grenadier_rpg", "rhsgref_cdf_b_reg_grenadier_rpg",
					"rhsgref_cdf_b_reg_grenadier_rpg", "rhsgref_cdf_b_reg_grenadier_rpg", "rhsgref_cdf_b_reg_specialist_aa",
				"rhsgref_cdf_b_reg_specialist_aa"], [], [], [], [], [], 0] call BIS_fnc_spawnGroup;
				                // Deleta o trigger após a ativação
				deleteVehicle _trgRoadBlock;
				_grupoSoldadosObjeto deleteGroupWhenEmpty true;

				sleep 3;
				[_grupoSoldadosObjeto, _markerPos] call BIS_fnc_taskDefend;

				{
					_object = _x;

					if (typeOf _object isEqualTo "seu_tipo_de_objeto_aqui") then {
						_object enableSimulation true;
						_normal = surfaceNormal (position _object);
						_object setVectorUp _normal;
					} else {
						_object enableSimulation false;
						_normal = surfaceNormal (position _object);
						_object setVectorUp _normal;
					}
				} forEach _obj;

				_roadBlocksAtivos pushBackUnique [_markerName, _grupoSoldadosObjeto, _obj];
				hint format ["Debug --- Array com 2 valores: %1", _roadBlocksAtivos];
				sleep 3;
			}
		} forEach _triggerData;
	} forEach _markerArray;

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

	sleep 3;
};