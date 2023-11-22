private ["_triggerName", "_securityLocal", "_ammoBox"];
_triggerName = _this select 0;
_securityLocal = _this select 1;
_ammoBox = _this select 2;

// Inicializa a variável para armazenar os grupos
_enableScript = true;
_randomMarkerNumber = floor(random 10000); // Gera um número aleatório entre 0 e 10000
_triggerPos = getPos _triggerName;
_securityLocation = _securityLocal;
_playersInRange = [];
_gruposAtivos = [];

// Defina as informações para criar os grupos
_grupoInfo1 = [_securityLocation, WEST, ["rhsgref_cdf_b_reg_squadleader", "rhsgref_cdf_b_reg_grenadier_rpg",
"rhsgref_cdf_b_reg_grenadier_rpg", "rhsgref_cdf_b_reg_machinegunner", "rhsgref_cdf_b_reg_machinegunner"],
[], [], [], [], [], 230];
_grupoInfo2 = [_securityLocation, WEST, ["rhsgref_cdf_b_reg_squadleader", "rhsgref_cdf_b_reg_grenadier_rpg",
	"rhsgref_cdf_b_reg_grenadier_rpg", "rhsgref_cdf_b_reg_machinegunner", "rhsgref_cdf_b_reg_machinegunner",
"rhsgref_cdf_b_reg_machinegunner", "rhsgref_cdf_b_reg_machinegunner", "rhsgref_cdf_b_reg_machinegunner", "rhsgref_cdf_b_reg_machinegunner"],
[], [], [], [], [], 130];

_grupoInfo3 = [_securityLocation, WEST, ["rhsgref_cdf_b_reg_squadleader", "rhsgref_cdf_b_reg_grenadier_rpg",
"rhsgref_cdf_b_reg_grenadier_rpg", "rhsgref_cdf_b_reg_machinegunner", "rhsgref_cdf_b_reg_machinegunner"],
[], [], [], [], [], 230];

// Crie arrays para armazenar as informações dos grupos
gruposSoldadosObjetos = [_grupoInfo1, _grupoInfo2, _grupoInfo3];
_gruposObjetos = [];

while { _enableScript } do {
	if (!_enableScript) exitWith {};

	    // Verificar se pelo menos um jogador está a menos de 600 metros de distância do _triggerPos
	{
		if (player distance _triggerPos < 600) then {
			_playersInRange pushBack _x;
		}
	} forEach allPlayers;

	    // Se pelo menos um jogador estiver dentro da faixa e não há grupos gerados
	if (count _playersInRange > 0 && count _gruposAtivos == 0) then {
		// Iterar sobre as arrays para criar os grupos
		{
			// _grupoInfo é array...
			_grupoInfo = _x;
			_grupo = _grupoInfo call BIS_fnc_spawnGroup;
			_grupo deleteGroupWhenEmpty true;

			            // Armazenar o grupo na variável de controle
			_gruposAtivos pushBack _grupo;

			            // Iterar pelos membros do grupo e definir a posição de cada um
			{
				_soldado = _x;
				_soldado setPosATL _triggerPos;
				_soldado allowDamage false;
				sleep 1;
				_soldado allowDamage true;
			} forEach units _grupo;
		} forEach gruposSoldadosObjetos;

		sleep 2;

		        // Configurar waypoints para os grupos ativos
		{
			_grupo = _x;
			sleep 2;
			[_grupo, [_triggerPos, 200, 200, 0, false]] call CBA_fnc_taskSearchArea;
		} forEach _gruposAtivos;

		        // Se desejar configurar waypoints diferentes para cada grupo, ajuste conforme necessário.
	};

	_totalGrupos = count allGroups;
	hint format ["Total de grupos no mapa: %1", _totalGrupos];

	    // Verificar se o player está longe e há grupos ativos para deletar
	if (player distance _triggerPos > 600 && count _gruposAtivos > 0) then {
		// Iterar sobre os grupos ativos e deletar apenas os grupos que foram gerados pelo script
		{
			_grupo = _x;

			            // Deletar cada membro do grupo
			{
				_soldado = _x;
				deleteVehicle _soldado;
			} forEach units _grupo;

			            // Aguardar até que todos os veículos (membros do grupo) sejam deletados
			waitUntil {
				sleep 0.1;
				count units _grupo == 0
			};

			            // Deletar o grupo após deletar todos os membros
			deleteGroup _grupo;
		} forEach _gruposAtivos;
	};

	    // Limpar a array de jogadores que se encontram na distância de respawn
	_playersInRange = [];

	    // Verificar se a munição está morta para criar o marcador e desabilitar o script
	if (!alive _ammoBox) then {
		_localMarkerName = format ["markername%1", _randomMarkerNumber];
		_MarkerComplete = createMarker[_localMarkerName, _triggerPos];
		_localMarkerName setMarkerSize [600, 600];
		_localMarkerName setMarkerText "Safe Area";
		_localMarkerName setMarkerShape "ELLIPSE";
		_localMarkerName setMarkerBrush "Grid";
		_localMarkerName setMarkerColor "ColorGreen";
		deleteVehicle _triggerName;
		hint "Trigger deletado com sucesso";
		_enableScript = false;
	};

	sleep 10;
};