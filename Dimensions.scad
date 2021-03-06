/**********************************************************************************************************************
 **
 ** Dimensions.scad
 **
 ** This file provides the dimensions of the various parts. 
 ** All dimensions are given in mm.
 ** For overall consistency: length = X, width = Y, height = Z.
 ** The side of the power supply that is adjacent to the PCB is assumed to be the lower side.
 **
 **********************************************************************************************************************/

// ===== POWER SUPPLY =================================================================================================

/**
 * The outer dimensions of the power supply housing.
 */
PS_LENGTH = 247;
PS_WIDTH  = 127;
PS_HEIGHT =  63.5;

/**
 * The size and position of the terminals on the primary (mains) side.
 */
PS_PRI_TERM_LENGTH   = 14;
PS_PRI_TERM_WIDTH    = 35; // theoretically: 3 * 10 + (10 - 8.2) / 2
PS_PRI_TERM_HEIGHT   = 15; 
PS_PRI_TERM_OFFSET_Y = 11.5; 
PS_PRI_TERM_OFFSET_Z =  9.5; 

/**
 * The size and position of the terminals on the secondary (output) side.
 */
PS_SEC_TERM_LENGTH   = 17;
PS_SEC_TERM_WIDTH    = 82; // theoretically 6 * 13 + (13 - 10) / 2;
PS_SEC_TERM_HEIGHT   = 19;
PS_SEC_TERM_OFFSET_Y = 26; 
PS_SEC_TERM_OFFSET_Z =  9; 

/**
 * The size and position of the screw holes in the sides.
 */
PS_SCREW_DIAMETER     = 3;
PS_SCREW_DEPTH        = 4;
PS_LOWER_SCREW_HEIGHT = PS_HEIGHT - 30 - 20;
PS_UPPER_SCREW_HEIGHT = PS_HEIGHT - 30;
PS_PRI_SCREW_OFFSET   =  11;
PS_SCREW_DISTANCE_X   = 220;
PS_SEC_SCREW_OFFSET   = PS_LENGTH - PS_PRI_SCREW_OFFSET - PS_SCREW_DISTANCE_X;

// ===== COMMON SETTINGS ==============================================================================================

/**
 * The thickness of the walls of the covers.
 */
WALL_THICKNESS = 3;

/**
 * The additional clearance added to the inner width of the covers to account for printing inaccuracies.
 */
COVER_INNER_WIDTH_CORRECTION = 1.0;
LID_WIDTH_CORRECTION = 0.0;

/**
 * The size of the screw holes used to mount the covers to the power supply.
 */
COVER_PS_SCREW_DIAMETER = 3.4;

/** 
 * How much of the power supply casing should be covered by the casing on either side.
 */
PRI_COVER_CASE_LENGTH = 2 * PS_PRI_SCREW_OFFSET;
SEC_COVER_CASE_LENGTH = 2 * PS_SEC_SCREW_OFFSET;

/**
 * The size of the pillars that support the lid and the dimensions of the screw holes in the pillars
 */
COVER_SUPPORT_PILLAR_SIZE = 9;
COVER_SUPPORT_PILLAR_HOLE_DIAMETER = 3.3; // to cut a M4 thread
COVER_SUPPORT_PILLAR_HOLE_DEPTH = 50;

/**
 * The distance of the inner support pillars from the face of the power supply.
 */
COVER_INNER_SUPPORT_PILLAR_DISTANCE_PS = 2; 

/**
 * The size of the holes in the lid for the screws that fit into the support pillars.
 */
LID_PILLAR_SCREW_DIAMETER = 4;

/**
 * The size and positions of the feet on the underside of the lids.
 */
FOOT_OUTER_DIAMETER  = 12;
FOOT_INNER_DIAMETER  = 10;
FOOT_HEIGHT          =  4;
FOOT_RECESS_DEPTH    =  1;
FOOT_EDGE_DISTANCE_X = 12;
FOOT_EDGE_DISTANCE_Y = 15;

// ===== PRIMARY (MAINS) SIDE =========================================================================================

/**
 * How much clearance to leave on the inside of the primary cover.
 */
PRI_COVER_INNER_CLEARANCE = 65; // switch needs >= 37, add the terminal >= 14 and some room for cables

