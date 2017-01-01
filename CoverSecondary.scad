/**********************************************************************************************************************
 **
 ** CoverSecondary.scad
 **
 ** This file renders a the top part of the cover for the secondary side.
 **
 **********************************************************************************************************************/

include <Dimensions.scad>
include <Common.scad>

// Convention: the "front" side is the one aligned to the Y axis (front if SECmary is left, secondary right).

module _cs_screw_hole(front = true) {
	translate([0, front ? -EPSILON : SEC_COVER_WIDTH + EPSILON, 0])
		rotate([front ? -90 : 90, 0, 0])
			cylinder(d = COVER_PS_SCREW_DIAMETER, h = WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
}

module _cs_vent_slots() {
	// The total width of n slots is n * SEC_COVER_VENT_WIDTH + (n+1) * SEC_COVER_VENT_SPACING.
	// The width available is the inner length between the support pillars
	_width_available = SEC_COVER_INNER_CLEARANCE - 2 * COVER_SUPPORT_PILLAR_SIZE;
	//     _width_available = n * SEC_COVER_VENT_WIDTH + (n+1) * SEC_COVER_VENT_SPACING
	// <=> _width_available = n * (SEC_COVER_VENT_WIDTH + SEC_COVER_VENT_SPACING) + SEC_COVER_VENT_SPACING
	// <=> _width_available - SEC_COVER_VENT_SPACING = n * (SEC_COVER_VENT_WIDTH + SEC_COVER_VENT_SPACING)
	// <=> n = (_width_available - SEC_COVER_VENT_SPACING) / (SEC_COVER_VENT_WIDTH + SEC_COVER_VENT_SPACING)
	// This will never be a natural number, so round off:
	_num_slots = floor((_width_available - SEC_COVER_VENT_SPACING) / (SEC_COVER_VENT_WIDTH + SEC_COVER_VENT_SPACING));

	// the top and bottom center positions	
	_slot_lower_z = WALL_THICKNESS + SEC_COVER_VENT_Y_CLEARANCE;
	_slot_upper_z = _slot_lower_z + SEC_COVER_VENT_HEIGHT;

