/**********************************************************************************************************************
 **
 ** Common.scad
 **
 ** This file contains common modules.
 **
 **********************************************************************************************************************/

include <Dimensions.scad>

/**
 * The size and positions of the feet on the underside of the lids.
 */
module Foot() {
	rotate([0, 180, 0])
		difference() {
			cylinder(d = FOOT_OUTER_DIAMETER, h = FOOT_HEIGHT, $fn = HOLE_RESOLUTION);
			translate([0, 0, FOOT_HEIGHT - FOOT_RECESS_DEPTH])
				cylinder(d = FOOT_INNER_DIAMETER, h = FOOT_RECESS_DEPTH + EPSILON, $fn = HOLE_RESOLUTION);
		}
}

module SupportPillar() {
	difference() {
		// the pillar
		translate([0, 0, WALL_THICKNESS])
			cube([COVER_SUPPORT_PILLAR_SIZE, COVER_SUPPORT_PILLAR_SIZE, PS_HEIGHT]);
		// minus the hole for the screws
		translate([COVER_SUPPORT_PILLAR_SIZE / 2, COVER_SUPPORT_PILLAR_SIZE / 2, WALL_THICKNESS - EPSILON])
			cylinder(d = COVER_SUPPORT_PILLAR_HOLE_DIAMETER, h = COVER_SUPPORT_PILLAR_HOLE_DEPTH + EPSILON, $fn = HOLE_RESOLUTION);
	}
}