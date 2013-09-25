//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Anti vibration dampers - header definitions
//


//////////////
// Balloons
M8_red =		["M8 anti-vibration balloon (red)",
			"red", 14, 8.0, 1.4, 12, 2, 14, 10, 6.0];
M8_blue =	["M8 anti-vibration balloon (blue)",
			"royalblue", 14, 8.0, 1.4, 12, 2, 14, 10, 6.0];
M8_black = 	["M8 anti-vibration balloon (black)",
			"black", 14, 8.0, 1.4, 12, 2, 14, 10, 6.0];

/*
Name
Color
Height
Hole_diameter
Hole_depth
Lip_diameter
Lip_height
Ball_diameter
Ball_height
Bore_diameter

*/

function balloon_name(balloon) = balloon[0];
function balloon_color(balloon) = balloon[1];
function balloon_height(balloon) = balloon[2];
function balloon_hole_diameter(balloon) = balloon[3];
function balloon_hole_depth(balloon) = balloon[4];
function balloon_lip_diameter(balloon) = balloon[5];
function balloon_lip_height(balloon) = balloon[6];
function balloon_ball_diameter(balloon) = balloon[7];
function balloon_ball_height(balloon) = balloon[8];
function balloon_bore_diameter(balloon) = balloon[9];

function balloon_hole_radius(balloon) = balloon_hole_diameter(balloon) / 2;
function balloon_lip_radius(balloon) = balloon_lip_diameter(balloon) / 2;
function balloon_ball_radius(balloon) = balloon_ball_diameter(balloon) / 2;
function balloon_bore_radius(balloon) = balloon_bore_diameter(balloon) / 2;