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
use <CoverSecondary.scad>
use <LidSecondary.scad>

Case926A();
translate(PRI_COVER_OFFSET) 
	CoverPrimary();
translate(PRI_LID_OFFSET)
	LidPrimary();
translate(SEC_COVER_OFFSET) 
	CoverSecondary();
translate(SEC_LID_OFFSET)
	LidSecondary();

