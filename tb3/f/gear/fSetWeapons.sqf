private ["_unit", "_weapons", "_priKit", "_secKit", "_pisKit", "_handled"];

_unit = _this select 0;
_weapons = _this select 1;
_priKit = _this select 2;
_secKit = _this select 3;
_pisKit = _this select 4;

if ( local _unit ) then
{

	// Remove all weapons on unit
	{
		_unit removeWeapon _x;
	} forEach (weapons _unit);
	// and now add the weapons
	{
		_unit addWeapon _x;
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
