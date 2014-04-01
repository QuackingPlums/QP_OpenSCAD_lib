//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Lipos - header definitions
//

// Lipo types
PolyPower_3S_1300_20C = ["Robotbirds Poly Power 3S 1300 20C",
	72, 36, 25];			// L, W, H

function lipo_name(lipo_type) = lipo_type[0];
function lipo_length(lipo_type) = lipo_type[1];
function lipo_width(lipo_type) = lipo_type[2];
function lipo_height(lipo_type) = lipo_type[3];