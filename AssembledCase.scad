/**********************************************************************************************************************
 **
 ** AssembledCase.scad
 **
 ** This file renders the power supply with all case parts attached.
 **
 **********************************************************************************************************************/

include <Dimensions.scad>

use <Case926A.scad>
use <CoverPrimary.scad>
use <LidPrimary.scad>

Case926A();
translate(PRI_COVER_OFFSET) 
	CoverPrimary();
translate(PRI_LID_OFFSET)
	LidPrimary();

