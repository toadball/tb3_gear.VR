//core info
params ["_unit","_cfg","_gear",["_respawn",true],["_mode",0]];

private _missionConfigPath = (missionConfigFile >> "TB3_Gear");
private _configFilePath = (ConfigFile >> "TB3_Gear");
private _isMissionConfig = isClass (_missionConfigPath >> _cfg >> _gear);
private _isConfigFile = isClass (_configFilePath >> _cfg >> _gear);
if ( !((_isMissionConfig) || (_isConfigFile)) ) exitWith {
  _handled = false;
  _handled;
};

switch (_mode) do {
  case 1: { //Force configFile use
    TB3_GearPath = _configFilePath;
  };
  case 0: {
    if (isClass (_missionConfigPath >> _cfg >> _gear)) then {
      TB3_GearPath = _missionConfigPath;
    } else {
      if (isClass (_configFilePath >> _cfg >> _gear)) then {
        TB3_GearPath = _configFilePath;
      };
    };
  };
};

private _weapons = getArray (TB3_GearPath >> _cfg >> _gear >> "weapons") + getArray (TB3_GearPath >> _cfg >> _gear >> "moreWeapons");
private _magazines = getArray (TB3_GearPath >> _cfg >> _gear >> "magazines");

private _priKit = getArray (TB3_GearPath >> _cfg >> _gear >> "priKit");
private _secKit = getArray (TB3_GearPath >> _cfg >> _gear >> "secKit");
private _pisKit = getArray (TB3_GearPath >> _cfg >> _gear >> "pisKit");

private _backpack = getArray (TB3_GearPath >> _cfg >> _gear >> "backpack");
private _backpackContents = getArray (TB3_GearPath >> _cfg >> _gear >> "backpackContents") + getArray (TB3_GearPath >> _cfg >> _gear >> "moreBackpackContents");

private _gunbagWeapon = getArray (TB3_GearPath >> _cfg >> _gear >> "ace_gunbagWeapon");

private _headgear = getArray (TB3_GearPath >> _cfg >> _gear >> "headgear");

private _uniform = getArray (TB3_GearPath >> _cfg >> _gear >> "uniform");
private _uniformContents = getArray (TB3_GearPath >> _cfg >> _gear >> "uniformContents") + getArray (TB3_GearPath >> _cfg >> _gear >> "moreUniformContents");

private _vest = getArray (TB3_GearPath >> _cfg >> _gear >> "vest");
private _vestContents = getArray (TB3_GearPath >> _cfg >> _gear >> "vestContents") + getArray (TB3_GearPath >> _cfg >> _gear >> "moreVestContents");

private _goggles = getArray (TB3_GearPath >> _cfg >> _gear >> "goggles");
private _playerGoggles = goggles _unit;
private _allowPlayerGoggles = getNumber (TB3_GearPath >> _cfg >> _gear >> "allowPlayerGoggles");

private _items = getArray (TB3_GearPath >> _cfg >> _gear >> "items");
private _assignedItems = getArray (TB3_GearPath >> _cfg >> _gear >> "assignedItems");

private _aceEarPlugs = getNumber (TB3_GearPath >> _cfg >> _gear >> "ace_earplugs");
private _aceMedic = getNumber (TB3_GearPath >> _cfg >> _gear >> "ace_medic"); //0-2
private _aceEngineer = getNumber (TB3_GearPath >> _cfg >> _gear >> "ace_engineer"); //0-2
private _aceEOD = getNumber (TB3_GearPath >> _cfg >> _gear >> "ace_eod"); //0-1

private _vehCargoWeapons = getArray (TB3_GearPath >> _cfg >> _gear >> "vehCargoWeapons");
private _vehCargoMagazines = getArray (TB3_GearPath >> _cfg >> _gear >> "vehCargoMagazines");
private _vehCargoItems = getArray (TB3_GearPath >> _cfg >> _gear >> "vehCargoItems");
private _vehCargoRucks = getArray (TB3_GearPath >> _cfg >> _gear >> "vehCargoRucks");

