/**********************************************************************************************************************
 **
 ** Case926A.scad
 **
 ** This file renders a power supply case designated as "Case No. 926A" in the MeanWell data sheets.
 **
 **********************************************************************************************************************/

include <Dimensions.scad>

// Convention: the "front" side is the one aligned to the Y axis (front if primary is left, secondary right).

module _ps_screw_hole(front = true) {
	translate([0, front ? -EPSILON : PS_WIDTH + EPSILON, 0])
		rotate([front ? -90 : 90, 0, 0])
			cylinder(d = PS_SCREW_DIAMETER, h = PS_SCREW_DEPTH + EPSILON, $fn = HOLE_RESOLUTION);
}

module Case926A() {
	union() {
	
		color("LightGray")
			difference() {
				// the basic shape of the case
				cube([PS_LENGTH, PS_WIDTH, PS_HEIGHT]);
		
				// minus the screw holes
				translate([PS_PRI_SCREW_OFFSET, 0, PS_LOWER_SCREW_HEIGHT]) {
					_ps_screw_hole(front = false);
					_ps_screw_hole(front = true);
				}
				translate([PS_PRI_SCREW_OFFSET, 0, PS_UPPER_SCREW_HEIGHT]) {
					_ps_screw_hole(front = false);
					_ps_screw_hole(front = true);
				}
				translate([PS_LENGTH - PS_SEC_SCREW_OFFSET, 0, PS_LOWER_SCREW_HEIGHT]) {
					_ps_screw_hole(front = false);
					_ps_screw_hole(front = true);
				}
				translate([PS_LENGTH - PS_SEC_SCREW_OFFSET, 0, PS_UPPER_SCREW_HEIGHT]) {
					_ps_screw_hole(front = false);
					_ps_screw_hole(front = true);
				}
			}
		
		color("Black") {
			// plus the primary terminal block placeholder
			translate([-PS_PRI_TERM_LENGTH, PS_PRI_TERM_OFFSET_Y, PS_PRI_TERM_OFFSET_Z])
				cube([PS_PRI_TERM_LENGTH, PS_PRI_TERM_WIDTH, PS_PRI_TERM_HEIGHT]);
		
			// plus the secondary terminal block placeholder
			translate([PS_LENGTH, PS_SEC_TERM_OFFSET_Y, PS_SEC_TERM_OFFSET_Z])
				cube([PS_SEC_TERM_LENGTH, PS_SEC_TERM_WIDTH, PS_SEC_TERM_HEIGHT]);
		}
	}
}

Case926A();