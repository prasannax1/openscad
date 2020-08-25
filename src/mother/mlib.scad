use <../lib/util.scad>;

render_nacelles=true;

engine_front=300;
engine_back=400;
engine_up=60;
engine_up_2=60;
engine_down=125;
engine_down_diff=50;
engine_width=210;
engine_disk_up=5;
engine_disk_down=5;
engine_faces=32;
engine_wall_ratio=0.99;
engine_inv_ratio=1.6;
engine_defl_x2=80;

nacelle_place_back=engine_back-50;
nacelle_place_width=550;
nacelle_place_height_diff=20;
nacelle_place_height=engine_up+nacelle_place_height_diff;

nacelle_front=200;
nacelle_back=600;
nacelle_width=100;
nacelle_up=60;
nacelle_down=20;
nacelle_brussard_h=64;

saucer_width=750;
saucer_front=750/2;
saucer_back=750/2;
saucer_up=70;
saucer_up_ext=5;
saucer_down=20;
saucer_hangar_height=20;
saucer_hangar_in=55;
saucer_segments=15;
saucer_hangar_width=2.56*saucer_width/saucer_segments;

command_width=180;
command_front=90;
command_height=20;
command_height_ext=5;
command_shuttlebay_width=120;
command_engine_width=50;
command_engine_length_f=75;
command_engine_length_b=125;
command_engine_up=3;
command_engine_down=50;
command_hangar_height=25;
command_hangar_r_iota=15;
command_bridge_width=40;
command_bridge_height=5;
command_nacelle_length_f=50;
command_nacelle_length_b=200;
command_nacelle_height=25;
command_nacelle_width=25;
command_neck_width=16;

escort_width=150;
escort_front=180;
escort_down=30;
escort_up=1;
escort_rear_width=80;
escort_deflector_width=36;
escort_nacelle_length=245;
escort_nacelle_height=36;
escort_nacelle_width=48;
escort_minus_length=25;

scout_width=100;
scout_up=15;
scout_down=3;
scout_body_up=12;
scout_body_down=15;
scout_body_front=18;
scout_body_width=36;
scout_body_back=100;

separate_length=500;
separate_height=100;


module saucer_plus() {
    difference() {
        union() {
            util_ovoid(saucer_front, saucer_back, 
                    saucer_width,
                    saucer_up+saucer_up_ext,
                    saucer_down);

            intersection() {
                translate([0,0,0])
                scale([1,1,1])
                util_nacelle(saucer_back*1.3,saucer_width*.5,
                    (2*saucer_up+saucer_up_ext), curved=true);
                    
                cylinder(r=saucer_front, h=saucer_up*4, center=true);
            }
        }

        translate([0,0,saucer_width*0.6 + saucer_up])
        cube(saucer_width*1.2,center=true);
    }
}


module engine_main(saucer_attached=true, escort_attached=true) {
    difference() {
        util_ovoid(engine_front, engine_back, engine_width,
            engine_up, engine_down);
        

            translate([0,0,-saucer_width/2-engine_down+engine_down_diff])
            cube(saucer_width,center=true);
            
            
        
        translate([0,0,-saucer_width/2-engine_down+engine_down_diff-escort_down])
        cube(saucer_width,center=true);
     
        translate([engine_front, 0, -engine_down+engine_down_diff])
        scale([(engine_front-escort_front)/(engine_down-engine_down_diff), 1,1])
        rotate([90,0,0])
        cylinder(h=engine_width, r=(engine_down-engine_down_diff),
            center=true);
        
        translate([-engine_back,0,-engine_down])
        scale([(engine_back-escort_nacelle_length)*1.2/engine_down,1,1])
        rotate([90,0,0])
        cylinder(r=engine_down, h=engine_width, center=true);
        
        translate([-engine_back*1.12,0, engine_up/2])
        rotate([0,30,0])
        cube(engine_width, center=true);
        
        if (saucer_attached == false) {
            translate([saucer_back,0,engine_up/2])
            cylinder(r=saucer_front, h=engine_up, center=true);
        }
    }



