params ["_unit"];
private _muzzles;
private _weapon = primaryWeapon _unit;
_handled = false;

if ( _weapon != "" ) then
{
	_muzzles = getArray(configFile >> "cfgWeapons" >> _weapon >> "muzzles");

	if ( (_muzzles select 0) == "this" ) then
	{
		_unit selectWeapon _weapon;
	} else
	{
		_unit selectWeapon (_muzzles select 0);
	};
	_handled = true;
};


_handled // ret
