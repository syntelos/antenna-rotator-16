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
 * M4 Hole represented as the thread depth OD
 */
module fastener_m4_tapped(depth = 0.5, expansion = 0){

	cylinder(r = 0.0787+expansion, depth, center = true, $fn = resolution);
}
/*
 * 4 x M4 Holes in motor mount
 * 
 * M4 ALLEN DIN 912 Head + Flat Washer (4 + 0.8 mm): depth = 0.189, expansion = 0.1771
 * 
 * M4 ALLEN DIN 912
 * Head Height 4 mm, 0.1575 in; Diameter 7 mm, 0.2756 in
 *
 * Flat Washer
 * Diameter 9mm, 0.3543 in; Height = 0.8 mm, 0.0315 in: depth = 0.25, expansion = 0.1771
 */
module fastener_m4_mount_tapped(depth = 0.5, offset = 0, expansion = 0){

	for (theta = [0 : 90: 300] ){
		/*
		 * translate to the mount plane and hole center
		 * for a representative space.
		 */
		translate([0.6693*sin(theta),0.6693*cos(theta),offset]){

			fastener_m4_tapped(depth,expansion);
		}
	}
}
/*
 * M4 Tap Hole ID 3.2 mm; 0.126 in; IR = 0.063 in
 */
module fastener_m4_tap(depth){

	cylinder(r = 0.063, h = depth, center = true, $fn = resolution);
	/*
	 * Cube test of minimal wall dimension
	 * 
	 * If this passes with no intersections, then the volume is safe.  
	 * A reasonable depth (min 8 mm) is always much greater than the 
	 * radius (nom 3.2 mm), providing some initial information about
	 * the interior wall dimensions.
	 * 
	 * The ideal version of this would be a torus centered on the 
	 * interior edge of the cylinder, with the plane of the extent of
	 * the depth of the torus, and the cylinder of the extent of the 
	 * radius of the torus.
	 * 
	cube(size = depth, center = true, $fn = 40);
	 */
}
/*
 * 4 x M4 Tap Holes with Depth on Round OD
 */
module fastener_m4_round_taps(od, depth){

	assign(radius = (od/2)-(depth/2)){

		for (rot = [45: 90: 360]){
	
			translate([(radius*sin(rot)),(radius*cos(rot)),0]){

				rotate([0,90,rot]){

					fastener_m4_tap(depth);
				}
			}
		}
	}
}

/*
 * M4 Counter Sunk Head
 * 
 * Centered in wall with indent.
 * 
 * Indent is not a mechanical figure, but is employed for
 * positive curve intersections in tube walls.  Mechanically
 * the top of the countersink triangle is on the lowest sides
 * (the saddle) of the intersection of the walled tube and
 * the "triangular" countersink cylinder.
 */
module fastener_m4_countersink(wall = 0.1875, indent = 0.1, debug = false){

	del = (wall-0.0976);
    ctr = (del/2);

	union(){
		translate([0,0,+((indent/2)+(0.0976/2)+ctr)]){

			cylinder( r = (0.3508/2), h = indent, center = true, $fn = resolution);
		}
		translate([0,0,ctr]){
			cylinder( r1 = (0.1575/2), r2 = (0.3508/2), h = 0.0976, center = true, $fn = resolution);
		}
		translate([0,0,(ctr-(0.0976/2)-(del/2))]){

			cylinder( r = (0.1575/2), h = (del+indent), center = true, $fn = resolution);
		}
	}
	if (debug){
		translate([-(wall),0,-(wall/2)]){

			cube( size = [(2*wall),(2*wall),wall], center = false);
		}
	}
}
/*
 * 4 x M4 Counter Sunk Heads on Tube OD
 */
module fastener_m4_tube_countersinks(od = 3.0, wall = 0.1875){

	assign(radius = ((od/2)-0.09375)){

		_fastener_m4_tube_countersinks_F_(wall,radius,45);
		_fastener_m4_tube_countersinks_R_(wall,radius,135);
		_fastener_m4_tube_countersinks_F_(wall,radius,225);
		_fastener_m4_tube_countersinks_R_(wall,radius,315);
	}
}
module _fastener_m4_tube_countersinks_F_(wall, radius, rot){
	translate([(radius*sin(rot)),(radius*cos(rot)),0]){
		rotate([0,90,rot]){
			fastener_m4_countersink(wall);
		}
	}
}
module _fastener_m4_tube_countersinks_R_(wall, radius, rot){
	translate([(radius*sin(rot)),(radius*cos(rot)),0]){
		rotate([0,-90,rot]){
			fastener_m4_countersink(wall);
		}
	}
}
