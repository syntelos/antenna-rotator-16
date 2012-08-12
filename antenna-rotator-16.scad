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

/*
 * model resolution: 10 is low, 100 is high
 */
resolution = 40;
/*
 * mechanical tolerance, separation of fit:
 * applied to diameter of cylinder, side of cube
 */
mechtol = 0.005;

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

mast_bearing_height = 0.42;

/*
 * LM67048 Tapered Bearing and L44610 Cup: 1.25 ID, 1.98 OD
 */
module mast_bearing(){
	difference(){
		cylinder(r = 0.990, h = mast_bearing_height, center = true, $fn = resolution);
		cylinder(r = 0.625, h = mast_bearing_height, center = true, $fn = resolution);
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

	head_block();
}
module head_block_shaft(){

	difference(){
		head_block();
		cylinder(r = (1.5+mechtol)/2, h = head_block_height, center = true, $fn = resolution);
	}
}

mast_block_height = 0.75;

/*
 * Turn 2" Round 6061 to (2.0-mechtol) OD
 */
module mast_block(){
	/*
	 * TODO 
	 */
	cylinder(r = (2.0-mechtol)/2, h = mast_block_height, center = true, $fn = resolution);
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

gearmotor_mount_height = 3.819;

/*
 * Brushless motor with planetary gearhead, 
 * drive control, position encoder, brake:
 * 24V, 2A, 500:1, 15.6 kg-m, 8 rpm;
 * http://www.aliexpress.com/store/product/explosion-proof-DC-servo-Brushless-gear-motor-micro-planetary-gearbox-gear-reducer-156kg-cm-hight-torque/506137_516569606.html
 */
module gearmotor(){
	difference(){
		union(){
			/*
			 * Main body volume
			 */
			cylinder(r = 0.8366, h = gearmotor_mount_height, center = true, $fn = resolution);
			/*
			 * Mount plane from center
			 */
			translate([0,0,1.9095]){
				/*
				 * Mount shoulder
				 * Translated for half of height, centered
				 */
				translate([0,0,0.053]){
					cylinder(r = 0.4724, h = 0.106, center = true, $fn = resolution
	);
				}
				/*
				 * Output shaft
				 * Translated for half of height, centered
				 */
				translate([0,0,0.3935]){
					cylinder(r = 0.2362, h = 0.787, center = true, $fn = resolution);
				}
			}
			/*
			 * Electrical connector, a space filling model
			 * for the bounds [20,2.75,6] mm
			 */
			translate([0,-0.8366,-1.339]){
				cube(size = [0.7874,0.2166,0.2362], center = true);
			}
		}
		/*
		 * M4 mounting holes
		 */
		for (theta = [0 : 90: 300] ){
			/*
			 * translate to the mount plane and hole center
			 * for a representative negative space centered 
			 * on this point.
			 */
			translate([0.6693*sin(theta),0.6693*cos(theta),1.9095]){
				cylinder(r = 0.0787, h = 0.5, center = true, $fn = resolution);
			}
		}
	}
}
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
			head_block_mount();
		}
   }
}

head();
