/**********************************************************************************************************************
 **
 ** CoverPrimary.scad
 **
 ** This file renders a the top part of the cover for the primary side.
 **
 **********************************************************************************************************************/

include <Dimensions.scad>
include <Common.scad>

// Convention: the "front" side is the one aligned to the Y axis (front if primary is left, secondary right).

module _cp_screw_hole(front = true) {
	translate([0, front ? -EPSILON : PRI_COVER_WIDTH + EPSILON, 0])
		rotate([front ? -90 : 90, 0, 0])
			cylinder(d = COVER_PS_SCREW_DIAMETER, h = WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
}

module _cp_power_connector_cutouts() {
	// the main cutout
	translate([-EPSILON, -PRI_COVER_PC_WIDTH / 2, 0])
		cube([WALL_THICKNESS + 2 * EPSILON, PRI_COVER_PC_WIDTH, PRI_COVER_PC_HEIGHT]);
	// the screw holes
	translate([-EPSILON, -PRI_COVER_PC_SCREW_HOLE_DISTANCE / 2, PRI_COVER_PC_HEIGHT / 2])
		rotate([0, 90, 0])
			cylinder(d = PRI_COVER_PC_SCREW_HOLE_DIAMETER, h = PRI_COVER_PC_SUPPORT_LENGTH + WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
	translate([-EPSILON, PRI_COVER_PC_SCREW_HOLE_DISTANCE / 2, PRI_COVER_PC_HEIGHT / 2])
		rotate([0, 90, 0])
			cylinder(d = PRI_COVER_PC_SCREW_HOLE_DIAMETER, h = PRI_COVER_PC_SUPPORT_LENGTH + WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
}		

module _cp_vent_slots() {
	// The total width of n slots is n * PRI_COVER_VENT_WIDTH + (n+1) * PRI_COVER_VENT_SPACING.
	// The width available is whatever we're left with after the mains compartment was separated.
	_width_available = PS_WIDTH - PRI_COVER_MAINS_COMP_WIDTH - COVER_SUPPORT_PILLAR_SIZE;
	//     _width_available = n * PRI_COVER_VENT_WIDTH + (n+1) * PRI_COVER_VENT_SPACING
	// <=> _width_available = n * (PRI_COVER_VENT_WIDTH + PRI_COVER_VENT_SPACING) + PRI_COVER_VENT_SPACING
	// <=> _width_available - PRI_COVER_VENT_SPACING = n * (PRI_COVER_VENT_WIDTH + PRI_COVER_VENT_SPACING)
	// <=> n = (_width_available - PRI_COVER_VENT_SPACING) / (PRI_COVER_VENT_WIDTH + PRI_COVER_VENT_SPACING)
	// This will never be a natural number, so round off:
	_num_slots = floor((_width_available - PRI_COVER_VENT_SPACING) / (PRI_COVER_VENT_WIDTH + PRI_COVER_VENT_SPACING));

	// the top and bottom center positions	
	_slot_lower_z = PRI_COVER_VENT_WIDTH / 2;
	_slot_upper_z = PRI_COVER_VENT_HEIGHT - PRI_COVER_VENT_WIDTH / 2;

	// render the slots
	for(_slot = [0 : _num_slots - 1]) {
		_slot_center_y = PRI_COVER_VENT_SPACING + _slot * (PRI_COVER_VENT_WIDTH + PRI_COVER_VENT_SPACING) + PRI_COVER_VENT_WIDTH / 2;
		hull() {
			translate([-EPSILON, _slot_center_y, _slot_lower_z])
				rotate([0, 90, 0])
					cylinder(d = PRI_COVER_VENT_WIDTH, h = WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
			translate([-EPSILON, _slot_center_y, _slot_upper_z])
				rotate([0, 90, 0])
					cylinder(d = PRI_COVER_VENT_WIDTH, h = WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
		}
	}
}

module _cp_pc_support() {
	translate([0, PRI_COVER_PC_SUPPORT_WIDTH/2, -PRI_COVER_PC_SUPPORT_HEIGHT/2]) {
		rotate([90, 0, 0])
			linear_extrude(height = PRI_COVER_PC_SUPPORT_WIDTH)
				polygon(points = [[0, 0],
					              [0, PRI_COVER_PC_SUPPORT_HEIGHT],
				    	          [PRI_COVER_PC_SUPPORT_LENGTH, PRI_COVER_PC_SUPPORT_HEIGHT/3*2],
				        	      [PRI_COVER_PC_SUPPORT_LENGTH, PRI_COVER_PC_SUPPORT_HEIGHT/3]]);
	}
}

module CoverPrimary() {
	color("RoyalBlue")
		union() {
	
			difference() {
				union() {
					// create the basic shape using a difference of two cubes
					difference() {
						cube([PRI_COVER_LENGTH, PRI_COVER_WIDTH, PRI_COVER_HEIGHT]);
						translate([WALL_THICKNESS, WALL_THICKNESS, -EPSILON])
							cube([PRI_COVER_LENGTH - WALL_THICKNESS + EPSILON,
								  PS_WIDTH + COVER_INNER_WIDTH_CORRECTION,
								  PS_HEIGHT + WALL_THICKNESS + EPSILON]);
					}

					// add the supports for the power connector screws
					translate([WALL_THICKNESS, 
						       WALL_THICKNESS + COVER_SUPPORT_PILLAR_SIZE + (PRI_COVER_MAINS_COMP_WIDTH - COVER_SUPPORT_PILLAR_SIZE) / 2 - PRI_COVER_PC_SCREW_HOLE_DISTANCE / 2, 
						       PRI_COVER_HEIGHT / 2])
						_cp_pc_support();
					translate([WALL_THICKNESS, 
						       WALL_THICKNESS + COVER_SUPPORT_PILLAR_SIZE + (PRI_COVER_MAINS_COMP_WIDTH - COVER_SUPPORT_PILLAR_SIZE) / 2 + PRI_COVER_PC_SCREW_HOLE_DISTANCE / 2, 
						       PRI_COVER_HEIGHT / 2])
						_cp_pc_support();
				}

				// minus the screw holes
				translate([PRI_COVER_INNER_CLEARANCE + WALL_THICKNESS + PS_PRI_SCREW_OFFSET, 0, WALL_THICKNESS + PS_LOWER_SCREW_HEIGHT]) {
					_cp_screw_hole(front = false);
					_cp_screw_hole(front = true);
				}
				translate([PRI_COVER_INNER_CLEARANCE + WALL_THICKNESS + PS_PRI_SCREW_OFFSET, 0, WALL_THICKNESS + PS_UPPER_SCREW_HEIGHT]) {
					_cp_screw_hole(front = false);
					_cp_screw_hole(front = true);
				}

				// minus the power connector cutout and screw holes 
				translate([0, 
					       WALL_THICKNESS + COVER_SUPPORT_PILLAR_SIZE + (PRI_COVER_MAINS_COMP_WIDTH - COVER_SUPPORT_PILLAR_SIZE) / 2, 
					       (PRI_COVER_HEIGHT - PRI_COVER_PC_HEIGHT) / 2])
					_cp_power_connector_cutouts();

				// minus the vent slots
				translate([0, 
					 	   WALL_THICKNESS + PRI_COVER_MAINS_COMP_WIDTH + PRI_COVER_MAINS_COMP_WALL_THICKNESS, 
					       (PRI_COVER_HEIGHT - PRI_COVER_VENT_HEIGHT) / 2])
					_cp_vent_slots();

			}

			// add the outer support pillars 
			translate([WALL_THICKNESS, WALL_THICKNESS, 0])
				SupportPillar();
			translate([WALL_THICKNESS, PRI_COVER_WIDTH - WALL_THICKNESS - COVER_SUPPORT_PILLAR_SIZE, 0])
				SupportPillar(); 

			// add the center support pillar and the compartment separation wall
			translate([WALL_THICKNESS + PRI_COVER_INNER_CLEARANCE - COVER_SUPPORT_PILLAR_SIZE - COVER_INNER_SUPPORT_PILLAR_DISTANCE_PS,
				       WALL_THICKNESS + PRI_COVER_MAINS_COMP_WIDTH - COVER_SUPPORT_PILLAR_SIZE + PRI_COVER_MAINS_COMP_WALL_THICKNESS, 0])
				SupportPillar(); 
			translate([WALL_THICKNESS, WALL_THICKNESS + PRI_COVER_MAINS_COMP_WIDTH, WALL_THICKNESS])
				cube([PRI_COVER_INNER_CLEARANCE - COVER_SUPPORT_PILLAR_SIZE, PRI_COVER_MAINS_COMP_WALL_THICKNESS, PS_HEIGHT]);
		}

}

CoverPrimary();
