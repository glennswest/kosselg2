// main module
rotate([0,90,0])main();

$fn=128;

module main() {
  
  difference(){
      translate([ -8,-7.5,-4.5]) cube([24,15,5]);
      translate([  4,-5,-5.5]) cylinder(r=1.6,h=12);
      translate([ -3,+5,-5.5]) cylinder(r=1.6,h=12);
      }
   
   difference(){
       union(){
         translate([11,-7.5,-4.5]) cube([5,15,50]);  
         translate([1.5,0,-4.5]) cylinder(r=17,h=50);
       }
       translate([1.5,0,-5.5]) cylinder(r=14,h=52);
       translate([-30,-15,-5.5]) cube([30,30,52]);
       }
      difference(){ 
        translate([1.5,0, 40]) cylinder(r=14,h=5.5);  //9.5
        translate([1.5,0, 39.2]) cylinder(r=9.5,h=6.4);
        }
      difference(){  
        translate([-23.4,0,40]) cylinder(r=41.5,h=5);
        translate([-23.4,0,39]) cylinder(r=38,h=7);
        translate([ -104,-42,39]) cube([84,84,8]);
        }  
  }