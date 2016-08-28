// J-Head (E3D) mount
// copyright (c) 2013 - Jarek Szczepanski <imrahil@imrahil.com>
// oryginal design derived from http://www.thingiverse.com/thing:26355

use <keystone.scad>

$fn=256;

size = 18;
length = 28;
height = 9;

separation = 50;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8.1;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 10;
cone_r1 = 2.5;
cone_r2 = 14;


mount_spacing = 50;
carriage_mount_dia = 4.5;

// dimensions for E3D hotned
extruder_dia = 16;
extruder_dia2 = 12;
extruder_cyl1_height = 3.7;
extruder_cyl2_height = 5.6;

mount_screws_dia = 3.5;

// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;


// main module
main();

module main() {
  translate([62,-16,-4.5]) rotate([0,0,90]) keystone();
  difference(){
      translate([16,-7.5,-4.5]) cube([23,15,height]);
      translate([31,+5,-5.5]) cylinder(r=1.6,h=12);
      translate([24,-5,-5.5]) cylinder(r=1.6,h=12);
      }
  translate([-20, 0, 0]){
    intersection() {
      mount();
      separator();
    }
  }

  difference() {
    mount();
    separator();
  }
}

module mount() {
  difference() {
    plate();
    extruder();
    mount_screws();
  }
}

module plate() {
  difference() {
  
       translate([0,0,-4.5]) cylinder(r=18, h=height);
   
   
  for (a = [90:180:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
	cylinder(r=m3_wide_radius+.5, h=2*height, center=true, $fn=12); // Add /5 to give us room for brass
    //  translate([0, mount_radius, height-4.4]) 
    //    cylinder(r=m3_nut_radius, h=3, center=true, $fn=6);
    }  
  }
}

module extruder() {
  pos1 = height/2 - extruder_cyl1_height/2 + 0.5;
  pos2 = height/2 - extruder_cyl1_height - extruder_cyl2_height/2;

  union() {
    translate([0, 0, pos1]){
      cylinder(r=extruder_dia/2, h=extruder_cyl1_height + 1, center=true, $fn=32); 
    }

    translate([0, 0, pos2]){
       cylinder(r=extruder_dia2/2, h=extruder_cyl2_height + 1, center=true, $fn=32); 
    }	
  }
}

module mount_screws() {
  union() {
    translate([0, 12, 0]){
      rotate([0, 90, 0]) cylinder(r=mount_screws_dia/2, h=length + 3, center=true, $fn=32); // hole for nut
      translate([length/2 - 3, 0, 0]){
        rotate([-90, 0, -90]) cylinder(r=mount_screws_dia, h=5, $fn=6); 
      }
      translate([-length/2 - 1.5, 0, 0]){
        rotate([0, 90, 0]) cylinder(r=3.1, h=5, $fn=32); // hole for screw's head
      }
    }

    translate([0, -12, 0]){
      rotate([0, 90, 0]) cylinder(r=mount_screws_dia/2, h=length + 3, center=true, $fn=32); // hole for nut 
      translate([length/2 - 3, 0, 0]){
        rotate([-90, 0, -90]) cylinder(r=mount_screws_dia, h=5, $fn=6); 
      }
      translate([-length/2 - 1.5, 0, 0]){
        rotate([0, 90, 0]) cylinder(r=3.1, h=5, $fn=32); // hole for screw's head 
      }
    }
  }
}

module separator() {
  translate([-20, 0, 0]){
    cylinder(r=43/2, h=height + 1, center=true, $fn=64); 
  }
}
