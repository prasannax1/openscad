use <performance.scad>;
        
module mother_a() {
    rotate(90) mother();
}

module science_a() {
    translate([0,240,64]) rotate(90) science();
    translate([0,188,64]) rotate(90) science();
}

module attack_a() {
    translate([0,220,64]) rotate(90) attack();
}

module hospital_a() {
    translate([0,225,75]) rotate(90) hospital();
}

module diplomat_a() {
    translate([0,250,64]) rotate(90) diplomat();
}

module scout_a() {
    translate([0,200,75]) rotate(-90) scout();
}

module sector(num) {
    rotate(-num * 360/16) children();
}



mother_a();
sector(0) diplomat_a();
sector(1) scout_a();
sector(2) hospital_a();
sector(3) science_a();
sector(5) science_a();
sector(6) science_a();
sector(7) attack_a();
sector(9) attack_a();
sector(10) science_a();
sector(11) science_a();
sector(13) science_a();
sector(14) science_a();
sector(15) scout_a();
