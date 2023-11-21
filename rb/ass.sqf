_vehicle = _this select 0;
_caller = _this select 1;
_id = _this select 2;

_loc= getpos _vehicle;

deletevehicle _vehicle;

_hedgehog = createVehicle ["Land_ConcreteHedgehog_01_F", _loc, [], 0, "NONE" ];
_hedgehog setpos _loc;


[[_hedgehog , ["Dissemble","FP\rb\dis.sqf","",1.5,true,true,"","",5]],"addAction",true,true] call BIS_fnc_MP;