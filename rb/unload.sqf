_vehicle = _this select 0;
_caller = _this select 1;
_id = _this select 2;

_loc= getpos _vehicle;
_location = getpos _vehicle;
_dir = direction _vehicle;

_a = 0;

while {_a =_a + 1; _a < 5} do {


_mdis = 2;
_bdir = _dir;

_xloc = _location select 0;
_yloc = _location select 1;

_xlocnew = _xloc-(sin _dir*_mdis);
_ylocnew = _yloc-(cos _dir*_mdis);


_startdir = getdir _vehicle;

_newloc = [_xlocnew, _ylocnew, _location select 2];

_blocker = createVehicle ["Land_ConcreteHedgehog_01_half_F", _newloc, [], 0, "NONE" ];
[[_blocker, ["Move","FP\rb\mov.sqf","",1.5,true,true,"","",5]],"addAction",true,true] call BIS_fnc_MP;
[[_blocker, ["Assemble","FP\rb\ass.sqf","",1.5,true,true,"","",5]],"addAction",true,true] call BIS_fnc_MP;
[[_blocker, ["Repack","FP\rb\rep.sqf","",1.5,true,true,"","",5]],"addAction",true,true] call BIS_fnc_MP;


_vehx = getpos _vehicle;
_high = _vehx select 2;
_blocker setpos _newloc;
_blocker setdir _dir;

_dir = _dir + 90;

};


deletevehicle _vehicle;
_empty = createVehicle ["Land_Pallet_F", _loc, [], 0, "NONE" ];
_empty setpos _loc;