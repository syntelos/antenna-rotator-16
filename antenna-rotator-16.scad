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
resolution = 100;

/*
 * Cantilever housing and antenna support, basic outline
 */
module vertical_rotator_geometry(c = 0.0){
	union(){
		/*
		 * Vertical rotator with 10mm motor mount wall 
		 */
		translate([0,15,160]){
			rotate([90,0,0]){
				cylinder(r = 140+c, h = 170+c, center = true, $fn = resolution);
			}
		}
		/*
		 * Weather shoulder, 2mm high
		 */
		translate([0,100,160]){
			rotate([90,0,0]){
				cylinder(r = 138+c, h = 80+c, center = true, $fn = resolution);
			}
		}
		translate([0,110,160]){
			rotate([90,0,0]){
				cylinder(r = 140+c, h = 10+c, center = true, $fn = resolution);
			}
		}
		/*
		 * Cutout vertical bearing races
		 */
		translate([0,0,160]){
			rotate([90,0,0]){
				/*
				 * Roller bearing race way: 30mm roller space height
				 */
				cylinder(r = 220+c, h = 60+c, center = true, $fn = resolution);
				/*
				 * Ball bearing races (2): 15mm ball space height
				 */
				cylinder(r = 190+c, h = 120+c, center = true, $fn = resolution);
			}
		}
	}
}
/*
 * Cantilever housing and antenna support, positive
 */
module vertical_rotator(){
	/*
	 * 
	 */
	module vertical_rotator_subtract1(){
	
		translate([0,0,160]){
			rotate([90,0,0]){
				/*
				 * Primary internal body cavity
				 */
				cylinder(r = 150, h = 40, center = true, $fn = resolution);
	
				cylinder(r = 100, h = 80, center = true, $fn = resolution);
			}
		}
	}
	/*
	 * 
	 */
	module vertical_rotator_subtract2(){
	
		translate([0,0,160]){
			rotate([90,0,0]){
				/*
				 * Reinforced cavities
				 */
				for ( i = [30 : 60 : 360] ){
				    translate([sin(i)*80, cos(i)*80, 0])
				    cylinder(r = 30, h = 400, center = true, $fn = resolution);
				}
				/*
				 * Preliminary speculative motor shaft attachment
				 * 
				 * The requirement is for a through- hole into the 
				 * center of this body
				 * 
				 * Shaft diameter 12mm, radius 6mm, cut to square of size 8.4mm
				 */
				cube(size = [8.4,8.4,400], center = true);
			}
		}
		translate([0,-20,160]){
			/*
			 * Escape from body center into motor shaft
			 */
			cylinder(r = 4, h = 100, center = true, $fn = resolution);
		}
		translate([0,+40,160]){
			/*
			 * Escape from body center into motor shaft
			 */
			cylinder(r = 4, h = 100, center = true, $fn = resolution);
		}
	}
	/*
	 * 
	 */
	module vertical_rotator_add(){
	
		translate([0,0,160]){
			rotate([90,0,0]){
				/*
				 * Reinforce horizontal cutouts
				 */
				for ( i = [30 : 60 : 360] ){
				    translate([sin(i)*80, cos(i)*80, 0])
				    cylinder(r = 40, h = 130, center = true, $fn = resolution);
				}
				/*
				 * Reinforce motor shaft centerline
				 */
				cylinder(r = 40, h = 130, center = true, $fn = resolution);
			}
		}
	}
	/*
	 * 
	 */
	difference(){	
		union(){
			difference(){
				vertical_rotator_geometry(-0.5);
				vertical_rotator_subtract1();
			}		
			vertical_rotator_add();
		}
		vertical_rotator_subtract2();
	}
}
/*
 * Bearing for vertical rotator and mating to horizontal rotator
 */
