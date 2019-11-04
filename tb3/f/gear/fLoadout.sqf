//loadout items
private ["_unit","_cfg","_gear","_items","_assignedItems","_weapons","_magazines","_backpack","_backpackRandom","_backpackSel","_headgear","_headgearRandom","_headgearSel","_uniform","_uniformRandom","_uniformSel","_vest","_vestRandom","_vestSel","_goggles","_gogglesRandom","_gogglesSel","_priKit","_secKit","_pisKit","_backpackContents","_vestContents","_uniformContents","_aceEarPlugs","_aceMedic","_vehCargoWeapons","_vehCargoMagazines","_vehCargoItems","_vehCargoRucks"];

//core info
_unit = _this select 0;
_cfg = _this select 1;
_gear  = _this select 2;

//get the defined gear.
TB3_GearPath = (missionConfigFile >> "TB3_Gear");
_weapons 			= getArray (TB3_GearPath >> _cfg >> _gear >> "weapons");
_magazines 			= getArray (TB3_GearPath >> _cfg >> _gear >> "magazines");

_priKit				= getArray (TB3_GearPath >> _cfg >> _gear >> "priKit");
_secKit 			= getArray (TB3_GearPath >> _cfg >> _gear >> "secKit");
_pisKit 			= getArray (TB3_GearPath >> _cfg >> _gear >> "pisKit");

_backpack			= getArray (TB3_GearPath >> _cfg >> _gear >> "backpack");
_backpackRandom 	= getNumber (TB3_GearPath >> _cfg >> _gear >> "backpackRandom");
_backpackContents 	= getArray (TB3_GearPath >> _cfg >> _gear >> "backpackContents");
_headgear			= getArray (TB3_GearPath >> _cfg >> _gear >> "headgear");
_headgearRandom 	= getNumber (TB3_GearPath >> _cfg >> _gear >> "headgearRandom");
_uniform			= getArray (TB3_GearPath >> _cfg >> _gear >> "uniform");
_uniformRandom 		= getNumber (TB3_GearPath >> _cfg >> _gear >> "uniformRandom");
_uniformContents 	= getArray (TB3_GearPath >> _cfg >> _gear >> "uniformContents");
_vest				= getArray (TB3_GearPath >> _cfg >> _gear >> "vest");
_vestRandom 		= getNumber (TB3_GearPath >> _cfg >> _gear >> "vestRandom");
_vestContents 		= getArray (TB3_GearPath >> _cfg >> _gear >> "vestContents");
_goggles			= getArray (TB3_GearPath >> _cfg >> _gear >> "goggles");
_gogglesRandom		= getNumber (TB3_GearPath >> _cfg >> _gear >> "gogglesRandom");
_items				= getArray (TB3_GearPath >> _cfg >> _gear >> "items");
_assignedItems		= getArray (TB3_GearPath >> _cfg >> _gear >> "assignedItems");

_aceEarPlugs	= getNumber (TB3_GearPath >> _cfg >> _gear >> "ace_earplugs");
_aceMedic			= getNumber (TB3_GearPath >> _cfg >> _gear >> "ace_medic"); //0-2
_aceEngineer	= getNumber (TB3_GearPath >> _cfg >> _gear >> "ace_engineer"); //0-2

_vehCargoWeapons 	= getArray (TB3_GearPath >> _cfg >> _gear >> "vehCargoWeapons");
_vehCargoMagazines 	= getArray (TB3_GearPath >> _cfg >> _gear >> "vehCargoMagazines");
_vehCargoItems 		= getArray (TB3_GearPath >> _cfg >> _gear >> "vehCargoItems");
_vehCargoRucks 		= getArray (TB3_GearPath >> _cfg >> _gear >> "vehCargoRucks");

