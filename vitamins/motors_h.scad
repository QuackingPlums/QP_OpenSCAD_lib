//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Motors - header definitions
//

include <fasteners_h.scad>;

// Motor types - brushless gimbal
iPower_GBM4008 = ["iFlight iPower GBM4008-150 brushless gimbal motor",				// 400-800g (NEX-6/7)	** VERIFIED **
	40, 8,			// stator d, stator h
	16, 19,	4,		// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
 	25, 25, 2,		// base d1, base d2, base h
 	13, 4,			// base ring d, base ring h
	49.61, 12.8,		// bell d, bell h
 	38.93, 3.84,		// bell cap d, bell cap h
	0, 0,			// shaft collar d, shaft collar h
	3.17, 0, 0,		// shaft d, shaft h, shaft direction
	12, 4, M3, M3];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw size

iPower_GBM4006 = ["iFlight iPower GBM4006-150 brushless gimbal motor",				// 400-800g (NEX-5)
	40, 6,			// stator d, stator h
	16, 19,	4,		// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
 	25, 25, 2,		// base d1, base d2, base h
 	13, 5,			// base ring d, base ring h
 	49.61, 9.32,		// bell d, bell h
 	38.93, 3.84,		// bell cap d, bell cap h
	0, 0,			// shaft collar d, shaft collar h
	3.17, 0, 0,		// shaft d, shaft h, shaft direction
	12, 4, M3, M3];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw size

iPower_GBM3508 = ["iFlight iPower GBM3508-130 brushless gimbal motor",				// 200-400g (GF3)
	35, 8,			// stator d, stator h
	16, 19,	4,		// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
 	26, 26, 1,		// base d1, base d2, base h
 	13, 5,			// base ring d, base ring h
	42, 9,			// bell d, bell h
 	35, 3,			// bell cap d, bell cap h
	0, 0,			// shaft collar d, shaft collar h
	3.17, 10, 0,		// shaft d, shaft h, shaft direction
	12, 4, M3, M3];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw size

iPower_GBM2212 = ["iFlight iPower GBM2212-80 brushless gimbal motor",				// 100-300g (GoPro = 75g)
	22, 12,			// stator d, stator h
	16, 19,	4,		// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
	25, 27.7, 5.5,	// base d1, base d2, base h
	0, 0,			// base ring d, base ring h
 	27.7, 14.5,		// bell d, bell h
	25, 5,			// bell cap d, bell cap h
	9, 4.2,			// shaft collar d, shaft collar h
	3.17, 0, 0,		// shaft d, shaft h, shaft direction
	12, 4, M2, M3];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw size

iPower_GBM2208 = ["iFlight iPower GBM2208-80 brushless gimbal motor",				// 100-200g (GoPro = 75g) ** VERIFIED **
	22, 8,			// stator d, stator h
	16, 19,	4,		// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
	25, 27.7, 5.5,	// base d1, base d2, base h
	0, 0,			// base ring d, base ring h
	27.7, 10.5,		// bell d, bell h
	25, 5,			// bell cap d, bell cap h
	9, 4.2,			// shaft collar d, shaft collar h
	3.17, 0, 0,		// shaft d, shaft h, shaft direction
	12, 4, M2, M3];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw size

GLB_GBM2208 = ["Goodluckbuy GBM2208-80 brushless gimbal motor",						// 100-200g (GoPro = 75g) ** VERIFIED **
	22, 8,			// stator d, stator h
	16, 19,	4,		// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
	25, 27.7, 5.5,	// base d1, base d2, base h
	0, 0,			// base ring d, base ring h
	27.7, 10.5,		// bell d, bell h
	25, 5,			// bell cap d, bell cap h
	0, 0,			// shaft collar d, shaft collar h
	3.17, 0, 0,		// shaft d, shaft h, shaft direction
	12, 4, M2, M3];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw size

RCTimer_GBM5010 = ["RCTimer 5010-021-150T", 								// ???g (DSLR?!)
	40, 8,
	19, 30, 4,
	42, 50, 6,
 	50, 3,
 	50, 10,
	20, 1,
	0, 0,
	3.17, 15.5, -1,
	12, 3, M3, M3];

RCTimer_GBM2212 = ["RCTimer HP2212-015-70T brushless gimbal motor",				// 100-200g (GoPro = 75g)
	22, 12,
	16, 19, 4,
	26, 28, 1,
 	28, 6,
 	28, 13,
	27, 3,
	10, 1,
	3.17, 10, -1,
	12, 3, M2, M3];

// 'regular' motor types
RCX_ZMR1804 = ["RCX ZMR 1804 2400KV",										// QPAV250 mini-quad
// ** AWAITING VERIFICATION **
	18, 4,			// stator d, stator h
	12.4, 12.4,	4,	// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
	18.6, 20.6, 4,	// base d1, base d2, base h
	23.6, 1.2,		// base ring d, base ring h
	23.6, 5,			// bell d, bell h
	20.6, 2,			// bell cap d, bell cap h
	9, 1,			// shaft collar d, shaft collar h
	5, 14.9, 0,		// shaft d, shaft h, shaft direction
	0, 0, M2, M2];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw size

