params ["_unit", "_vest"];
private _handled;

if ( local _unit ) then {

  removeVest _unit;
	_unit addVest _vest;

	_handled = true;
} else
{
	_handled = false;
};

_handled // ret
