use <../lib/util.scad>;
use <../combined/multilib.scad>;




module saucer_shape(width, height, height_ext, depth, depth_ext) {
    difference() {
        util_ovoid(width/2,
                   width/2,
                   width,
                   height+height_ext,
                   depth+depth_ext);
        
        if (height_ext > 0) {
            translate([0,0,width/2 + height])
            cube(width, center=true);
        }
        
        if (depth_ext > 0) {
            translate([0,0,-width/2 - depth])
            cube(width, center=true);
        }
    }
}

module if_rotate(condition, rot_vector) {
    if (condition) {
        rotate(rot_vector) children();
    } else {
        children();
    }
}


hangar_saucer_width = 750;
hangar_saucer_height = 30;
hangar_saucer_direction = 1;
hangar_saucer_height_ext = 45;
hangar_saucer_inner_diam = 320;
hangar_saucer_extreme_angle = 150;

hangar_saucer_hangar_length = 55;
hangar_saucer_hangar_width = 100;
hangar_saucer_hangar_height = 22;

hangar_body_width=205;
hangar_body_back=480;
hangar_body_max_height=75;

hangar_inner_saucer_width=120;
hangar_inner_saucer_up=5;
hangar_inner_saucer_down=10;
hangar_inner_front_extra=30;
hangar_body_front_minus_up=80.5;
hangar_body_back_minus_up=50;
hangar_body_back_plus_back=50;

hangar_rear_door_w_ratio=.65;
hangar_rear_door_h_ratio=.59;
hangar_rear_door_l_ratio=.7;

big_nacelle_front=200;
big_nacelle_back_hangar=600;
big_nacelle_back_saucer=600;
big_nacelle_back_transwarp=600;
big_nacelle_width=50;
big_nacelle_up=15;
big_nacelle_down=15;

big_nacelle_loc_back=750/2 + 250;
big_nacelle_loc_up=84;

module mvm_hexagon() {
            translate([0,0,hangar_saucer_width-hangar_body_front_minus_up])
        rotate([90,0,0])
        cylinder(r=hangar_saucer_width,h=hangar_saucer_width*1.2, center=true, $fn=6);
}

module mvm_saucer_minus_carrier() {
    translate([0,0,hangar_saucer_height]) carrier_minus_engine();
}

module mvm_carrier(saucer_attached=true, engine_attached=true) {
    difference() {
        translate([0,0,-hangar_saucer_direction*hangar_saucer_height/2])
        saucer_shape(hangar_saucer_width, hangar_saucer_height, hangar_saucer_height_ext, 3, 0);


        if (engine_attached == false) {
            carrier_minus_engine();
        }
        


        repeat(3, rv=[0,0,hangar_saucer_extreme_angle])
        rotate(-hangar_saucer_extreme_angle)
        translate([hangar_saucer_width/2,0,0])
        cube([hangar_saucer_hangar_length,hangar_saucer_hangar_width,hangar_saucer_hangar_height], center=true);
    }
    
        if (saucer_attached == false) {
            translate([0,0,hangar_saucer_height/2]) {
            saucer_shape(200,10,5,3,0);            
            saucer_shape(80,13,2,3,0);
            }
        }



//        translate([-hangar_saucer_inner_diam/2,0,0])
//    scale([1.5,.75,1])
//        cylinder(r2=hangar_inner_saucer_width,r1=0,h=hangar_inner_saucer_up+hangar_inner_saucer_down,center=true,$fn=4);
//        util_ovoid(hangar_saucer_inner_diam/2 + hangar_inner_front_extra,hangar_saucer_inner_diam/2,hangar_inner_saucer_width,hangar_inner_saucer_up, hangar_inner_saucer_down);


    difference() {
        translate([-hangar_saucer_width/2,0,-hangar_saucer_height/2])
        util_ovoid(hangar_body_width/1.5, hangar_body_back, hangar_body_width, hangar_body_max_height, 3);
        
        mvm_hexagon();


        
        translate([-hangar_saucer_width/2-hangar_body_back-hangar_body_back_plus_back,0,hangar_saucer_inner_diam-hangar_body_back_minus_up])
        rotate([90,0,0])
        cylinder(r=hangar_saucer_inner_diam, h=hangar_saucer_inner_diam,
        center=true, $fn=6);
    }