//Remove the unit's current gear if they are a person and not a vehicle, because fuck vehicles. Those fucking cunts, objects too!
if (_unit isKindOf "Man") then {

	if ( local _unit ) then {
		removeAllAssignedItems _unit;
		removeAllItemsWithMagazines _unit;
		{_unit removeWeapon _x;} forEach weapons _unit;
    if ((count _uniform) < 1) then {
      removeUniform _unit;
    } else {
      if ((count _uniform) > 1) then {
        private _uniformSel = selectRandom _uniform;
        if(_uniformSel != uniform _unit) then {
          [_unit,_uniformSel] call tb3_fnc_SetUniform;
        };
      } else {
        if(_uniform select 0 != uniform _unit) then {
          [_unit,_uniform select 0] call tb3_fnc_SetUniform;
        };
      };
    };
    if ((count _backpack) < 1) then {
      removeBackpack _unit;
    } else {
      if ((count _backpack) > 1) then {
        private _backpackSel = selectRandom _backpack;
        if(_backpackSel != backpack _unit) then {
          [_unit,[_backpackSel]] call tb3_fnc_Setbackpack;
        };
      } else {
        if(_backpack select 0 != backpack _unit) then {
          [_unit,[_backpack select 0]] call tb3_fnc_Setbackpack;
        };
      };
    };
    if ((count _vest) < 1) then {
      removeVest _unit;
    } else {
      if ((count _vest) > 1) then {
        private _vestSel = selectRandom _vest;
        if(_vestSel != vest _unit) then {
          [_unit,_vestSel] call tb3_fnc_Setvest;
        };
      } else {
        if(_vest select 0 != vest _unit) then {
          [_unit,_vest select 0] call tb3_fnc_Setvest;
        };
      };
    };
    if (_allowPlayerGoggles <= 0) then {
        removeGoggles _unit;
    };
		removeHeadGear _unit; //no you may not leave your hat on.
	};
};

if ((count _assignedItems) > 0) then { [_unit,_assignedItems] call tb3_fnc_SetLinkedItems; };
if ((count _headgear) > 0) then {
	if ((count _headgear) > 1) then {
		private _headgearSel = selectRandom _headgear;
		[_unit,_headgearSel] call tb3_fnc_SetHeadgear;
	} else {  [_unit,_headgear select 0] call tb3_fnc_SetHeadgear; };
};

if ((count _goggles) > 0) then {
  if ( (!(isPlayer _unit)) || (isNil "_allowPlayerGoggles") || (_allowPlayerGoggles <= 0) ) then {
    if ((count _goggles) > 1) then {
        private _gogglesSel = selectRandom _goggles;
        [_unit,_gogglesSel] call tb3_fnc_SetGoggles;
    } else {
      [_unit,_goggles # 0] call tb3_fnc_SetGoggles;
    };
  } else {
      [_unit,_playerGoggles] call tb3_fnc_SetGoggles;
  };
};

if ((count _magazines) > 0) then {	[_unit,_magazines] call tb3_fnc_SetMagazines; };
if ((count _weapons) > 0) then { [_unit,_weapons,_priKit,_secKit,_pisKit] call tb3_fnc_SetWeapons; };
if ((count _items) > 0) then { [_unit,_items] call tb3_fnc_SetItems;	};

if (_aceEarPlugs == 1) then { _unit setVariable ["ACE_hasEarPlugsIn", true, true]; };
if (!(isNil "_aceMedic")) then { _unit setVariable ["ace_medical_medicClass", _aceMedic, true]; };
if (!(isNil "_aceEngineer")) then { _unit setVariable ["ACE_IsEngineer", _aceEngineer, true]; };
if (_aceEOD == 1) then { _unit setVariable ["ACE_isEOD", true, true]; };

if ((count _backpackContents) > 0) then { [_unit,_backpackContents] call tb3_fnc_setRuckContents; };
if ((count _uniformContents) > 0) then { [_unit,_uniformContents] call tb3_fnc_setUniformContents; };
if ((count _vestContents) > 0) then { [_unit,_vestContents] call tb3_fnc_setVestContents; };
if ((count _gunbagWeapon) > 0) then { [_unit,_gunbagWeapon] call tb3_fnc_setGunbagWeapon; };

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

_unit setVariable ["tb3_loadout", [_unit,_cfg,_gear], true];

if (_respawn && ( !(_unit getVariable ["tb3_loadout_respawnEH", false]) )) then {
  _unit setVariable ["tb3_loadout_respawnEH", true, true];

  _unit addMPEventHandler ["MPRespawn", {
    params ["_unit", "_corpse"];
    private _loadoutParams = _unit getVariable "tb3_loadout";
    _loadoutParams set [0,_unit];
    _loadoutParams call tb3_fnc_Loadout;
  }];
};


_handled = true;
_handled;
