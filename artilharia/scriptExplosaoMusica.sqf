params ["_triggerName"];

// Obtenha a posição do trigger
_triggerPos = getPos _triggerName;
_jetPos = [_triggerPos, 300, 100] call BIS_fnc_relPos;

// Crie um grupo para o caça
_drivers = createGroup west;

// Seleciona um tipo de caça aleatório
_jetType = selectRandom ["UK3CB_TKA_B_MIG21_AT"];

// Inicialize o caça e obtenha o objeto criado
_jetInit = [_jetPos, 280, _jetType, _drivers] call BIS_fnc_spawnVehicle;
_jetCreated = (_jetInit select 0);

// Configurações para o caça
_jetCreated setSpeedMode "LIMITED";
_jetCreated forceSpeed 300;

[group _jetCreated, _triggerPos, 0] call CBA_fnc_taskAttack;

sleep 2;

_jetCreated setCombatBehaviour "COMBAT";

// Aplica deleteGroupWhenEmpty ao grupo (caça e pilotos)
_drivers deleteGroupWhenEmpty true;

{
    _explosionType = "Bo_GBU12_LGB";

    // Crie a GBU ajustando a posição e o azimute
    _explosion = createVehicle [_explosionType, getPos _jetCreated, [], 0, "CAN_COLLIDE"];
    // Crie o paraquedas e anexe à GBU
    _chute = createVehicle ["B_Parachute_02_F", (getPosATL _explosion), [], 0, "NONE"];

    if((_explosion call CBA_fnc_isAlive)) then {
    _chute attachTo [_explosion, [0,0,-1.5]]; // Ajuste a posição conforme necessário
    } else {
        deleteVehicle _chute;
    };

    _explosion setDir -90;
    _explosion setVelocity [0, 0, -20];
    _explosion setVehicleAmmo 0;

    sleep 1; // Ajuste conforme necessário para o ritmo desejado das explosões
} forEach [0, 1, 2]; // Número de explosões

// Toque a música configurada no CfgSounds usando playSound3D
//_musica = selectRandom ["ARTY1", "ARTY", "atmos", "chatter", "news", "news1", "news2", "news3", "news5"];
hint "Trigger ativado! Explosões e música iniciadas.";
if (player inArea _triggerName) then { 
    playSound "ARTY";
    hint "kaio";
};

sleep 320;

// Retorna os tripulantes
_pilots = crew _jetCreated;
// Delete o jet
deleteVehicle _jetCreated;
// Delete os pilotos (isso garante que sejam excluídos corretamente)
{deleteVehicle _x} forEach _pilots;

hint "Caça deletado com sucesso";
