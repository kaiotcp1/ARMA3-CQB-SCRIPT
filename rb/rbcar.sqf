_vehicle = _this select 0;
_player = _this select 1;
_id = _this select 2;


private _side = side _player;

switch _side do {
	case WEST: {

openMap true; 
_mapZeusEH = addMissionEventHandler ["MapSingleClick", {_pos = _this select 1; 
_veh = 'B_MRAP_01_F' createVehicle _pos;
[[_veh, ['Build Roadblock','FP\rb\rbbuild.sqf','',1.5,true,true,'','',5]],'addAction',true,true] call BIS_fnc_MP;

openMap false;}];

waitUntil {!visibleMap}; 

removeMissionEventHandler ["MapSingleClick",_mapZeusEH]; 



	};
	case EAST: {


openMap true; 
_mapZeusEH = addMissionEventHandler ["MapSingleClick", {_pos = _this select 1; 
_veh = 'O_Truck_02_box_F' createVehicle _pos;
[[_veh, ['Build Roadblock','FP\rb\rbbuild.sqf','',1.5,true,true,'','',5]],'addAction',true,true] call BIS_fnc_MP;

openMap false;}];

waitUntil {!visibleMap}; 

removeMissionEventHandler ["MapSingleClick",_mapZeusEH]; 


	};
	case INDEPENDENT: {

openMap true; 
_mapZeusEH = addMissionEventHandler ["MapSingleClick", {_pos = _this select 1; 
_veh = 'I_Truck_02_box_F' createVehicle _pos;
[[_veh, ['Build Roadblock','FP\rb\rbbuild.sqf','',1.5,true,true,'','',5]],'addAction',true,true] call BIS_fnc_MP;

openMap false;}];

waitUntil {!visibleMap}; 

removeMissionEventHandler ["MapSingleClick",_mapZeusEH]; 



	};
};

