//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Bearings - header definitions
//

// useful references:
// http://www.gizmology.net/bearings.htm
// http://www.ahrinternational.com/FAG_nomenclature.shtml
// http://www.bearing-king.co.uk/how-to-measure-a-bearing.php

// Flanged bearings
MF632rs	= ["MF632rs 3x6x2.5", 3, 6, 2.5, 7.2, 0.5];		// RCBearings.co.uk	//flange width??
F683rs	= ["F683rs 3x7x3", 3, 7, 3, 8.2, 0.6];		// RCBearings.co.uk
MF95zz	= ["MF95zz 5x9x3 flanged bearing", 5, 9, 3, 10.2, 0.6];
MF105zz	= ["MF105zz 5x10x4 flanged bearing", 5, 10, 4, 11.6, 0.8];
MF106zz	= ["MF106zz 6x10x3 flanged bearing", 6, 10, 3, 11.2, 0.6];
MF128rs	= ["MF128rs 8x12x3.5 flanged bearing", 8, 12, 3.5, 13.2, 0.6];		// RCBearings.co.uk
MF1482rs	= ["MF1482rs 8x14x4 flanged bearing", 8, 14, 4, 15.2, 0.8];		// RCBearings.co.uk
F6700rs	= ["F6700rs 10x15x4 flanged bearing", 10, 15, 4, 16.2, 0.8];		// RCBearings.co.uk

// Regular radial bearings
MR117rs	= ["MR117rs 7x11x3 bearing", 7, 11, 3, 0, 0];		// RCBearings.co.uk
MR137rs	= ["MR137rs 7x13x4 bearing", 7, 13, 4, 0, 0];		// RCBearings.co.uk
MR128rs	= ["MR128rs 8x12x3.5 bearing", 8, 12, 3.5, 0, 0];		// RCBearings.co.uk

// Skate bearing
MR6082rs	= ["MR6082rs 8x22x7 skate bearing", 8, 22, 7, 0, 0];

function bearing_name(bearing_type) = bearing_type[0];
function bearing_bore_diameter(bearing_type) = bearing_type[1];
function bearing_diameter(bearing_type) = bearing_type[2];
function bearing_width(bearing_type) = bearing_type[3];
function bearing_flange_diameter(bearing_type) = bearing_type[4];
function bearing_flange_width(bearing_type) = bearing_type[5];

function bearing_bore_radius(bearing_type) = bearing_bore_diameter(bearing_type) / 2;
function bearing_radius(bearing_type) = bearing_diameter(bearing_type) / 2;
function bearing_flange_radius(bearing_type) = bearing_flange_diameter(bearing_type) / 2;
