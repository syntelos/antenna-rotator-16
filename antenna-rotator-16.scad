resolution = 20;

module vertical_bearing(){
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
		/*
		 * Cutout motor mount interior wall
		 */
		translate([0,-95,160]){
			rotate([90,0,0]){
				/*
				 * 60mm motor space diameter
				 */
				cylinder(r = 30, h = 30, center = true, $fn = resolution);
			}
		}
		/*
		 * Cutout motor mount clearance
		 */
		translate([0,-75,160]){
			rotate([90,0,0]){
				/*
				 * 24mm entry way
				 */
				cylinder(r = 12, h = 10, center = true, $fn = resolution);
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
	}
}

vertical_bearing();
