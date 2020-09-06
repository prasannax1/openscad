/*
The other components in this file are STLs I downloaded
off the internet and scaled so that 1 pt = 1 meter.

Other files not included in source code.
*/

use <../mother/mlib.scad>;
use <galaxy.scad>;
use <sovereign.scad>;


render()
mvm_saucer();

translate([150,0,400]) galaxy();

translate([150,0,200]) sovereign();