//remix of http://www.thingiverse.com/thing:528934
//
//-- NEMA 17 stepper holder for 2020 rail
//  designed by L Buell  Feb 2016
//-- remixed from a well designed remix by AndrewBCN - November 2014
//-- remixed from an original (excellent) design by Paul Chase
//-- original design is Thingiverse no. 321523

//  I removed some of AndrewBCN's stuff and added the 2020 mount
// some of my 2020 rail mounted designs are meant to be drop onto the rail,
//   and some are meant to more fully engage and slide in from the end of the rail
// this design is drop-in style

//-- slop is tolerance, wall is wall thickness
slop = 0.2; // don't mess with these two!
wall = 3;

base_plate_height = 16;
Vert_plate_thickness = 6; // vertical base plate thickness
motor_w = 42;
motor_r = 50/2;
$fn=32;
height = wall+12;
m5 = 5.5;           // threaded z-rod diameter
m3 = 3.3/2;     // diam of m3 screw
m3n = 6.9/2;  // diam of m3 nut
m3nh = 4;      // nut height of m3 nuts that hold adaptor to x-ends
m3nl = 20;     // screw length of nuts that hold adaptor to x-ends
hole_sep = 20;  // separation of mount holes - mount holes deleted - this now controls height of mount

rail_Ht=20;  //height of 2020 rail 
2020_mount_width=20;  // width of mounting arm on top of 2020 rail
2020_mount_thickness=10;  // thickness of mounting arm on top of 2020 rail
mount_radius=3;  //radius of corners of rounded block
2020_groove_size=6; //used for the width and depth of the block fitting into the 2020 rail
Tslot_nut_length=12;  //length of T-slot nut

complete_part();
//mirror(0,0,1) complete_part();

module complete_part(){
difference(){
union(){
stepper_holder();	
translate([-motor_w/2-2020_mount_width/2-Vert_plate_thickness-.95,0,10+hole_sep-2020_mount_thickness/2])2020_block();  //block that mounts into the 2020 rail
}  //union
// cavities

// 2020 mounting block cavities
translate([-motor_w/2-2020_mount_width/2-Vert_plate_thickness-.95,-2020_mount_width/2,0]){
//cutout for t-slot nut
translate([-2020_mount_width/2+rail_Ht/2-2020_groove_size/2-.5,(2020_mount_width-Tslot_nut_length)/2,rail_Ht-2020_groove_size-.5])cube([2020_groove_size+1,Tslot_nut_length,2020_groove_size+.5]);
// hole for t-slot nut
translate([-2020_mount_width/2+rail_Ht/2,2020_mount_width/2,rail_Ht+2020_mount_thickness/2])cylinder(h=rail_Ht, r=5.5/2,center=true,$fn=16);
}  // translate
}  //difference
}  //module

module 2020_block(){
rounded_rectangle([rail_Ht,2020_mount_width,2020_mount_thickness],mount_radius,center=true);
// fill in rounded corner
translate([rail_Ht/2-3,-2020_mount_width/2,-2020_mount_thickness/2])cube([Vert_plate_thickness,2020_mount_width,2020_mount_thickness]);
// square block to fit in slot on rail
translate([-2020_groove_size/2,-2020_mount_width/2,-2020_mount_thickness/2-2020_groove_size+.5])cube([2020_groove_size,2020_mount_width,2020_groove_size]);
}  //module 2020_block

module stepper_holder() {
	scale_slop = 1.025; // another tolerance
	scale_size = (motor_w+wall+wall)/motor_w;	
	difference(){
		union(){
			hull(){
				//strap
				scale([scale_size,scale_size,1]) motor_base(h=height);
				//clamp
				translate([0,motor_w/2+wall+m3+wall,height/2]) rotate([0,90,0]) cylinder(r=height/2, h=5*wall, center=true);			
			}
			//mount base
			hull(){
				// bottom block of mount
				translate([-motor_w/2-wall-wall/2+0.55,0,base_plate_height/2]) cube([Vert_plate_thickness,31,base_plate_height], center=true);
				//  top cylinders that make top of mount
				translate([-motor_w/2-wall-wall/2+0.55-Vert_plate_thickness/2,+10,8+hole_sep]) rotate([0,90,0]) cylinder(r=2, h=Vert_plate_thickness);
				translate([-motor_w/2-wall-wall/2+0.55-Vert_plate_thickness/2,-10,8+hole_sep]) rotate([0,90,0]) cylinder(r=2, h=Vert_plate_thickness);				
			}
			// reinforcement cylinders in corners
			translate([-motor_w/2-wall-wall+3.5,+16,0]) rotate([0,0,0]) cylinder(r=2, h=15);
			translate([-motor_w/2-wall-wall+3.5,-16,0]) rotate([0,0,0]) cylinder(r=2, h=15);
		}  //union

		//cavities
		// slit
		translate([0,motor_w/2,height/2]) cube([wall,motor_w,height+1],center=true);
		// clamp holes
		render() translate([0,motor_w/2+wall+m3+wall,height/2]) rotate([0,90,0]) clamp_holes();
		// motor cross section hollowed out
		scale([scale_slop,scale_slop,1]) translate([0,0,-.05]) motor_base(h=height+.1);
	}
	
	// uncomment this if you need a place to tie wires to
	/*
	//-- AndrewBCN: I added a place where people can tie some wires
	difference(){
	   rotate([0,0,-90]) translate([22.5,+8,0]) cube([8,8,4]);
	   rotate([0,0,-90]) translate([26.5,+10,-2]) cube([1.5,4,12]);
	}
	*/	
} //module stepper_holder

module clamp_holes() {
	len = wall*5;
	// screwhole
	rotate([0,0,-90]) cap_cylinder(r=3.1/2, h=len*2, center=true); 
	// nut is on the inside
	mirror([0,0,1]) translate([0,0,wall*2.5]) rotate([0,0,-90]) cylinder(r=6.9/2, h=len, $fn=6);
	// screw is on the outside
	translate([0,0,wall*2.5]) rotate([0,0,-90]) cap_cylinder(r=6.9/2, h=len);
}

module cap_cylinder(r=1, h=1, center=false){
	render() union() {
		cylinder(r=r, h=h, center=center);
		intersection(){
			rotate([0,0,22.5]) cylinder(r=r/cos(180/8), h=h, $fn=8, center=center);
			translate([0,-r/cos(180/4),0]) rotate([0,0,0]) cylinder(r=r/cos(180/4), h=h, $fn=4, center=center);
		}
	}
}

//-- Motor cross section
module motor_base(h=wall){
	intersection(){
		translate([0,0,h/2]) cube([motor_w, motor_w, h], center=true);
		cylinder(r=motor_r+slop, h=h, $fn=64);
	}
}

// From: https://github.com/T3P3/Mendel90/tree/LaserCut/scad
// utils.scad
module rounded_square(w, h, r){
    union() {
        square([w - 2 * r, h], center = true);
        square([w, h - 2 * r], center = true);
        for(x = [-w/2 + r, w/2 - r])
            for(y = [-h/2 + r, h/2 - r])
                translate([x, y])
                    circle(r = r);
    }
}
// From: https://github.com/T3P3/Mendel90/tree/LaserCut/scad
// utils.scad
module rounded_rectangle(size, r, center = true){
    w = size[0];
    h = size[1];
    linear_extrude(height = size[2], center = center)
        rounded_square(size[0], size[1], r);
}