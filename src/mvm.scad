use <util.scad>;


module mvm_main_disk() {
    difference() {
        translate([0,0,-30]) difference() {
            util_saucer(750,750,75);
            translate([0,0,500+60])
                cube(1000, center=true);
        }
        translate([0,0,-15]) difference() {
            cylinder(20,800/2, 800/2, center=true);

            scale([1,1,5])
                util_star(800/2, 20, 16, half=true);
        }
    }
    
    translate([0,0,-14])
       cylinder(24, 740/2, 680/2, center=true);

}

module mvm_main_disk_nacelle() {
    scale([1,1,.3]) {
        rotate([0,90,0])
            cylinder(150, 25,25, center=true);
        
        util_mirrored([1,0,0])
            translate([75,0,0])
                sphere(25);

        difference() {
            rotate([90,0,0])
                cylinder(10,75,75,center=true,$fn=6);
            translate([0,0,-200])
                cube(400, center=true);
        }
    }
}


module mvm_main_disk_assembly() {
    mvm_main_disk();
    
    util_mirrored([0,1,0])
        translate([0,330,-40])
            mvm_main_disk_nacelle();
    
    translate([315,0,-30])
        mvm_main_disk_deflector();
    
    mvm_main_disk_impulse();
}

module mvm_main_disk_deflector() {
    difference() {
        union() {
            scale([1,1.5,.5])
                difference() {
                    union() {
                        rotate([0,90,0])
                            cylinder(100,25,25,center=true);
                        translate([-50,0,0])
                            sphere(25);
                    }
                    translate([50,0,0])
                        sphere(20);
                }
            
            translate([0,0,50*.7*.6*.5])
                cube([100, 50*1.5, 50*.7*.6], center=true);
                
            translate([-50,0,50*.7*.6*.5])
                scale([1,1.5,1])
                    cylinder(50*.7*.6, 25,25, center=true);
        }
        
        translate([0,0,40])
            cube([1000,1000,70], center=true);
    }
        
}



module mvm_command() {
    difference() {
        util_saucer(400,400,40);
        translate([200,0,10])
            cube(40,center=true);
    }


    


    translate([-120,0,0])
        mirror([0,0,1])
        util_nacelle(400,120,40,curved=true,up=false);
}



module mvm_main_disk_impulse() {
    difference() {
    intersection() {
    translate([-750/2+100,0,0])
        cube([200,150,60], center=true);
        
        translate([0,0,-30])
        util_saucer(750,750,750/2);
    }
    
    translate([-750/2+7,0,10])
    cube([16,100,20-.1], center=true);
}
}



module mvm_transwarp() {
    difference() {
    mirror([0,0,1])
    util_saucer(400,400,50);
        
        translate([0,0,-200-25])
        cube(400,center=true);
    }


    difference() {
        translate([-750/2,0,0])
            mirror([0,0,1])
                util_saucer(750,270,120);

        translate([-70,0,-75])
            rotate([0,90,0])
                cylinder(175,20,80,center=true);
        
        translate([-700,0,-175])
            scale([1.8,1,1])
                rotate([90,0,0])
                    cylinder(500,150,150,center=true);

        translate([-700+-250,0,-250-25])
            cube(500,center=true);
    }
    
    scale([1,1,1])
        mvm_transwarp_nacelle_bar();
    
    util_mirrored([0,1,0])
        translate([-750,750/2-50,55]) 
            mvm_transwarp_nacelle();
}


module mvm_transwarp_nacelle_bar() {
    difference() {
        translate([-700,0,-30])
        util_nacelle_bar(700,60,700,16);
        
        translate([-700,0,-175])
            scale([1.8,1,1])
                rotate([90,0,0])
                    cylinder(500,150,150,center=true);

        translate([-700+-250,0,-250-25])
            cube(500,center=true);

        translate([-750/2,0,0])
            util_saucer(750,270,150);

        translate([-1300,0,0])
            cylinder(900,600,600,center=true);

        util_mirrored([0,1,0])
            translate([-750/2+75,550,0])
                cylinder(900,450,450,center=true);
        
        translate([-750/2,0,490])
            rotate([90,0,0])
                cylinder(900,400,400,center=true);
    }
}

module mvm_transwarp_nacelle() {
    translate([125,0,0]) {
        difference() {
            union() {
                util_saucer(1000,100,60);
                mirror([0,0,1])
                    util_saucer(1000,100,15);
            }
            
            translate([500,0,0])
                cube(1000,center=true);
        }

        util_saucer(500,100,60);
        mirror([0,0,1])
            util_saucer(500,100,15);
    }
}

module mvm_back_hangar() {
    difference() {
        util_saucer(750,270,75);

        translate([750/2,0,0])
            cylinder(500,750/2,750/2,center=true);

        translate([0,0,500+60])
            cube(1000, center=true);

//        translate([50,0,40])
//            cube([100,120,100],center=true);
    }

    translate([-180,0,60])
    util_saucer(64,64,10);
    
    util_mirrored([0,1,0])
        translate([-90,60,60])
            mirror([1,0,0])
                    util_nacelle(200,30,30,curved=true);


}

module mvm_total_assembly_combined() {
    mvm_main_disk_assembly();
    translate([0,0,30-.01]) mvm_command();
    translate([0,0,-30+.01]) mvm_transwarp();
    translate([-750/2,0,-30+.01]) mvm_back_hangar();
}

module mvm_total_assembly_transwarp() {
    mvm_transwarp();
    mvm_command();
}

module mvm_total_assembly_separate() {
    mvm_main_disk_assembly();
    translate([250,0,100]) mvm_command();
    translate([-100,0,-100]) mvm_transwarp();
    translate([-750/2-250,0,50]) mvm_back_hangar();
}

module mvm_total_assembly_starbase() {
    mvm_main_disk_assembly();
    translate([-750/2,0,-30+.01])
        mvm_back_hangar();
}


module mvm_assembly(type="combined") {
    if (type == "combined") 
        mvm_total_assembly_combined();
    else if (type == "separate")
        mvm_total_assembly_separate();
    else if (type == "transwarp")
        mvm_total_assembly_transwarp();
    else if (type == "starbase")
        mvm_total_assembly_starbase();
    else if (type == "scout")
        mvm_command();
    else
        mvm_transwarp();
    
}

mvm_assembly();