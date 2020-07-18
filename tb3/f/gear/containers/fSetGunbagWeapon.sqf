params ["_unit", "_gunbagWeapon"];

if !(local _unit) exitWith {false};
if !(backpack _unit in ["ace_gunbag", "ace_gunbag_Tan"]) exitWith {false};


private _gunbag = backpackContainer _unit;
_gunbagWeapon params ["_weapon","_items"];

private _magazines = [];
private _attachments = [];
{
  if (isClass (configFile >> "CfgWeapons" >> _x)) then { _attachments pushBackUnique _X; } else {
    if (isClass (configFile >> "CfgMagazines" >> _x)) then { _magazines pushBackUnique _x; };
  };
} forEach _items;

// add virtual load
private _mass = [_weapon, _attachments, _magazines] call ace_gunbag_fnc_calculateMass;
[_unit, _gunbag, _mass] call ace_movement_fnc_addLoadToUnitContainer;

_gunbag setVariable ["ace_gunbag_gunbagWeapon", [_weapon, _attachments, _magazines apply {[_x]}], true];

true;
