//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Magnets - header definitions
//
use <../docSCAD.scad>; //docSCAD_help();

/////////////////////
// disc/cylindrical magnets

disc_4x2 =	["4x2", 4, 2, 4.2, 2.2];
disc_3x2 =	["3x2", 3, 2, 3.2, 2.2];
disc_2x3 =	["2x3", 2, 3, 2.2, 3.2];

// ***** FUNCTIONS *****
function disc_magnet_name(disc_magnet) = disc_magnet[0];
function disc_magnet_diameter(disc_magnet) = disc_magnet[1];
function disc_magnet_height(disc_magnet) = disc_magnet[2];
function disc_magnet_clearance_diameter(disc_magnet) = disc_magnet[3];
function disc_magnet_clearance_height(disc_magnet) = disc_magnet[4];

function disc_magnet_radius(disc_magnet) = disc_magnet_diameter(disc_magnet) / 2;
function disc_magnet_clearance_radius(disc_magnet) = disc_magnet_clearance_diameter(disc_magnet)/2;


// ***** docSCAD *****
module magnets_h_help()
{
	
}