	// render the slots
	for(_slot = [0 : _num_slots - 1]) {
		_slot_center_x = SEC_COVER_CASE_LENGTH + COVER_SUPPORT_PILLAR_SIZE + SEC_COVER_VENT_SPACING + _slot * (SEC_COVER_VENT_WIDTH + SEC_COVER_VENT_SPACING) + SEC_COVER_VENT_WIDTH;
		hull() {
			translate([_slot_center_x, -EPSILON, _slot_lower_z])
				rotate([-90, 0, 0])
					cylinder(d = SEC_COVER_VENT_WIDTH, h = WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
			translate([_slot_center_x, -EPSILON, _slot_upper_z])
				rotate([-90, 0, 0])
					cylinder(d = SEC_COVER_VENT_WIDTH, h = WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
		}
	}
}

module _cs_shunt_block() {
	difference() {
		// the block
		cube([SEC_COVER_SHUNT_BLOCK_LENGTH, SEC_COVER_SHUNT_BLOCK_WIDTH, SEC_COVER_SHUNT_BLOCK_HEIGHT]);
		// minus the screw hole
		translate([-EPSILON, 
			       SEC_COVER_SHUNT_BLOCK_WIDTH/2,
			       (SEC_COVER_SHUNT_BLOCK_HEIGHT - SEC_COVER_SHUNT_CLEARANCE_TOP) / 2])
			rotate([0, 90, 0])
				cylinder(h = SEC_COVER_SHUNT_BLOCK_LENGTH + 2 * EPSILON, 
					     d = SEC_COVER_SHUNT_BLOCK_HOLE_DIAMETER, 
					     $fn = HOLE_RESOLUTION);
	}
}

module CoverSecondary() {
	color("RoyalBlue")
		union() {
			// create the basic shape using a difference of two cubes
			difference() {
				cube([SEC_COVER_LENGTH, SEC_COVER_WIDTH, SEC_COVER_HEIGHT]);
				translate([-EPSILON, WALL_THICKNESS, -EPSILON])
					cube([SEC_COVER_LENGTH - WALL_THICKNESS + EPSILON,
						  PS_WIDTH + COVER_INNER_WIDTH_CORRECTION,
						  PS_HEIGHT + WALL_THICKNESS + EPSILON]);

				// minus the screw holes
				translate([SEC_COVER_CASE_LENGTH - PS_SEC_SCREW_OFFSET, 0, WALL_THICKNESS + PS_LOWER_SCREW_HEIGHT]) {
					_cs_screw_hole(front = false);
					_cs_screw_hole(front = true);
				}
				translate([SEC_COVER_CASE_LENGTH - PS_SEC_SCREW_OFFSET, 0, WALL_THICKNESS + PS_UPPER_SCREW_HEIGHT]) {
					_cs_screw_hole(front = false);
					_cs_screw_hole(front = true);
				}

				// minus the cutout for the display
				translate([SEC_COVER_LENGTH - WALL_THICKNESS - EPSILON, SEC_DISPLAY_Y, SEC_DISPLAY_Z])
					cube([WALL_THICKNESS + 2 * EPSILON, SEC_DISPLAY_WIDTH, SEC_DISPLAY_HEIGHT]);

				// minus the cutout for the cable gland
				translate([SEC_COVER_LENGTH - WALL_THICKNESS - EPSILON, SEC_GLAND_Y, SEC_GLAND_Z])
					rotate([0, 90, 0])
						cylinder(h = WALL_THICKNESS + 2 * EPSILON, 
							     d = SEC_GLAND_HOLE_DIAMETER, 
						    	 $fn = HOLE_RESOLUTION);

				// minus the vent slots
				translate([0, 0, 0])
					_cs_vent_slots();
				translate([0, SEC_COVER_WIDTH - WALL_THICKNESS, 0])
					_cs_vent_slots();

			}

			// the mounting blocks for the shunt
			translate([SEC_COVER_CASE_LENGTH + SEC_COVER_SHUNT_CLEARANCE_PS, 0, PS_HEIGHT + WALL_THICKNESS - SEC_COVER_SHUNT_BLOCK_HEIGHT]) {
				translate([0, SEC_COVER_SHUNT_BLOCK_Y_OFFSET, 0]) 
					_cs_shunt_block();
				translate([0, SEC_COVER_WIDTH - (SEC_COVER_SHUNT_BLOCK_Y_OFFSET + SEC_COVER_SHUNT_BLOCK_WIDTH), 0])
					_cs_shunt_block();
			}

			// add the outer support pillars 
			translate([SEC_COVER_LENGTH - WALL_THICKNESS - COVER_SUPPORT_PILLAR_SIZE, 
				       WALL_THICKNESS, 
				       0])
				SupportPillar();
			translate([SEC_COVER_LENGTH - WALL_THICKNESS - COVER_SUPPORT_PILLAR_SIZE, 
				       SEC_COVER_WIDTH - WALL_THICKNESS - COVER_SUPPORT_PILLAR_SIZE, 
				       0])
				SupportPillar(); 

			// add the inner support pillars 
			translate([SEC_COVER_CASE_LENGTH + COVER_INNER_SUPPORT_PILLAR_DISTANCE_PS, 
				       WALL_THICKNESS, 
				       0])
				SupportPillar();
			translate([SEC_COVER_CASE_LENGTH + COVER_INNER_SUPPORT_PILLAR_DISTANCE_PS, 
				       SEC_COVER_WIDTH - WALL_THICKNESS - COVER_SUPPORT_PILLAR_SIZE, 
				       0])
				SupportPillar(); 

		}

}

CoverSecondary();
