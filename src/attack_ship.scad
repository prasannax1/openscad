use <util.scad>;

module at_main_no_diff() {
    union () {
        util_saucer(80,40,10);
        util_body(80,40,5,10);
    }
}


module at_main_minus() {
    translate([-14.5,-90,-10])
        rotate([-15,0,0])
            cube([29,80,80]);

    translate([0,40.5,-2.5])
        sphere(1.5, $fn=16);

    translate([-2.5,39,1])
        rotate([60,0,0])
            cube([5,5,10]);

    translate([0,-35,0])
        rotate([45,0,0])
            cube([40,10,40], center=true);
}

module at_nacelle_assembly() {
    translate([12,5,4])
        rotate([0,-45,0])
            at_nacelle_2();
    mirror([1,0,0])
        translate([12,5,4])
            rotate([0,-45,0])
                at_nacelle_2();
}

module at_nacelle_2() {
    rotate(90)
        util_nacelle(40,7.5,12,curved=true, up=false,front_bulge=true);
}


module at_main() {
    union() {
        difference() {
            rotate(90) at_main_no_diff();
            at_main_minus();
        }
        at_nacelle_assembly();
    }
}

module attack() {
    scale(.75) at_main();
}

attack();