LD1510A = ["Hobbyking LD1510A-02-P",
	15, 10,			// stator d, stator h
	12, 12,	4,		// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
	18, 18, 3.5,		// base d1, base d2, base h
	0, 0,			// base ring d, base ring h
	18, 12,			// bell d, bell h
	10, 2.5,			// bell cap d, bell cap h
	5, 2,			// shaft collar d, shaft collar h
	2, 7.9, 0,		// shaft d, shaft h, shaft direction
	0, 0, M2, M2];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw size

QPAV250_generic = ["generic 250 quad motor",
	0, 0,			// stator d, stator h
	12, 14,	4,		// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
	22, 22, 3.5,		// base d1, base d2, base h
	0, 0,			// base ring d, base ring h
	22, 5,			// bell d, bell h
	22, 2,			// bell cap d, bell cap h
	20, 2,			// shaft collar d, shaft collar h
	5, 15, 0,		// shaft d, shaft h, shaft direction
	0, 0, M2, M2];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw size

Turnigy_AeroDrive_C2024 = ["Turnigy AeroDrive C2024",
	20, 14,			// stator d, stator h
	25, 25, 3,		// bottom mount hole centers min, max, bottom hole pattern (3 or 4)
	29, 29, 1.5,		// base d1, base d2, base h
	0, 0,			// base ring d, base ring h
	22.5, 15,		// bell d, bell h
	7, 1,			// bell cap d, bell cap h
	7, 5,			// shaft collar d, shaft collar h
	2, 0, 0,			// shaft d, shaft h, shaft direction
	0, 0, M2, M2];		// top mount hole centers, top mount hole pattern (3 or 4), top mount screw size, base mount screw siz

/*
name
stator d,
stator h,
bottom mount min,
bottom mount max
bottom mount hole pattern (3 or 4)
base d1,
base d2,
base h
base ring d,
base ring h
bell d,
bell h
bell cap d,
bell cap h
shaft collar d,
shaft collar h
shaft d,
shaft h,
shaft direction
top mount holes,
top mount hole pattern (3 or 4)
*/

function motor_name(motor_type) = motor_type[0];
function motor_stator_d(motor_type) = motor_type[1];
function motor_stator_h(motor_type) = motor_type[2];
function motor_mount_holes_1(motor_type) = motor_type[3];
function motor_mount_holes_2(motor_type) = motor_type[4];
function motor_mount_hole_pattern(motor_type) = motor_type[5];
function motor_base_d1(motor_type) = motor_type[6];
function motor_base_d2(motor_type) = motor_type[7];
function motor_base_h(motor_type) = motor_type[8];
function motor_base_ring_d(motor_type) = motor_type[9];
function motor_base_ring_h(motor_type) = motor_type[10];
function motor_bell_d(motor_type) = motor_type[11];
function motor_bell_h(motor_type) = motor_type[12];
function motor_cap_d(motor_type) = motor_type[13];
function motor_cap_h(motor_type) = motor_type[14];
function motor_shaft_collar_d(motor_type) = motor_type[15];
function motor_shaft_collar_h(motor_type) = motor_type[16];
function motor_shaft_d(motor_type) = motor_type[17];
function motor_shaft_h(motor_type) = motor_type[18];
function motor_shaft_dir(motor_type) = motor_type[19];
function motor_top_mount_holes(motor_type) = motor_type[20];
function motor_top_mount_hole_pattern(motor_type) = motor_type[21];
function motor_top_mount_hole_size(motor_type) = motor_type[22];
function motor_base_mount_hole_size(motor_type) = motor_type[23];

function motor_stator_r(motor_type) = motor_stator_d(motor_type) / 2;
function motor_base_r1(motor_type) = motor_base_d1(motor_type) / 2;
function motor_base_r2(motor_type) = motor_base_d2(motor_type) / 2;
function motor_base_ring_r(motor_type) = motor_base_ring_d(motor_type) / 2;
function motor_bell_r(motor_type) = motor_bell_d(motor_type) / 2;
function motor_cap_r(motor_type) = motor_cap_d(motor_type) / 2;
function motor_shaft_collar_r(motor_type) = motor_shaft_collar_d(motor_type) / 2;
function motor_shaft_r(motor_type) = motor_shaft_d(motor_type) / 2;
function motor_shaft_offset(motor_type) = motor_shaft_h(motor_type) * motor_shaft_dir(motor_type);

function motor_mount_diameter(motor_type) =
	max(	motor_bell_d(motor_type), motor_base_d1(motor_type));

function motor_length(motor_type) = 
	motor_base_h(motor_type) +
	motor_base_ring_h(motor_type) +
	motor_bell_h(motor_type) +
	motor_cap_h(motor_type) +
	motor_shaft_collar_h(motor_type) +
	motor_shaft_h(motor_type);

//echo(motor_length(iPower_GBM4008));