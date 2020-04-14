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
    if (_wepArg isEqualType []) then {
        if ((_wepArg # 0) isEqualType "") then {
            _wepArg params ["_class","_attachments"];
            _unit addWeapon _class;
            {
                if (_x isEqualType []) then {
                    private _attachment = selectRandom _x;
                    _unit addWeaponItem [_class, _attachment, 1];
                } else {
                    _unit addWeaponItem [_class, _x, 1];
                };
            } forEach _attachments;
        };
        if ((_wepArg # 0) isEqualType []) then {
            private _wepSel = selectRandom _wepArg;
            _wepSel params ["_class","_attachments"];
            _unit addWeapon _class;
            {
                if (_x isEqualType []) then {
                    private _attachment = selectRandom _x;
                    _unit addWeaponItem [_class, _attachment, 1];
                } else {
                    _unit addWeaponItem [_class, _x, 1];
                };
            } forEach _attachments;
        };
    } else {
        _unit addWeapon _x;
    };
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
