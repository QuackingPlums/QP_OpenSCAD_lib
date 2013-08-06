//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Fasteners - screws, nuts, washers etc.
//

include <fasteners_h.scad>;
use <../polyholes.scad>;

$fs = 0.5;
$fa = 5;

ff = 0.05;	// fudge factor to prevent barfing on coincident faces

///////////
// Screws

module screw(screw_type = M3_cap_screw, length = 20, washer = false, exploded = 0)
{
	head_height = screw_head_height(screw_type);
	washer_type = screw_washer(screw_type);
	washer_thickness = washer_thickness(washer_type);

	color("dimgray")
		translate([0, 0, (washer ? washer_thickness(washer_type) : 0) + exploded])
			union()
			{
				// head
				cylinder(r = screw_head_radius(screw_type), h = head_height);
	
				// thread
				translate([0, 0, -length])
					cylinder(r = screw_radius(screw_type),	h = length);
			}
	
	// washer
	if (washer)
		translate([0, 0, exploded / 2])
			washer(washer_type);
}

module screw_clearance_hole(screw_type, depth)
{
	translate([0, 0, -depth])
		poly_cylinder(h = depth, r = metric_clearance_radius(screw_type));
}

module screw_head_clearance_hole(screw_type = M3_cap_screw)
{
	hh = screw_head_height(screw_type);
	translate([0, 0, -hh])
		poly_cylinder(h = hh, r = screw_head_clearance_radius(screw_type));
}

module self_tap_hole(screw_type = No2, depth = 10)
{
	translate([0, 0, -depth])
		poly_cylinder(h = depth, r = metric_radius(screw_type), $fn = 3);
}

/////////
// Nuts

module nut(nut_type = M3_nut, exploded = 0)
{
	color("silver")
		translate([exploded, 0, 0])
			difference()
			{
				// nut
				cylinder(	r = nut_radius(nut_type),
							h = nut_height(nut_type),
							$fn = 6);
		
				// hole
				translate([0, 0, -ff/2])
					cylinder(	r = nut_thread(nut_type) / 2,
								h = (nut_height(nut_type)) + ff);
			}
}

module nyloc(nut_type = M3_nyloc, exploded = 0)
{
	hex_h = 0.8 * nut_thread(nut_type);

	color("silver")
		translate([0, 0, exploded])
			difference()
			{
				// nut
				union()
				{
					cylinder(	r = nut_radius(nut_type),
								h = 0.8 * nut_thread(nut_type),
								$fn = 6);

					cylinder(	r = nut_flat_radius(nut_type),
								h = nut_height(nut_type));
				}
		
				// hole
				translate([0, 0, -ff/2])
					cylinder(	r = nut_thread(nut_type) / 2,
								h = (nut_height(nut_type) + ff));
			}
}

module nut_trap(nut_type = M3_nut, depth = nut_clearance_diameter(M3_nut))
{
	// align this with a surface and subtract from a solid to create a nut trap
	translate([-nut_clearance_radius(nut_type), -nut_flat_clearance_radius(nut_type), 0])
		cube([depth + ff, nut_flat_clearance_diameter(nut_type), nut_clearance_height(nut_type)]);		
}

module nut_recess(nut_type = M3_nut)
{
	cylinder(	r = nut_clearance_radius(nut_type),
				h = nut_height(nut_type),
				$fn = 6);
}

////////////
// Washers

module washer(washer_type = M3_washer)
{
	color("silver")
		difference()
		{
			cylinder(r = washer_outer_radius(washer_type), h = washer_thickness(washer_type));
			translate([0, 0, -ff])
				cylinder(r = washer_bore_radius(washer_type), h = washer_thickness(washer_type) + ff * 2);
		}
}


////////////
// Studs

module stud(stud_type = M3_stud, length = 20, nyloc = true, exploded = 0)
{
	color("dimgray")
		translate([0, 0, -length + exploded])
			cylinder(h = length, r = stud_radius(stud_type));

	if(nyloc)
		nyloc(nut_type = stud_nyloc(stud_type), nyloc = true, exploded = exploded);
}

////////////
// BOM

module BOM(quantity, vitamin, description = "undefined")
{
	d = (description != "undefined") ? str(" [", description, "]") : "";
	echo(str("BOM: ", quantity, "x ", vitamin, d));
}

module BOM_screw(quantity = 1, screw_type = M3_cap_screw, length = 20, description = "undefined")
{
	vitamin = str(screw_size(screw_type), "x", length, " ", screw_name(screw_type));
	BOM(quantity, vitamin, description);
}

module BOM_nut(quantity = 1, nut_type = M3_nut, description = "undefined")
{
	vitamin = str(nut_size(nut_type), " ", nut_variant(nut_type));
	BOM(quantity, vitamin, description);
}

module BOM_washer(quantity = 1, washer_type = M3_washer, description = "undefined")
{
	vitamin = str(washer_size(washer_type), " ", washer_variant(washer_type));
	BOM(quantity, vitamin, description);
}

module BOM_stud(quantity = 1, stud_type = M3_stud, length = 25, description = "undefined")
{
	vitamin = str(stud_size(stud_type), "x", length, " ", stud_description(stud_type));
	BOM(quantity, vitamin, description);
}

//screw(screw_type = M2_cap_screw, washer = true, exploded = 10);
//nut(exploded = 10);
//nut_trap();
//nyloc(exploded = 10);
//stud(stud_type = M5_stud, length = 25, nyloc = true, exploded = 0);
//screw_clearance_hole(screw_type = M2, depth = 12);
//screw_head_clearance_hole();
//self_tap_hole(No2, 10);