    util_ovoid(engine_front, engine_back/2, engine_width,
            engine_disk_up, engine_disk_down);

    util_ovoid(engine_front, 5, engine_width-20,
            engine_up_2, engine_disk_down);

    difference() {
        util_ovoid(engine_front-40, 5, engine_width-40,
                engine_disk_up, engine_down - engine_down_diff  +escort_down);
        
            translate([0,0,-engine_down + engine_down_diff - saucer_width/2])
            cube(saucer_width, center=true);
        
    }
    
    difference() {
            translate([+engine_front-engine_up_2,0,-0]) 
rotate([90,0,0])
cylinder(h=command_engine_width, r=engine_up_2, center=true);
        
        translate([engine_front-engine_up_2,0,-command_width/2])
        cube(command_width,center=true);
                
    }


translate([-engine_front+engine_up_2+saucer_back,0,-0+engine_up_2/2])
cube([engine_front-engine_up_2,command_engine_width,engine_up_2],center=true);
        
}


module engine(escort_attached=true, saucer_attached=true, command_attached=true) {
    engine_main(escort_attached=escort_attached, saucer_attached=saucer_attached);
    if (render_nacelles==true) {
        util_mirrored([0,1,0]) engine_nacelle_assembly();
    }
}

module saucer(command_attached=true, engine_attached=true, scout_attached=true) {
    difference() {
        saucer_plus();
        saucer_minus(command_attached=command_attached, engine_attached=engine_attached, scout_attached=scout_attached);
    }
}


module scout(saucer_attached=true) {
    util_ovoid(scout_width/2, scout_width/2,
        scout_width, scout_up,scout_down);

    difference() {
        util_ovoid(scout_body_front,
            scout_body_back,
            scout_body_width,
            scout_body_up,
            scout_body_down);
        
        translate([0,0,-scout_body_down])
        scale([2,1,1])
        rotate([90,0,0])
        cylinder(r=scout_body_down, h= scout_body_width*1.5, center=true);
        
                translate([-scout_body_back,0,-scout_body_down])
        scale([1.7,1,1])
        rotate([90,0,0])
        cylinder(r=scout_body_down, h= scout_body_width*1.5, center=true);
        
        translate([-scout_body_back-scout_body_front+7,0,0])
        rotate([0,30,0])
        cube(scout_body_width,center=true);
        
    }
    
    translate([-scout_body_width*.8,0,0])
    util_ovoid(scout_body_front-2.5, scout_body_back/2.5, scout_body_width-5, scout_body_up-2.5, scout_body_down-2.5);
    
    if (render_nacelles==true) {
        util_mirrored([0,1,0]) {
            hull() {
                translate([-scout_width/1.7,0,0])
                rotate([0,90,0])
                cylinder(h=20,r=1.5,center=true);

                translate([-scout_body_back*.9,scout_width/2-20,scout_up])
                rotate([0,90,0])
                cylinder(h=10,r=.8,center=true);
            }

            translate([-scout_body_back*.72,scout_width/2-20,scout_up-2])
        util_ovoid(scout_body_front,scout_body_back*.6, scout_up,
            scout_up*.6,2, faces=13);
        }
    }
}

module saucer_minus(command_attached=true, engine_attached=true, scout_attached=true) {
        for (theta = [0,6,12]) {
            rotate(6*360/saucer_segments - theta*360/saucer_segments)
            translate([saucer_width/2, 0,saucer_hangar_height/2+2])
            cube([saucer_hangar_in,
                saucer_hangar_width,
                saucer_hangar_height], center=true);
        }
        
     
        hull() {
        translate([-saucer_back,0,-25])
        scale([(engine_front)/(engine_width*.5),1,1])
        cylinder(h=50,d=engine_width+20,center=true);
          
      translate([0,0,-25])  
        cylinder(h=50,d=scout_width*.75,center=true);
        }
        
