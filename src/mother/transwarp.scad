use <../lib/util.scad>;


module mvm_transwarp() {
    difference() {
    mirror([0,0,1])
    util_saucer(400,400,40);
        
        translate([0,0,-200-20])
        cube(400,center=true);
    }


    difference() {
        translate([-750/2,0,0])
            mirror([0,0,1])
 //               util_saucer(750,270,120);
        union() {
    
            difference() {
                util_saucer(640,270,100);
                translate([250+.01,0,0])
                cube(500,center=true);
            }
            difference() {
                util_saucer(540,270,100);
                translate([-250-.01,0,0])
                cube(500, center=true);
            }
        }

        translate([-120,0,-50])
            rotate([0,90,0])
                cylinder(175,15,80,center=true);
        
        translate([-600,0,-175])
            scale([1.8,1,1])
                rotate([90,0,0])
                    cylinder(500,150,150,center=true);

        translate([-600+-250,0,-250-25])
            cube(500,center=true);
    }
    
    scale([1,1,1])
        mvm_transwarp_nacelle_bar();
    
    util_mirrored([0,1,0])
        translate([-700,750/2-50,75]) 
            mvm_transwarp_nacelle();
}



module mvm_transwarp_nacelle_bar() {
    difference() {
        translate([-700,0,-30])
        util_nacelle_bar(700,100,700,16);
        
        translate([-600,0,-175])
            scale([1.8,1,1])
                rotate([90,0,0])
                    cylinder(500,150,150,center=true);

        translate([-600+-250,0,-250-25])
            cube(500,center=true);

        translate([-750/2,0,0])
            util_saucer(750,270,150);

        translate([-1450,0,0])
            cylinder(900,750,750,center=true);
        
//        translate([-1124,0,0])
//        cube(750,center=true);

        util_mirrored([0,1,0])
            translate([-750/2+440,550,0])
                cylinder(900,750,750,center=true);
        
        translate([-750/2,0,490])
            rotate([90,0,0])
                cylinder(900,400,400,center=true);
    }
}

module mvm_transwarp_nacelle() {
    translate([125,0,0]) {
        difference() {
            union() {
                util_saucer(1100,100,60);
                mirror([0,0,1])
                    util_saucer(1100,100,15);
            }
            
            translate([600,0,0])
                cube(1200,center=true);
        }

        util_saucer(500,100,60);
        mirror([0,0,1])
            util_saucer(500,100,15);
    }
}

mvm_transwarp();
