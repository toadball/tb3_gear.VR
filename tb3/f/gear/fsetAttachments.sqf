params ["_unit","_weapon","_attachments"];
private _handled;
{
  if (_x isEqualType []) then { //if presented with an array within _attachments, randomly select an attachment from those listed
    private _attachment = selectRandom _x;
    _unit addWeaponItem [_weapon, _attachment, 1];
    _handled = true;
  } else { _unit addWeaponItem [_weapon, _x, 1]; _handled = true; };
} forEach _attachments;

_handled;