module vertical_bearing(){
	/*
	 * 
	 */
	module motor_mount_add(){
		/*
		 * Motor enclosure wall, 2mm
		 */	
		translate([0,-130,160]){
			rotate([90,0,0]){
				cylinder(r = 32, h = 100, center = true, $fn = resolution);
			}
		}
		translate([0,-130,130]){
			rotate([90,0,0]){
				cube(size = [26,14,100], center = true, $fn = resolution);
			}
		}
		/*
		 * Motor cable guide, +82.5mm from mounting plane, 6.6mm ID, 8.6mm OD
		 * Mounting plane (80mm) + Offset Delta (82.5) = 162.5
		 */
		translate([0,-162.5,113]){

			cylinder(r = 4.3, h = 20, center = true, $fn = resolution);
		}
		translate([0,-162.5,122]){

			cylinder(r = 10, h = 2, center = true, $fn = resolution); //fillet
		}
		/*
		 * Motor cover (independent)
		 */
		translate([0,-200,160]){
			rotate([90,0,0]){
				cylinder(r = 30, h = 2, center = true, $fn = resolution);
			}
		}
	}
	/*
	 * 
	 */
	module motor_mount_subtract(){
		/*
		 * Cutout motor mount interior walls, 2mm
		 */
		translate([0,-125,160]){
			rotate([90,0,0]){
				/*
				 * 60mm motor space diameter with 5mm end plate shoulder
				 */
				cylinder(r = 30, h = 90, center = true, $fn = resolution);
			}
		}
		translate([0,-131,160]){
			rotate([90,0,0]){
				/*
				 * remove interior of end plate shoulder
				 */
				cylinder(r = 25, h = 100.5, center = true, $fn = resolution);
			}
		}
		translate([0,-179,160]){
			rotate([90,0,0]){
				/*
				 * remove exterior of end plate shoulder
				 */
				cylinder(r = 30, h = 2.1, center = true, $fn = resolution);
			}
		}
		translate([0,-135,135]){
			rotate([90,0,0]){
				cube(size = [22,20,80], center = true, $fn = resolution);
			}
		}
		translate([0,-162.5,123]){

			cylinder(r = 3.3, h = 44, center = true, $fn = resolution);
			cylinder(r = 6, h = 1, center = true, $fn = resolution); // fillet
		}
		/*
		 * Cutout motor mount clearance
		 */
		translate([0,-75,160]){
			rotate([90,0,0]){
				/*
				 * 24mm entry way
				 */
				cylinder(r = 12, h = 20, center = true, $fn = resolution);
			}
		}
		/*
		 * Cutout motor mount M4 fastener tunnels
		 */
		translate([0,-75,143]){
			// bottom
			rotate([90,0,0]){
				cylinder(r = 2, h = 12, center = true, $fn = resolution);
			}
		}
		translate([0,-75,177]){
			// top
			rotate([90,0,0]){
				cylinder(r = 2, h = 12, center = true, $fn = resolution);
			}
		}
		translate([-17,-75,160]){
			// left
			rotate([90,0,0]){
				cylinder(r = 2, h = 12, center = true, $fn = resolution);
			}
		}
		translate([+17,-75,160]){
			// right
			rotate([90,0,0]){
				cylinder(r = 2, h = 12, center = true, $fn = resolution);
			}
		}
		/*
		 * M3 motor cover soft receivers 
		 * (screw into plastic with light torque)
		 * Shoulder depth 5mm
		 * Receiver ID 2.7mm
		 * (drill both cover and shoulder)
		 */
		translate([0,-190,160]){
			rotate([90,0,0]){
				for ( i = [30 : 60 : 360] ){
				    translate([sin(i)*27.5, cos(i)*27.5, 0])
				    cylinder(r = 1.35, h = 40, center = true, $fn = resolution);
				}
			}
		}
	}
	/*
	 * 
	 */
	module escapes_subtract(){
		/*
		 * roller bearing thrust surface
		 */
		translate([0,0,0]){
			cylinder(r = 4, h = 200, center = true, $fn = resolution);
		}
		/*
		 * ball bearing cage rail
		 */
		translate([0,-45,0]){
			cylinder(r = 4, h = 200, center = true, $fn = resolution);
		}
		/*
		 * ball bearing cage rail
		 */
		translate([0,+45,0]){
			cylinder(r = 4, h = 200, center = true, $fn = resolution);
		}
		/*
		 * rotator weather trim
		 */
		translate([0,80,0]){
			cylinder(r = 4, h = 200, center = true, $fn = resolution);
		}
	}
	/*
	 * 
	 */
	module bearing_cage_rails_subtract(c = +0.05){
		/*
		 * Vertical ball bearing cage rail: 2mm width, 3mm depth
		 */
		translate([0,-45,160]){
			rotate([90,0,0]){
				cylinder(r = 196+c, h = 2+c, center = true, $fn = resolution);
			}
		}
		/*
		 * Vertical ball bearing cage rail: 2mm width, 3mm depth
		 */
		translate([0,+45,160]){
			rotate([90,0,0]){
				cylinder(r = 196+c, h = 2+c, center = true, $fn = resolution);
			}
		}
		/*
		 * Roller bearing cage rail: 2mm width, 3mm depth
		 */
		translate([0,0,160]){
			rotate([90,0,0]){
				rotate_extrude($fn = resolution){
					translate([205, 0, 0]){
						polygon(points = [[-1+c,-33+c],[-1+c,33+c],[1+c,33+c],[-1+c,33+c]]);
					}
				}
			}
		}
	}
	/*
	 * 
	 */
	difference(){
		union(){
			/*
			 * Vertical bearing toroid
			 */
			translate([0,0,160]){
				hull(){
					rotate([90,0,0]){
						rotate_extrude($fn = resolution){
						    translate([160, 0, 0]){
							    circle(r = 80, $fn = resolution);
							}
						}
					   cylinder(r = 160, h = 80, center = true, $fn = resolution);
					}
				}
			}
			/*
			 * Vertical rotator weather strip, 1mm wall
			 */	
			translate([0,80,160]){
				rotate([90,0,0]){
					cylinder(r = 142, h = 68, center = true, $fn = resolution);
				}
			}
			/*
			 * Vertical support column and crown 
			 * for mating to horizontal rotator.
			 */
			translate([0,0,310]){
				sphere(r = 90, $fn = resolution);
			}
			translate([0,0,120]){
				cylinder(r1 = 120, r2 = 90, h = 380, center = true, $fn = resolution);
			}
			/*
			 * Horizontal rotator mating
			 */
			translate([0,0,-80]){
				cylinder(r = 120, h = 20, center = true, $fn = resolution);
			}
			motor_mount_add();
		}
		vertical_rotator_geometry(+0.5);
		bearing_cage_rails_subtract()
		escapes_subtract();
		motor_mount_subtract();
	}
}




vertical_rotator();

vertical_bearing();


