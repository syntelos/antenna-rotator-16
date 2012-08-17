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
 * ID M4 Tap Hole ID 3.2 mm; IR = 0.126 in
 */
module fastener_m4_taps(offset = 0.3937, height = 0.3937){

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
 * M4 Counter Sunk Head
 */
module fastener_m4_countersink(){
	translate([0,0,0.00385]){
		union(){
			translate([0,0,+(0.0899/2)]){
				cylinder( r = (0.3508/2), h = 0.0899, center = true, $fn = resolution);
			}
			translate([0,0,-(0.0976/2)]){
				cylinder( r1 = (0.1575/2), r2 = (0.3508/2), h = 0.0976, center = true, $fn = resolution);
			}
		}
	}
}
/*
 * 4 x M4 Counter Sunk Heads on Tube OD
 */
module fastener_m4_tube_countersinks(od = 3.0){
	assign(radius = ((od/2)-0.09375)){
		_fastener_m4__tube_countersinks_F(radius,45);
		_fastener_m4__tube_countersinks_R(radius,135);
		_fastener_m4__tube_countersinks_F(radius,225);
		_fastener_m4__tube_countersinks_R(radius,315);
	}
}
module _fastener_m4__tube_countersinks_F(radius, rot){
	translate([(radius*sin(rot)),(radius*cos(rot)),0]){
		rotate([0,90,rot]){
			m4_countersink();
		}
	}
}
module _fastener_m4__tube_countersinks_R(radius, rot){
	translate([(radius*sin(rot)),(radius*cos(rot)),0]){
		rotate([0,-90,rot]){
			m4_countersink();
		}
	}
}
