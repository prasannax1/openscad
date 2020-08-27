use <../mother/mlib.scad>;
use <../macs/macs.scad>;
use <../macs/shuttle.scad>;
use <../macs/fighter.scad>;
use <../lib/util.scad>;
use <../icp/tactical-runabout.scad>;
use <multilib.scad>;


color("SlateGray")
mvm_escort();

color("IndianRed")
translate([140,0,5])
tactical();

color("Chocolate")
util_mirrored([0,1,0])
repeat(2,tv=[0,18,0])
translate([10,9,5])
rotate(180)
macs_fighter();