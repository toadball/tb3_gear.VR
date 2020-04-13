params ["_unit", "_goggles"];
private _handled;

if ( local _unit ) then {
	removeGoggles _unit;
	_unit addGoggles _goggles;

	_handled = true;
} else
{
	_handled = false;
};

_handled // ret