//Remove the unit's current gear if they are a person and not a vehicle, because fuck vehicles. Those fucking cunts, objects too!
if (_unit isKindOf "Man") then {

	if ( local _unit ) then {
		removeAllAssignedItems _unit;
		removeAllItemsWithMagazines _unit;
		{_unit removeWeapon _x;} forEach weapons _unit;
		if ((count _uniform) > 0) then {
			if (_uniformRandom == 1) then {
				_uniformSel = _uniform call BIS_fnc_selectRandom;
				if(_uniformSel != uniform _unit) then {
					[_unit,_uniformSel] call tb3_fnc_SetUniform;
				};
			} else {
				if(_uniform select 0 != uniform _unit) then {
					[_unit,_uniform select 0] call tb3_fnc_SetUniform;
				};
			};
		} else {
			removeUniform _unit;
		};
		if ((count _backpack) > 0) then {
			if (_backpackRandom == 1) then {
				_backpackSel = _backpack call BIS_fnc_selectRandom;
				if(_backpackSel != backpack _unit) then {
					[_unit,[_backpackSel]] call tb3_fnc_Setbackpack;
				};
			} else {
				if(_backpack select 0 != backpack _unit) then {
					[_unit,[_backpack select 0]] call tb3_fnc_Setbackpack;
				};
			};
		} else {
			removeBackpack _unit;
		};
		if ((count _vest) > 0) then {
			if (_vestRandom == 1) then {
				_vestSel = _vest call BIS_fnc_selectRandom;
				if(_vestSel != vest _unit) then {
					[_unit,_vestSel] call tb3_fnc_Setvest;
				};
			} else {
				if(_vest select 0 != vest _unit) then {
					[_unit,_vest select 0] call tb3_fnc_Setvest;
				};
			};
		} else {
			removeVest _unit;
		};
		removeGoggles _unit;
		removeHeadGear _unit; //no you may not leave your hat on.
	};
};

	if ((count _assignedItems) > 0) then { [_unit,_assignedItems] call tb3_fnc_SetLinkedItems; };
	if ((count _headgear) > 0) then {
		if (_headgearRandom == 1) then {
			_headgearSel = _headgear call BIS_fnc_selectRandom;
			[_unit,_headgearSel] call tb3_fnc_SetHeadgear;
		} else {  [_unit,_headgear select 0] call tb3_fnc_SetHeadgear; };
	};
	if ((count _goggles) > 0) then {
		if (_gogglesRandom == 1) then {
			_gogglesSel = _goggles call BIS_fnc_selectRandom;
			[_unit,_gogglesSel] call tb3_fnc_SetGoggles;
		} else { [_unit,_goggles select 0] call tb3_fnc_SetGoggles; };
	};

	if ((count _magazines) > 0) then {	[_unit,_magazines] call tb3_fnc_SetMagazines; };
	if ((count _weapons) > 0) then { [_unit,_weapons,_priKit,_secKit,_pisKit] call tb3_fnc_SetWeapons; };
	if ((count _items) > 0) then { [_unit,_items] call tb3_fnc_SetItems;	};

	if (_aceEarPlugs == 1) then { _unit setVariable ["ACE_hasEarPlugsIn", true, true]; };
	if (!(isNil "_aceMedic")) then { _unit setVariable ["ace_medical_medicClass", _aceMedic, true]; };
  if (!(isNil "_aceEngineer")) then { _unit setVariable ["ACE_IsEngineer", _aceEngineer, true]; };

	if ((count _backpackContents) > 0) then { [_unit,_backpackContents] call tb3_fnc_setRuckContents; };
	if ((count _uniformContents) > 0) then { [_unit,_uniformContents] call tb3_fnc_setUniformContents; };
	if ((count _vestContents) > 0) then { [_unit,_vestContents] call tb3_fnc_setVestContents; };

	if (!(_unit isKindOf "Man")) then {

		if ( local _unit ) then {
			//get rid the stuff in the vehicle already. If you wanted it tough titties don't bloody try to add extra stuff via a large framework gear script, can't have your cake and eat it.
			clearItemCargoGlobal _unit;
			clearBackpackCargoGlobal _unit;
			clearMagazineCargoGlobal _unit;
			clearWeaponCargoGlobal _unit;
			//well, you probably could...but I'm too lazy to let you.

			if ((count _vehCargoItems) > 0) then { [_unit,_vehCargoItems] call tb3_fnc_setVehCargoItems; };
			if ((count _vehCargoWeapons) > 0) then { [_unit,_vehCargoWeapons] call tb3_fnc_setVehCargoWeapons; };
			if ((count _vehCargoMagazines) > 0) then { [_unit,_vehCargoMagazines] call tb3_fnc_setVehCargoMagazines; };
			if ((count _vehCargoRucks) > 0) then { [_unit,_vehCargoRucks] call tb3_fnc_setVehCargoBackpacks; };
		};
	};

	if ((isClass(configFile >> "CfgPatches" >> "ACRE_Main")) && (isClass(missionConfigFile >> "TB3_ACRE2")) && {(getNumber(TB3_Settings >> "ACRE2" >>  "babelEnabled") == 1)}) then {
		if ((count _languages) > 0) then { [_unit,_languages] call tb3_fnc_setLanguages; };
	};

	_unit setVariable ["tb3_loadout", _this, true];
	_handled = true;
