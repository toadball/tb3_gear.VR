# TB3 Gear System (Stand Alone Version)

This document details the implementation and usage of the TB3 standalone gear system outside of the TB3 mission framework.

You will require the following to implement this gear script:

* TB3 gear system example mission files, available on github: https://github.com/toadball/tb3_gear.VR
* A good script \ text editor such as: Notepad++, Visual Studio Code, or Atom is also recommended.


## Adding the TB3 gear system to your mission.
To setup the system extract the description.ext and tb3 folder and contents to your mission folder.
If you have an existing description.ext do not overwrite it, instead include the following:

```cpp
#include "tb3\loadouts.hpp"

class CfgFunctions {
	class tb3 {
        #include "tb3\f\gear\CfgFunctions.hpp"
	};
};

```

This will include the loadout definitions in your description.ext and it will compile all the loadout functions.
If you have an existing CfgFunctions, simply include the TB3 class and it's underlying includes.
If you use other TB3 modules simply make sure you're including their CfgFunctions definitions as normal alongisde the TB3 gear ones.

## Adding a loadout to a unit.
Loadouts can be added to units using the following in the unit’s init line:
```sqf
[this,"ExampleSide","ExampleLoadout"] call tb3_fnc_Loadout;
```

The loadout function “tb3_floadout” will search the TB3_Gear class in your description.ext file (included with the loadouts.hpp file) for two things: The side class, in this case ExampleSide, and the loadout class, in this case ExampleLoadout. Once the appropriate loadout is found it will use a variety of functions to apply this loadout to the unit the function is being called on. Note that the system will remove ALL existing gear prior to adding that defined in the loadout.

## Creating a new loadout.
The tb3 gear system can be used to add equipment to a unit or the inventory space of a vehicle or object (it cannot alter the vehicles on board weapons).

The loadouts.hpp file contains the TB3_gear class, within this we define the side classes which will contain the various unit/vehicle inventory loadouts.
In a practical example, we have a mission with two sides, SIDE1 and SIDE2. So in our loadouts file we will have the TB3_Gear class and within that two sub classes: class SIDE1 and class SIDE2.
Within each of these we will have the various loadouts we want to give units for that specific side  the example below.

```cpp
class TB3_Gear {
  //everything between the {} are within the defined class.
  class SIDE1 {
    class RIFLEMAN {};
	class TEAMLEADER {};
	class VEHICLEINVENTORY {};
  };
	class SIDE2 {
	class RIFLEMAN {};
	class TEAMLEADER {};
	class VEHICLEINVENTORY {};		
  };
};
```

You will notice in the above example that we haven’t specified any equipment in the loadouts.
This is done with a number of variables, some are specific to unit inventories and others to vehicle inventories.

### Unit Specific variables:
```cpp
// Add a rifle and rangefinder to the unit
weapons[] = {"arifle_Mk20_GL_F","Rangefinder"};
```
```cpp
// Add rifle with attachments and rangefinder to the unit
weapons[] = {
  {"arifle_Mk20_GL_F",
    {"optic_Arco","acc_pointer_IR","30Rnd_556x45_Stanag","1Rnd_HE_Grenade_shell"}
  },
  "Rangefinder"
};
```
```cpp
// Add rifle with attachments and random optics along with a rangefinder
weapons[] = {
  {"arifle_Mk20_GL_F",
    {{"optic_Arco", "optic_Hamr", "optic_Aco"},"acc_pointer_IR","30Rnd_556x45_Stanag","1Rnd_HE_Grenade_shell"}
  },
  "Rangefinder"
};
```
```cpp
// Add a random rifle from the list along with the rangefinder
weapons[] = {
  {
    {"arifle_TRG21_GL_F",
      {"optic_Holosight_khk_F","acc_pointer_IR","30Rnd_556x45_Stanag","1Rnd_HE_Grenade_shell"}
    },
    {"arifle_TRG21_GL_F",
      {"optic_MRCO","acc_pointer_IR","30Rnd_556x45_Stanag","1Rnd_HE_Grenade_shell"}
    },
    {"arifle_Mk20_GL_plain_F",
      {"optic_MRCO","acc_pointer_IR","30Rnd_556x45_Stanag","1Rnd_HE_Grenade_shell"}
    }
  },
  "Rangefinder"
};
```

Weapons: This is an array containing the classname strings for all weapons added to a unit primary weapon, secondary weapon, launcher weapon, and binocular type weapons.
Within this you can specify weapons as simple classnames or as arrays. Arrays as shown above will allow for you to specify attachments including magazines on the weapon, or a selection of weapons and attachments to randomly draw from.

`assignedItems[] = {"ItemRadio","ItemMap","ItemCompass","ItemWatch","ItemGPS"};`

Assigned/Linked Items: This array contains the classname strings for all the items you want to be linked to a unit on start, these occupy the assigned item slots in a unit’s inventory and included night vision goggles.

ACRE Note: Do not add any ACRE radios to this array.

`headgear[] = {"H_HelmetB_plain_mcamo"};`

Headgear: This array should contain only classname strings of the headgear which you want to be applied to the unit. Adding multiple entries will randomize what headgear is applied to the unit.