    translate([-hangar_saucer_width/2-hangar_body_back*hangar_rear_door_l_ratio,0,-10])
    util_ovoid(hangar_body_width*hangar_rear_door_w_ratio/2, hangar_body_width*hangar_rear_door_w_ratio/2,hangar_body_width*hangar_rear_door_w_ratio,hangar_body_max_height*hangar_rear_door_h_ratio,3);

    util_mirrored([0,1,0]) {
        translate([-big_nacelle_loc_back,(hangar_saucer_width/2)-2*big_nacelle_width,big_nacelle_loc_up]) {
            hull() {
        translate([0,big_nacelle_width/2,big_nacelle_up/2])
        util_ovoid(big_nacelle_front,big_nacelle_back_hangar,big_nacelle_width,big_nacelle_up/2,big_nacelle_down/2);
            
        translate([0,-big_nacelle_width/2,big_nacelle_up/2])
        util_ovoid(big_nacelle_front,big_nacelle_back_hangar,big_nacelle_width,big_nacelle_up/2,big_nacelle_down/2);
                
    translate([0,big_nacelle_width/2,-big_nacelle_down/2])
        util_ovoid(big_nacelle_front,big_nacelle_back_hangar,big_nacelle_width,big_nacelle_up/2,big_nacelle_down/2);
            
        translate([0,-big_nacelle_width/2,-big_nacelle_down/2])
        util_ovoid(big_nacelle_front,big_nacelle_back_hangar,big_nacelle_width,big_nacelle_up/2,big_nacelle_down/2);
            }
            

       }
    }
    
    mvm_main_nacelle(15,0);
}

module mother() {
    mvm_saucer();
    mvm_carrier();
    mvm_engine();
    mvm_command();
    mvm_escort();
    mvm_scout();
}


saucer_width=660;
saucer_height=50;
saucer_height_extra=7.5;

saucer_body_width=240;

module mvm_saucer_basic() {
    difference() {
        union() {
            translate([0,0,hangar_saucer_height/2])
            saucer_shape(saucer_width,saucer_height,saucer_height_extra,1,0);

            intersection() {
                difference() {
                    rotate([0,-90,0])
                    translate([0,0,1.2*hangar_saucer_width/4])
                    rotate(30)
                    cylinder(d=saucer_body_width, h=1.2*hangar_saucer_width/2, center=true, $fn=6);

                    translate([0,0,1.2*hangar_saucer_width/2+hangar_saucer_height/2+saucer_height])
                    cube(1.2*hangar_saucer_width, center=true);
                }

                mvm_hexagon();
            }
        }
        

    }

    mvm_main_nacelle(15,1);
    
    translate([-hangar_saucer_width/2-180,0,.9*hangar_body_max_height])
    mirror([0,0,1])
    util_nacelle_bar(saucer_body_width*.9, .6*hangar_body_max_height, 30, 10);
    
    translate([-hangar_saucer_width/2-180,0,.9*hangar_body_max_height])
    saucer_shape(60,2,0,15,5);

    translate([-hangar_saucer_width/2-180,0,.9*hangar_body_max_height])
    saucer_shape(120,15,0,2,0);

    util_mirrored([0,1,0]) {
    translate([-hangar_saucer_width/2-100, saucer_body_width/2-32,32])
    rotate([30,0,0])
    cube([200,20,saucer_height*.75], center=true);

        
    translate([-big_nacelle_loc_back,(hangar_saucer_width/2)-2*big_nacelle_width,big_nacelle_loc_up+big_nacelle_up+big_nacelle_down]) {
        hull() {
        translate([0,big_nacelle_width/2,-(big_nacelle_up+big_nacelle_down)/2])
        util_ovoid(big_nacelle_front,big_nacelle_back_saucer,big_nacelle_width,big_nacelle_up+big_nacelle_down-3,3);
            
        translate([0,-big_nacelle_width/2,-(big_nacelle_up+big_nacelle_down)/2])
        util_ovoid(big_nacelle_front,big_nacelle_back_saucer,big_nacelle_width,big_nacelle_up+big_nacelle_down-3,3);
            }
            


            
        }
    }
    
