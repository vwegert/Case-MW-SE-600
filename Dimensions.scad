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
PS_PRI_TERM_WIDTH    = 3 * 10 + (10 - 8.2) / 2;
PS_PRI_TERM_HEIGHT   = 19; // TODO validate this value
PS_PRI_TERM_OFFSET_Y = 10; // TODO validate this value
PS_PRI_TERM_OFFSET_Z = 10; // TODO validate this value

/**
 * The size and position of the terminals on the secondary (output) side.
 */
PS_SEC_TERM_LENGTH   = 17;
PS_SEC_TERM_WIDTH    = 6 * 13 + (13 - 10) / 2;
PS_SEC_TERM_HEIGHT   = 19; // TODO validate this value
PS_SEC_TERM_OFFSET_Y = 25; // TODO validate this value
PS_SEC_TERM_OFFSET_Z = 10; // TODO validate this value

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
COVER_SUPPORT_PILLAR_HOLE_DEPTH = 30;

/**
 * The size of the holes in the lid for the screws that fit into the support pillars.
 */
LID_PILLAR_SCREW_DIAMETER = 4;

/**
 * The width and height of the ventilation slots.
 */
COVER_VENT_WIDTH   = 2.5;
COVER_VENT_HEIGHT  = PS_HEIGHT * 2 / 3;
COVER_VENT_SPACING = 4;

/**
 * The size and positions of the feet on the underside of the lids.
 */
FOOT_OUTER_DIAMETER  = 15;
FOOT_INNER_DIAMETER  = 13;
FOOT_HEIGHT          =  5;
FOOT_RECESS_DEPTH    =  1;
FOOT_EDGE_DISTANCE_X = 12;
FOOT_EDGE_DISTANCE_Y = 15;

// ===== PRIMARY (MAINS) SIDE =========================================================================================

/**
 * How much clearance to leave on the inside of the primary cover.
 */
PRI_COVER_INNER_CLEARANCE = 45; // switch needs >= 37

/**
 * The width of the compartment that holds the mains wiring and power connector / switch.
 */
PRI_COVER_MAINS_COMP_WIDTH = 60; // TODO validate this value (check fan size)

/**
 * The thickness of the compartment separation wall.
 */
PRI_COVER_MAINS_COMP_WALL_THICKNESS = 1.5;

/**
 * The dimensions of the cutout and the screw holes for the power connector.
 */
PRI_COVER_PC_WIDTH  = 28;
PRI_COVER_PC_HEIGHT = 47;
PRI_COVER_PC_SCREW_HOLE_DIAMETER = 3.4;
PRI_COVER_PC_SCREW_HOLE_DISTANCE = 40;

/**
 * The distance of the center support pillar from the face of the power supply.
 */
PRI_COVER_CENTER_SUPPORT_DISTANCE_PS = 2; // TODO validate this value

/**
 * The outer dimensions of the primary-side cover.
 */
PRI_COVER_LENGTH = PRI_COVER_CASE_LENGTH + PRI_COVER_INNER_CLEARANCE + WALL_THICKNESS;
PRI_COVER_WIDTH  = PS_WIDTH + 2 * WALL_THICKNESS;
PRI_COVER_HEIGHT = PS_HEIGHT + 2 * WALL_THICKNESS;

/**
 * The offset of the primary side cover and lid in relation to the case model.
 */
PRI_COVER_OFFSET = [-(PRI_COVER_INNER_CLEARANCE + WALL_THICKNESS), -WALL_THICKNESS, -WALL_THICKNESS];
PRI_LID_OFFSET = [-PRI_COVER_INNER_CLEARANCE, 0, -WALL_THICKNESS];

// ===== AUXILIARY VALUES =============================================================================================

/**
 * The resolution to use when rendering holes.
 */
HOLE_RESOLUTION = 96;

/**
 * A small value to correct for rendering issues.
 */
EPSILON = 0.01;


