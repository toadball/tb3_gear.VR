params ["_unit", "_headgear"];
private _handled;

if ( local _unit ) then {
	removeHeadgear _unit;
	_unit addHeadgear _headgear;

	_handled = true;
} else
{
	_handled = false;
};

_handled // ret