    if (engine_attached == false) {
        translate([-saucer_back,0,0])
            util_ovoid(engine_front, 5, engine_width-20,
            engine_up_2, engine_disk_down);
        
        
        translate([-saucer_back+engine_front-engine_up_2,0,-0])
        rotate([90,0,0])
        cylinder(h=command_engine_width, r=engine_up_2, center=true);


        translate([-engine_front+engine_up_2,0,-0+engine_up_2/2])
        cube([engine_front-engine_up_2,command_engine_width,engine_up_2],center=true);
    }
    
    if (scout_attached == false) {
        translate([0,0,-saucer_down])
            util_ovoid(scout_width/2, scout_width/2,
        scout_width, scout_up,scout_down);
        
    }
    
    if (command_attached == false) {
        translate([  -command_width/2-command_engine_width,0,saucer_up])      
        scale([2,1,2])
        rotate([0,90,0]) {
            
        util_mirrored([0,0,1])
            translate([0,0,command_engine_length_b/4])
            sphere(command_engine_width/2);
            
        cylinder(d=command_engine_width, h=command_engine_length_b/2, 
            center=true);
            
        }
        
                translate([0,0,-command_height/4+saucer_up])
        cylinder(h=command_height/2,d1=command_width-10,d2=command_width, center=true);
        
    }
    
    translate([-command_engine_length_b-command_engine_width/2-saucer_back/2,0,saucer_up])
    scale([1,1,2])
    rotate([0,90,0])
    cylinder(d=command_engine_width, h=saucer_back, center=true);
}





module engine_nacelle_assembly() {
    hull() {
        difference() {
            util_ovoid(engine_front, engine_back, engine_width,
                        engine_disk_up, engine_disk_down);

            translate([0,saucer_width/2, 0])
            cube(saucer_width, center=true);

            translate([-engine_front-saucer_width/2,0,0])
            cube(saucer_width, center=true);

            translate([saucer_width/2.4,0,0])
            cube(saucer_width, center=true);

            scale([engine_back*2/engine_width,1,1])
            cylinder(h=engine_up, d=engine_width*.8, center=true);
        }

        translate([-nacelle_place_back,-nacelle_place_width/2, nacelle_place_height])
        cube([80,15,10],center=true);
    }

    translate([-nacelle_place_back+nacelle_front/2,-nacelle_place_width/2, nacelle_place_height]) {
        util_ovoid(nacelle_front, nacelle_back, nacelle_width,
            nacelle_up, nacelle_down);
        
        util_ovoid(nacelle_front, nacelle_back/3, nacelle_width,
            nacelle_brussard_h, nacelle_down);
        
    }
}




module escort( engine_attached=true) {
    
    difference() {
        util_ovoid(escort_front, escort_nacelle_length,
            escort_width, escort_down, escort_down);
        
        if (engine_attached == false) {
            translate([0,0,saucer_width/2])
            cube(saucer_width,center=true);
            

        }
        
        translate([-saucer_width/2,0,0])
        cube(saucer_width,center=true);
        
        translate([escort_front,0,0])
        cube(escort_deflector_width, center=true);
    }
    
    difference() {
        util_mirrored([0,1,0])
        translate([0,escort_rear_width/2-.01,0])
        rotate([90,0,0])
        scale([2,1,1])
        util_nacelle(escort_nacelle_length*.5,2*escort_down,(escort_width-escort_rear_width)/1.4,curved=true,up=false);
        
        translate([0,0,saucer_width/2+.01])
            cube(saucer_width,center=true);
        
    }

    
}


module command_disk() {
        
        util_ovoid(command_front,command_front,command_width,saucer_up_ext,saucer_up_ext);
    
            translate([0,0,-command_height/4])
            cylinder(h=command_height/2,d1=command_width-10,d2=command_width, center=true);
        

        translate([0,0,saucer_up_ext])
        cylinder(r1=command_bridge_width, r2=command_bridge_width-5, h=command_bridge_height*2, center=true);
        
