_vehicle = _this select 0;
_caller = _this select 1;
_id = _this select 2;

_loc= getpos _vehicle;

_array = nearestObjects [_vehicle, ["Land_ConcreteHedgehog_01_half_F","Land_Pallet_F"], 20];

if (count _array > 3) then {
deletevehicle _vehicle;
_palett = (_loc nearestObject "Land_Pallet_F");
_pos = (getpos _palett);
{deletevehicle _x} foreach _array;

_rese = createVehicle ["Land_ConcreteHedgehog_01_palette_F", _pos, [], 0, "NONE" ];
_rese setpos _pos;
[[_rese, ["Unload","FP\rb\unload.sqf","",1.5,true,true,"","",5]],"addAction",true,true] call BIS_fnc_MP;
};


