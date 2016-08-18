private ["_object","_return"];

_object = _this select 0; //classname (String)

//return types
if ((_object isKindOf ["Rifle", configFile >> "CfgWeapons"]) || (_object isKindOf ["Launcher", configFile >> "CfgWeapons"]) || (_object isKindOf ["Pistol", configFile >> "CfgWeapons"])) then {_return = "Weapon";}; //isWeapon
if (_object isKindOf ["CA_Magazine", configFile >> "CfgMagazines"]) then {_return = "Magazine"};
if ((_object isKindOf ["ItemCore", configFile >> "CfgWeapons"]) || (_object isKindOf ["Binocular", configFile >> "CfgWeapons"])) then {_return = "Item";}; //isItem
	if (isClass(configFile >> "CfgPatches" >> "ACE_Main")) then {
		if (_object isKindOf ["ACE_ItemCore", configFile >> "CfgWeapons"])  then {
			_return = "Item";
		};
	}; //isItem
	if (isClass(configFile >> "CfgPatches" >> "ACRE_Main")) then {
		if ([_object] call acre_api_fnc_isRadio)  then {
			_return = "Item";
		};
	}; //isItem
if (_object isKindOf ["Bag_Base", configFile >> "CfgVehicles"]) then {_return = "Backpack";}; //isBackpack

_return;