        intersection() {
            translate([0,0,-command_height/2])
            util_nacelle(command_width,command_bridge_width*2,command_bridge_height+command_height*.9, curved=true);
            
            translate([0,0,command_width/2-.05])
            cylinder(d=command_width,h=command_width,center=true);
        }
        
            translate([0,0,saucer_up_ext+command_bridge_height])
        util_ovoid(command_bridge_width/2, command_bridge_width/2, command_bridge_width, command_bridge_height, command_bridge_height, faces=7);
}


module command(saucer_attached=true, saucer_raised=false,engine_attached=true) {
    
    if (saucer_raised == true) {
            translate([-command_width/2-command_engine_width+command_engine_length_b/2+command_neck_width/2,0,command_height/4-.01])
        cylinder(d=command_neck_width,h=command_height*2,center=true);
    
                    translate([-command_width/2-command_engine_width+command_engine_length_b/2+2.2*command_neck_width,0,command_height/4-.01])
        cylinder(d=command_neck_width,h=command_height*2,center=true);
        
        translate([0,0,command_height]) command_disk();
    } else {
        command_disk();
    }
    

    


    difference() {

    translate([-command_width/2-command_engine_width,0,0])
    difference() {
        scale([2,1,2])
        rotate([0,90,0]) {
            
        util_mirrored([0,0,1])
            translate([0,0,command_engine_length_b/4])
            sphere(command_engine_width/2);
            
        cylinder(d=command_engine_width, h=command_engine_length_b/2, 
            center=true);
            
        }

        translate([0,0,command_width]) cube(command_width*2,center=true);
        
        if (saucer_attached==false) {
            translate([command_width/2+command_engine_width,0,-command_height/4])
            scale([1,1,1.2])
            cylinder(h=command_height/2,d1=command_width-10,d2=command_width, center=true);
        }
    }
    
    if (engine_attached==false) {
        translate([-saucer_back+engine_front-engine_up_2,0,-saucer_up])
        rotate([90,0,0])
        cylinder(h=command_engine_width, r=engine_up_2, center=true);


        translate([-engine_front+engine_up_2,0,-saucer_up+engine_up_2/2])
        cube([engine_front-engine_up_2,command_engine_width,engine_up_2],center=true);
        }
    }
    
    
    translate([-command_engine_width*3.4,0,-.01])
    scale([2,1,.5])
    rotate([0,-90,0]) {
    translate([0,0,command_engine_length_b/8])
    sphere(command_engine_width/2);
    cylinder(d=command_engine_width,h=command_engine_length_b/4,center=true);
    }
    
    translate([-command_width, 0, command_bridge_height/2])
    scale([.75,1.8,1])
    cylinder(h=command_bridge_height,r=command_engine_width,center=true, $fn=3);

    if (render_nacelles==true) {
        util_mirrored([0,1,0])
        translate([-command_width, command_width/2.7, 0])
        util_ovoid(command_width/2.5, command_width, command_bridge_width/1.5, command_bridge_height*3, 1, faces=13);
    }
    
    translate([-command_engine_width*2.4,0,-.01])
    scale([2,1,.2])
    rotate([0,-90,0]) {

    cylinder(d=command_engine_width,h=command_engine_length_b/4,center=true);
    }
}

module mother() {
    saucer();
    translate([0,0,saucer_up-.01]) command();
    translate([0,0,-saucer_down+.01]) scout();
    translate([-saucer_back+.01,0,0]) engine();
    translate([-saucer_back+.01,0,-(engine_down-engine_down_diff)+.01]) escort();
}



module mvm_escort() {
    escort(engine_attached=false);
}

module mvm_saucer() {
    saucer(command_attached=false,engine_attached=false,scout_attached=false);
}

module mvm_scout() {
    scout(saucer_attached=false);
}

module mvm_command() {
    command(saucer_attached=false, engine_attached=false);
}

module mvm_transwarp() {
    engine(saucer_attached=false, escort_attached=false, command_attached=false);
}

