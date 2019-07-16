use <util.scad>;



module macs_pod_diff() {
    translate([0,0,-(6+.5)])
        cube(12, center=true);

    translate([-(3+1.25),0,0])
        cube(6, center=true);
}

module macs_pod() {
    difference() {
        scale([1,.4,.35])
            rotate(90)
                sphere(6, $fn=6);
        macs_pod_diff();
    }
    
    //macs_pod_wing();
}



module macs_pod_wing() {
    translate([-1,0,0])
        rotate([0,90,0])
            scale([.1,1,1])
                cylinder(2, 3.5, 2.75, $fn=6);
}

module macs_small_warp() {
    difference() {
        scale([1,1,.9])
            rotate([0,-90,0])
                rotate(90)
                    cylinder(4,2,2,$fn=6, center=true);

        translate([0,0,-(6+.5)])
            cube(12, center=true);
    }

    translate([0,0,1.5])
        mirror([0,0,1])
            scale([1,1.2,0.8])
                util_nacelle_bar(6,2,2,.15);

    util_mirrored([0,1,0])
        translate([2.75,3.4,0])
            util_nacelle(6,1,1,curved=true, up=false);
}

module macs_small_shuttle() {
    union() {
        translate([1.25,0,0]) macs_pod();
        translate([-2,0,0]) macs_small_warp();
    }
}

macs_small_shuttle();