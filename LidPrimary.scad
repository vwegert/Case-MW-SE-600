/**********************************************************************************************************************
 **
 ** LidPrimary.scad
 **
 ** This file renders a the bottom lid that covers the primary side.
 **
 **********************************************************************************************************************/

include <Dimensions.scad>
include <Common.scad>

module _lp_screw_hole() {
	translate([0, 0, -EPSILON])
			cylinder(d = LID_PILLAR_SCREW_DIAMETER, h = WALL_THICKNESS + 2 * EPSILON, $fn = HOLE_RESOLUTION);
}


module LidPrimary() {
	color("DodgerBlue")
		union() {
			difference() {
				// the base plate
				cube([PRI_LID_LENGTH, PRI_LID_WIDTH, WALL_THICKNESS]);

				// minus the screw holes in the corners
				translate([COVER_SUPPORT_PILLAR_SIZE / 2, COVER_SUPPORT_PILLAR_SIZE / 2 - COVER_INNER_WIDTH_CORRECTION/2, 0])
					_lp_screw_hole();
				translate([COVER_SUPPORT_PILLAR_SIZE / 2, PS_WIDTH - COVER_SUPPORT_PILLAR_SIZE / 2 + COVER_INNER_WIDTH_CORRECTION/2, 0])
					_lp_screw_hole();

				// minus the center screw hole
				translate([PRI_COVER_INNER_CLEARANCE - COVER_SUPPORT_PILLAR_SIZE / 2 - PRI_COVER_CENTER_SUPPORT_DISTANCE_PS,
					       PRI_COVER_MAINS_COMP_WIDTH - COVER_SUPPORT_PILLAR_SIZE / 2 - COVER_INNER_WIDTH_CORRECTION + PRI_COVER_MAINS_COMP_WALL_THICKNESS, 
					       0])
					_lp_screw_hole();
			}

			// the feet below the lid
			translate([FOOT_EDGE_DISTANCE_X, FOOT_EDGE_DISTANCE_Y, 0])
				Foot();
			translate([PRI_LID_LENGTH - FOOT_EDGE_DISTANCE_X, FOOT_EDGE_DISTANCE_Y, 0])
				Foot();
			translate([FOOT_EDGE_DISTANCE_X, PRI_LID_WIDTH - FOOT_EDGE_DISTANCE_Y, 0])
				Foot();
			translate([PRI_LID_LENGTH - FOOT_EDGE_DISTANCE_X, PRI_LID_WIDTH - FOOT_EDGE_DISTANCE_Y, 0])
				Foot();

		}
}

LidPrimary();
