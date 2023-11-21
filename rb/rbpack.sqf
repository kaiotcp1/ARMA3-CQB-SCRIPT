_vehicle = _this select 0;
_player = _this select 1;
_id = _this select 2;
_objarr = _this select 3;

_obj1 = (_objarr select 0);

if (((speed _vehicle) < 1)  and ((_vehicle distance _obj1) < 20)) then {

_pos = (getpos _vehicle);
_hedge = (_pos nearestObject "Land_ConcreteHedgehog_01_palette_F");

if (isNil "_hedge") then {

hintSilent composeText [
parseText "<t color='#C3C328' align='center'>-------------------------------------------------------</t>",
parseText "<br/>",
parseText "<t color='#C3C328' align='center'>- Repack Hedgehogs first -</t>",
parseText "<br/>",
parseText "<t color='#C3C328' align='center'>-------------------------------------------------------</t>"
];

} else {

if ((_vehicle distance _hedge) < 50) then {


{deletevehicle _x} foreach _objarr;

deletevehicle _hedge;

// Remove RB-Action from _vehicle
[_vehicle,"removeAllActions",true,true] call BIS_fnc_MP;
[[_vehicle, ["<t color='#00FF00'>Set up roadblock</t>","FP\rb\rbbuild.sqf","",1.5,true,true,"","",5]],"addAction",true,true] call BIS_fnc_MP;
hintSilent composeText [
parseText "<t color='#8B0000' align='center'>-------------------------------------------------------</t>",
parseText "<br/>",
parseText "<t color='#8B0000' align='center'>- Roadblock Deconstructed -</t>",
parseText "<br/>",
parseText "<t color='#8B0000' align='center'>-------------------------------------------------------</t>"
];
} else {

hintSilent composeText [
parseText "<t color='#C3C328' align='center'>-------------------------------------------------------</t>",
parseText "<br/>",
parseText "<t color='#C3C328' align='center'>- Repack Hedgehogs first -</t>",
parseText "<br/>",
parseText "<t color='#C3C328' align='center'>-------------------------------------------------------</t>"
];


};
};
} else {

hintSilent composeText [
parseText "<t color='#C3C328' align='center'>-------------------------------------------------------</t>",
parseText "<br/>",
parseText "<t color='#C3C328' align='center'>- Vehicle must be nearby -</t>",
parseText "<br/>",
parseText "<t color='#C3C328' align='center'>-------------------------------------------------------</t>"
];


};