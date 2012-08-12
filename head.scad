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
 * Turn 3" Round 6061 to (2.625-mechtol) OD
 */
module head_block(){

	cylinder(r = (2.625-mechtol)/2, h = head_block_height, center = true, $fn = resolution);
}
module head_block_mount(){
	difference(){
		head_block();
		gearmotor_mount(head_block_height);
		translate([0,0,-(head_block_height/2)+0.05]){
			gearmotor_body(gearmotor_body_radius+0.1, 0.1);
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
	}
}
module head_block_shaft(){

	difference(){
		head_block();
		cylinder(r = (1.5+mechtol)/2, h = head_block_height, center = true, $fn = resolution);
	}
}

/*
 * Tube 6061 3.0 OD, 2.625 ID
 */
module head_tube(){
	difference(){
		cylinder(r = (3.0/2), h = 8.0, center = true, $fn = resolution);
		cylinder(r = (2.625/2), h = 8.0, center = true, $fn = resolution);
	}
}

head_bearing_spacer_height = 1.5;

/*
 * Tube 6061 2.75 OD, 0.25 Wall turned to (2.625-mechtol) OD
 */
module head_bearing_spacer(){
	difference(){
		cylinder(r = (2.625-mechtol)/2, h = head_bearing_spacer_height, center = true, $fn = resolution);
		cylinder(r = (2.25/2), h = head_bearing_spacer_height, center = true, $fn = resolution);
	}
}
/*
 *
 */
module head(){
	rotate([0,90,0]){
		% head_tube();
		translate([0,0,-((head_block_height/2)+(head_bearing_spacer_height/2)+(head_bearing_height/2)+(2*mechtol))]){
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
		translate([0,0,+((head_block_height/2)+(head_bearing_spacer_height/2)+(head_bearing_height/2)+(2*mechtol))]){
			head_block_shaft();
		}
   }
}
