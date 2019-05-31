//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Magnets - header definitions
//
use <QP_OpenSCAD_lib/docSCAD.scad>;	//docSCAD_help();

/////////////////////
// disc/cylindrical magnets

disc_4x2 =	["4x2", 4, 2, 4.2, 2.2];
disc_3x2 =	["3x2", 3, 2, 3.2, 2.2];
disc_2x3 =	["2x3", 2, 3, 2.2, 3.2];
disc_3x3 =	[];	// to buy?

// ***** FUNCTIONS *****
function disc_magnet_name(disc_magnet) = disc_magnet[0];
function disc_magnet_diameter(disc_magnet) = disc_magnet[1];
function disc_magnet_height(disc_magnet) = disc_magnet[2];
function disc_magnet_clearance_diameter(disc_magnet) = disc_magnet[3];
function disc_magnet_clearance_height(disc_magnet) = disc_magnet[4];

function disc_magnet_radius(disc_magnet) = disc_magnet_diameter(disc_magnet) / 2;
function disc_magnet_clearance_radius(disc_magnet) = disc_magnet_clearance_diameter(disc_magnet)/2;


// ***** docSCAD *****
//magnets_h_help();
module magnets_h_help()
{
	format_help(
		name="magnets_h.scad",
		description="Header definitions for N52 magnets",
		types=[
			new_type(type="disc_4x2", description="4mm diameter x 2mm tall"),
			new_type(type="disc_3x2", description="3mm diameter x 2mm tall"),
			new_type(type="disc_2x3", description="2mm diameter x 3mm tall"),
			new_type(type="disc_3x3", description="NOT BOUGHT YET")
		],
		accessors=[
			new_help_item(
				signature="disc_magnet_name(disc_magnet)",
				description="GETs the name of the disc_magnet type"),
			new_help_item(
				signature="disc_magnet_diameter(disc_magnet)",
				description="GETs the diameter of the disc_magnet type"),
		]
	);
}