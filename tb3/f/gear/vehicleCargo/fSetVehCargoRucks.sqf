private ["_unit", "_rucks", "_handled"];
/*
clearBackpackCargo cursorTarget; cursortarget addBackpackCargo ["B_kitbag_rgr",1]; buttes = count everyBackpack cursorTarget -1; everybackpack cursorTarget select buttes addMagazineCargo ["HandGrenade",15]
*/

_unit = _this select 0;

if ( local _unit ) then
{
	// first remove all backpacks in vehicle cargo

	clearBackpackCargoGlobal _unit ;


	// and now add all given backpacks
	_rucks = _this select 1;
	{
		if (count _x < 3) then {
			//when _x looks like: {"B_Kitbag_sgg",15}
			_unit addBackpackCargoGlobal _x;
		} else {
			//when _x looks like: {"B_Kitbag_sgg",15,{{"fing",10},{"fing",10},{"fing",10}}}
			_rClass = _x select 0;//backpack classname
			_rNum = _x select 1; //number of _rClass to add
			_rCon = _x select 2; // array of contents to be added to these rucksacks


			for "_i" from 1 to _rNum step 1 do { //Add a rucksack, add contents to rucksack, repeat.
				_unit addBackpackCargoGlobal [_rClass,1]; //add ruck to vehicle cargo
				_backpack = (everyBackpack _unit) select ((count everyBackpack _unit)-1); // select tbe last added ruck in vehicle cargo
				[_backpack,_rCon,1] call tb3_fnc_SetBackpackCargoInVeh; //using a function because fuck nested for statements		
			};
		};

	} forEach _rucks;

	_handled = true;
} else
{
	_handled = false;
};

_handled // ret
