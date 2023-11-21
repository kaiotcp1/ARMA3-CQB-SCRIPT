_vehicle = _this select 0;
_caller = _this select 1;
_pos = getpos _vehicle;
_dir = direction _caller;
_mdis = 2; 


_vehicle setpos [(_pos select 0)+(sin _dir*_mdis),(_pos select 1)+(cos _dir*_mdis),(_pos select 2)];
