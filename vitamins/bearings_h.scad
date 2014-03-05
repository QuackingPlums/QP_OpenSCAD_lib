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

// Bearing types
MF106zz	= ["MF106zz 6x10x3 flanged bearing", 6, 10, 3, 11.2, 0.6];
MF105zz	= ["MF105zz 5x10x4 flanged bearing", 5, 10, 4, 11.6, 0.8];
MF95zz	= ["MF95zz 5x9x3 flanged bearing", 5, 9, 3, 10.2, 0.6];
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