`goggles[] = {"G_Shades_Black"};`

Goggles/Facewear: This array should contain only one classname string for the worn goggles or facewear of a unit.

`uniform[] = {"U_B_CTRG_1"};`

`uniform[] = {"U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3"};`

Clothing/Uniform: This array should contain only classname strings of the clothing/Uniform which you want to be applied to the unit. Adding multiple entries will randomize what clothing/Uniform is applied to the unit.

```cpp
uniformContents[] = {
	{"30Rnd_556x45_Stanag",3},  // {classname,number}
	{"SmokeShell",2},
	{"Chemlight_green",2},
	{"FirstAidKit",1},
	{"ACRE_PRC148",1}
};
```

Uniform Contents: This array is an array of arrays containing the classname string of the magazines, items, and weapons to be added to the uniform and the quantity to be added.

`vest[] = {"V_PlateCarrierL_CTRG"};`

`vest[] = {"V_PlateCarrierL_CTRG","V_Chestrig_oli","V_PlateCarrier1_rgr","V_BandollierB_oli"};`

Vest: This array should contain only classname strings of the vest/loadbearing equipment which you want to be applied to the unit. Adding multiple entries will randomize what vest is applied to the unit.

```cpp
vestContents[] = {
	{"30Rnd_556x45_Stanag",5},
	{"30Rnd_556x45_Stanag_Tracer_Red",1},
	{"1Rnd_HE_Grenade_shell",7},
	{"1Rnd_SmokeRed_Grenade_shell",2},
	{"1Rnd_SmokeGreen_Grenade_shell",2},
	{"HandGrenade",2},
	{"Chemlight_green",4},
	{"I_IR_Grenade",1},
	{"FirstAidKit",1}
};
```
Vest Contents:  This array is an array of arrays containing the classname string of the magazines, items, and weapons to be added to the vest and the quantity to be added.


`backpack[] = {"B_TacticalPack_oli"}; or backpack[] = {"B_TacticalPack_oli",1}; `

Backpack: This array should contain only one classname string for the backpack or CSW component bag to be carried by the unit. The second value in the array can be 1 or 0, if this is set to 1 the backpack’s contents will be cleared if for whatever reason it has preconfigured contents. If it’s set to 0 the contents will not be affected. Default behaviour is to leave the contents as they are.

```cpp
backpackContents[] = {
	{"30Rnd_556x45_Stanag",6},
	{"30Rnd_556x45_Stanag_Tracer_Red",2},
	{"HandGrenade",2},
	{"SmokeShell",2},
	{"SmokeShellRed",2},
	{"SmokeShellGreen",2},
	{"I_IR_Grenade",1},
	{"1Rnd_SmokeRed_Grenade_shell",2},
	{"1Rnd_HE_Grenade_shell",6},
	{"Chemlight_green",6},
	{"FirstAidKit",2}
};
```

Backpack Contents: This array is an array of arrays containing the classname string of the magazines, items, and weapons to be added to the backpack and the quantity to be added.

`ace_gunbagWeapon[] = {"srifle_DMR_02_F", {"10Rnd_338_Mag", "optic_lrps", "acc_pointer_ir", "muzzle_snds_338_black", "bipod_01_f_blk"}};`

Gunbag Weapon: This array contains a single weapon in the same format as the `weapon[]` array that will be added to the unit if it is carrying an ACE gunbag (`"ace_gunbag"` or `"ace_gunbag_tan"`). Note that this array does not support randomisation.

`ace_earplugs = 1;`

When set to 1 aceEarPlugs will have a unit with this loadout start with earplugs in.

`ace_medic = 1;`

When set to 0, 1, or 2, this will make a unit with the given loadout a medic of the given level for ace:

* 0 = Not a medic
* 1 = Medic
* 2 = Doctor

`ace_engineer = 1;`

When set to 0, 1, or 2, this will make a unit with the given loadout an engineer of the given level for ace:

* 0 = Not an engineer
* 1 = Engineer
* 2 = Advanced engineer

For ace_medic and ace_engineer, best practice is to only define these on relevant loadouts to ensure behavior as expected. If they must be defined in a generic base class it is recommended they are both set to 0.

`allowPlayerGoggles = 1;`
By default TB3 gear will overwrite goggles applied through user profile, setting this to 1 on a loadout will allow user profile defined goggles to remain.

```
magazines[] = {};
items[] = {};
```

General magazines and Items: These arrays work in the same way as the container arrays for magazines and items however, these are added nonspecifically.
Note: You should not use these arrays with the container specific arrays, instead if you want to add things in a non-specific manner leave the container specific arrays empty or do not include them.
Similarly if you want to add content to specific containers do not include the general magazines and general items arrays or leave them empty.

#### Randomisation of Gear:

A unit’s: headgear, goggles/facewear, backpack, vest, uniform, and weapons can all be randomized using the TB3 loadout system.
How this can be done is detailed along with how to set these as normal.


Once enabled, additional classes should be added to the appropriate loadout variable. Additionally, this will disable the ability for you to clear the inventories of rucksacks prior to adding them to a unit.

