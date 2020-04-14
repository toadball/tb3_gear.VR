    class TB_FIA_INS { 
        class baseUnit {
            ace_earplugs = 1;	
            
            weapons[] = {"rhs_weap_akm"};
            priKit[] = {};
            secKit[] = {};
            pisKit[] = {};
            
            assignedItems[] = {"ItemMap","ItemCompass","ItemWatch","ace_maptools"};
            
            headgear[] = {
                "H_Watchcap_khk",
                "H_Watchcap_blk",
                "H_ShemagOpen_khk",
                "H_Shemag_olive",
                "H_Bandanna_gry",
                "H_Bandanna_sgg",
                "H_Bandanna_cbr",
                "H_Bandanna_khk",
                "H_MilCap_dgtl",
                "H_MilCap_gry",
                "H_Cap_grn",
                "H_Cap_blk",
                "H_Cap_tan",
                "H_Booniehat_dgtl",
                "H_Booniehat_tan",
                "H_Booniehat_grn",
                "H_Booniehat_khk"
            };
            goggles[] = {};
            
            uniform[] = {
                "U_BG_Guerrilla_6_1",
                "U_BG_leader",
                "U_BG_Guerilla3_2",
                "U_BG_Guerilla2_3",
                "U_BG_Guerilla2_2",
                "U_BG_Guerilla2_1",
                "U_BG_Guerilla1_1"
            };
                uniformContents[] = {};
                
            vest[] = {
                "V_Chestrig_oli",
                "V_Chestrig_blk",
                "V_Chestrig_rgr",
            };
            vestContents[] = {
                {"ACE_fieldDressing",2},
                {"ACE_tourniquet",2},	
                {"ACE_packingBandage",2},
                {"ACE_quikclot",2},
                {"ACE_elasticBandage",2},					
                {"rhs_30Rnd_762x39mm",6},
                {"rhs_30Rnd_762x39mm_tracer",2},
                {"HandGrenade",2}
            };
                
            backpack[] = {};
            backpackContents[] = {};
        };
        class InsurgentSL1: baseUnit {
            uniformContents[] = {{"ACRE_PRC343",1},{"ACE_Cellphone",1}};
            weapons[] = {"rhs_weap_akms","Binocular"};
            backpack[] = {
                "B_FieldPack_khk",
                "B_FieldPack_cbr",
                "B_FieldPack_oli"
            };
            backpackContents[] = {{"ACRE_PRC77",1}};			
        };
        class InsurgentSL2: InsurgentSL1 {
            weapons[] = {"rhs_weap_akm","Binocular"};			
        };
        class InsurgentTL1: baseUnit {
            uniformContents[] = {{"ACRE_PRC343",1}};
            weapons[] = {"rhs_weap_akms","Binocular"};		
        };
        class InsurgentTL2: InsurgentTL1 {
            weapons[] = {"rhs_weap_akm","Binocular"};		
        };	
        class Insurgent1: baseUnit {
            weapons[] = {"rhs_weap_akms"};
        };
        class Insurgent2: baseUnit {
            weapons[] = {"rhs_weap_akm"};
        };		
        class InsurgentGL1: baseUnit {
            weapons[] = {"rhs_weap_akms_gp25"};
            vestContents[] = {
                {"ACE_fieldDressing",2},
                {"ACE_tourniquet",2},	
                {"ACE_packingBandage",2},
                {"ACE_quikclot",2},
                {"ACE_elasticBandage",2},					
                {"rhs_30Rnd_762x39mm",4},
                {"rhs_30Rnd_762x39mm_tracer",2},
                {"HandGrenade",2},
                {"rhs_VOG25",10}
            };				
        };
        class InsurgentGL2: InsurgentGL1 {
            weapons[] = {"rhs_weap_akm_gp25"};			
        };		
        class InsurgentMG: baseUnit {
            weapons[] = {"rhs_weap_pkm"};
            priKit[] = {"rhs_100Rnd_762x54mmR"};
            vestContents[] = {
                {"ACE_fieldDressing",2},
                {"ACE_tourniquet",2},	
                {"ACE_packingBandage",2},
                {"ACE_quikclot",2},
                {"ACE_elasticBandage",2},					
                {"rhs_100Rnd_762x54mmR",1},
                {"rhs_100Rnd_762x54mmR_green",1},
                {"HandGrenade",2}
            };				
        };	
        class InsurgentMM: baseUnit {
            weapons[] = {"rhs_weap_svd"};
            priKit[] = {"rhs_acc_pso1m2"};
            vestContents[] = {
                {"ACE_fieldDressing",2},
                {"ACE_tourniquet",2},	
                {"ACE_packingBandage",2},
                {"ACE_quikclot",2},
                {"ACE_elasticBandage",2},					
                {"rhs_10Rnd_762x54mmR_7N1",8},
                {"HandGrenade",2}
            };				
        };		
        class InsurgentMED: baseUnit {
            uniformContents[] = {{"ACRE_PRC343",1}};		
            backpackRandom = 1;
            backpack[] = {
                "B_FieldPack_khk",
                "B_FieldPack_cbr",
                "B_FieldPack_blk",
                "B_FieldPack_oli"
            };
            backpackContents[] = {
                {"SmokeShellYellow",2},
                {"SmokeShellGreen",2},
                {"ACE_fieldDressing",20},
                {"ACE_packingBandage",20},
                {"ACE_quikclot",20},
                {"ACE_elasticBandage",20},
                {"ACE_morphine",20},
                {"ACE_epinephrine",20},
                {"ACE_salineIV",5},
                {"ACE_personalAidKit",3},
                {"ACE_surgicalKit",3},
                {"ACE_tourniquet",5}
            };			
        };		
        //apply these to rucksacks placed on the ground
        class AMMObackpack {
            vehCargoMagazines[] = {
                {"rhs_30Rnd_762x39mm",4},
                {"rhs_30Rnd_762x39mm_tracer",1},
                {"rhs_100Rnd_762x54mmR_green",1},
                {"HandGrenade",2},
                {"SmokeShell",2}
            };
        };
        class MGbackpack {
            vehCargoWeapons[] = { };
            vehCargoMagazines[] = {
                {"rhs_100Rnd_762x54mmR",2},
                {"rhs_100Rnd_762x54mmR_green",1}
            };

            vehCargoItems[] = {};
            vehCargoRucks[] = {};
        };	
        class IEDbackpack {
            vehCargoWeapons[] = { };
            vehCargoMagazines[] = {
                {"DemoCharge_Remote_Mag",5},
                {"IEDLandBig_Remote_Mag",1}
            };
            vehCargoItems[] = {
                {"ACE_Clacker",2},
                {"ACE_Cellphone",1},
                {"ACE_DefusalKit",1}
            };
            vehCargoRucks[] = {};
        };		
        class MEDbackpack {
            vehCargoWeapons[] = {};
            vehCargoMagazines[] = {
                {"SmokeShellYellow",2},
                {"SmokeShellGreen",2}			
            };
            vehCargoItems[] = {
                {"ACE_fieldDressing",20},
                {"ACE_packingBandage",20},
                {"ACE_quikclot",20},
                {"ACE_elasticBandage",20},
                {"ACE_morphine",20},
                {"ACE_epinephrine",20},
                {"ACE_salineIV",5},
                {"ACE_personalAidKit",3},
                {"ACE_surgicalKit",3},
                {"ACE_tourniquet",5}			
            };
            vehCargoRucks[] = {};
        };	

    };