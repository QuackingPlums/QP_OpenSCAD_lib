//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Anti vibration dampers - screws, nuts, washers etc.
//

include <av_dampers_h.scad>;

$fs = 0.5;
$fa = 5;

ff = 0.05;	// fudge factor to prevent barfing on coincident faces

//////////////
// Balloons

module balloon(balloon_type = M8_red)
{
	color(balloon_color(balloon_type))
		translate([0, 0, -balloon_lip_height(balloon_type)])
			difference()
			{
				union()
				{
					// lower lip
					cylinder(h = balloon_lip_height(balloon_type), r = balloon_lip_radius(balloon_type));
			
					// lower hole grommet
					translate([0, 0, balloon_lip_height(balloon_type)])
						cylinder(h = balloon_hole_depth(balloon_type), r = balloon_hole_radius(balloon_type));
			
					// ball
					translate([0, 0, balloon_height(balloon_type)/2])
						resize([balloon_ball_diameter(balloon_type), balloon_ball_diameter(balloon_type), balloon_ball_height(balloon_type)])
							sphere(r = balloon_ball_radius(balloon_type), center = true);
			
					// upper hole grommet
					translate([0, 0, balloon_height(balloon_type) - balloon_lip_height(balloon_type) - balloon_hole_depth(balloon_type)])
						cylinder(h = balloon_hole_depth(balloon_type), r = balloon_hole_radius(balloon_type));
			
					// upper lip
					translate([0, 0, balloon_height(balloon_type) - balloon_lip_height(balloon_type)])
						cylinder(h = balloon_lip_height(balloon_type), r = balloon_lip_radius(balloon_type));
				}
				// through hole
				translate([0, 0, -ff/2])
					cylinder(h = balloon_height(balloon_type) + ff, r = balloon_bore_radius(balloon_type));
			}
}


////////////
// BOM

module BOM(quantity, vitamin, description = "undefined")
{
	d = (description != "undefined") ? str(" [", description, "]") : "";
	echo(str("BOM: ", quantity, "x ", vitamin, d));
}

module BOM_balloon(quantity = 1, balloon_type = M8_red, description = "undefined")
{
	vitamin = balloon_name(balloon_type);
	BOM(quantity, vitamin, description);
}

balloon(balloon_type = M8_blue);
BOM_balloon(4, M8_red, "Anti-vibration mount");