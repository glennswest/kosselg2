// main module
rotate([0,90,0])main();

$fn=128;

module main() {
  
  difference(){
      translate([ -4,-9,-4.5]) cube([20,18,5]);
      translate([  7,-5,-5.5]) cylinder(r=1.6,h=12);
      translate([  0,+5,-5.5]) cylinder(r=1.6,h=12);
      }
   
   difference(){
       union(){
         translate([11,-7.5,-4.5]) cube([5,15,50]);  
         translate([1.5,0,-4.5]) cylinder(r=17,h=50);
       }
       translate([1.5,0,-5.5]) cylinder(r=14.5,h=53);
       translate([-30,-15,-5.5]) cube([30,30,52]);
       }
      difference(){ 
        translate([1.5,0, 40]) cylinder(r=15,h=5.5);  //9.5
        translate([1.5,0, 39.2]) cylinder(r=10,h=6.4);
        }
      difference(){  
        translate([-23.0,0,38.6]) cylinder(r=41.5,h=7);
        translate([-23.0,0,36.6]) cylinder(r=38,h=10);
        translate([ -104,-42,38]) cube([84,84,12]);
        translate([ -15,-42,28]) cube([4,84,12]);  
        }  
      
  }