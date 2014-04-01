//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Lipos
//

include <lipos_h.scad>;

$fn = 24;

ff = 0.05;	// fudge factor to prevent barfing on coincident faces

module lipo(lipo_type = PolyPower_3S_1300_20C)
{
	cube([lipo_length(lipo_type), lipo_width(lipo_type), lipo_height(lipo_type)]);
}

lipo();