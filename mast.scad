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