    translate([-saucer_width/2+25,0,hangar_saucer_height/2+saucer_height])
    scale([1,1,.3])
    rotate([0,90,0])
    cylinder(d=100,h=120,center=true);
}


engine_down=105;
engine_front=hangar_saucer_width/2;
engine_back=hangar_body_back;
engine_width=200;
engine_saucer_width=450;
engine_saucer_h=10;
engine_saucer_height_ext=30;
engine_smaller_saucer=430;
engine_smaller_saucer_h=10;
engine_smaller_saucer_h_ext=10;
engine_back_diff=30;
engine_upper_disk_width=200;
engine_upper_disk_height=15;

module carrier_minus_engine() {
    translate([0,0,-hangar_saucer_height/2]) 
    cylinder(h=2*engine_upper_disk_height, d=engine_upper_disk_width, center=true);
}

module mvm_engine(scout_attached=true, carrier_attached=true) {
    difference() {
        translate([-hangar_saucer_width/2,0,-hangar_saucer_height/2])
        util_ovoid(engine_front, engine_back, engine_width,5, engine_down);
        
        scout_nacelle_minus();
        if (scout_attached == false) {
            scout_saucer_minus();
        }
        
        translate([0,0,-hangar_saucer_height/2-engine_saucer_h-engine_saucer_width/2])
        sphere(engine_saucer_width/2,$fn=100);
        
        translate([-hangar_saucer_width/2 - engine_back+engine_back_diff,0,-engine_down*3.3])
        rotate([0,-30,0])
        rotate([90,0,0])
        cylinder(d=engine_front+engine_back, h=engine_front+engine_back, center=true, $fn=100);
    }
    
    difference() {
        translate([-hangar_saucer_width/2,0,-hangar_saucer_height/2-engine_down/2.5])
        util_ovoid(engine_front-50, 5, engine_width-130,engine_down/2-25, engine_down/2-25);
    
        translate([0,0,-.7*saucer_width+35])
        rotate([0,45,0])
        cube(saucer_width, center=true);
    }
    

    translate([0,0,-hangar_saucer_height/2]) {
        saucer_shape(engine_saucer_width,3,0,engine_saucer_h,engine_saucer_height_ext);
        if (carrier_attached == false) {
            saucer_shape(200,10,5,3,0);
        }
    }
    
    if (carrier_attached == false) {
        translate([0,0,-hangar_saucer_height/2+10]) {
            saucer_shape(40,5,2,3,0);
        }
    }
    
    difference() {
        translate([0,0,-hangar_saucer_height/2-engine_saucer_h]) {
            saucer_shape(engine_smaller_saucer,3,0,engine_smaller_saucer_h,engine_smaller_saucer_h_ext);
        }
        scout_nacelle_minus();
        if (scout_attached == false) {
            scout_saucer_minus();
        }
    }


    mvm_main_nacelle(15,-1);
    util_mirrored([0,1,0]) {


            
        translate([-big_nacelle_loc_back,(hangar_saucer_width/2)-2*big_nacelle_width,big_nacelle_loc_up-(big_nacelle_up+big_nacelle_down)]) {
            hull() {
            translate([0,big_nacelle_width/2,(big_nacelle_up+big_nacelle_down)/2])
            util_ovoid(big_nacelle_front,big_nacelle_back_transwarp,big_nacelle_width,3, big_nacelle_up+big_nacelle_down-3);
                
            translate([0,-big_nacelle_width/2,(big_nacelle_up+big_nacelle_down)/2])
            util_ovoid(big_nacelle_front,big_nacelle_back_transwarp,big_nacelle_width,3, big_nacelle_up+big_nacelle_down-3);
                }
                


                
            }
    }
}

