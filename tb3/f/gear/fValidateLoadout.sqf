// tb3_fnc_util_validateLoadout
//
// Checks container (uniform, vest, backpack) inventory against container capacity
// for all possible containers for a loadout.
//
// Parameters:
// 0: Loadout category <string>
// 1: Loadout name (use "" to validate all loadouts in the category) [Default: ""] <string>
// 2: Enable verbose logging [Default: false] <bool>
//
// Returns true if all loadouts pass validation, otherwise false
//
// Author: VKing


params ["_loadout", ["_gear", ""], ["_verbose", false]];

private _log = {
  params ["_message", ["_alwaysPrint", false]];
  if (_alwaysPrint || _verbose) then {
    systemChat format ["[TB3 Gear] %1", _message];
    diag_log format ["[TB3 Gear] %1", _message];
  };
};

private _missionConfigPath = (missionConfigFile >> "TB3_Gear");
private _configFilePath    = (ConfigFile >> "TB3_Gear");
private _isMissionConfig   = isClass (_missionConfigPath >> _loadout);
private _isConfigFile      = isClass (_configFilePath >> _loadout);
private _cfgPath = configNull;

if ( !(_isMissionConfig || _isConfigFile) ) exitWith {
  systemChat format ["Loadout %1 not found", _loadout];
  false;
};

if (_isMissionConfig) then {
  _cfgPath = _missionConfigPath;
} else {
  _cfgPath = _configFilePath;
};

private _validateGear = {
  params ["_loadoutConfig"];

  if (!isClass _loadoutConfig) exitWith {
    format ["Loadout not found"] call _log;
    false;
  };

  private _loadoutName = configName _loadoutConfig;
  [format ["Validating %1 >> %2", _loadout, _loadoutName], true] call _log;

  private _invalidLoadouts = [];
  
  private _uniform          = getArray (_loadoutConfig >> "uniform");
  private _uniformContents  = getArray (_loadoutConfig >> "uniformContents");
  private _vest             = getArray (_loadoutConfig >> "vest");
  private _vestContents     = getArray (_loadoutConfig >> "vestContents");
  private _backpack         = getArray (_loadoutConfig >> "backpack");
  private _backpackContents = getArray (_loadoutConfig >> "backpackContents");
  
  private _getContentsWeight = {
    params ["_contents"];

    private _totalWeight = 0;
    { // forEach _contents
      private _item        = _x # 0;
      private _amount      = _x # 1;
      private _itemConfig  = configNull;
      private _itemType    = "";
      private _itemWeight  = 0;

      // From CBA_fnc_getItemConfig
      {
        private _config = (configFile >> _x >> _item);

        if (isClass _config) exitWith {
            _itemConfig = _config;
            _itemType = _x;
        };
      } forEach ["CfgWeapons", "CfgMagazines", "CfgGlasses"];
      
      
      if (_itemConfig != configNull) then {
        if (_itemType == "CfgWeapons") then {
          _itemWeight = getNumber (_itemConfig >> "ItemInfo" >> "mass");
        } else {
          _itemWeight = getNumber (_itemConfig >> "mass");
        };
        _totalWeight = _totalWeight + (_itemWeight * _amount);
      };
    } forEach _contents;

    _totalWeight;
  };
  
  private _uniformContentsWeight  = [_uniformContents] call _getContentsWeight;
  private _vestContentsWeight     = [_vestContents] call _getContentsWeight;
  private _backpackContentsWeight = [_backpackContents] call _getContentsWeight;
  
  { // forEach _uniform
    private _uniformClass = _x;
    private _containerClass = getText (configFile >> "CfgWeapons" >> _uniformClass >> "ItemInfo" >> "containerClass");
    private _uniformCapacity = getNumber (configFile >> "CfgVehicles" >> _containerClass >> "maximumLoad");

    if (_uniformContentsWeight > _uniformCapacity) then {
      _invalidLoadouts pushBackUnique _loadoutName;
      [format ["Uniform %2 failed: Load %3 > capacity %4", _loadoutName, _uniformClass, _uniformContentsWeight, _uniformCapacity], true] call _log;
    } else {
      format ["Uniform %1 ok", _uniformClass, _uniformContentsWeight, _uniformCapacity] call _log;
    };
  } forEach _uniform;

  { // forEach _vest
    private _vestClass = _x;
    private _containerClass = getText (configFile >> "CfgWeapons" >> _vestClass >> "ItemInfo" >> "containerClass");
    private _vestCapacity = getNumber (configFile >> "CfgVehicles" >> _containerClass >> "maximumLoad");

    if (_vestContentsWeight > _vestCapacity) then {
      _invalidLoadouts pushBackUnique _loadoutName;
      [format ["Vest %2 failed: Load %3 > capacity %4", _loadoutName, _vestClass, _vestContentsWeight, _vestCapacity], true] call _log;
    } else {
      format ["Vest %1 ok", _vestClass, _vestContentsWeight, _vestCapacity] call _log;
    };
  } forEach _vest;

  { // forEach _backpack
    private _backpackClass = _x;
    private _backpackCapacity = getNumber (configfile >> "CfgVehicles" >> _backpackClass >> "maximumLoad");

    if (_backpackContentsWeight > _backpackCapacity) then {
      _invalidLoadouts pushBackUnique _loadoutName;
      [format ["Backpack %2 failed: Load %3 > capacity %4", _loadoutName, _backpackClass, _backpackContentsWeight, _backpackCapacity], true] call _log;
    } else {
      format ["Backpack %1 ok", _backpackClass, _backpackContentsWeight, _backpackCapacity] call _log;
    };
  } forEach _backpack;

  if (_invalidLoadouts isEqualTo []) then {
    ["Ok", true] call _log;
  } else {
    ["Fail", true] call _log;
  };
  _invalidLoadouts;
};

private _invalidLoadouts = [];
if (_gear != "") then {
  _invalidLoadouts = (_cfgPath >> _loadout >> _gear) call _validateGear;
} else {
  {
    if (!isNil {[_x, "uniform", nil] call BIS_fnc_returnConfigEntry}) then {
      private _res = _x call _validateGear;
      if !(_res isEqualTo []) then {
        _invalidLoadouts pushBackUnique _res # 0;
      };
    };
  } forEach ("true" configClasses (_cfgPath >> _loadout));
};

if (_invalidLoadouts isEqualTo []) then {
  [format ["All loadouts are valid"], true] call _log;
  true;
} else {
  [format ["Some loadouts are invalid: %1", _invalidLoadouts], true] call _log;
  copyToClipboard str _invalidLoadouts;
  false;
};
