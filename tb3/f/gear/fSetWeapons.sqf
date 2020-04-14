params ["_unit", "_weapons", "_priKit", "_secKit", "_pisKit"];
private _handled;

if ( local _unit ) then {
    // Remove all weapons on unit
    { _unit removeWeapon _x; } forEach (weapons _unit);

    // and now add the weapons
    {
      private _wepArg = _x;
      private _class;
      private _attachments;

      if (_wepArg isEqualType []) then { //when presented with an array within _weapons

        switch true do {
            case (_wepArg isEqualTypeAll ""): { //presented with an array of strings within _weapons, select weapon at random
              _class = selectRandom _x;
              _unit addWeapon _class;
            };
            case (_wepArg isEqualTypeArray ["",[]]): { //standard weapon with attachments array - _wepArg consists of a string followed by an array
              _wepArg params ["_class","_attachments"];
              _unit addWeapon _class;
              [_unit, _class, _attachments] call tb3_fnc_setAttachments;
            };
            case (_wepArg isEqualTypeAll []): { //multiple weapon and attachment arrays - _wepArg is an array of arrays only
              private _wepSel = selectRandom _wepArg;
              _wepSel params ["_class","_attachments"];
              _unit addWeapon _class;
              [_unit, _class, _attachments] call tb3_fnc_setAttachments;
            };
            default { false; }; //if you have some how managed to not do any of the above I'm honestly at a loss, go read the docs. please.
          };
        } else { _unit addWeapon _x; };
    } forEach _weapons;


    if ((count _priKit) > 0) then {
        {
            _unit addPrimaryWeaponItem _x;
        } forEach _priKit;
    };

    //Secondary Weapon attachments: Launchers
    if ((count _secKit) > 0) then {
        {
            _unit addSecondaryWeaponItem _x;
        } ForEach _secKit;
    };
    //Pistol weapon attachments
    if ((count _pisKit) > 0) then {
        {
            _unit addHandgunItem _x;
        } ForEach _pisKit;
    };

    _handled = true;
} else {
    _handled = false;
};

_handled // ret
