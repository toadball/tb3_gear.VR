params ["_unit","_outputClass"];

if (isNil "_outputClass") then {
    _outPutClass = "outPutClass";
};

if (!(_unit isKindOf "Man")) exitWith {};

private _uniform = uniform _unit; private _uniformString = format ["uniform[] = {%1};%2", _uniform,endl];
private _vest = vest _unit; private _vestString = format ["vest[] = {%1};%2",_vest,endl];
private _backpack = backpack _unit; private _backpackString = format ["backpack[] = {%1};%2",_backpack,endl];

private _headgear = headgear _unit;
private _headgearString = format ["headgear[] = {%1};%2",_headgear,endl];

private _uniformItems = uniformItems _unit;
private _vestItems = vestItems _unit;
private _backpackItems = backpackItems _unit;

private _allItems = [_uniformItems,_vestItems,_backpackItems];

if (isClass(configFile >> "CfgPatches" >> "ACRE_Main")) then {
    {
        private _containerArr = _x;
        private _containerIndex = _forEachIndex;
        {
            private _item = _x;
            private _itemIndex = _forEachIndex;

            if ([_item] call acre_api_fnc_isRadio) then {
                private _radio = [_x] call acre_api_fnc_getBaseRadio;
                _containerArr set [_itemIndex,_radio];
            }; // if item is a radio, change the entry in the array to the base radio class

        } forEach _containerArr; // for each item in the container array check for radios

        _allItems set [_containerIndex,_containerArr];
    } forEach _allItems; //for each of our containers iterate through their contents for radios
};

{ _allItems set [_forEachIndex,_x call BIS_fnc_consolidateArray]; } forEach _allItems; //now we consolidate each of the sub arrays

{
    private _string = (str _x) splitString "";
    {
        switch (_x) do {
            case "[" : { _string set [_forEachIndex,"{"] };
            case "]" : { _string set [_forEachIndex,"}"] };
        };
    } forEach _string; //replace square brackets with curly brackets for missionConfigFile use by iterating through each character.
    _string = _string joinString "";
    _allItems set [_forEachIndex,_string];

} forEach _allItems; //for each of our containers iterate through their contents arrays.

_uniformItems = _allItems # 0;
_uniformItemsString = format ["uniformContents[] = %1;%2", _uniformItems,endl];

_vestItems = _allItems # 1;
_vestItemsString = format ["vestContents[] = %1;%2", _vestItems,endl];

_backpackItems = _allItems # 2;
_backpackItemsString = format ["backpackContents[] = %1;%2", _backpackItems,endl];

private _goggles = goggles _unit;
private _gogglesString = format ["goggles[] = {%1};%2",_goggles,endl];

private _weapons = weapons _unit;
private _weaponsString = format ["weapons[] = {%1};%2",_weapons joinString ",",endl];

private _primAccs = (primaryWeaponItems _unit) - [""];
private _primAccsString = format ["priKit[] = {%1};%2",_primAccs joinString ",",endl];

private _secAccs = (secondaryWeaponItems _unit) - [""];
private _secAccsString = format ["secKit[] = {%1};%2",_secAccs joinString ",",endl];

private _pisAccs = (handgunItems _unit) - [""];
private _pisAccsString = format ["pisKit[] = {%1};%2",_pisAccs joinString ",",endl];

private _assignedItems = ((assignedItems _units) - (_weapons) - ["ItemRadioAcreFlagged"]);
private _assignedItemsString = format ["assignedItems[] = {%1};%2",_assignedItems joinString ",",endl];


//Create output string
private _output = composeText [
    "class ", _outPutClass, " {", endl,
    toString[9],"ace_earplugs = 1;",toString[10],
    toString[9],"ace_medic = 0;",toString[10],
    toString[9],"ace_engineer = 1;",toString[10],
    toString[9],"ace_eod = 0;",toString[10],
    toString[10],    
    toString[9],"headgearRandom = 0;",toString[10],
    toString[9],"gogglesRandom = 0;",toString[10],
    toString[9],"uniformRandom = 0;",toString[10],
    toString[9],"backpackRandom = 0;",toString[10],
    toString[9],"vestRandom = 0;",toString[10],
    toString[10],
    toString[9], _weaponsString,
    toString[9], _primAccsString,
    toString[9], _secAccsString,
    toString[9], _pisAccsString,
    toString[10],
    toString[9], _assignedItemsString,
    toString[10],
    toString[9], _headgearString,
    toString[9], _gogglesString,
    toString[10],
    toString[9], _uniformString,
    toString[9], _uniformItemsString,
    toString[10],
    toString[9], _vestString,
    toString[9], _vestItemsString,
    toString[10],
    toString[9], _backpackString,
    toString[9], _backpackItemsString,
    "};"
];


copyToClipboard str _output;
str _outPut;