#### More*[] arrays

These arrays can be added to a loadout inheriting from another loadout, which allows the loadout to add weapons or items without having to duplicate the `weapons[]` and `*contents[]` arrays of the parent.

`moreWeapons[]`, `moreUniformContents[]`, `moreVestContents[]`, and `moreBackpackContents[]` are supported.

Example:
```cpp
class Rifleman {
  weapons[] = {LOADS_OF_RANDOM_RIFLES};
  vestContents[] = {
    MAGAZINES,
    GRENADES,
    BANDAGES
};

class TeamLeader: Rifleman {
  moreWeapons[] = {BINOCULARS};
  moreVestContents[] = {RADIO};
};
```


### Vehicle/Object Inventory Specific variables:

`vehCargoWeapons[] = {{"launch_NLAW_F",8}};`

Vehicle Inventory Weapons: This array is an array of arrays containing the classname strings and quantity of weapons to be added to the vehicle’s inventory.

```cpp
vehCargoMagazines[] = {
	{"30Rnd_556x45_Stanag",20},
	{"30Rnd_556x45_Stanag_Tracer_Yellow",20},
	{"200Rnd_65x39_cased_Box",4},
	{"200Rnd_65x39_cased_Box_Tracer",4},
	{"HandGrenade",12},
	{"SmokeShell",12},
	{"1Rnd_HE_Grenade_shell",20}
};
```

Vehicle Inventory Magazines: This array is an array of arrays containing the classname strings and quantity of magazines to be added to the vehicle’s inventory.

```cpp
vehCargoItems[] = {
	{"FirstAidKit",15},
	{"Medikit",1},
	{"I_UavTerminal",1},
	{"ToolKit",1}
};
```

Vehicle Inventory Items : This array is an array of arrays containing the classname strings and quantity of items to be added to the vehicle’s inventory.

```cpp
vehCargoRucks[] = {
	{"B_Kitbag_sgg",15}
};
```

Vehicle Inventory Backpacks: This array is an array of arrays containing the classname strings and quantity of backpacks or CSW bags to be added to the vehicle’s inventory.
Backpacks with predefined contents can be defined using the alternate syntax below.

```cpp
vehCargoRucks[] = {
  {"B_Kitbag_sgg",15},
  {"B_Kitbag_rgr",2,
    {
      {"30Rnd_556x45_Stanag_red",6},
      {"30Rnd_556x45_Stanag_Tracer_Red",2},
      {"HandGrenade",2},
      {"SmokeShell",2},
      {"Chemlight_green",2},
      {"B_IR_Grenade",1},
      {"200Rnd_556x45_box_red_f",2},
      {"200Rnd_556x45_box_tracer_red_f",2}
    }
  }
};
```

In this example we are now adding two backpacks of a different type with contents defined in a 3rd element of the array. This third element is formatted exactly the same way as with the backpackContents array.

## Utility Functions:

### GearToClass
```sqf
// Params:
// _unit: the unit you want to create a loadout based on - object
// _outputClass: the class name of the exported loadout - string
[_unit,_outputClass] call tb3_fnc_util_GearToClass;
```

This function returns the current gear of a specified unit as a TB3 gear loadout class. It also exports the same return to clipboard for easy copy and paste loadout creation. The exported class can then be adjusted as normal by editing it within your preferred program.

### ValidateLoadout
```sqf
// Parameters:
// 0: Loadout category <string>
// 1: Loadout name (use "" to validate all loadouts in the category) [Default: ""] <string>
// 2: Enable verbose logging [Default: false] <bool>
["ExampleSide"] call tb3_fnc_util_validateLoadout;
```

This function checks container inventory (uniform, vest, backpack) against container capacity for all possible containers for a loadout. If the inventory items all fit in all containers, the script returns true. Logs errors to RPT.

## Redundant Variables:
`priKit[] = {"optic_Arco","acc_pointer_IR"};`

Primary attachments: This is an array containing the classname strings for all the attachments (including magazines) you want to attach to the unit’s primary weapon. Adding magazines to this array will have the weapon start loaded with those magazines. This works for UGLs as well as normal mags.

#This has been phased out by improvements made to how weapons are defined.#

`secKit[] = {“muzzle_snds_L”};`

Launcher weapon attachments: This is an array containing the classname strings for all the attachments (including magazines) you want to attach to the launcher used by a unit. Adding magazines to this array will have the weapon start loaded with those magazines.

#This has been phased out by improvements made to how weapons are defined.#

`pisKit[] = {“muzzle_snds_L”};`

Pistol weapon attachments: This is an array containing the classname strings for all the attachments (including magazines) you want to attach to the pistol/sidearm used by a unit. Adding magazines to this array will have the weapon start loaded with those magazines.

#This has been phased out by improvements made to how weapons are defined.#

The following are redundant following an update to how randomisation of gear was implemented in TB3
* *uniformRandom* `uniformRandom = 1;`
* *vestRandom* `vestRandom = 1;`
* *headgearRandom* `headgearRandom = 1;`
* *gogglesRandom* `gogglesRandom = 1;`
* *backpackRandom* `backpackRandom = 1;`
