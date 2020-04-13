params ["_unit", "_items"];
private _handled;

if ( local _unit ) then
{
	// first remove all items
	removeAllAssignedItems _unit;

	// and now add the items
	{
		_unit linkItem _x;
	} forEach _items;

	_handled = true;
} else
{
	_handled = false;
};

_handled // ret
