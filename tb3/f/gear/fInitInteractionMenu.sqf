
if !(hasInterface) exitWith {};
if (isNil "tb3_fnc_loadout" && isNil "tb3_gear_fnc_loadout") exitWith {diag_log "setupLoadoutInteraction: TB3 Gear not found"};
if (isNil "tb3_fnc_loadout") then {
    tb3_fnc_loadout = tb3_gear_fnc_loadout;
};

if (isNil "TB3_LOADOUT") then {TB3_LOADOUT = ""};
if (isNil "TB3_REMOTE_LOADOUT") then {TB3_REMOTE_LOADOUT = false};
if (isNil "TB3_DEBUG_ADMIN") then {TB3_DEBUG_ADMIN = false};

private _loadoutClasses = ("true" configClasses (missionConfigFile >> "TB3_gear")) + ("true" configClasses (configFile >> "TB3_gear"));
if (count _loadoutClasses < 1) exitWith {diag_log "No TB3 loadouts found"};


//private _isAdmin = serverCommandAvailable "#logout";
private _tb3Menu = ["TB3Menu", "TB3 Gear","",{},{serverCommandAvailable "#logout" || TB3_DEBUG_ADMIN}] call ACE_interact_menu_fnc_createAction;
[ACE_PLAYER, 1, ["ACE_SelfActions"], _tb3Menu] call ace_interact_menu_fnc_addActionToObject;



_loadoutClasses = _loadoutClasses apply {configName _x};

private _pageSize = 15; // Amount of loadout classes per menu page

for "_i" from 0 to (count _loadoutClasses - 1) do {
    if (_i % _pageSize == 0) then {
        _loadoutClasses pushBack [];
    };
    _loadoutClasses # (count _loadoutClasses - 1) pushBack _loadoutClasses # 0;
    _loadoutClasses deleteAt 0;
};


private _loadoutClassesChildPages = {
    params ["_target", "_player", "_loadoutClasses"];

    private _actions = [];

    private _loadoutClassesChildItems = {
        params ["_target", "_player", "_loadoutClasses"];
        private _actions = [];
        {
            private _childStatement = {
                params ["_target", "_player", "_loadoutClass"];
                {
                    TB3_LOADOUT = _loadoutClass;
                    private _loadoutData = _x getVariable "tb3_loadout";
                    _loadoutData set [1, _loadoutClass];
                    _loadoutData call tb3_fnc_loadout;
                } forEach allUnits + vehicles;
            };
            private _action = [_x, _x, "", _childStatement, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
            _actions pushBack [_action, [], _target];
        } forEach _loadoutClasses;
        _actions;
    };

    if (count _loadoutClasses == 1) then {
        // If there are less than _pageSize amount of loadout classes, don't make a page, just plop them in there.
        _actions = [_target, _player, _loadoutClasses # 0] call _loadoutClassesChildItems;
    } else {
        // Make pages with the loadout classes as children
        {
            private _action = [format ["LoadoutsPage%1",_forEachIndex+1], format ["Page %1",_forEachIndex+1], "", {}, {true}, _loadoutClassesChildItems, _x] call ace_interact_menu_fnc_createAction;
            _actions pushBack [_action, [], _target];
        } forEach _loadoutClasses;
    };
    _actions;
};

private _selectLoadout = ["SelectLoadout","Change Loadouts","",{},{true},_loadoutClassesChildPages,_loadoutClasses] call ACE_interact_menu_fnc_createAction;
[ACE_PLAYER, 1, ["ACE_SelfActions","TB3Menu"], _selectLoadout] call ace_interact_menu_fnc_addActionToObject;



// List all loadouts in the selected loadout class and make the action apply the loadout to the player
private _loadoutChildren = {
    private _actions = [];
    
    private _cfgPath = configNull;
    if (isClass (missionConfigFile >> "TB3_Gear" >> TB3_LOADOUT)) then {
        _cfgPath = (missionConfigFile >> "TB3_Gear" >> TB3_LOADOUT);
    } else {
        _cfgPath = (configFile >> "TB3_Gear" >> TB3_LOADOUT);
    };

    // Get all child loadouts that can be applied to players (avoid vehicle and ammo box loadouts)
    private _loadouts = "!(isNil {[_x, ""uniform"", nil] call BIS_fnc_returnConfigEntry})" configClasses _cfgPath;

    {
        private _childStatement = {
            params ["_target", "_player", "_loadoutName"];
            [_target, TB3_LOADOUT, _loadoutName] call tb3_fnc_loadout;
        };

        private _action = [_x, _x, "", _childStatement, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
        _actions pushBack [_action, [], _target];
    } forEach (_loadouts apply {configName _x});

    _actions;
};


private _applyLoadout = ["ApplyLoadout","Apply Loadout","",{},{!(TB3_LOADOUT isEqualTo "")}, _loadoutChildren] call ACE_interact_menu_fnc_createAction;
[ACE_PLAYER, 1, ["ACE_SelfActions","TB3Menu"], _applyLoadout] call ace_interact_menu_fnc_addActionToObject;


private _enableTargetApplication = ["EnableTargetApplication","Enable menu on units","",{TB3_REMOTE_LOADOUT = true},{!TB3_REMOTE_LOADOUT && {serverCommandAvailable "#logout" || TB3_DEBUG_ADMIN}}] call ACE_interact_menu_fnc_createAction;
[ACE_PLAYER, 1, ["ACE_SelfActions","TB3Menu"], _enableTargetApplication] call ace_interact_menu_fnc_addActionToObject;
private _enableTargetApplication = ["DisableTargetApplication","Disable menu on units","",{TB3_REMOTE_LOADOUT = false},{TB3_REMOTE_LOADOUT && {serverCommandAvailable "#logout" || TB3_DEBUG_ADMIN}}] call ACE_interact_menu_fnc_createAction;
[ACE_PLAYER, 1, ["ACE_SelfActions","TB3Menu"], _enableTargetApplication] call ace_interact_menu_fnc_addActionToObject;

private _applyRemoteLoadout = ["ApplyLoadout","Apply Loadout","",{},{TB3_REMOTE_LOADOUT && {!(TB3_LOADOUT isEqualTo "") && {serverCommandAvailable "#logout" || TB3_DEBUG_ADMIN}}}, _loadoutChildren] call ACE_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_MainActions"], _applyRemoteLoadout, true] call ace_interact_menu_fnc_addActionToClass;
