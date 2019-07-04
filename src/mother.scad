use <util.scad>;

module m_saucer() {
    union() {
        translate([0,0,20])
            util_saucer(600,500,40);
        
        scale([1.2,1,1])
            util_hangar_disk(40,225,250,16);
        
        translate([0,0,50])
            m_upper_bridge();
    }        
}

module m_body() {
    union() {
        difference() {
            translate([-250,0,20]) {
                mirror([0,0,1])
                    util_saucer(450,80,80);                
            }
            
            translate([-540,0,0])
                rotate([0,30,0])
                    cube(400,center=true);
        }
        
        difference() {
            translate([-300,0,-50]) {
                mirror([0,0,1])
                    util_saucer(360,180,70);
                util_saucer(360,180,30);
            }
            
            translate([-135,0,-75])
                sphere(18);
        }
    }
}



module m_bar() {
    difference() {
        util_nacelle_bar(500,150,300,15);
    
        translate([-555,0,0])
            rotate([0,-30,0])
                cube(900,center=true);
    
        translate([450,0,270])
            rotate([0,45,0])
                cube(900,center=true);
    }
}

module m_nacelle() {
    difference() {
        union() {
            util_saucer(1000,80,45);
            mirror([0,0,1])
                util_saucer(1000,80,15);
        }
        
        union() {
            translate([300,0,0])
                cube(600, center=true);
            
            translate([-660,0,-200])
                rotate([0,45,0])
                    cube(600,center=true);
        }
    }
    
    union() {
        util_saucer(240,80,45);
        mirror([0,0,1]) 
            util_saucer(240,80,15);
    }
}

module m_nacelle_assembly() {
    translate([-400,0,-80])
        m_bar();
    util_mirrored([0,1,0])
        translate([-400,250,75])
            m_nacelle();
}

module m_upper_bridge() {
    difference() {
        util_saucer(180,150,20);
        translate([75,0,10])
            scale([1.2,1,1])
                rotate(30)
                    cylinder(60,50,50,center=true, $fn=6);
    }
}

module m_lower_bridge() {
    difference() {
        union(){
            mirror([0,0,1])
                util_saucer(180,150,15);
            util_saucer(180,150,5);
            
 
        }
        
        union(){
            translate([90,0,0])
                rotate([0,-15,0])
                    cube([25,16,25],center=true);
            
            translate([-(90+45),0,0])
                cube(150, center=true);
        }
    

    }

        
    
    util_mirrored([0,1,0])
        translate([-12,54,-7.5])
            rotate([90,0,0])
                util_nacelle(150,18,36,curved=true,up=false);
}

module m_lower_bridge_assembly() {
    translate([0,0,-20])
        m_lower_bridge();
}

module m_main() {
    m_saucer();
    m_body();
    m_nacelle_assembly();
}

module mother() {
    scale(1)  {
        m_main();
        m_lower_bridge_assembly();
    }
}

module m_main_sep() {
    difference() {
        m_saucer();
        m_lower_bridge_assembly();
    }
    
    m_body();
    m_nacelle_assembly();
    
    translate([0,0,-50])
    difference() {
        m_lower_bridge_assembly();
        m_body();
    }
}


mother();
//m_main_sep();

//m_lower_bridge_assembly();