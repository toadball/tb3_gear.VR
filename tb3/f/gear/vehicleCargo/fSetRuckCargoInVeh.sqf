private ["_backpack","_contents","_cargoCleared","_handledCargo","_return","_clearCargo"];

//Add cargo to a backpack in vehicle cargo.
_backpack = _this select 0;
_contents = _this select 1;

_cargoCleared = false;
_handledCargo = false;
_return = [];

if (count _this > 2) then {
	_clearCargo = _this select 2;
	switch (_clearCargo) do {
		case 0:{_cargoCleared = false;};
		case 1:{
			clearWeaponCargoGlobal _backpack;
			clearMagazineCargoGlobal _backpack;
			clearItemCargoGlobal _backpack;
			clearBackpackCargoGlobal _backpack;
			_cargoCleared = true;
		};
		default {_cargoCleared = false;};
		
	};
};
{
	//_x = array in format {"fing",10};
	switch ([_x select 0] call tb3_fIsTypeOf) do {
		case "Weapon": {
			_backpack addWeaponCargoGlobal _x;
		};
		case "Magazine": {
			_backpack addMagazineCargoGlobal _x;
		};		
		case "Item": {
			_backpack addItemCargoGlobal _x;
		};	
		case "Backpack": {
			_backpack addBackpackCargoGlobal _x;
		};			
		default {};
	};
} forEach _contents;	
_handledCargo = true;

_return = [_handledCargo,_cargoCleared];