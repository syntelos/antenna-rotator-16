resolution = 20;

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
		 */
		translate([0,-175,160]){
			rotate([90,0,0]){
				for ( i = [30 : 60 : 360] ){
				    translate([sin(i)*27.5, cos(i)*27.5, 0])
				    cylinder(r = 1.35, h = 11, center = true, $fn = resolution);
				}
			}
		}
	}
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
					cylinder(r = 142, h = 20, center = true, $fn = resolution);
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
		/*
		 * Cutout vertical rotator, 
		 * leaving a 10mm motor mount wall 
		 * in the vertical bearing hull
		 */
		translate([0,50,160]){
			rotate([90,0,0]){
				cylinder(r = 140, h = 240, center = true, $fn = resolution);
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
				cylinder(r = 220, h = 60, center = true, $fn = resolution);
				/*
				 * Ball bearing races (2): 15mm ball space height
				 */
				cylinder(r = 190, h = 120, center = true, $fn = resolution);
			}
		}
		/*
		 * Cutout 8mm escape tunnel into the roller bearing thrust surface
		 */
		translate([0,0,0]){
			cylinder(r = 4, h = 200, center = true, $fn = resolution);
		}
		/*
		 * Cutout 8mm escape tunnel into the ball bearing cage rail
		 */
		translate([0,-45,0]){
			cylinder(r = 4, h = 200, center = true, $fn = resolution);
		}
		/*
		 * Cutout vertical ball bearing cage rail: 2mm width, 3mm depth
		 */
		translate([0,-45,160]){
			rotate([90,0,0]){
				cylinder(r = 196, h = 2, center = true, $fn = resolution);
			}
		}
		/*
		 * Cutout 8mm escape tunnel into the ball bearing cage rail
		 */
		translate([0,+45,0]){
			cylinder(r = 4, h = 200, center = true, $fn = resolution);
		}
		/*
		 * Cutout vertical ball bearing cage rail: 2mm width, 3mm depth
		 */
		translate([0,+45,160]){
			rotate([90,0,0]){
				cylinder(r = 196, h = 2, center = true, $fn = resolution);
			}
		}
		/*
		 * Cutout roller bearing cage rail: 2mm width, 3mm depth
		 */
		translate([0,0,160]){
			rotate([90,0,0]){
				rotate_extrude($fn = resolution){
					translate([205, 0, 0]){
						polygon(points = [[-1,-33],[-1,33],[1,33],[-1,33]]);
					}
				}
			}
		}
		motor_mount_subtract();
	}
}

vertical_bearing();
