params ["_unit", "_backpackARR"];
private _handled;

if ( local _unit ) then {
	switch (count _backpackARR) do {
		case 1 : {
			removeBackpack _unit;

			private _backpack = _backpackARR select 0;

			_unit addBackpack _backpack;

			_handled = true;
		};
		case 2 : {
			if ((_backpackARR select 1) == 1) then {
				removeBackpack _unit;

				private _backpack = _backpackARR select 0;

				_unit addBackpack _backpack;
				clearAllItemsFromBackpack _unit;

				_handled = true;
			} else {
				removeBackpack _unit;

				private _backpack = _backpackARR select 0;

				_unit addBackpack _backpack;

				_handled = true;
			};
		};
		default {_handled = false;};
	};

} else
{
	_handled = false;
};

_handled // ret
