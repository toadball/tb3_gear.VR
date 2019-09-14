//Loadouts called with: [this,"side_class","unit_class"] call tb3_fLoadout;
//Use those bellow as an example as to creating a side and unit class.
class TB3_Gear {//Gear definitions stay within this.
	class ExampleSide { //Side_class, 1st string in _this
		class ExampleUnit { //unit_class, 2nd string in _this
			weapons[] = {"arifle_Mk20_GL_F","Rangefinder"}; //weapons: includes binos, launchers, pistols, and main rifle/klmg weapon
			priKit[] = {"optic_Arco","acc_pointer_IR","30Rnd_556x45_Stanag","1Rnd_HE_Grenade_shell"};//primary weapon attachments
			secKit[] = {};//launcher attachments
			pisKit[] = {};//sidearm attachments

			assignedItems[] = {"ItemRadio","ItemMap","ItemCompass","ItemWatch","ItemGPS"};//linked items: gps, map etc: Do not use any ACRE class names here, if you want to add an acre radio do so in a container item slot, itemRadio is auto replaced with a 343

			headgear[] = {"H_HelmetB_plain_mcamo"};
			goggles[] = {"G_Tactical_Black"};
			ace_earplugs = 1;
			uniform[] = {"U_B_CTRG_1"};
				uniformContents[] = {
					{"30Rnd_556x45_Stanag",3},// {classname,number}
					{"SmokeShell",2},
					{"Chemlight_green",2},
					{"FirstAidKit",1},
					{"ACRE_PRC148",1}
				};

			vest[] = {"V_PlateCarrierL_CTRG"};
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

			backpack[] = {"B_TacticalPack_oli"};
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

			magazines[] = {}; items[] = {}; // only use these if you do not want to assign gear to specific locations in containers, if you do use these ensure the magazine/item container arrays are empty.
		};//end ExampleUnit

		class RandomisedUnit: ExampleUnit {
			//Inherits all but containers, goggles, and headgear from: ExampleUnit
			headgear[] = {"H_Booniehat_khk","H_HelmetB_plain_blk","H_HelmetB_paint","H_HelmetB_light","H_Cap_khaki_specops_UK"};
			goggles[] = {"G_Tactical_Black","G_Bandanna_tan","G_Tactical_Clear","G_Combat","G_Lowprofile"};
			uniform[] = {"U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3"};
			backpack[] = {"B_TacticalPack_oli","B_Kitbag_cbr","B_AssaultPack_cbr","B_FieldPack_khk","B_Carryall_khk"};
			vest[] = {"V_PlateCarrierL_CTRG","V_Chestrig_oli","V_PlateCarrier1_rgr","V_BandollierB_oli"};

			//variables bellow enable randomisation of unit containers, goggles, and headgear
			headgearRandom = 1;
			gogglesRandom = 1;
			uniformRandom = 1;
			backpackRandom = 1;
			vestRandom = 1;
		};

		class ExampleVehicle {
			vehCargoWeapons[] = {{"launch_NLAW_F",8}};
			vehCargoMagazines[] = {
				{"30Rnd_556x45_Stanag",20},
				{"30Rnd_556x45_Stanag_Tracer_Yellow",20},
				{"200Rnd_65x39_cased_Box",4},
				{"200Rnd_65x39_cased_Box_Tracer",4},
				{"HandGrenade",12},
				{"SmokeShell",12},
				{"1Rnd_HE_Grenade_shell",20}
			};
			vehCargoItems[] = {
				{"FirstAidKit",15},
				{"Medikit",1},
				{"I_UavTerminal",1},
				{"ToolKit",1}
			};
			vehCargoRucks[] = {
				{"B_Kitbag_sgg",2,{
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
				}},
				{"B_Kitbag_sgg",3,{
					{"30Rnd_65x39_caseless_green",4},
					{"30Rnd_65x39_caseless_green_mag_Tracer",2},
					{"HandGrenade",1},
					{"SmokeShell",1},
					{"O_IR_Grenade",1},
					{"Chemlight_Red",6},
					{"FirstAidKit",2}
				}}
			};
		};
		class ExampleVehicle2: ExampleVehicle {
			vehCargoRucks[] = {
				{"B_AssaultPack_ocamo",1,{
					{"hgun_Pistol_heavy_01_F",2},
					{"11Rnd_45ACP_Mag",8}
				}},
				{"B_AssaultPack_ocamo",1,{
					{"ACRE_PRC77",1}
				}},
				{"B_AssaultPack_ocamo",1,{
					{"ACE_fieldDressing",2},
					{"ACE_morphine",1},
					{"ACE_tourniquet",1},
					{"ACE_epinephrine",1},
					{"ACE_packingBandage",2},
					{"ACE_quikclot",2}
				}}
			};
		};
	};
	#include "toadball_insurgents1.hpp"
};