module mvm_transwarp_escort() {
    engine(saucer_attached=false, escort_attached=true, command_attached=false);
    translate([0,0,-(engine_down-engine_down_diff)+.01]) 
    escort();
}

module mvm_transwarp_full() {
    engine(saucer_attached=false, escort_attached=true, command_attached=true);
    translate([0,0,-(engine_down-engine_down_diff)+.01]) 
    escort();
    translate([saucer_back-.01,0,saucer_up-.01])
    command(engine_attached=true, saucer_attached=false);
}


module mvm_scout_separate() {
    saucer(scout_attached=false);
    translate([0,0,saucer_up-.01]) command();
    translate([0,0,-saucer_down-separate_height]) scout(saucer_attached=false);
    translate([-saucer_back+.01,0,0]) engine();
    translate([-saucer_back+.01,0,-(engine_down-engine_down_diff)+.01]) escort();
}

module mvm_command_separate() {
    saucer(command_attached=false);
    translate([0,0,saucer_up+separate_height]) command(saucer_attached=false, engine_attached=false);
    translate([0,0,-saucer_down+.01]) scout();
    translate([-saucer_back+.01,0,0]) engine(command_attached=false);
    translate([-saucer_back+.01,0,-(engine_down-engine_down_diff)+.01]) escort();
}

module mvm_escort_separate() {
    saucer();
    translate([0,0,saucer_up-.01]) command();
    translate([0,0,-saucer_down+.01]) scout();
    translate([-saucer_back+.01,0,0]) engine(escort_attached=false);
    translate([-saucer_back+.01,0,-(engine_down-engine_down_diff)-separate_height]) escort(engine_attached=false);
}

module mvm_battle_separate() {
    translate([separate_length/2,0,0]) saucer(engine_attached=false, command_attached=false);
    translate([-separate_length/2,0,saucer_up-.01]) command(saucer_attached=false, saucer_raised=true);
    translate([separate_length/2,0,-saucer_down+.01]) scout();
    translate([-separate_length/2-saucer_back+.01,0,0]) engine(saucer_attached=false);
    translate([-separate_length/2-saucer_back+.01,0,-(engine_down-engine_down_diff)+.01]) escort();
}

module mvm_normal_separate() {
    translate([separate_length/2,0,0]) saucer(engine_attached=false, command_attached=true);
    translate([separate_length/2,0,saucer_up-.01]) command(saucer_attached=true, engine_attached=false);
    translate([separate_length/2,0,-saucer_down+.01]) scout();
    translate([-separate_length/2-saucer_back+.01,0,0]) engine(saucer_attached=false);
    translate([-separate_length/2-saucer_back+.01,0,-(engine_down-engine_down_diff)+.01]) escort();
}

module mvm_full_separate() {
    translate([separate_length/2,0,0]) saucer(engine_attached=false, command_attached=false, scout_attached=false);
    translate([separate_length/2,0,saucer_up+separate_height]) command(saucer_attached=false, engine_attached=false);
    translate([separate_length/2,0,-saucer_down-separate_height]) scout();
    translate([-separate_length/2-saucer_back+.01,0,0]) engine(saucer_attached=false, command_attached=false, escort_attached=false);
    translate([-separate_length/2-saucer_back+.01,0,-(engine_down-engine_down_diff)-separate_height]) escort(engine_attached=false);
}

module m_main_sep() {
    mvm_full_separate();
}


module mvm_aux_separate() {
    saucer(command_attached=false, scout_attached=false);
    translate([0,0,saucer_up+separate_height*.75]) command(saucer_attached=false, engine_attached=false);
    translate([0,0,-saucer_down-separate_height*.75]) scout(saucer_attached=false);
    translate([-saucer_back+.01,0,0]) engine(command_attached=false, escort_attached=false);
    translate([-saucer_back+.01,0,-(engine_down-engine_down_diff)-separate_height*.5]) escort(engine_attached=false);
}
