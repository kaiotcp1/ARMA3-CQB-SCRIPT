_vehicle = _this select 0;
_caller = _this select 1;
_id = _this select 2;

_loc= getpos _vehicle;

deletevehicle _vehicle;

_blocker = createVehicle ["Land_ConcreteHedgehog_01_half_F", _loc, [], 0, "NONE" ];
_blocker setpos _loc;


[[_blocker, ["Move","FP\rb\mov.sqf","",1.5,true,true,"","",5]],"addAction",true,true] call BIS_fnc_MP;
[[_blocker, ["Assemble","FP\rb\ass.sqf","",1.5,true,true,"","",5]],"addAction",true,true] call BIS_fnc_MP;
[[_blocker, ["Repack","FP\rb\rep.sqf","",1.5,true,true,"","",5]],"addAction",true,true] call BIS_fnc_MP;