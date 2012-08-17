/*
 * Antenna Rotator 16 kg-m
 * Copyright 2012 John Pritchard
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * units = inches
 */


head_bearing_height = 0.5625;

head_block_od = 2.625;

/*
 * R24-2RS Radial Bearing: 1.5 ID, 2.625 OD, 0.5625 H
 */
module head_bearing(){
	difference(){
		cylinder(r = (2.625/2), h = head_bearing_height, center = true, $fn = resolution);
		cylinder(r = (1.5/2), h = head_bearing_height, center = true, $fn = resolution);
	}
}

head_block_height = 0.75;

/*
 * Turn 3" Round 6061 to 2.625 OD
 */
module head_block(){

	cylinder(r = head_block_od/2, h = head_block_height, center = true, $fn = resolution);
}

head_block_mount_gearmotor_clearance = 0.1;

module head_block_mount(){
	difference(){
		head_block();
		gearmotor_mount(head_block_height);
		translate([0,0,-(head_block_height/2)+(head_block_mount_gearmotor_clearance/2)]){
			/*
			 * gearmotor body clearance: maximize mount strength
			 */
			gearmotor_body((gearmotor_body_radius+mechtol), head_block_mount_gearmotor_clearance);
		}
		translate([0,0,+(head_block_height/2)-0.125]){
			/*
			 * Embedded axle clearance
			 */
			cylinder(r = (1.5+(2*mechtol))/2, h = 0.25, center = true, $fn = resolution);
			/*
			 * Mount bolt head clearance 
			 * M4 ALLEN DIN 912
			 * Head Height 4 mm, 0.1575 in; Diameter 7 mm, 0.2756 in
			 *
			 * Flat Washer
			 * Diameter 9mm, 0.3543 in; Height = 0.8 mm, 0.0315 in
			 */
			gearmotor_mount_holes(depth = 0.25, expansion = 0.1771);
		}
		translate([0,0,+(head_block_height/2)-0.25-(0.189/2)]){
			/*
			 * Mount bolt head sink 
			 * M4 ALLEN DIN 912 Head + Flat Washer (4 + 0.8 mm)
			 */
			gearmotor_mount_holes(depth = 0.189, expansion = 0.1771);
		}
		head_block_mount_taps();
	}
}
/*
 * M4 taps with 10 mm depth
 * Minimal interior wall at gearmotor body clearance (diagonal)
 */
module head_block_mount_taps(depth = 0.3937){

	translate([0,0,-0.07]){

		head_block_taps( (head_block_od/2)-(depth/2), depth);
	}
}
/*
 * ID M4 Tap Hole ID 3.2 mm; IR = 0.126 in
 */
module head_block_taps(offset = 0.3937, height = 0.3937){

	for (rot = [45: 90: 360]){
	
		translate([(offset*sin(rot)),(offset*cos(rot)),0]){
			rotate([0,90,rot]){
				cylinder(r = 0.126, h = height, center = true, $fn = 40);
				/*
				 * Minimal wall dimension
				 * 
				 * This cube tests the intersection with the gearmotor body clearance (inset 0.1 in)
				 * 
				cube(size = height, center = true, $fn = 40);
				 */
			}
		}
	}
}
/*
 * M4 taps with 8 mm depth
 * Minimal interior wall at gearmotor body clearance (diagonal)
 */
module head_block_shaft_taps(depth = 0.3149){

	head_block_taps( (head_block_od/2)-(depth/2), depth);
}
/*
 * TR-023 Hydraulic Rod T-Seal Buna-N
 * 1.5" ID x 1.875" OD x 0.28" H
 */
module head_block_shaft_tseal(){

	translate([0,0,(head_block_height-0.28+mechtol)/2]){

		cylinder(r = 0.9375, h = 0.28, center = true, $fn = resolution);
	}
}
module head_block_shaft(){

	difference(){
		head_block();
		cylinder(r = (1.5+mechtol)/2, h = head_block_height, center = true, $fn = resolution);
		head_block_shaft_taps();
		head_block_shaft_tseal();
	}
}

/*
 * Tube 6061 3.0 OD, 2.625 ID, Wall 0.1875 in
 */
module head_tube(height = 8.29){
	translate([0,0,-((head_block_height)+(head_bearing_spacer_height/2)+(head_bearing_height)+(2*mechtol))]){
		difference(){
			cylinder(r = (3.0/2), h = height, center = true, $fn = resolution);
			cylinder(r = (2.625/2), h = height, center = true, $fn = resolution);
		}
	}
}

head_bearing_spacer_height = 1.5;

/*
 * Tube 6061 2.75 OD, 0.25 Wall turned to Head Block OD 2.625 in
 */
module head_bearing_spacer(){
	difference(){
		cylinder(r = head_block_od/2, h = head_bearing_spacer_height, center = true, $fn = resolution);
		cylinder(r = (2.25/2), h = head_bearing_spacer_height, center = true, $fn = resolution);
	}
}
/*
 * Blocks, Bearings, and Spacer
 */
module head_internal(){
	translate([0,0,-((gearmotor_body_height/2)+(head_block_height-head_block_mount_gearmotor_clearance)+(head_bearing_spacer_height/2)+(head_bearing_height)+(3*mechtol))]){
		gearmotor();
	}
	translate([0,0,-((head_block_height/2)+(head_bearing_spacer_height/2)+(head_bearing_height)+(2*mechtol))]){
		head_block_mount();
	}
	translate([0,0,-((head_bearing_spacer_height/2)+(head_bearing_height/2)+mechtol)]){
		head_bearing();
	}
	translate([0,0,0]){
		head_bearing_spacer();
	}
	translate([0,0,+((head_bearing_spacer_height/2)+(head_bearing_height/2)+mechtol)]){
		head_bearing();
	}
	translate([0,0,+((head_block_height/2)+(head_bearing_spacer_height/2)+(head_bearing_height)+(2*mechtol))]){
		head_block_shaft();
	}
}
module head(){
	head_tube();
	head_internal();
}