module mvm_command_body() {
    translate([-command_width/2,0,hangar_saucer_height/2+saucer_height])
util_ovoid(command_body_front,command_body_back,command_body_width,command_body_up,command_body_down);
}

module mvm_saucer(command_attached=true, carrier_attached=true) {
    difference() {
        mvm_saucer_basic();
        if (command_attached==false) {
            mvm_command_body();
        }
        if (carrier_attached == false) {
            mvm_saucer_minus_carrier();
        }
    }
}
 
main_nacelle_difference=(big_nacelle_up+big_nacelle_down)*.5;

module mvm_main_nacelle(w, pos) {
    util_mirrored([0,1,0]) {

        translate([0,0,pos*main_nacelle_difference])
                hull() {
                    translate([-hangar_saucer_width/2-25,hangar_body_width/2.2,0])
                    sphere(w/2,$fn=16);

                    translate([-hangar_saucer_width/2-175,hangar_body_width/2.4,0])
                    sphere(w/2,$fn=16);

                    translate([-big_nacelle_loc_back+25,(hangar_saucer_width/2)-3*big_nacelle_width,big_nacelle_loc_up])
                    sphere(w/2,$fn=16);

                    translate([-big_nacelle_loc_back-25,(hangar_saucer_width/2)-3*big_nacelle_width,big_nacelle_loc_up])
                    sphere(w/2,$fn=16);
                }
                
                

    translate([-big_nacelle_loc_back,(hangar_saucer_width/2)-2*big_nacelle_width,big_nacelle_loc_up+ pos*(big_nacelle_up+big_nacelle_down)]) {
                
            cube([120,2*big_nacelle_width+1,big_nacelle_up+big_nacelle_down+1],center=true);
        }
    }
}

command_width=200;
command_height=20;
command_height_ext=5;
command_middle_width=75;
command_middle_height=6;
command_bridge_width=40;
command_bridge_height=4;
command_impulse_width=50;
command_body_front=100;
command_body_back=100;
command_body_width=50;
command_body_up=25;
command_body_down=30;
command_nacelle_front=70;
command_nacelle_back=180;
command_nacelle_width=25;
command_nacelle_up=13;
command_nacelle_down=2;




module mvm_command(saucer_attached=true) {
    translate([0,0,hangar_saucer_height/2+saucer_height])
    saucer_shape(command_width,command_height,command_height_ext,3,0);

    hull() {
        translate([0,0,hangar_saucer_height/2+saucer_height+command_height])
        cylinder(d=command_middle_width, h=2*command_middle_height, center=true);

        translate([-command_width/2,0,hangar_saucer_height/2+saucer_height+0.5*(command_height+command_middle_height)])
        cube([2,command_impulse_width,command_height+command_middle_height],center=true);
    }

    translate([0,0,hangar_saucer_height/2+saucer_height+command_height+command_middle_height])
    rotate(45/2)
    util_ovoid(command_bridge_width/2,command_bridge_width/2,command_bridge_width,command_bridge_height,1,faces=8);

    difference() {
        mvm_command_body();

        if(saucer_attached==false) {
            translate([-command_body_front-command_body_back,0,hangar_saucer_height/2+saucer_height-command_body_down])
            rotate([90,0,0])
            scale([command_body_back/command_body_down,1,1])
            cylinder(r=command_body_down,h=1.5*command_body_width,center=true);
            
            translate([command_body_front*1.2/2,0,0])
            rotate([0,45,0])
            cube(command_width, center=true);
        }
    }
    



