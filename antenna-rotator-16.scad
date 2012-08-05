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
resolution = 10;


/*
 * Bearing for vertical rotator and mating to horizontal rotator
 */


module toroid_constructor(wall = 0.0){
    translate([0,0,160]){
        hull(){
            rotate([90,0,0]){
                rotate_extrude($fn = resolution){
                    translate([160, 0, 0]){
                        circle(r = (80+wall), $fn = resolution);
                    }
                }
               cylinder(r = 160, h = (80+wall), center = true, $fn = resolution);
            }
        }
    }
}
module toroid_escapes(){
    translate([0,0,160]){
        rotate([90,0,0]){
            for ( i = [30 : 60 : 360] ){
                translate([sin(i)*80, cos(i)*80, 0])
                cylinder(r = 30, h = 161, center = true, $fn = resolution);
            }
        }
    }
}
module toroid(){
    difference(){
        toroid_constructor(+2.5);
        toroid_constructor(-2.5);
        toroid_escapes();
    }
}
module column_constructor(wall = 0.0){

    translate([0,0,310]){
        sphere(r = (90+wall), $fn = resolution);
    }
    translate([0,0,120]){
        cylinder(r1 = (120+wall), r2 = (90+wall), h = 380, center = true, $fn = resolution);
    }
}
module column(){
    difference(){
        column_constructor(+2.5);
        column_constructor(-2.5);
    }
}

module vertical_bearing(){
    union(){
        toroid();
        column();
    }
}

//vertical_bearing();

toroid();
