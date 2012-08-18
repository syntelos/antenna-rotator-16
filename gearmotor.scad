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
 * 
 * External constants
 * 
 * resolution: 10 is low, 100 is high
 *
 * mechtol: mechanical tolerance
 */

gearmotor_body_radius = 0.8366;
gearmotor_body_height = 3.819;

/*
 * Brushless motor with planetary gearhead, 
 * drive control, position encoder, brake:
 * 24V, 2A, 500:1, 15.6 kg-m, 8 rpm;
 * http://www.aliexpress.com/store/product/explosion-proof-DC-servo-Brushless-gear-motor-micro-planetary-gearbox-gear-reducer-156kg-cm-hight-torque/506137_516569606.html
 */
module gearmotor(){
	difference(){
		union(){

			gearmotor_body();
			/*
			 * Mount plane from center
			 */
			translate([0,0,1.9095]){

				gearmotor_mount_shoulder(gearmotor_mount_shoulder_height,(gearmotor_mount_shoulder_height/2));

				gearmotor_output_shaft();
			}
			/*
			 * Electrical connector, a space filling model
			 * for the bounds [20,2.75,6] mm
			 */
			translate([0,-gearmotor_body_radius,-1.339]){
				cube(size = [0.7874,0.2166,0.2362], center = true);
			}
		}
		fastener_m4_mount_tapped(0.5,1.9095);
	}
}
/*
 * Main body volume
 */
module gearmotor_body(radius = gearmotor_body_radius, height = gearmotor_body_height){
	cylinder( r = radius, h = height, center = true, $fn = resolution);
}
/*
 * Output shaft
 * Translated for half of height, centered
 */
module gearmotor_output_shaft(length = 0.787){

	translate([0,0,(length/2)]){
		cylinder(r = 0.2362, length, center = true, $fn = resolution);
	}
}

gearmotor_mount_shoulder_radius = 0.4724;
gearmotor_mount_shoulder_height = 0.106;

/*
 * Mount shoulder
 * Translated for half of height, centered
 */
module gearmotor_mount_shoulder(height = gearmotor_mount_shoulder_height, offset = 0){

	translate([0,0,offset]){
		cylinder(r = gearmotor_mount_shoulder_radius, height, center = true, $fn = resolution);
	}
}
/*
 * Motor mounting in the mount plane: shoulder and tap holes
 */
module gearmotor_mount(depth,offset = 0){
	gearmotor_mount_shoulder(depth,offset);
	fastener_m4_mount_tapped(depth,offset);
}
