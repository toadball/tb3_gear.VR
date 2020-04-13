params ["_unit", "_weapons", "_priKit", "_secKit", "_pisKit","_weaponsRandom"];
private _handled = false;
/*
New weapons array:
weapons[] = {
  {arifle_TRG21_GL_F,
    {optic_Holosight_khk_F,acc_pointer_IR,30Rnd_556x45_Stanag,1Rnd_HE_Grenade_shell}
  },
  Rangefinder
};
Array set up for randmoisation

weapons[] = {
  {
    {arifle_TRG21_GL_F,{optic_Holosight_khk_F,acc_pointer_IR,30Rnd_556x45_Stanag,1Rnd_HE_Grenade_shell}},
    {arifle_TRG21_GL_F,{optic_MRCO,acc_pointer_IR,30Rnd_556x45_Stanag,1Rnd_HE_Grenade_shell}},
    {arifle_Mk20_GL_plain_F,{optic_MRCO,acc_pointer_IR,30Rnd_556x45_Stanag,1Rnd_HE_Grenade_shell}}
  },
  Rangefinder
};

*/
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
          _unit addWeaponItem [_class, _x, 1];
        } forEach _attachments;

      };
      if ((_wepArg # 0) isEqualType []) then {
        private _wepSel = selectRandom _wepArg;
        _wepSel params ["_class","_attachments"];

        _unit addWeapon _class;
        {
          _unit addWeaponItem [_class, _x, 1];
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
} else
{
	_handled = false;
};

_handled // ret
