/*
The other components in this file are STLs I downloaded
off the internet and scaled so that 1 pt = 1 meter.

Other files not included in source code.
*/

use <../mother/saucer.scad>;
use <galaxy.scad>;
use <sovereign.scad>;


saucer();

translate([400,0,200]) galaxy();

