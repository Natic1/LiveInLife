
/*
    Author:
        Vincent Heins

    Description:
        Flips a target/given vehicle.

    Parameter(s):
        (_this select 0) : _vehicle : <objNull> : vehicle to flip

    Result:
        <bool> : whether the vehicle was flipped or not
    
    Example(s):
        (Example 1)
        private _vehicle = objNull
        private _vehicleFlipped = ([_vehicle] call lilc_actions_fnc_doFlipVehicle);
*/

params [
    ["_vehicle", objNull, [objNull]]
];

if (
    (isNull _vehicle) ||
    (isPlayer _vehicle) ||
    !([_vehicle] call lilc_actions_fnc_canFlipVehicle)
) exitWith { false; };

if ({ (alive _x) } count (crew _vehicle)) exitWith { false; };

lilc_action_active = true;
_vehicle setVariable ["lilc_flipTimestamp", (time + 6)];
["Dein Fahrzeug wird in 5 Sekunden umgedreht.", "WARNING"] call lilc_ui_fnc_hint;
sleep 5;

_vehicle allowDamage false;
private _vehiclePosition = (getPosASL _vehicle);
_vehiclePosition set [2, ((_vehiclePosition select 2) + 0.2)];

_vehicle setVectorUp [0, 0, 1];
_vehicle setPosASL _vehiclePosition;

["Du hast das Fahrzeug erfolgreich umgedreht."] call lilc_ui_fnc_hint;
sleep 1;
_vehicle allowDamage true;
lilc_action_active = false;

true;