/**
 * The width of the compartment that holds the mains wiring and power connector / switch.
 */
PRI_COVER_MAINS_COMP_WIDTH = 60; 

/**
 * The thickness of the compartment separation wall.
 */
PRI_COVER_MAINS_COMP_WALL_THICKNESS = 2;

/**
 * The dimensions of the cutout and the screw holes for the power connector.
 */
PRI_COVER_PC_WIDTH  = 28;
PRI_COVER_PC_HEIGHT = 48;
PRI_COVER_PC_SCREW_HOLE_DIAMETER = 2.5;
PRI_COVER_PC_SCREW_HOLE_DISTANCE = 40;

/**
 * The dimensions of the support structures around the power connector mounting holes.
 */
PRI_COVER_PC_SUPPORT_LENGTH = 5;
PRI_COVER_PC_SUPPORT_WIDTH  = 5;
PRI_COVER_PC_SUPPORT_HEIGHT = 15;

/**
 * The outer dimensions of the primary cover.
 */
PRI_COVER_LENGTH = PRI_COVER_CASE_LENGTH + PRI_COVER_INNER_CLEARANCE + WALL_THICKNESS;
PRI_COVER_WIDTH  = PS_WIDTH + 2 * WALL_THICKNESS + COVER_INNER_WIDTH_CORRECTION;
PRI_COVER_HEIGHT = PS_HEIGHT + 2 * WALL_THICKNESS;

PRI_LID_LENGTH   = PRI_COVER_LENGTH - WALL_THICKNESS;
PRI_LID_WIDTH    = PS_WIDTH + LID_WIDTH_CORRECTION;

/**
 * The offset of the primary side cover and lid in relation to the case model.
 */
PRI_COVER_OFFSET = [-(PRI_COVER_INNER_CLEARANCE + WALL_THICKNESS), -WALL_THICKNESS - COVER_INNER_WIDTH_CORRECTION, -WALL_THICKNESS];
PRI_LID_OFFSET = [-PRI_COVER_INNER_CLEARANCE, 0, -WALL_THICKNESS];

// ===== SECONDARY (OUTPUT) SIDE ======================================================================================

/**
 * The width and height of the ventilation slots.
 */
PRI_COVER_VENT_WIDTH   = 2.5;
PRI_COVER_VENT_HEIGHT  = PS_HEIGHT * 2 / 3;
PRI_COVER_VENT_SPACING = 4;

/**
 * The offset of the primary side cover and lid in relation to the case model.
 */
PRI_COVER_OFFSET = [-(PRI_COVER_INNER_CLEARANCE + WALL_THICKNESS), -WALL_THICKNESS - COVER_INNER_WIDTH_CORRECTION/2, -WALL_THICKNESS];
PRI_LID_OFFSET = [-PRI_COVER_INNER_CLEARANCE, 0, -WALL_THICKNESS];

// ===== SECONDARY (OUTPUT) SIDE ======================================================================================

/** 
 * The dimensions of the shunt used to measure the output current.
 */
SEC_SHUNT_WIDTH         = 120;
SEC_SHUNT_LENGTH        =  25;
SEC_SHUNT_HEIGHT        =  20;
SEC_SHUNT_HOLE_DISTANCE = 101; 
SEC_SHUNT_HOLE_DIAMETER =   6;

/**
 * The clearance of the shunt (that is mounted in parallel to the back side of the power supply) on the sides.
 */
SEC_COVER_SHUNT_CLEARANCE_PS   = 40;
SEC_COVER_SHUNT_CLEARANCE_TOP  = 2;

/**
 * The dimensions of the blocks that the shunt is mounted on.
 */
SEC_COVER_SHUNT_BLOCK_LENGTH = 10;
SEC_COVER_SHUNT_BLOCK_WIDTH  = 30;
SEC_COVER_SHUNT_BLOCK_HEIGHT = SEC_SHUNT_LENGTH + SEC_COVER_SHUNT_CLEARANCE_TOP;
SEC_COVER_SHUNT_BLOCK_HOLE_DIAMETER = SEC_SHUNT_HOLE_DIAMETER;

/**
 * The dimensions of the voltage/current display unit.
 */
SEC_DISPLAY_LENGTH = 25;
SEC_DISPLAY_WIDTH  = 45;
SEC_DISPLAY_HEIGHT = 26;