    translate([0,0,hangar_saucer_height/2+saucer_height])
    util_mirrored([0,1,0])
    if_rotate(saucer_attached==false, [30,0,0]) {
    hull() {
        translate([-command_width/2,0,0])
        sphere(2.5);

        translate([-command_width/2-25,0,0])
        sphere(2.5);

        translate([-command_body_front-command_body_back+25, command_width/2-command_nacelle_width*1.5, 0])
        sphere(1.5);

        translate([-command_body_front-command_body_back-35, command_width/2-command_nacelle_width*1.5, 0])
        sphere(1.5);
    }

    translate([-command_body_front-command_body_back+25, command_width/2-command_nacelle_width*1.5, 0])
    if_rotate(saucer_attached==false, [-30,0,0])
    hull()
    repeat(2, tv=[0,command_nacelle_width/2,0])
    util_ovoid(command_nacelle_front,command_nacelle_back,command_nacelle_width/2,command_nacelle_up,command_nacelle_down,faces=9);
    }
}

escort_width=150;
escort_height=15;
escort_height_ext=10;
escort_notch_width=32;
escort_nacelle_length=210;
escort_nacelle_width=40;
escort_nacelle_height_diff=15;
escort_nacelle_height=escort_width/2-escort_notch_width/2+escort_nacelle_height_diff;

module mvm_escort(docked=true) {
    translate([-hangar_saucer_width/2-hangar_body_back+1.4*escort_width,0,-hangar_saucer_height/2-escort_height/2]) {
        difference() {
            saucer_shape(escort_width,escort_height/2,escort_height_ext, escort_height/2, escort_height_ext);

            translate([escort_width/2,0,0])
            cube(escort_notch_width, center=true);
                
            translate([-escort_width/2,0,0])
            cube(escort_notch_width, center=true);
        }

        difference() {
            util_mirrored([0,1,0])
            translate([0,escort_notch_width/2,0])
            rotate([90,0,0])
            util_nacelle(escort_nacelle_length, escort_nacelle_width, escort_nacelle_height, curved=true, up=false);
            if (docked == false) {
                translate([0,0,saucer_width/2+escort_height/2])
                cube(saucer_width,  center=true);
            }

        }
        
        saucer_shape(escort_width/2,3,0,escort_height,escort_height_ext);
    }
}

scout_width=100;
scout_up=10;
scout_up_ext=5;
scout_body_front=50;
scout_body_back=50;
scout_body_width=25;
scout_body_up=10;
scout_body_down=15;
scout_nacelle_front=25;
scout_nacelle_back=75;
scout_nacelle_up=8;
scout_nacelle_down=2;
scout_nacelle_width=8;


module mvm_scout(engine_attached=true) {
    translate([scout_width,0,-hangar_saucer_height/2-engine_saucer_h-engine_smaller_saucer_h]) {
        saucer_shape(scout_width,scout_up,scout_up_ext,1,0);
        saucer_shape(scout_width/3,scout_up+3.3, 3.3, 3.3, 1);
    }

    difference() {
        translate([scout_body_back,0,-hangar_saucer_height/2-engine_saucer_h-engine_smaller_saucer_h])
        util_ovoid(scout_body_front,scout_body_back,scout_body_width,scout_body_up,scout_body_down);
        
        translate([scout_width,0,-hangar_saucer_height/2-engine_saucer_h-engine_smaller_saucer_h-scout_width/2+scout_body_down])
        rotate([90,0,0])
        cylinder(d=scout_width,h=scout_width,center=true,$fn=6);
    
    
        translate([0,0,-hangar_saucer_height/2-engine_saucer_h-engine_smaller_saucer_h-scout_body_down])
        scale([2,1,1])
        rotate([90,0,0])
        cylinder(r=scout_body_down, h=scout_body_width*1.5,center=true);
    }
    
    mvm_scout_nacelle_assembly();
    
}

module scout_nacelle_minus() {
    translate([-10,0,-hangar_saucer_height/2-engine_saucer_h-engine_smaller_saucer_h+3])
    cube([1.2*scout_width, .8*scout_width, 2*scout_body_up+scout_body_down],center=true);
}

