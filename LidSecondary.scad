/**********************************************************************************************************************
 **
 ** LidSecondary.scad
 **
 ** This file renders a the bottom lid that covers the secondary side.
 **
 **********************************************************************************************************************/

include <Dimensions.scad>
include <Common.scad>

module _ls_screw_hole() {
	translate([0, 0, -EPSILON])
		cylinder(d = LID_PILLAR_SCREW_DIAMETER, h = WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
}

module LidSecondary() {
	color("DodgerBlue")
		union() {
			difference() {
				// the base plate
				cube([SEC_LID_LENGTH, SEC_LID_WIDTH, WALL_THICKNESS]);

				// minus the screw for the outer support pillars
				translate([SEC_COVER_LENGTH - WALL_THICKNESS - COVER_SUPPORT_PILLAR_SIZE / 2, 
					       COVER_SUPPORT_PILLAR_SIZE / 2 - COVER_INNER_WIDTH_CORRECTION/2, 
					       0])
					_ls_screw_hole();
				translate([SEC_COVER_LENGTH - WALL_THICKNESS - COVER_SUPPORT_PILLAR_SIZE / 2, 
					       PS_WIDTH - COVER_SUPPORT_PILLAR_SIZE / 2 + COVER_INNER_WIDTH_CORRECTION/2, 
					       0])
					_ls_screw_hole();

				// minus the screw for the inner support pillars
				translate([SEC_COVER_CASE_LENGTH + COVER_INNER_SUPPORT_PILLAR_DISTANCE_PS + COVER_SUPPORT_PILLAR_SIZE / 2, 
					       COVER_SUPPORT_PILLAR_SIZE / 2 - COVER_INNER_WIDTH_CORRECTION/2, 
					       0])
					_ls_screw_hole();
				translate([SEC_COVER_CASE_LENGTH + COVER_INNER_SUPPORT_PILLAR_DISTANCE_PS + COVER_SUPPORT_PILLAR_SIZE / 2, 
					       PS_WIDTH - COVER_SUPPORT_PILLAR_SIZE / 2 + COVER_INNER_WIDTH_CORRECTION/2, 
					       0])
					_ls_screw_hole();

			}

			// the feet below the lid
			translate([FOOT_EDGE_DISTANCE_X, FOOT_EDGE_DISTANCE_Y, 0])
				Foot();
			translate([SEC_LID_LENGTH - FOOT_EDGE_DISTANCE_X, FOOT_EDGE_DISTANCE_Y, 0])
				Foot();
			translate([FOOT_EDGE_DISTANCE_X, SEC_LID_WIDTH - FOOT_EDGE_DISTANCE_Y, 0])
				Foot();
			translate([SEC_LID_LENGTH - FOOT_EDGE_DISTANCE_X, SEC_LID_WIDTH - FOOT_EDGE_DISTANCE_Y, 0])
				Foot();

		}
}

LidSecondary();