/**
 * The dimensions to use for the PG16 cable gland.
 */
SEC_GLAND_HOLE_DIAMETER    = 22.25; // actually 22, but add some clearance
SEC_GLAND_INNER_NUT_LENGTH = 30;
SEC_GLAND_INNER_NUT_HEIGHT = 33;
SEC_GLAND_MOUNTING_DEPTH   = 10;
SEC_GLAND_OUTER_LENGTH     = 30; // approx

/**
 * Which side to mount the gland on.
 */
SEC_GLAND_LEFT = false;

/**
 * How much clearance to leave on the inside of the secondary cover.
 */
SEC_COVER_INNER_CLEARANCE = SEC_COVER_SHUNT_CLEARANCE_PS + 
                            SEC_COVER_SHUNT_BLOCK_LENGTH + 
                            max(SEC_GLAND_MOUNTING_DEPTH, SEC_DISPLAY_LENGTH);

/**
 * The outer dimensions of the secondary cover.
 */
SEC_COVER_LENGTH = SEC_COVER_CASE_LENGTH + SEC_COVER_INNER_CLEARANCE + WALL_THICKNESS;
SEC_COVER_WIDTH  = PS_WIDTH + 2 * WALL_THICKNESS + COVER_INNER_WIDTH_CORRECTION;
SEC_COVER_HEIGHT = PS_HEIGHT + 2 * WALL_THICKNESS;

SEC_LID_LENGTH   = SEC_COVER_LENGTH - WALL_THICKNESS;
SEC_LID_WIDTH    = PS_WIDTH + LID_WIDTH_CORRECTION;

/**
 * The distance of the shunt mounting blocks from the outer wall of the cover.
 */
SEC_COVER_SHUNT_BLOCK_Y_OFFSET = (SEC_COVER_WIDTH - (SEC_SHUNT_HOLE_DISTANCE + SEC_COVER_SHUNT_BLOCK_WIDTH)) / 2;

/**
 * The space around the components on the outer secondary side.
 */
SEC_COMPONENT_SPACING = ( SEC_COVER_WIDTH - (SEC_DISPLAY_WIDTH + SEC_GLAND_HOLE_DIAMETER) ) / 3;

/**
 * The horizontal positions of the components on the outer secondary side.
 */
SEC_DISPLAY_Y = SEC_GLAND_LEFT ? 2 * SEC_COMPONENT_SPACING + SEC_GLAND_HOLE_DIAMETER : SEC_COMPONENT_SPACING;
SEC_GLAND_Y   = ( SEC_GLAND_LEFT ? SEC_COMPONENT_SPACING : 2 * SEC_COMPONENT_SPACING + SEC_DISPLAY_WIDTH ) + SEC_GLAND_HOLE_DIAMETER/2;

/**
 * The vertical positions of the components on the outer secondary side.
 */
SEC_DISPLAY_Z = ( SEC_COVER_HEIGHT - SEC_DISPLAY_HEIGHT ) / 2;
SEC_GLAND_Z   = SEC_COVER_HEIGHT / 2;

/**
 * The width and height of the ventilation slots.
 */
SEC_COVER_VENT_WIDTH       = 2.5;
SEC_COVER_VENT_Y_CLEARANCE = 5;
SEC_COVER_VENT_HEIGHT      = PS_HEIGHT - SEC_COVER_SHUNT_BLOCK_HEIGHT - 2 * SEC_COVER_VENT_Y_CLEARANCE;
SEC_COVER_VENT_SPACING     = 4;

/**
 * The offset of the primary side cover and lid in relation to the case model.
 */
SEC_COVER_OFFSET = [PS_LENGTH - SEC_COVER_CASE_LENGTH, -WALL_THICKNESS - COVER_INNER_WIDTH_CORRECTION/2, -WALL_THICKNESS];
SEC_LID_OFFSET = [PS_LENGTH - SEC_COVER_CASE_LENGTH, 0, -WALL_THICKNESS];

// ===== AUXILIARY VALUES =============================================================================================

/**
 * The resolution to use when rendering holes.
 */
HOLE_RESOLUTION = 96;

/**
 * A small value to correct for rendering issues.
 */
EPSILON = 0.01;