module scout_saucer_minus() {
    render() {
        translate([scout_width,0,-hangar_saucer_height/2-engine_saucer_h-engine_smaller_saucer_h]) {
            saucer_shape(scout_width,scout_up+scout_up_ext,0,scout_up+scout_up_ext,0);
        }
        
        translate([scout_body_back,0,-hangar_saucer_height/2-engine_saucer_h-engine_smaller_saucer_h])
        rotate([0,90,0])
        cylinder(d=scout_body_width,h=scout_body_back+scout_body_front,center=true);
    }
}
    


module mvm_scout_nacelle_assembly() {
    util_mirrored([0,1,0]) {
        translate([scout_nacelle_front/2,scout_width/2-2*scout_nacelle_width,-hangar_saucer_height/2-engine_saucer_h])
        hull()
        util_mirrored([0,1,0])
        translate([0,2,0])
        util_ovoid(scout_nacelle_front,scout_nacelle_back,scout_nacelle_width,scout_nacelle_up,scout_nacelle_down);
        
        hull() {
            translate([scout_body_back,0,-hangar_saucer_height/2-engine_saucer_h-engine_smaller_saucer_h]) sphere(1);
            
            translate([scout_body_back-25,0,-hangar_saucer_height/2-engine_saucer_h-engine_smaller_saucer_h]) sphere(1);
            
            translate([scout_nacelle_front/2+5,scout_width/2-2*scout_nacelle_width,-hangar_saucer_height/2-engine_saucer_h])
            sphere(1);
            
            translate([scout_nacelle_front/2-5,scout_width/2-2*scout_nacelle_width,-hangar_saucer_height/2-engine_saucer_h])
            sphere(1);
        }
    }
}

module mvm_carrier_full() {
    mvm_carrier(saucer_attached=false, engine_attached=false);
    mvm_escort();
}

module mvm_saucer_full() {
    mvm_saucer(carrier_attached=false);
    mvm_command();
}

module mvm_transwarp_full() {
    mvm_engine(carrier_attached=false);
    mvm_scout();
}

module mother() {
    mvm_saucer();
    mvm_carrier();
    mvm_engine();
    mvm_command();
    mvm_escort();
    mvm_scout();
}

major_separation=200;
minor_separation=100;

module mvm_saucer_single() {
    mvm_saucer(command_attached=false, carrier_attached=false);
}

module mvm_command_single() {
    mvm_command(saucer_attached=false);
}

module mvm_carrier_single() {
    mvm_carrier(saucer_attached=false, engine_attached=false);
}

module mvm_escort_single() {
    mvm_escort(docked=false);
}

module mvm_transwarp_single() {
    mvm_engine(scout_attached=false, carrier_attached=false);
}

module mvm_scout_single() {
    mvm_scout();
}

module mvm_half_separation() {
    translate([0,0,major_separation]) mvm_saucer_full();
    translate([0,0,0]) mvm_carrier_full();
    translate([0,0,-major_separation]) mvm_transwarp_full();
}

module mvm_saucer_separation() {
    mvm_saucer(command_attached=false, carrier_attached=false);
    translate([0,0,minor_separation])mvm_command(saucer_attached=false);
}
    
module mvm_carrier_separation() {
    mvm_carrier(saucer_attached=false, engine_attached=false);
    translate([0,0,-minor_separation*.5]) mvm_escort(docked=false);
}

module mvm_transwarp_separation() {
    mvm_engine(scout_attached=false, carrier_attached=false);
    translate([0,0,-minor_separation]) mvm_scout();
}

module mvm_full_separation() {
    translate([0,0,major_separation]) mvm_saucer_separation();
    translate([0,0,0]) mvm_carrier_separation();
    translate([0,0,-major_separation]) mvm_transwarp_separation();
}

module mvm_without_carrier() {
    translate([0,0,-hangar_saucer_height/2]) {
        mvm_command();
        mvm_saucer();
    }
    
    translate([0,0,hangar_saucer_height/2]) {
        mvm_engine();
        mvm_scout();
    }
}

module mvm_without_saucer() {
    mvm_carrier_full();
    mvm_transwarp_full();
}

module mvm_without_transwarp() {
    mvm_saucer_full();
    mvm_carrier_full();
}


