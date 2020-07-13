params ["_loadout", ["_gear", ""]];

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

  if (!isClass _loadoutConfig) exitWith {false};
  
  private _uniform          = getArray (_loadoutConfig >> "uniform");
  private _uniformContents  = getArray (_loadoutConfig >> "uniformContents");
  private _vest             = getArray (_loadoutConfig >> "vest");
  private _vestContents     = getArray (_loadoutConfig >> "vestContents");
  private _backpack         = getArray (_loadoutConfig >> "backpack");
  private _backpackContents = getArray (_loadoutConfig >> "backpackContents");
  
  private _getContentsWeight = {
    params ["_contents"];
    { // forEach _ontents
      private _item        = _x;
      private _itemConfig  = configNull;
      private _itemType    = "";
      private _itemWeight  = 0;
      private _totalWeight = 0;

      // From CBA_fnc_getItemConfig
      {
        private _config = configFile >> _x >> _item;

        if (isClass _config) exitWith {
            _itemConfig = _config;
            _itemType = _x;
        };
      } forEach ["CfgWeapons", "CfgMagazines", "CfgGlasses"];
      //
      
      if (_itemConfig != configNull) then {
        if (_itemType == "CfgWeapons") then {
          _itemWeight = getNumber (configFile >> _itemConfig >> "ItemInfo" >> "mass");
        } else {
          _itemWeight = getNumber (configFile >> _itemConfig >> "mass");
        }
        _totalWeight = _totalWeight + _itemWeight;
      };
    } forEach _contents;

    _totalWeight;
  };
  
  private _uniformContentsWeight  = _uniformContents call _getContentsWeight;
  private _vestContentsWeight     = _vestContents call _getContentsWeight;
  private _backpackContentsWeight = _backpackContents call _getContentsWeight;

  private _success = true;
  
  { // forEach _uniform
    private _uniformClass = _x;
    private _supplyString = getText (configFile >> "CfgWeapons" >> _uniformClass >> "ItemInfo" >> "containerClass");
    private _capacityArray = _supplyString splitString "";
    _capacityArray deleteRange [0, 6];
    private _uniformCapacity = parseNumber (_capacityArray joinString "");

    if (_uniformContentsWeight > _uniformCapacity) then {
      _success = false;
      private _errorMessage = format ["Uniform items for loadout %1 cannot fit in uniform %2", _gear, _uniformClass];
      systemChat _errorMessage;
      diag_log _errorMessage;
    };
  } forEach _uniform;

  { // forEach _vest
    private _vestClass = _x;
    private _supplyString = getText (configFile >> "CfgWeapons" >> _vestClass >> "ItemInfo" >> "containerClass");
    private _capacityArray = _supplyString splitString "";
    _capacityArray deleteRange [0, 6];
    private _vestCapacity = parseNumber (_capacityArray joinString "");

    if (_vestContentsWeight > _vestCapacity) then {
      _success = false;
      private _errorMessage = format ["Vest items for loadout %1 cannot fit in vest %2", _gear, _vestClass];
      systemChat _errorMessage;
      diag_log _errorMessage;
    };
  } forEach _vest;

  { // forEach _backpack
    private _backpackClass = _x;
    private _backpackCapacity = getNumber (configfile >> "CfgVehicles" >> _backpackClass >> "maximumLoad");

    if (_backpackContentsWeight > _backpackCapacity) then {
      _success = false;
      private _errorMessage = format ["Backpack items for loadout %1 cannot fit in backpack %2", _gear, _backpackClass];
      systemChat _errorMessage;
      diag_log _errorMessage;
    };
  } forEach _uniform;
  
  _success;
};

private _success = true;
if (_gear != "") then {
  _success = [(_cfgPath >> _loadout >> _gear)] call _validateGear;
} else {
  {
    if (!isNil ([_x, "uniform", nil] call BIS_fnc_returnConfigEntry)) then {
      if ([_x] call _validateGear == false) then {_success = false};
    };
  } forEach ("true" configClasses (_cfgPath >> _loadout));
};
_success;
